[Documentation]   Testes de API para os endpoints de Produtos

*** Settings ***
Resource    ../resources/produtos.resource
Resource    ../resources/autenticacao.resource
Resource    ../resources/carrinhos.resource 

Suite Setup    Criar Sessao
Test Setup     Preparar Token Admin

*** Test Cases ***
CT-P01 Criar produto
    [Tags]    produtos    criacao    smoke
    [Documentation]    Testa a criação de um produto com dados válidos e permissão:
    ${res}=    Criar Produto    ${TOKEN_ADMIN}
    Status Should Be    201    ${res}


CT-P02 Criar produto com usuário comum
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto utilizando um token de um usuário sem permissão (administrador=false):

    Gerar Email Para Teste
    ${user}=     Criar Usuario    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false
    ${token}=    Realizar Login E Obter Token    ${EMAIL_USER}    ${SENHA_USER}
    ${res}=      Criar Produto    ${token}
    Status Should Be    403    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Rota exclusiva para administradores


CT-P03 Excluir produto com ID inválido
    [Tags]    produtos    exclusao
    [Documentation]    Testa a exclusão de um produto utilizando um ID inválido:

    ${res}=    Excluir Produto    ${TOKEN_ADMIN}    UugfO0IlXp0x2Au1
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Nenhum registro excluído


CT-P04 Contrato produto
    [Tags]    produtos    contrato
    [Documentation]    Valida o contrato do produto via GET /produtos/{id}:

    ${post}=    Criar Produto    ${TOKEN_ADMIN}
    Status Should Be    201    ${post}
    ${id}=      Set Variable    ${post.json()['_id']}
    ${res}=     Buscar Produto por ID   ${id}
    Status Should Be    200    ${res}
    Validar Contrato Produto    ${res}


CT-P05 Criar produto sem autenticação
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto sem fornecer token de autenticação:

    ${res}=    Criar Produto    ${EMPTY}
    Status Should Be    401    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais


CT-P06 Listar produtos
    [Tags]    produtos    listagem    smoke
    [Documentation]    Testa a listagem de produtos cadastrados:

    ${res}=    Listar Produtos
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['quantidade']}    ${res.json()['produtos'].__len__()}


CT-P07 Excluir produto em carrinho
    [Tags]    produtos    exclusao
    [Documentation]    Testa a exclusão de um produto que está em um carrinho ativo:

    ${produto}=     Criar Produto    ${TOKEN_ADMIN}
    ${id_produto}=  Set Variable    ${produto.json()['_id']}
    Criar Carrinho    ${TOKEN_ADMIN}    ${id_produto}
    ${res}=         Excluir Produto    ${TOKEN_ADMIN}    ${id_produto}
    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Não é permitido excluir produto que faz parte de carrinho


CT-P08 Criar produto com quantidade inválida
    [Tags]    produtos    validacao
    [Documentation]    Testa a criação de um produto com quantidade negativa:

    ${res}=    Criar Produto    ${TOKEN_ADMIN}    quantidade=-5
    Status Should Be    400    ${res}
    Should Be Equal    ${res.json()['quantidade']}    quantidade deve ser maior ou igual a 0


CT-P09 Atualizar produto existente
    [Tags]    produtos    atualizacao
    [Documentation]    Testa a atualização de um produto existente via PUT /produtos/{id}:

    ${post}=    Criar Produto    ${TOKEN_ADMIN}
    ${id}=      Set Variable    ${post.json()['_id']}
    ${res}=     Atualizar Produto    ${TOKEN_ADMIN}    ${id}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Registro alterado com sucesso
