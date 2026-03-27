[Documentation]   Recurso Base para a API ServeRest, contendo configurações e keywords comuns para os testes

*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   ../variables/variables.robot

*** Keywords ***

Criar Sessao
    [Documentation]    Cria uma sessão para a API ServeRest utilizando a URL base definida nas variáveis:

    Create Session    serverest    ${BASE_URL}

Criar Header Com Token
    [Documentation]    Cria um header de autenticação utilizando o token fornecido:

    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=${token}
    RETURN    ${headers}
