[Documentation]   Recurso de Carrinhos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Resource   base.resource

*** Keywords ***
Criar Carrinho  
    [Documentation]    Cria um carrinho de compras utilizando um token de autenticação e um ID de produto, retornando a resposta da requisição:

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


Concluir Compra
    [Documentation]    Conclui a compra do carrinho utilizando um token de autenticação, retornando a resposta da requisição:

    [Arguments]    ${token}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /carrinhos/concluir-compra
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}


Validar Carrinho Criado
    [Documentation]    Valida se o carrinho foi criado com sucesso, através do status code da resposta:
    
    [Arguments]    ${response}
    Status Should Be    201    ${response}


Validar Produto Inválido 
    [Documentation]    Valida se o produto é inválido, através do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    400    ${response}


Validar Compra Concluida
    [Documentation]    Valida se a compra foi concluída com sucesso, através do status code da resposta:

    [Arguments]    ${response}

    Status Should Be    200    ${response}