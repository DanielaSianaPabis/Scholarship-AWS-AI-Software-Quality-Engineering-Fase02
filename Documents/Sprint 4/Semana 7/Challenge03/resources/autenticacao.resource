[Documentation]   Recurso de Autenticação para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../variables/variables.robot
Resource   base.resource 
Resource   usuarios.resource 

*** Keywords ***

Realizar Login
    [Documentation]    Realiza o login na API ServeRest utilizando email e senha, retornando a resposta da requisição.

    [Arguments]    ${email}    ${senha}
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}


Obter Token
    [Documentation]    Extrai o token de autenticação da resposta do login.

    [Arguments]    ${response}
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}


Validar Contrato Login
    [Documentation]    Valida contrato do login: estrutura, tipos, mensagem e token JWT.

    [Arguments]    ${response}
    
    ${json}=    Set Variable    ${response.json()}
    
    Validar Campos Obrigatórios    ${json}    message    authorization

    Validar Tipo Campo    ${json['message']}    string
    Validar Tipo Campo    ${json['authorization']}    string

    Validar Mensagem Resposta    ${json['message']}    Login realizado com sucesso
    Validar Token JWT    ${json['authorization']}


Preparar Usuario De Login
    [Documentation]    Gera email aleatório, cria usuário e salva o email como variável de teste.

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=     Set Variable    user_${random}@email.com
    Criar Usuario    ${NOME_USER}    ${email}    ${SENHA_USER}    false
    Set Test Variable    ${EMAIL_USER}    ${email}


Realizar Login E Obter Token
    [Documentation]    Faz login com as credenciais fornecidas e retorna o token JWT.
    ...                Falha se o login não retornar 200.

    [Arguments]    ${email}    ${senha}
    ${res}=     Realizar Login    ${email}    ${senha}
    Validar Status Da Resposta    200    ${res}
    ${token}=   Obter Token    ${res}
    RETURN    ${token}


Preparar Token Admin
    [Documentation]    Cria usuário admin, realiza login e salva TOKEN_ADMIN como variável de teste.

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=     Set Variable    admin_${random}@email.com
    ${res}=       Criar Usuario    Admin User    ${email}    ${SENHA_USER}    true
    ${login}=     Realizar Login    ${email}    ${SENHA_USER}
    ${token}=     Obter Token    ${login}
    Set Test Variable    ${TOKEN_ADMIN}    ${token}
