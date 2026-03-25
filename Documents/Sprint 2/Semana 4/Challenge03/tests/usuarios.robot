[Documentation]    Testes de API para os endpoints de Usuários

*** Settings ***
Resource    ../resources/usuarios.resource
Resource    ../resources/autenticacao.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-U01 Criar usuário
    [Documentation]    Testa a criação de um usuário com dados válidos:

    ${email}=    Gerar Email Aleatorio 
    ${res}=    Criar Usuario    user    ${email}    ${SENHA_USER}    false
    Validar Usuario Cadastrado    ${res}

CT-U02 Criar usuário com email duplicado
    [Documentation]    Testa a criação de um usuário utilizando um email duplicado:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    user    ${email}    ${SENHA_USER}    false
    ${res}=    Criar Usuario    user2    ${email}    ${SENHA_USER}    false
    Validar Email Duplicado    ${res}

CT-U03 Cadastro com campos vazios
    [Documentation]    Testa a criação de um usuário contendo campos com strings vazias:

    ${email}=    Gerar Email Aleatorio
    ${res}=    Criar Usuario    ''    ${email}    ''    false
    Validar Erro Campos Obrigatórios    ${res}