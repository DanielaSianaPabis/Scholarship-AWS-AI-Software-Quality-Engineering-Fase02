[Documentation]    Testes de API para os endpoints de Autenticação

*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-A01 Login válido
    [Documentation]    Testa o login com credenciais válidas
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    true

    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Validar Login Sucesso    ${res}


CT-A02 Login inválido
    [Documentation]    Testa o login com credenciais inválidas (senha incorreta)
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    true

    ${res}=    Realizar Login    ${email}    senha_incorreta
    Validar Login Invalido    ${res}


CT-A03 Contrato login
    [Documentation]    Valida o contrato da resposta do login
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    false

    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Validar Login Sucesso    ${res}
    Validar Contrato Login    ${res}