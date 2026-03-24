*** Settings ***
Resource    ../resources/produtos.resource
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-P01 Criar produto
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Admin    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Produto Criado    ${res}
    

CT-P02 Criar produto com usuário comum
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    false

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Sem Permissao    ${res}


CT-P03 Criar produto sem token
    ${res}=  Criar produto sem token  
    Validar Sem Token    ${res}


CT-P04 Contrato produto
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Admin    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Contrato Produto    ${res}