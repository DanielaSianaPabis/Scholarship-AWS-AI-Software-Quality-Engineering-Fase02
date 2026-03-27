[Documentation]   Recurso de Carrinhos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Resource   base.resource

*** Keywords ***

Criar Carrinho
    [Documentation]    Cria um carrinho de compras utilizando um token de autenticação e um ID de produto, validando o status esperado:

    [Arguments]    ${token}    ${produto_id}    ${status_esperado}=201
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

    Status Should Be    ${status_esperado}    ${response}
    RETURN    ${response}


Concluir Compra
    [Documentation]    Conclui a compra do carrinho utilizando um token de autenticação, validando o status esperado:

    [Arguments]    ${token}    ${status_esperado}=200

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /carrinhos/concluir-compra
    ...    headers=${headers}
    ...    expected_status=any

    Status Should Be    ${status_esperado}    ${response}
    RETURN    ${response}


