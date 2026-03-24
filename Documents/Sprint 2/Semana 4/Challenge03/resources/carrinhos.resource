*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   base.resource

*** Keywords ***
Criar Carrinho
    [Arguments]    ${token}    ${produto_id}
    ${headers}=    Criar Header Com Token    ${token}

    ${produto}=    Create Dictionary
    ...    idProduto=${produto_id}
    ...    quantidade=1

    ${lista}=    Create List    ${produto}

    ${body}=    Create Dictionary
    ...    produtos=${lista}

    ${response}=    POST On Session
    ...    serverest
    ...    /carrinhos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}

Criar carrinho sem token
    ${response}=   POST On Session
    ...    serverest
    ...    /carrinhos
    ...    expected_status=any
    
    RETURN    ${response}

Validar Carrinho Criado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Produto Invalido
    [Arguments]    ${response}
    Status Should Be    400    ${response}