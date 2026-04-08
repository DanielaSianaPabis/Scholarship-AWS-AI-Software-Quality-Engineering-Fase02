[Documentation]   Recurso de Produtos para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../resources/base.resource 

*** Keywords ***

Criar Produto
    [Documentation]    Cria um produto utilizando um token de autenticação e valida o status esperado:

    [Arguments]    ${token}    ${status_esperado}=201
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

    Status Should Be    ${status_esperado}    ${response}
    RETURN    ${response}


Excluir Produto
    [Documentation]    Exclui um produto utilizando token de autenticação e o ID do produto, validando o status esperado:

    [Arguments]    ${token}    ${produto_id}    ${status_esperado}=200

    ${headers}=    Criar Header Com Token    ${token}

    ${response}=    DELETE On Session
    ...    serverest
    ...    /produtos/${produto_id}
    ...    headers=${headers}
    ...    expected_status=any

    Status Should Be    ${status_esperado}    ${response}
    RETURN    ${response}


Validar Contrato Produto
    [Documentation]    Valida os elementos do contrato da resposta da criação de um produto:

    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    _id
    Should Be Equal    ${json['message']}    Cadastro realizado com sucesso
    Should Not Be Empty    ${json['_id']}