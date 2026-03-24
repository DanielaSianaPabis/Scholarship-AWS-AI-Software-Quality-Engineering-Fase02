[Documentation]   Recurso de Produtos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource   ../resources/base.resource 

*** Keywords ***
Criar Produto
    [Documentation]    Cria um produto utilizando um token de autenticação, retornando a resposta da requisição:

    [Arguments]    ${token}
    ${headers}=    Criar Header Com Token    ${token}

    ${produto}=    Generate Random String    5

    ${body}=    Create Dictionary
    ...    nome=Produto ${produto}
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
    [Documentation]    Tenta criar um produto sem fornecer um token de autenticação, retornando a resposta da requisição:

    ${produto}=    Generate Random String    5

    ${body}=    Create Dictionary
    ...    nome=Produto ${produto}
    ...    preco=150
    ...    descricao=Teste 2
    ...    quantidade=6

    ${response}=    POST On Session
    ...    serverest
    ...    /produtos
    ...    json=${body}
    ...    expected_status=any

    RETURN    ${response}

Validar Produto Criado
    [Documentation]    Valida se o produto foi criado com sucesso, verificando o status code da resposta:

    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Sem Permissao
    [Documentation]   Valida se a criação do produto falhou devido à falta de permissão, verificando o status code da resposta:

    [Arguments]    ${response}
    Status Should Be    403    ${response}

Validar Sem Token
    [Documentation]   Valida se a criação do produto falhou devido à ausência de token, verificando o status code da resposta:

    [Arguments]    ${response}
    Status Should Be    401    ${response}

Validar Contrato Produto
    [Documentation]    Valida o contrato da resposta da criação do produto, verificando a presença de 'message' e '_id':

    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    _id