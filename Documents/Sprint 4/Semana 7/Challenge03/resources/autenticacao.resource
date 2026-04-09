[Documentation]   Recurso de Autenticação para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../variables/variables.robot
Resource   base.resource
Resource   usuarios.resource

*** Keywords ***

Realizar Login
    [Documentation]    Realiza o login na API ServeRest utilizando email e senha, retornando a resposta da requisição:

    [Arguments]    ${email}    ${senha}
    ${body}=    Create Dictionary    email=${email}    password=${senha}
    ${response}=    POST On Session    serverest    /login    json=${body}    expected_status=any
    RETURN    ${response}


Obter Token
    [Documentation]    Extrai o token de autenticação da resposta do login:

    [Arguments]    ${response}
    ${token}=    Set Variable    ${response.json()['authorization']}
    RETURN    ${token}

Preparar Usuario De Login
    [Documentation]    Gera email aleatório, cria usuário e salva o email como variável de teste:

    ${email}=    Gerar Email Aleatorio
    Criar Usuario    ${NOME_USER}    ${email}    ${SENHA_USER}    false
    Set Test Variable    ${EMAIL_USER}    ${email}


Validar Contrato Login
    [Documentation]    Valida contrato do login: estrutura, tipos, mensagem e token JWT

    [Arguments]    ${response}
    
    ${json}=    Set Variable    ${response.json()}
    
    Validar Campos Obrigatórios    ${json}    message    authorization

    Validar Tipo Campo    ${json['message']}    string
    Validar Tipo Campo    ${json['authorization']}    string

    Validar Mensagem Resposta    ${json['message']}    Login realizado com sucesso
    Validar Token JWT    ${json['authorization']}
