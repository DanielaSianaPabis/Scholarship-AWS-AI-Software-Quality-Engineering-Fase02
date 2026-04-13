[Documentation]   Recurso de Produtos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***

Resource   base.resource 

*** Keywords ***

Criar Produto
    [Documentation]    Cria um produto utilizando um token de autenticação.

    [Arguments]    ${token}    ${preco}=100    ${quantidade}=10

    ${headers}=    Criar Header Com Token    ${token}

    ${random}=    Generate Random String    5
    ${nome}=      Set Variable    Produto ${random}

    ${preco_int}=       Convert To Integer    ${preco}
    ${quantidade_int}=  Convert To Integer    ${quantidade}

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    preco=${preco_int}
    ...    descricao=Produto de teste
    ...    quantidade=${quantidade_int}

    ${response}=    POST On Session
    ...    serverest
    ...    /produtos
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}

Criar Produto E Obter ID 
    [Documentation]    Cria um produto e retorna seu ID.
    ...                Falha imediatamente se o cadastro não retornar 201.
    [Arguments]    ${token}    ${preco}=100    ${quantidade}=10
    ${res}=    Criar Produto    ${token}    ${preco}    ${quantidade}
    Validar Status Da Resposta    201    ${res}
    RETURN    ${res.json()['_id']}

Listar Produtos
    [Documentation]    Lista todos os produtos cadastrados.

    ${response}=    GET On Session    serverest    /produtos    expected_status=any
    RETURN    ${response}

Buscar Produto por ID 
    [Documentation]    Busca um produto pelo ID na API ServeRest:

    [Arguments]    ${id}
    ${response}=    GET On Session    serverest    /produtos/${id}    expected_status=any
    RETURN    ${response}

Atualizar Produto
    [Documentation]    Atualiza um produto pelo ID.

    [Arguments]    ${token}    ${id}    ${preco}=150    ${quantidade}=20

    ${headers}=    Criar Header Com Token    ${token}

    ${random}=    Generate Random String    5
    ${nome}=      Set Variable    Produto Atualizado ${random}

    ${preco_int}=       Convert To Integer    ${preco}
    ${quantidade_int}=  Convert To Integer    ${quantidade}

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    preco=${preco_int}
    ...    descricao=Produto atualizado
    ...    quantidade=${quantidade_int}

    ${response}=    PUT On Session
    ...    serverest
    ...    /produtos/${id}
    ...    json=${body}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}

Excluir Produto
    [Documentation]    Exclui um produto utilizando token de autenticação e o ID do produto.

    [Arguments]    ${token}    ${produto_id}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /produtos/${produto_id}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}

Validar Contrato Produto
    [Documentation]    Valida contrato do produto via GET usando schema JSON.

    [Arguments]    ${response}

    Validar Contrato    ${response}    produto_schema.json
