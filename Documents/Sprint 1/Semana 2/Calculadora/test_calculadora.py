import pytest
from calculadora import Calculadora

"""
Testes unitários para a classe Calculadora
"""

"""
Testes que contemplam resultados decimais (divisão e radiciação) usam, para exemplo, 'pytest.approx' e 'rel' para tolerância
"""

@pytest.fixture
def calculadora():
    return Calculadora()

# Testes para soma
@pytest.mark.parametrize("parcela1, parcela2, resultado",
    [
        (2, 9, 11),
        (-1, 1, 0),
        (7, 0, 7),
        (-2, -2, -4)
    ],
)
def test_soma(calculadora, parcela1, parcela2, resultado):
    assert calculadora.soma(parcela1, parcela2) == resultado

#Testes para subtração
@pytest.mark.parametrize("minuendo, subtraendo, resultado",
    [
        (8, 7, 1),
        (7, 8, -1),
        (-7, -7, 0),
        (-2, 2, -4)
    ],
)
def test_subtracao(calculadora, minuendo, subtraendo, resultado):
    assert calculadora.subtracao(minuendo, subtraendo) == resultado

#Testes para multiplicação
@pytest.mark.parametrize("multiplicando, multiplicador, resultado",
    [
        (4, 5, 20),
        (4, 1, 4),
        (0, 4, 0),
        (4, -5, -20),
    ],
)
def test_multiplicacao(calculadora, multiplicando, multiplicador, resultado):
    assert calculadora.multiplicacao(multiplicando, multiplicador) == resultado

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
    with pytest.raises(ZeroDivisionError) as exec_info:
        calculadora.divisao(4, 0)
    assert "Não é possível dividir por zero" in str(exec_info)

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
    with pytest.raises(ValueError) as exec_info:
        calculadora.raiz(0, 225)
    assert "O índice não pode ser zero" in str(exec_info)

def test_raiz_negativa_indice_par(calculadora):
    with pytest.raises(ValueError) as exec_info:
        calculadora.raiz(12, -64)
    assert "Não existe solução real para radicando negativo com índice par" in str(exec_info)
