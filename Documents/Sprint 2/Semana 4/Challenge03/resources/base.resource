*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/variables.robot

*** Keywords ***
Criar Sessao
    Create Session    serverest    ${BASE_URL}

Criar Header Com Token
    [Arguments]    ${token}
    ${headers}=    Create Dictionary
    ...    Authorization=${token}
    RETURN    ${headers}