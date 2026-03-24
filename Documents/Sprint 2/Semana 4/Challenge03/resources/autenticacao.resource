*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/variables.robot
Resource   base.resource

*** Keywords ***
Realizar Login
    [Arguments]    ${email}    ${senha}
    ${body}=    Create Dictionary    email=${email}    password=${senha}

    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}

Obter Token 
    [Arguments]    ${response}
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}

Validar Login Sucesso
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    authorization

Validar Login Invalido
    [Arguments]    ${response}
    Status Should Be    401    ${response}

Validar Contrato Login
    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    message
    Dictionary Should Contain Key    ${json}    authorization