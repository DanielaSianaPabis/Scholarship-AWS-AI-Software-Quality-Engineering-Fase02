[Documentation]    Recurso de Usuários para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    RequestsLibrary
Library    Collections
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

    ${random}=    Generate Random String    4     [LETTERS]
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


Validar Usuario Cadastrado
    [Documentation]    Valida se o usuário foi criado com sucesso, ataravés do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    201    ${response}


Validar Email Duplicado
    [Documentation]    Valida se a criação do usuário falhou devido a um email duplicado, através do status code da resposta:

    [Arguments]    ${response}
    Status Should Be    400    ${response}


Validar Erro Campos Obrigatórios
    [Documentation]    Valida se a criação do usuário falhou devido à ausência de campos obrigatórios:

    [Arguments]    ${response}

    Status Should Be    400    ${response}