[Documentation]   Recurso de Autenticação para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/variables.robot
Resource   base.resource

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

Validar Login Sucesso
    [Documentation]    Valida se o login foi realizado com sucesso, verificando o status code e a presença do token na resposta:

    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    authorization

Validar Login Invalido
    [Documentation]    Valida se o login falhou, verificando o status code e a mensagem de erro na resposta:

    [Arguments]    ${response}
    Status Should Be    401    ${response}

Validar Contrato Login
    [Documentation]    Valida o contrato da resposta do login, verificando a presença de 'message' e 'authorization':

    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    authorization