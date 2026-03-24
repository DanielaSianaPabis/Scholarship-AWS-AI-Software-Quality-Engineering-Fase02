[Documentation]   Recurso de Carrinhos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    RequestsLibrary
Library    Collections
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

Acessar carrinho sem autenticação 
    [Documentation]    Tenta acessar um carrinho de compras sem estar autenticado, retornando a resposta da requisição:

    ${response}=   POST On Session
    ...    serverest
    ...    /carrinhos
    ...    expected_status=any

    RETURN    ${response}

Validar Carrinho Criado
    [Documentation]    Valida se o carrinho foi criado com sucesso, verificando o status code da resposta:
    
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Produto Invalido
    [Documentation]    Valida se o produto é inválido, verificando o status code da resposta:

    [Arguments]    ${response}
    Status Should Be    400    ${response}

Validar Carrinho Sem Autenticação
    [Documentation]   Valida se a criação do carrinho falhou devido à falta de autenticação e token, verificando o status code da resposta:

    [Arguments]    ${response}
    Status Should Be    401    ${response}