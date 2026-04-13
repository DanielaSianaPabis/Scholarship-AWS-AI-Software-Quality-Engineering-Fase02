[Documentation]   Testes de API para os endpoints de Carrinhos

*** Settings ***

Resource    ../resources/base.resource 
Resource    ../resources/carrinhos.resource 
Suite Setup       Criar Sessao
Test Setup        Preparar Token E Produto
Test Teardown     Limpar Dados Do Teste

*** Test Cases ***

CT-C01 Criar carrinho com produto válido
    [Tags]    carrinhos    criacao    smoke
    [Documentation]    Testa a criação de um carrinho com um produto válido, token e permissão.

    ${res}=    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}    
    Status Should Be    201    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Cadastro realizado com sucesso


CT-C02 Criar carrinho com produto inválido
    [Tags]    carrinhos    validacao
    [Documentation]    Testa a criação de um carrinho utilizando um ID de produto inválido.

    ${res}=    Criar Carrinho    ${TOKEN_ADMIN}    BbgfO3IlXI4xIII8
    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Produto não encontrado


CT-C03 Criar carrinho com produto duplicado
    [Tags]    carrinhos    validacao
    [Documentation]    Testa que não é possível adicionar o mesmo produto duas vezes em um carrinho.

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    ${res}=    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    Status Should Be    400    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Não é permitido ter mais de 1 carrinho


CT-C04 Validar decremento de estoque após compra
    [Tags]    carrinhos    compra    estoque
    [Documentation]    Valida que a quantidade do produto é decrementada após a conclusão da compra.

    ${antes}=    Buscar Produto por ID    ${ID_PRODUTO}
    ${qtd_antes}=    Set Variable    ${antes.json()['quantidade']}

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO} 
    ${qtd_comprada}=    Set Variable    ${1}
    Concluir Compra    ${TOKEN_ADMIN}

    ${depois}=    Buscar Produto por ID    ${ID_PRODUTO}
    ${qtd_depois}=    Set Variable    ${depois.json()['quantidade']}

    Should Be True    ${qtd_comprada}    ${qtd_antes - ${qtd_depois}}


CT-C05 Cancelar compra
    [Tags]    carrinhos    cancelamento
    [Documentation]    Testa o cancelamento de uma compra com sucesso.

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    ${res}=    Cancelar Compra    ${TOKEN_ADMIN}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Registro excluído com sucesso. Estoque dos produtos reabastecido


CT-C06 Validar retorno de produto ao estoque após cancelamento
    [Tags]    carrinhos    cancelamento    estoque

    ${id_antes}=    Buscar Produto por ID    ${ID_PRODUTO}
    ${json_antes}=    Set Variable    ${id_antes.json()}

    Run Keyword If    'quantidade' not in ${json_antes}    Return From Keyword
    ${quantidade_antes}=    Set Variable    ${json_antes['quantidade']}

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    Cancelar Compra    ${TOKEN_ADMIN}

    ${id_depois}=    Buscar Produto por ID    ${ID_PRODUTO}
    ${json_depois}=    Set Variable    ${id_depois.json()}

    Run Keyword If    'quantidade' not in ${json_depois}    Return From Keyword
    ${quantidade_depois}=    Set Variable    ${json_depois['quantidade']}

    Should Be True    ${quantidade_depois} == ${quantidade_antes}


CT-C07 Concluir uma compra
    [Tags]    carrinhos    compra    smoke
    [Documentation]    Testa a conclusão de uma compra com sucesso.

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    ${res}=    Concluir Compra    ${TOKEN_ADMIN}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Registro excluído com sucesso


CT-C08 Contrato de carrinho
    [Tags]    carrinhos    contrato    
    [Documentation]    Valida o contrato do carrinho via GET /carrinhos.

    Criar Carrinho    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    ${res}=    Buscar Carrinho    ${TOKEN_ADMIN}
    Status Should Be    200    ${res}
    Validar Contrato Carrinho    ${res}


