[Documentation]    Recurso de Usuários para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../variables/variables.robot
Resource   base.resource

*** Keywords ***

Gerar Email Aleatorio
    [Documentation]    Gera um email aleatório para uso nos testes de criação de usuários:

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=    Set Variable    user_${random}@email.com
    RETURN    ${email}

Criar Usuario
    [Documentation]    Cria um usuário utilizando um nome, email, senha e status de administrador, retornando a resposta da requisição:

    [Arguments]    ${nome}    ${email}    ${senha}    ${admin}

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=${admin}

    ${response}=    POST On Session
    ...    serverest
    ...    /usuarios
    ...    json=${body}
    ...    expected_status=any

    RETURN    ${response}
