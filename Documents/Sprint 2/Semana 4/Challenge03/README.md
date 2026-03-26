# Testes Automatizados - API ServeRest (Challenge 03) 

## Objetivo do Projeto 

Este projeto tem como objetivo validar os principais fluxos da **API ServeRest** (<https://compassuol.serverest.dev/>), utilizando testes automatizados com **Robot Framework**. 

Foram implementados testes para cenários como: 
- Cadastro e login de usuários 
- Criação e exclusão de produtos 
- Criação de carrinho 
- Conclusão de compra 
- Validações de regras de negócio e contratos de resposta 

--- 

## Tecnologias utilizadas 
- Python (v 3.14.3) 
- Robot Framework (v 7.4.2) 
- RequestsLibrary (v 0.9.7) 

--- 

## Ambiente de desenvolvimento utilizado
- Visual Studio Code (v 1.113.0)

## Instalação das dependências 

### 1. Instalar o Python 

Baixe e instale o Python (versão 3.x.x). Para mais, acesse: <https://www.python.org/> 

Verifique a instalação:
```bash
python --version
```

### 2. Instalar Robot

Instale o Robot Framework:

```bash
pip install robotframework
```

Verifique a instalação:
```bash
robot --version
```

Instale a biblioteca RequestsLibrary: 

```bash
pip install robotframework-requests
```

Verifique a instalação:
```bash
pip show requests
```

--- 

## Como executar os testes 

### Para Executar todos os testes 

Execute em seu terminal:
```bash
robot -d results/todos tests/
```

### Para executar suítes individuais 

Execute em seu terminal:
```bash
robot -d results/[nome_pasta] tests/[nome_arquivo].robot
```
*Ex: robot -d results/usuarios tests/usuarios.robot* 

## Evidências dos testes 

Após a execução individual ou conjunta das suítes, serão gerados os seguintes arquivos (já presentes), em results/: 
- log.html: fornece detalhes completos da execução 
- report.html: fornece resumo dos testes 
- output.xml: arquivo bruto da execução 

## Como visualizar 

Acesse o terminal e insira:
```bash
start results
```

Abrirá o local onde seus arquivos de results estão armazenados. Selecione a pasta e o arquivo desejado para sua vizualização.

