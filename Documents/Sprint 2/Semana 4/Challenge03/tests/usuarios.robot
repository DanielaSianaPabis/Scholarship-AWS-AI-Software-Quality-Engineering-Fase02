*** Settings ***
Resource    ../resources/usuarios.resource
Resource    ../resources/autenticacao.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-U01 Criar usuário
    ${email}=    Gerar Email Aleatorio 
    ${res}=    Criar Usuario    user    ${email}    ${SENHA_USER}    false
    Validar Usuario Cadastrado    ${res}

CT-U02 Criar usuário com email duplicado
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    user    ${email}    ${SENHA_USER}    false
    ${res}=    Criar Usuario    user2    ${email}    ${SENHA_USER}    false
    Validar Email Duplicado    ${res}

CT-U03 Contrato listagem de usuários
    ${res}=    Listar Usuarios
    Validar Contrato Usuarios    ${res}