# Testes Automatizados - API ServeRest (Challenge 04) 

## Sobre o Projeto

Este projeto é uma **evolução do Challenge 03**, com melhorias na estrutura, validações e qualidade dos testes automatizados da **API ServeRest** (<https://compassuol.serverest.dev/>), utilizando **Robot Framework**.

### Melhorias implementadas no Challenge 04:

**Validação de contratos com JSON Schema**
- Implementação de schemas JSON para validação automática de contratos
- 4 schemas criados (login, usuário, produto, carrinho)
- Validações completas de estrutura, tipos e formatos

**Otimização de keywords**
- 32 keywords customizadas organizadas por domínio
- Keywords reutilizáveis e documentadas
- Separação clara de responsabilidades

**Validações de estoque aprimoradas**
- Validação de decremento após compra
- Validação de retorno ao estoque após cancelamento
- Lógica flexível e parametrizável

**Estrutura de projeto profissional**
- Organização por domínios (usuarios, produtos, carrinhos, autenticacao)
- Resources específicos para cada módulo
- Documentação completa com README em schemas/

---

## Cenários de Teste

### Total: 31 cenários automatizados

| Módulo | Cenários | Descrição |
|--------|----------|-----------|
| **Usuários** | 7 | Criação, listagem, atualização, exclusão e validação de contrato |
| **Produtos** | 9 | CRUD completo, validações de permissão e contrato |
| **Autenticação** | 7 | Login válido/inválido, múltiplos logins, validação de contrato |
| **Carrinhos** | 8 | Criação, compra, cancelamento, validação de estoque e contrato |

---

## Tecnologias utilizadas

- Python (v 3.14.3)
- Robot Framework (v 7.4.2)
- RequestsLibrary (v 0.9.7)
- jsonschema (v 4.26.0) - **Novo no Challenge 04**

---

## Ambiente de desenvolvimento

- Visual Studio Code (v 1.113.0)

---

## Instalação das dependências

### 1. Instalar o Python

Baixe e instale o Python (versão 3.x.x): <https://www.python.org/>

Verifique a instalação:
```bash
python --version
```

### 2. Instalar Robot Framework

```bash
pip install robotframework
```

Verifique a instalação:
```bash
robot --version
```

### 3. Instalar bibliotecas necessárias

```bash
pip install robotframework-requests
pip install jsonschema
```

Verifique a instalação:
```bash
pip show requests
pip show jsonschema
```

---

## Estrutura do Projeto

```
Challenge04/
├── resources/           # Keywords customizadas por domínio
│   ├── base.resource
│   ├── usuarios.resource
│   ├── produtos.resource
│   ├── autenticacao.resource
│   └── carrinhos.resource
├── schemas/            # Schemas JSON para validação de contratos
│   ├── login_schema.json
│   ├── usuario_schema.json
│   ├── produto_schema.json
│   ├── carrinho_schema.json
│   └── README.md
├── tests/              # Suítes de testes
│   ├── usuarios.robot
│   ├── produtos.robot
│   ├── autenticacao.robot
│   └── carrinhos.robot
├── variables/          # Variáveis globais
│   └── variables.robot
├── results/            # Relatórios de execução
└── README.md
```

---

## Como executar os testes

### Executar todos os testes

```bash
robot -d results/todos tests/
```

### Executar suítes individuais

```bash
robot -d results/[nome_pasta] tests/[nome_arquivo].robot
```

**Exemplos:**
```bash
robot -d results/usuarios tests/usuarios.robot
robot -d results/produtos tests/produtos.robot
robot -d results/autenticacao tests/autenticacao.robot
robot -d results/carrinhos tests/carrinhos.robot
```

### Executar testes por tag

```bash
robot -d results/smoke -i smoke tests/
robot -d results/contrato -i contrato tests/
```

---

## Evidências dos testes

Após a execução, são gerados automaticamente em `results/`:

- **log.html**: Detalhes completos da execução
- **report.html**: Resumo dos testes executados
- **output.xml**: Arquivo bruto da execução

### Visualizar resultados

```bash
start results
```

Ou acesse diretamente os arquivos HTML no navegador.

---

## Diferenciais do Challenge 04

- **Validação de contratos automatizada** com JSON Schema
- **32 keywords reutilizáveis** organizadas por domínio
- **Maior cobertura** das keywords criadas
- **Documentação** em todos os módulos
- **Validações robustas** de regras de negócio