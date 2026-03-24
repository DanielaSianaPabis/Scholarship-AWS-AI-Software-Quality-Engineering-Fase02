*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource   ../resources/base.resource 

*** Keywords ***
Criar Produto
    [Arguments]    ${token}
    ${headers}=    Criar Header Com Token    ${token}

    ${random}=    Generate Random String    5

    ${body}=    Create Dictionary
    ...    nome=Produto ${random}
    ...    preco=100
    ...    descricao=Teste
    ...    quantidade=10

    ${response}=    POST On Session
    ...    serverest
    ...    /produtos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}

Criar produto sem token
    ${response}=   POST On Session
    ...    serverest
    ...    /produtos
    ...    expected_status=any
    
    RETURN    ${response}

Validar Produto Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Sem Permissao
    [Arguments]    ${response}
    Status Should Be    403    ${response}

Validar Sem Token
    [Arguments]    ${response}
    Status Should Be    401    ${response}

Validar Contrato Produto
    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    _id