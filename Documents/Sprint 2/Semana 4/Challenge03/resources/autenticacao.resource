[Documentation]   Recurso de Autenticação para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../variables/variables.robot
Resource   base.resource
Resource   usuarios.resource

*** Keywords ***

Realizar Login
    [Documentation]    Realiza o login na API ServeRest utilizando email e senha, retornando a resposta da requisição:

    [Arguments]    ${email}    ${senha}
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}

Obter Token
    [Documentation]    Extrai o token de autenticação da resposta do login:

    [Arguments]    ${response}
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}

Criar Usuario E Obter Token
    [Documentation]    Cria um usuário com email aleatório, realiza login e retorna o token de autenticação:

    [Arguments]    ${nome}    ${admin}
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    ${nome}    ${email}    ${SENHA_USER}    ${admin}
    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}
    RETURN    ${token}

Validar Contrato Login
    [Documentation]    Valida os elementos do contrato da resposta do login:

    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    authorization
    Should Be Equal    ${json['message']}    Login realizado com sucesso
    Should Start With    ${json['authorization']}    Bearer
    Should Not Be Empty    ${json['authorization']}
