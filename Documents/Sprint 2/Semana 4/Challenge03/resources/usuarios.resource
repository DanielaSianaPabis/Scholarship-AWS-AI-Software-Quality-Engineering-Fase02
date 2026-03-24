*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource   ../variables/variables.robot
Resource   base.resource

*** Keywords ***
Gerar Email Aleatorio
    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=    Set Variable    user_${random}@email.com
    RETURN    ${email}

Criar Usuario
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

Listar Usuarios
    ${response}=    GET On Session    serverest    /usuarios
    RETURN    ${response}

Validar Usuario Cadastrado
    [Arguments]    ${response}
    Status Should Be    201    ${response}

Validar Email Duplicado
    [Arguments]    ${response}
    Status Should Be    400    ${response}

Validar Contrato Usuarios
    [Arguments]    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    quantidade
    Dictionary Should Contain Key    ${json}    usuarios