[Documentation]   Testes de API para os endpoints de Carrinhos

*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource
Resource    ../resources/carrinhos.resource 
Resource    ../resources/produtos.resource 

Suite Setup    Criar Sessao

*** Test Cases ***

CT-C01 Criar carrinho
    [Documentation]    Testa a criação de um carrinho com um produto válido, token e permissão:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${produto}=    Criar Produto    ${token}
    ${produto_id}=    Set Variable    ${produto.json()['_id']}

    ${res}=    Criar Carrinho    ${token}    ${produto_id}
    Validar Carrinho Criado    ${res}


CT-C02 Acessar Carrinho sem autenticação
    [Documentation]    Testa o acesso de um carrinho sem fornecer um token e a autenticação:

    ${res}=    Acessar carrinho sem autenticação
    Validar Carrinho Sem Autenticação    ${res}


CT-C03 Produto inválido
    [Documentation]    Testa a criação de um carrinho utilizando um ID de produto inválido:
    
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Carrinho    ${token}    id_invalido
    Validar Produto Invalido    ${res}