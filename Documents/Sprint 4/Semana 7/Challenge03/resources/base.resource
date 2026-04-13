[Documentation]   Recurso Base para a API ServeRest, contendo configurações e keywords comuns para os testes

*** Settings ***
Library    RequestsLibrary
Library    String 
Library    Collections
Library    OperatingSystem
Resource   ../variables/variables.robot 
Resource   usuarios.resource 
Resource   autenticacao.resource
Resource   produtos.resource  
Resource   carrinhos.resource   

*** Keywords ***

Criar Sessao
    [Documentation]    Cria uma sessão para a API utilizando a URL base definida nas variáveis.

    Create Session    serverest    ${BASE_URL}    verify=true


Criar Header Com Token
    [Documentation]    Cria um header de autenticação utilizando o token fornecido.
    [Arguments]    ${token}

    ${headers}=    Create Dictionary    Authorization=${token}
    RETURN    ${headers}


Validar Status Da Resposta
    [Documentation]    Valida o status code da resposta da requisição.
    [Arguments]    ${status_esperado}    ${response}

    Status Should Be    ${status_esperado}    ${response}


Validar Mensagem Resposta  
    [Documentation]    Valida a mensagem de resposta da requisição.
    [Arguments]    ${mensagem_obtida}    ${mensagem_esperada}

    Should Be Equal    ${mensagem_obtida}    ${mensagem_esperada}


Validar Contrato
    [Documentation]    Valida o contrato da resposta da requisição utilizando um arquivo de schema JSON.
    [Arguments]    ${response}    ${schema_file}

    ${json_data}=    Set Variable    ${response.json()}
    ${schema_path}=    Set Variable    ${CURDIR}/../schemas/${schema_file}
    ${schema_content}=    Get File    ${schema_path}
    
    Evaluate    __import__('jsonschema').validate(${json_data}, __import__('json').loads(r'''${schema_content}'''))    modules=jsonschema,json


Limpar Dados Do Teste
    [Documentation]    Limpa dados criados durante o teste (carrinho, produto e usuário).
    ...                Ignora erros caso os recursos já tenham sido excluídos ou não existam.

    ${token_existe}=    Run Keyword And Return Status    Variable Should Exist    ${TOKEN_ADMIN}
    IF    ${token_existe}
        Run Keyword And Ignore Error    Concluir Compra    ${TOKEN_ADMIN}
        Run Keyword And Ignore Error    Cancelar Compra    ${TOKEN_ADMIN}
        Run Keyword And Ignore Error    Excluir Produto    ${TOKEN_ADMIN}    ${ID_PRODUTO}
    END
    Run Keyword And Ignore Error    Excluir Usuario    ${ID_ADMIN}
    Run Keyword And Ignore Error    Excluir Usuario    ${ID_USER}


Gerar Email Para Teste     
    [Documentation]    Gera email aleatório, salva como variável de teste e retorna o email.

    ${random}=    Generate Random String    5     [LETTERS]
    ${email}=    Set Variable    user_${random}@email.com
    Set Test Variable    ${EMAIL_USER}    ${email}
    RETURN    ${email}
