[Documentation]   Testes de API para os endpoints de Carrinhos

*** Settings ***
Resource    ../resources/autenticacao.resource
Resource    ../resources/carrinhos.resource 
Resource    ../resources/produtos.resource 

Suite Setup    Criar Sessao

*** Test Cases ***
CT-C01 Criar carrinho
    [Tags]    carrinhos    criacao    smoke
    [Documentation]    Testa a criação de um carrinho com um produto válido, token e permissão:

    ${token}=    Criar Usuario E Obter Token    User    true
    ${produto}=    Criar Produto    ${token}
    ${produto_id}=    Set Variable    ${produto.json()['_id']}
    Criar Carrinho    ${token}    ${produto_id}


CT-C02 Produto inválido
    [Tags]    carrinhos    validacao
    [Documentation]    Testa a criação de um carrinho utilizando um ID de produto inválido:

    ${token}=    Criar Usuario E Obter Token    User    true
    Criar Carrinho    ${token}    BbgfO3IlXI4xIII8    400


CT-C03 Concluir uma compra
    [Tags]    carrinhos    compra    smoke
    [Documentation]    Testa a conclusão de uma compra com sucesso:

    ${token}=    Criar Usuario E Obter Token    User    true
    ${produto}=    Criar Produto    ${token}
    ${produto_id}=    Set Variable    ${produto.json()['_id']}
    Criar Carrinho    ${token}    ${produto_id}
    Concluir Compra    ${token}
