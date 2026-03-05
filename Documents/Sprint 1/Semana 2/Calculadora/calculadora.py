class Calculadora:
    """
    Classe destinada as operações matemáticas
    """

    def soma(self, operando1, operando2):
        return operando1 + operando2
    
    def subtracao(self, operando1, operando2):
        return operando1 - operando2
    
    def multiplicacao(self, operando1, operando2):
        return operando1 * operando2
    
    def divisao(self, dividendo, divisor):
        """
        Verificação para possível caso:
        """
        if divisor == 0:
            raise ZeroDivisionError("Não é possível dividir por zero")
        return dividendo / divisor
    
    def potencia(self, base, expoente):
        return base ** expoente
    
    """
    Função definida apenas para o conjunto dos reais (R)
    Não suporta resultados complexos (números imaginários)
    """
    def raiz(self, indice, radicando):
        """
        Verificação para possíveis casos:
        """
        if indice == 0:
            raise ValueError("O índice não pode ser zero")
        if radicando < 0:
            if indice % 2 == 0:
                raise ValueError("Não existe solução real para radicando negativo com índice par")
            """
            Solução real para radicando negativo e índice ímpar:
            """
            return -((- radicando) ** (1 / indice))
        """
        Solução real para demais casos:
        """
        return radicando ** (1 / indice)
