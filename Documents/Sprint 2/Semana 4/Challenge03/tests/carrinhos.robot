*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource
Resource    ../resources/carrinhos.resource
Resource    ../resources/produtos.resource 

Suite Setup    Criar Sessao

*** Test Cases ***

CT-C01 Criar carrinho
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${produto}=    Criar Produto    ${token}
    ${produto_id}=    Set Variable    ${produto.json()['_id']}

    ${res}=    Criar Carrinho    ${token}    ${produto_id}
    Validar Carrinho Criado    ${res}


CT-C02 Criar Carrinho sem token
    ${res}=   Criar carrinho sem token

    Validar Sem Token    ${res}


CT-C03 Produto inválido
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Carrinho    ${token}    id_invalido
    Validar Produto Invalido    ${res}