[Documentation]   Testes de API para os endpoints de Produtos

*** Settings ***
Resource    ../resources/produtos.resource
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-P01 Criar produto
    [Tags]    produtos    criacao    smoke
    [Documentation]    Testa a criação de um produto com dados válidos e permissão:

    ${token}=    Criar Usuario E Obter Token    Admin    true
    Criar Produto    ${token}


CT-P02 Criar produto com usuário comum
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto utilizando um token de um usuário sem permissão (administrador=false):

    ${token}=    Criar Usuario E Obter Token    User    false
    Criar Produto    ${token}    403


CT-P03 Excluir produto com ID inválido
    [Tags]    produtos    exclusao
    [Documentation]    Testa a exclusão de um produto utilizando um ID inválido:

    ${token}=    Criar Usuario E Obter Token    Admin    true
    Criar Produto    ${token}
    Excluir Produto    ${token}    UugfO0IlXp0x2Au1


CT-P04 Contrato produto
    [Tags]    produtos    contrato
    [Documentation]    Valida o contrato da resposta da criação de um produto:

    ${token}=    Criar Usuario E Obter Token    Admin    true
    ${res}=    Criar Produto    ${token}
    Validar Contrato Produto    ${res}
