# Schemas JSON - API ServeRest

Esta pasta contém os schemas JSON para validação de contratos da API ServeRest.

## Arquivos disponíveis

| Arquivo | Descrição | Uso |
|---------|-----------|-----|
| `usuario_schema.json` | Valida resposta de criação de usuário | POST /usuarios |
| `login_schema.json` | Valida resposta de login | POST /login |
| `produto_schema.json` | Valida resposta de criação de produto | POST /produtos |
| `carrinho_schema.json` | Valida resposta de criação de carrinho | POST /carrinhos |
| `compra_concluida_schema.json` | Valida resposta de conclusão de compra | DELETE /carrinhos/concluir-compra |
| `erro_schema.json` | Valida respostas de erro genéricas | Qualquer endpoint com erro |

## Como usar

### 1. Instalar biblioteca necessária

```bash
pip install robotframework-jsonlibrary
```

### 2. Importar no resource

```robot
*** Settings ***
Library    JSONLibrary
Library    OperatingSystem
```

### 3. Criar keyword de validação

```robot
*** Keywords ***
Validar Schema JSON
    [Arguments]    ${response}    ${schema_file}
    ${schema}=    Load JSON From File    ${CURDIR}/../schemas/${schema_file}
    ${json_response}=    Set Variable    ${response.json()}
    Validate Json By Schema File    ${json_response}    ${CURDIR}/../schemas/${schema_file}
```

### 4. Usar nos testes

```robot
CT-A03 Contrato login
    ${email}=    Gerar Email Aleatorio
    Criar Usuario    User Login    ${email}    ${SENHA_USER}    false
    ${res}=    Realizar Login    ${email}    ${SENHA_USER}
    Status Should Be    200    ${res}
    Validar Schema JSON    ${res}    login_schema.json
```

## Estrutura dos schemas

Todos os schemas seguem o padrão JSON Schema Draft-07 e incluem:

- **$schema**: Versão do JSON Schema
- **title**: Título descritivo
- **description**: Descrição do propósito
- **type**: Tipo de dado (object, array, string, etc)
- **properties**: Definição dos campos esperados
- **required**: Lista de campos obrigatórios
- **additionalProperties**: Se permite campos extras (false = rígido, true = flexível)
- **pattern**: Regex para validação de formato
- **enum**: Valores exatos permitidos

## Validações implementadas

### IDs (_id)
- Padrão: 16 caracteres alfanuméricos
- Regex: `^[a-zA-Z0-9]{16}$`

### Token JWT (authorization)
- Padrão: Bearer + JWT (3 partes separadas por ponto)
- Regex: `^Bearer [a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-_]+\.[a-zA-Z0-9\-_]+$`

### Mensagens
- Valores fixos usando `enum` para garantir mensagens exatas
