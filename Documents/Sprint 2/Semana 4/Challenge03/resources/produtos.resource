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


Excluir Produto
    [Documentation]    Exclui um produto utilizando token de autenticação e o ID do produto, retornando a resposta da requisição:

    [Arguments]    ${token}    ${produto_id}

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /produtos/${produto_id}
    ...    headers=${headers}
    ...    expected_status=any

    RETURN    ${response}


Validar Produto Criado
    [Documentation]    Valida se o produto foi criado com sucesso, através do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    201    ${response}


Validar Sem Permissao
    [Documentation]   Valida se a criação do produto falhou devido à falta de permissão, atarvés do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    403    ${response}


Validar Contrato Produto
    [Documentation]    Valida os elementos do contrato da resposta da criação de um produto, verificando a presença de 'message' e '_id' na resposta:
    [Arguments]    ${response}

    Status Should Be    201    ${response}

    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    _id

    Should Be Equal    ${json['message']}    Cadastro realizado com sucesso
    Should Not Be Empty    ${json['_id']}


Validar Exclusão Produto Inválido 
    [Documentation]    Valida a exclusão do produto com ID inválido, através do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    200    ${response}

