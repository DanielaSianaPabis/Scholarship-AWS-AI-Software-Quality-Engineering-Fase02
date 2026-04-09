[Documentation]    Testes de API para os endpoints de Autenticação

*** Settings ***
Resource    ../resources/autenticacao.resource

Suite Setup    Criar Sessao
Test Setup     Preparar Usuario De Login

*** Test Cases ***
CT-A01 Login válido
    [Tags]    autenticacao    smoke
    [Documentation]    Testa o login com credenciais válidas

    ${res}=    Realizar Login    ${EMAIL_USER}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta   ${res.json()['message']}    Login realizado com sucesso


CT-A02 Login inválido
    [Tags]    autenticacao    validacao
    [Documentation]    Testa o login com credenciais inválidas (senha incorreta)

    ${res}=    Realizar Login    ${EMAIL_USER}    senha_incorreta
    Status Should Be    401    ${res}
    Validar Mensagem Resposta   ${res.json()['message']}    Email e/ou senha inválidos


CT-A03 Contrato login
    [Tags]    autenticacao    contrato
    [Documentation]    Valida o contrato da resposta do login

    ${res}=    Realizar Login    ${EMAIL_USER}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Contrato Login    ${res}
