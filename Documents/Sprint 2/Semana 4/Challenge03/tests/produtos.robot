[Documentation]   Testes de API para os endpoints de Produtos

*** Settings ***
Resource    ../resources/produtos.resource
Resource    ../resources/autenticacao.resource
Resource    ../resources/usuarios.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT-P01 Criar produto
    [Documentation]    Testa a criação de um produto com dados válidos e permissão:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Admin    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Produto Criado    ${res}
    

CT-P02 Criar produto com usuário comum
    [Documentation]    Testa a criação de um produto utilizando um token de um usuário sem permissão (administrador=false):

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User    ${email}    ${SENHA_USER}    false

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Sem Permissao    ${res}


CT-P04 Excluir produto com ID inválido
    [Documentation]    Testa a exclusão de um produto utilizando um ID inválido:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Admin    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Produto Criado    ${res}
    
    ${res}=    Excluir Produto   ${token}    UugfO0IlXp0xMFN2
    Validar Exclusão Produto Inválido    ${res}


CT-P04 Contrato produto
    [Documentation]    Valida o contrato da resposta da criação de um produto:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    Admin    ${email}    ${SENHA_USER}    true

    ${login}=    Realizar Login    ${email}    ${SENHA_USER}
    ${token}=    Obter Token    ${login}

    ${res}=    Criar Produto    ${token}
    Validar Produto Criado    ${res}
    Validar Contrato Produto    ${res}
