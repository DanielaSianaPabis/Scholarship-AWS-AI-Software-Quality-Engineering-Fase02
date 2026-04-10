[Documentation]    Recurso de Usuários para a API ServeRest, contendo as keywords necessárias para aplicação nos testes

*** Settings ***
Library    String
Resource   ../variables/variables.robot
Resource   base.resource 
Resource   autenticacao.resource 

*** Keywords ***

Gerar Email Para Teste
    [Documentation]    Gera email aleatório e salva como variável de teste:

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=    Set Variable    user_${random}@email.com
    Set Test Variable    ${EMAIL_USER}    ${email}

Criar Usuario
    [Documentation]    Cria um usuário utilizando um nome, email, senha e status de administrador, retornando a resposta da requisição:

    [Arguments]    ${nome}    ${email}    ${senha}    ${admin}

    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=${admin}

    ${response}=    POST On Session
    ...    serverest
    ...    /usuarios
    ...    json=${body}
    ...    expected_status=any

     RETURN    ${response}


Excluir Usuario
    [Documentation]    Exclui um usuário pelo ID na API ServeRest:

    [Arguments]    ${id}
    ${response}=    DELETE On Session    serverest    /usuarios/${id}    expected_status=any
    RETURN    ${response}


Atualizar Usuario
    [Documentation]    Atualiza um usuário pelo ID na API ServeRest:

    [Arguments]    ${id}    ${nome}    ${email}    ${senha}    ${admin}
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${senha}
    ...    administrador=${admin}
    ${response}=    PUT On Session    serverest    /usuarios/${id}    json=${body}    expected_status=any
    RETURN    ${response}


Buscar Usuario por ID 
    [Documentation]    Busca um usuário pelo ID na API ServeRest:

    [Arguments]    ${id}
    ${response}=    GET On Session    serverest    /usuarios/${id}    expected_status=any
    RETURN    ${response}


Listar Usuarios
    [Documentation]    Lista todos os usuários cadastrados na API ServeRest:

    ${response}=    GET On Session    serverest    /usuarios    expected_status=any
    RETURN    ${response}


Validar Contrato Usuario
    [Documentation]    Valida contrato do usuário via GET: estrutura, tipos e valores persistidos

    [Arguments]    ${response}

    ${json}=    Set Variable    ${response.json()}

    Validar Campos Obrigatórios    ${json}    nome    email    password    administrador    _id

    Validar Tipo Campo    ${json['nome']}            string
    Validar Tipo Campo    ${json['email']}           string
    Validar Tipo Campo    ${json['password']}        string
    Validar Tipo Campo    ${json['administrador']}   string
    Validar Tipo Campo    ${json['_id']}             string

    Validar ID    ${json['_id']}


Criar Usuario E Obter ID
    [Documentation]    Cria um usuário e retorna seu ID.
    ...                Falha imediatamente se o cadastro não retornar 201.
    [Arguments]    ${nome}    ${email}    ${senha}    ${administrador}=false
    ${res}=    Criar Usuario    ${nome}    ${email}    ${senha}    ${administrador}
    Validar Status Da Resposta    201    ${res}
    RETURN    ${res.json()['_id']}