*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-A01 Login válido
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Teste Login    ${email}    ${SENHA_USER}    true

    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Validar Login Sucesso    ${res}

CT-A02 Login inválido
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Teste Login    ${email}    ${SENHA_USER}    true

    ${res}=    Realizar Login    ${email}    senhaincorreta
    Validar Login Invalido    ${res}

CT-A03 Contrato login
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Teste Login    ${email}    ${SENHA_USER}    true

    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Validar Contrato Login    ${res}