[Documentation]    Testes de API para os endpoints de Autenticação

*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-A01 Login válido
    [Tags]    autenticacao    smoke
    [Documentation]    Testa o login com credenciais válidas
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    true
    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Status Should Be    200    ${res}


CT-A02 Login inválido
    [Tags]    autenticacao    validacao
    [Documentation]    Testa o login com credenciais inválidas (senha incorreta)
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    true
    ${res}=    Realizar Login    ${email}    senha_incorreta
    Status Should Be    401    ${res}


CT-A03 Contrato login
    [Tags]    autenticacao    contrato
    [Documentation]    Valida o contrato da resposta do login
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    false
    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Contrato Login    ${res}
