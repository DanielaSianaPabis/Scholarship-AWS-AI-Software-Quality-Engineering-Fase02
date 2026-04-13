[Documentation]    Testes de API para os endpoints de Usuários

*** Settings ***

Resource    ../resources/usuarios.resource  
Suite Setup    Criar Sessao
Test Setup     base.Gerar Email Para Teste
Test Teardown  Limpar Dados Do Teste

*** Test Cases ***

CT-U01 Criar usuário
    [Tags]    usuarios    criacao    smoke
    [Documentation]    Testa a criação de um usuário com dados válidos.

    ${res}=      Criar Usuario    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false 

    Status Should Be    201    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Cadastro realizado com sucesso


CT-U02 Criar usuário com email duplicado
    [Tags]    usuarios    validacao
    [Documentation]    Testa a criação de um usuário utilizando um email duplicado.

    Criar Usuario    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false
    ${res}=      Criar Usuario    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false

    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Este email já está sendo usado


CT-U03 Criar usuário com campos vazios
    [Tags]    usuarios    validacao
    [Documentation]    Testa a criação de um usuário contendo campos com strings vazias.

    ${res}=      Criar Usuario    ''    ${EMAIL_USER}    ''    false
    Status Should Be    201    ${res}


CT-U04 Listar usuários
    [Tags]    usuarios    listagem    smoke
    [Documentation]    Testa a listagem de usuários cadastrados.

    ${res}=    Listar Usuarios

    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['quantidade']}    ${res.json()['usuarios'].__len__()}


CT-U05 Atualizar usuário existente
    [Tags]    usuarios    atualizacao
    [Documentation]    Testa a atualização de um usuário existente via PUT /usuarios/{id}:

    ${id}=       Criar Usuario E Obter ID    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false
    ${res}=      Atualizar Usuario    ${id}    Usuario Atualizado    ${EMAIL_USER}    ${SENHA_USER}    true

    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Registro alterado com sucesso


CT-U06 Excluir usuário com carrinho ativo
    [Tags]    usuarios    exclusao    negativo
    [Documentation]    Testa a exclusão de um usuário que possui carrinho ativo via DELETE /usuarios/{id}.
    
    ${id}=        Criar Usuario E Obter ID    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    true
    ${token}=     Realizar Login E Obter Token    ${EMAIL_USER}    ${SENHA_USER}
    ${id_produto}=     Criar Produto E Obter ID    ${token}
    Criar Carrinho    ${token}    ${id_produto}

     ${res}=         Excluir Usuario    ${id}
    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Não é permitido excluir usuário com carrinho cadastrado


CT-U07 Contrato usuário
    [Tags]    usuarios    contrato
    [Documentation]    Valida o contrato do usuário via GET /usuarios/{id}.

    ${res_id}=     Criar Usuario E Obter ID    ${NOME_USER}    ${EMAIL_USER}    ${SENHA_USER}    false

    ${res}=      Buscar Usuario por ID    ${res_id}

    Status Should Be    200    ${res}
    Validar Contrato Usuario    ${res}







