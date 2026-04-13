[Documentation]   Testes de API para os endpoints de Produtos

*** Settings ***

Resource    ../resources/base.resource 
Suite Setup       Criar Sessao
Test Setup        Preparar Usuário Admin
Test Teardown     Limpar Dados Do Teste

*** Test Cases ***

CT-P01 Criar produto
    [Tags]    produtos    criacao    smoke
    [Documentation]    Testa a criação de um produto com dados válidos e permissão.

    ${res}=    Criar Produto    ${TOKEN_ADMIN}  
    Status Should Be    201    ${res}


CT-P02 Criar produto com usuário comum
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto utilizando um token de um usuário sem permissão (administrador=false).

    ${email}=    Gerar Email Para Teste
    ${user}=     Criar Usuario    ${NOME_USER}    ${email}    ${SENHA_USER}    false
    ${token}=    Realizar Login E Obter Token    ${email}    ${SENHA_USER}
    ${res}=      Criar Produto    ${token}
    Status Should Be    403    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Rota exclusiva para administradores


CT-P03 Criar produto sem autenticação
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto sem fornecer token de autenticação.

    ${res}=    Criar Produto    ${EMPTY}
    Status Should Be    401    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

# DOCUMENTAÇÃO DEVERIA SER MAIS ESPECÍFICA QUANTO A ESTE POSSÍVEL STATUS CODE
CT-P04 Criar produto com quantidade inválida
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto com quantidade negativa.

    ${res}=    Criar Produto    ${TOKEN_ADMIN}    quantidade=-5
    Status Should Be    400    ${res}


CT-P05 Listar produtos
    [Tags]    produtos    listagem    smoke
    [Documentation]    Testa a listagem de produtos cadastrados.

    ${res}=    Listar Produtos
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['quantidade']}    ${res.json()['produtos'].__len__()}


CT-P06 Atualizar produto existente
    [Tags]    produtos    atualizacao
    [Documentation]    Testa a atualização de um produto existente via PUT /produtos/{id}.

    ${post}=    Criar Produto    ${TOKEN_ADMIN}
    ${id}=      Set Variable    ${post.json()['_id']}
    ${res}=     Atualizar Produto    ${TOKEN_ADMIN}    ${id}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Registro alterado com sucesso

# BUG IDENTIFICADO (STATUS CODE 400 PARA ID MENOR QUE 16 CARACTERES - TROCADO ID DE: UugfO0IlXp0x2ABC PARA: UugfO0IlXp0x2)
# BUG IDENTIFICADO (RETORNA STATUS CODE 200 AO EXCLUIR PRODUTO COM ID INVÁLIDO)
CT-P07 Excluir produto com ID inválido
    [Tags]    produtos    exclusao
    [Documentation]    Testa a exclusão de um produto utilizando um ID inválido.

    ${res}=    Excluir Produto    ${TOKEN_ADMIN}    UugfO0IlXp0x2
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Nenhum registro excluído


CT-P08 Excluir produto em carrinho
    [Tags]    produtos    exclusao
    [Documentation]    Testa a exclusão de um produto que está em um carrinho ativo.

    ${produto}=     Criar Produto    ${TOKEN_ADMIN}
    ${id_produto}=  Set Variable    ${produto.json()['_id']}
    Criar Carrinho    ${TOKEN_ADMIN}    ${id_produto}
    ${res}=         Excluir Produto    ${TOKEN_ADMIN}    ${id_produto}
    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Não é permitido excluir produto que faz parte de carrinho


CT-P09 Contrato produto
    [Tags]    produtos    contrato
    [Documentation]    Valida o contrato do produto via GET /produtos/{id}.

    ${produto}=    Criar Produto    ${TOKEN_ADMIN}
    Status Should Be    201    ${produto}
    ${id}=      Set Variable    ${produto.json()['_id']}
    ${res}=     Buscar Produto por ID   ${id}
    Status Should Be    200    ${res}
    Validar Contrato Produto    ${res}
