# Schemas JSON - API ServeRest (Challenge 04)

Esta pasta contém os schemas JSON para validação de contratos da API ServeRest nos testes automatizados.

## Schemas disponíveis

| Schema | Endpoint | Teste | Descrição |
|--------|----------|-------|-----------|
| `login_schema.json` | POST /login | CT-A03 | Valida resposta de login com sucesso |
| `usuario_schema.json` | GET /usuarios/{id} | CT-U07 | Valida resposta de busca de usuário por ID |
| `produto_schema.json` | GET /produtos/{id} | CT-P09 | Valida resposta de busca de produto por ID |
| `carrinho_schema.json` | GET /carrinhos | CT-C07 | Valida resposta de busca de carrinhos |
| `produto_schema.json` | GET /produtos | - | Valida resposta de busca de produto |

## Estrutura dos schemas

Todos os schemas seguem o padrão **JSON Schema Draft-07** e incluem:

- **Campos obrigatórios**: Definidos em `required`
- **Tipos de dados**: string, integer, array, object
- **Validações de formato**: Regex para IDs, tokens JWT, emails
- **Valores permitidos**: `enum` para mensagens fixas
- **Restrições numéricas**: `minimum` para valores não negativos
- **Campos extras**: `additionalProperties: false` (não permite)

## Testes de contrato

Os schemas são usados nos seguintes testes:

- **CT-A03**: Contrato de login
- **CT-U07**: Contrato de usuário
- **CT-P09**: Contrato de produto
- **CT-C07**: Contrato de carrinho

Cada teste valida automaticamente a estrutura completa da resposta da API usando o schema correspondente.
