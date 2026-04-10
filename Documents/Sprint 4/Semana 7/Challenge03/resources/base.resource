[Documentation]   Recurso Base para a API ServeRest, contendo configurações e keywords comuns para os testes

*** Settings ***
Library    RequestsLibrary
Library    String 
Library    Collections
Resource   ../variables/variables.robot 

*** Keywords ***

Criar Sessao
    [Documentation]    Cria uma sessão para a API ServeRest utilizando a URL base definida nas variáveis:

    Create Session    serverest    ${BASE_URL}    verify=true


Criar Header Com Token
    [Documentation]    Cria um header de autenticação utilizando o token fornecido:

    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Authorization=${token}
    RETURN    ${headers}


Validar Campos Obrigatórios
    [Arguments]    ${json}    @{campos}

    FOR    ${campo}    IN    @{campos}
        Dictionary Should Contain Key    ${json}    ${campo}
    END


Validar Status Da Resposta
    [Arguments]    ${status_esperado}    ${response}
    Status Should Be    ${status_esperado}    ${response}


Validar Mensagem Resposta  
    [Arguments]    ${mensagem_obtida}    ${mensagem_esperada}

    Should Be Equal    ${mensagem_obtida}    ${mensagem_esperada}


Validar Tipo Campo
    [Arguments]    ${valor}    ${tipo}

    IF    '${tipo}' == 'string'
        Should Be String    ${valor}
    ELSE IF    '${tipo}' == 'number'
        Should Be True    isinstance($valor, (int, float))
    ELSE IF    '${tipo}' == 'boolean'
        Should Be True    isinstance($valor, bool)
    ELSE
        Fail    Tipo desconhecido: ${tipo}
    END


Validar ID
    [Arguments]    ${id}

    Should Be String    ${id}
    Should Not Be Empty    ${id}
    
    ${length}=    Get Length    ${id}
    Should Be True    ${length} >= 16


Validar Token JWT
    [Arguments]    ${authorization}

    Should Start With    ${authorization}    Bearer${SPACE}

    ${token_parts}=    Split String    ${authorization}    ${SPACE}    max_split=1
    Length Should Be    ${token_parts}    2

    ${token}=    Get From List    ${token_parts}    1
    Should Not Be Empty    ${token}

    ${jwt_parts}=    Split String    ${token}    .
    Length Should Be    ${jwt_parts}    3

    FOR    ${part}    IN    @{jwt_parts}
        Should Not Be Empty    ${part}
    END

    ${token_length}=    Get Length    ${token}
    Should Be True    ${token_length} > 20

