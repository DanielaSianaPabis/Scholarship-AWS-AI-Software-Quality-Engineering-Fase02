[Documentation]   Recurso de Carrinhos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Resource   base.resource
Resource   autenticacao.resource
Resource   produtos.resource

*** Keywords ***

Preparar Token E Produto
    [Documentation]    Cria usuário admin, faz login, cria produto e salva TOKEN_ADMIN e ID_PRODUTO como variáveis de teste.

    Preparar Token Admin
    ${id}=    Criar Produto E Obter ID    ${TOKEN_ADMIN}
    Set Test Variable    ${ID_PRODUTO}    ${id}


Cancelar Compra
    [Documentation]    Cancela a compra do carrinho utilizando um token de autenticação:

    [Arguments]    ${token}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /carrinhos/cancelar-compra
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}


Buscar Carrinho
    [Documentation]    Busca o carrinho do usuário autenticado pelo token:

    [Arguments]    ${token}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    GET On Session
    ...    serverest
    ...    /carrinhos
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}


Validar Contrato Carrinho
    [Documentation]    Valida contrato do carrinho via GET: estrutura, tipos e campos obrigatórios

    [Arguments]    ${response}

    ${json}=    Set Variable    ${response.json()}

    Validar Campos Obrigatórios    ${json}    quantidade    carrinhos

    Validar Tipo Campo    ${json['quantidade']}    number

    ${carrinho}=    Get From List    ${json['carrinhos']}    0
    Validar Campos Obrigatórios    ${carrinho}    produtos    precoTotal    quantidadeTotal    idUsuario    _id
    Validar Tipo Campo    ${carrinho['precoTotal']}        number
 
    Validar Tipo Campo    ${carrinho['quantidadeTotal']}   number
    Validar Tipo Campo    ${carrinho['idUsuario']}         string
    Validar ID    ${carrinho['_id']}

    ${produto}=    Get From List    ${carrinho['produtos']}    0
    Validar Campos Obrigatórios    ${produto}    idProduto    quantidade    precoUnitario
    Validar Tipo Campo    ${produto['idProduto']}       string
    Validar Tipo Campo    ${produto['quantidade']}     number
    Validar Tipo Campo    ${produto['precoUnitario']}  number


Criar Carrinho
    [Documentation]    Cria um carrinho de compras utilizando um token de autenticação e um ID de produto:

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
    [Documentation]    Conclui a compra do carrinho utilizando um token de autenticação:

    [Arguments]    ${token}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /carrinhos/concluir-compra
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}


