[Documentation]    Testes de API para os endpoints de Autenticação

*** Settings ***

Resource    ../resources/base.resource
Suite Setup       Criar Sessao
Test Setup        Preparar Usuario De Login
Test Teardown     Limpar Dados Do Teste

*** Test Cases ***

CT-A01 Login válido
    [Tags]    autenticacao    smoke 
    [Documentation]    Testa o login com credenciais válidas

    ${res}=    Realizar Login    ${EMAIL_USER}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Mensagem Resposta   ${res.json()['message']}    Login realizado com sucesso


CT-A02 Login com senha incorreta
    [Tags]    autenticacao    validacao
    [Documentation]    Testa o login com senha incorreta

    ${res}=    Realizar Login    ${EMAIL_USER}    senha_incorreta
    Status Should Be    401    ${res}
    Validar Mensagem Resposta   ${res.json()['message']}    Email e/ou senha inválidos


CT-A03 Login com email inexistente
    [Tags]    autenticacao    validacao  
    [Documentation]    Não permite login com email inexistente

    ${email_inexistente}=    Set Variable    inexistente_${EMAIL_USER}
    ${res}=    Realizar Login    ${email_inexistente}    ${SENHA_USER}

    Status Should Be    401    ${res}
    Validar Mensagem Resposta    ${res.json()['message']}    Email e/ou senha inválidos


CT-A04 Login com campos em branco
    [Tags]    autenticacao    validacao    negativo
    [Documentation]    Testa o login com email e senha vazios

    ${res}=    Realizar Login    ${EMPTY}    ${EMPTY}
    Status Should Be    400    ${res}

# TESTE DE CARGA COM 50 LOGINS SIMULTÂNEOS RETORNA, em certos momentos, STATUS CODE 401, O QUE EVIDENCIA PROBLEMA DE CONCORRÊNCIA NA API
CT-A05 Múltiplos logins simultâneos
    [Tags]    autenticacao    concorrencia    stress
    [Documentation]    Testa 50 logins simultâneos com o mesmo usuário para validar concorrência.

    ${tokens}=    Realizar Multiplos Logins    ${EMAIL_USER}    ${SENHA_USER}    50
    
    ${total}=    Get Length    ${tokens}
    Should Be Equal As Integers    ${total}    50
    
    ${res}=    Listar Usuarios
    Status Should Be    200    ${res}


CT-A06 Login sem campo password
    [Tags]    autenticacao    validacao    negativo
    [Documentation]    Testa login sem enviar o campo password no body.
    ${res}=    Realizar Login Sem Campo Password    ${EMAIL_USER}
    Status Should Be    400    ${res}


CT-A07 Contrato login
    [Tags]    autenticacao    contrato
    [Documentation]    Valida o contrato da resposta do login.

    ${res}=    Realizar Login    ${EMAIL_USER}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Contrato Login    ${res}









