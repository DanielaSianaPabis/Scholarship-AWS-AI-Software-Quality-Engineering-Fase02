[Documentation]   Recurso de Autenticação para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***

Resource   ../variables/variables.robot 
Resource   usuarios.resource 
Resource   base.resource 

*** Keywords ***

Realizar Login
    [Documentation]    Realiza o login  utilizando email e senha, retornando a resposta da requisição.

    [Arguments]    ${email}    ${senha}
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}

Realizar Login Sem Campo Password
    [Documentation]    Realiza o login utilizando apenas email, sem campo password, retornando a resposta da requisição.

    [Arguments]    ${email}
    ${body}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}

Realizar Login E Obter Token
    [Documentation]    Faz login com as credenciais fornecidas e retorna o token JWT.
    ...                Falha se o login não retornar 200.

    [Arguments]    ${email}    ${senha}
    ${res}=     Realizar Login    ${email}    ${senha}
    Validar Status Da Resposta    200    ${res}
    ${token}=   Obter Token    ${res}
    RETURN    ${token}

Obter Token
    [Documentation]    Extrai o token de autenticação da resposta do login.

    [Arguments]    ${response}
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}

Preparar Usuario De Login
    [Documentation]    Gera email aleatório, cria usuário e salva o email e ID como variável de teste.

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=     Set Variable    user_${random}@email.com
    ${res}=       Criar Usuario    ${NOME_USER}    ${email}    ${SENHA_USER}    false
    ${id}=        Set Variable    ${res.json()['_id']}
    Set Test Variable    ${EMAIL_USER}    ${email}
    Set Test Variable    ${ID_USER}    ${id}

Preparar Usuário Admin 
    [Documentation]    Cria usuário admin, realiza login e salva TOKEN_ADMIN e ID_ADMIN como variável de teste.

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=     Set Variable    user_${random}@email.com
    ${res}=       Criar Usuario    Admin User    ${email}    ${SENHA_USER}    true
    ${id}=        Set Variable    ${res.json()['_id']}
    ${login}=     Realizar Login    ${email}    ${SENHA_USER}
    ${token}=     Obter Token    ${login}
    Set Test Variable    ${TOKEN_ADMIN}    ${token}
    Set Test Variable    ${ID_ADMIN}    ${id}

Realizar Multiplos Logins   
    [Documentation]    Realiza múltiplos logins e retorna lista de tokens gerados.
    [Arguments]    ${email}    ${senha}    ${quantidade}=50

    @{tokens}=    Create List
    
    FOR    ${i}    IN RANGE    ${quantidade}
        ${res}=    Realizar Login    ${email}    ${senha}
        Validar Status Da Resposta    200    ${res}
        ${token}=    Obter Token    ${res}
        Append To List    ${tokens}    ${token}
    END
    
    RETURN    ${tokens}

Validar Contrato Login 
    [Documentation]    Valida o contrato da resposta de login usando o schema JSON
    [Arguments]    ${response}

    Validar Contrato    ${response}    login_schema.json
