import pytest
from calculadora import Calculadora

"""
Testes unitários para a classe Calculadora
"""

"""
Uso de 'pytest.mark.parametrize' para executar o mesmo teste, mas com diferentes valores de entrada e saída

Testes que contemplam resultados decimais (divisão e radiciação) usam, para exemplo, 'pytest.approx' e 'rel' para tolerância
"""

@pytest.fixture
def calculadora():
    """
    Cria e retorna uma instância da classe Calculadora, o que evita repetição de código
    """
    return Calculadora()

# Testes para soma
@pytest.mark.parametrize("operando1, operando2, resultado",
    [
        (2, 9, 11),
        (-1, 1, 0),
        (7, 0, 7),
        (-2, -2, -4)
    ],
)
def test_soma(calculadora, operando1, operando2, resultado):
    assert calculadora.soma(operando1, operando2) == resultado

#Testes para subtração
@pytest.mark.parametrize("operando1, operando2, resultado",
    [
        (8, 7, 1),
        (7, 8, -1),
        (-7, -7, 0),
        (-2, 2, -4)
    ],
)
def test_subtracao(calculadora, operando1, operando2, resultado):
    assert calculadora.subtracao(operando1, operando2) == resultado

#Testes para multiplicação
@pytest.mark.parametrize("operando1, operando2, resultado",
    [
        (4, 5, 20),
        (4, 1, 4),
        (0, 4, 0),
        (4, -5, -20),
    ],
)
def test_multiplicacao(calculadora, operando1, operando2, resultado):
    assert calculadora.multiplicacao(operando1, operando2) == resultado

#Testes para divisão (2 casos)
@pytest.mark.parametrize("dividendo, divisor, resultado",
    [
        (10, 2, 5),
        (2, 5, 0.4),
        (-8, 2, -4),
        (2.5, 2.5, 1),
        (1, 3, pytest.approx(0.333, rel=1e-2)),
    ],
)
def test_divisao(calculadora, dividendo, divisor, resultado):
    assert calculadora.divisao(dividendo, divisor) == resultado

def test_divisao_por_zero(calculadora):
    """
    Teste para o caso de divisão por zero. Verificando se é lançada a excessão de 'ZeroDivisionError'
    """
    with pytest.raises(ZeroDivisionError):
        calculadora.divisao(4, 0)

#Testes para potência
@pytest.mark.parametrize("base, expoente, resultado",
    [
        (2, 4, 16),
        (16, 0, 1),
        (4, 0.5, 2),
        (-2, 3, -8),
    ],
)
def test_potencia(calculadora, base, expoente, resultado):
    assert calculadora.potencia(base, expoente) == resultado

#Testes para raíz (3 casos)
@pytest.mark.parametrize("indice, radicando, resultado",
    [
        (2, 144, 12),
        (3, 27, 3),
        (3, -8, -2),
        (2, 10, pytest.approx(3.162, rel=1e-2)),
    ],
)
def test_raiz(calculadora, indice, radicando, resultado):
    assert calculadora.raiz(indice, radicando) == resultado

def test_raiz_indice_zero(calculadora):
    """
    Teste para o caso de índice zero. Verificando se é lançada a excessão de 'ValueError'
    """
    with pytest.raises(ValueError):
        calculadora.raiz(0, 225)

def test_raiz_negativa_indice_par(calculadora):
    """
    Teste para o caso de índice par e radicando negativo. Verificando se é lançada a excessão de 'ValueError'
    """
    with pytest.raises(ValueError):
        calculadora.raiz(12, -64)
