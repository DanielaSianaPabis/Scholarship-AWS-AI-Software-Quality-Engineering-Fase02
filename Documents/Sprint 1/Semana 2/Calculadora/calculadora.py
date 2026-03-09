class Calculadora:
    """
    Classe destinada as operações matemáticas
    """

    def soma(self, parcela1, parcela2):
        return parcela1 + parcela2
    
    def subtracao(self, minuendo, subtraendo):
        return minuendo - subtraendo
    
    def multiplicacao(self, multiplicando, multiplicador):
        return multiplicando * multiplicador
    
    def divisao(self, dividendo, divisor):
        if divisor == 0:
            raise ZeroDivisionError("Não é possível dividir por zero")
        return dividendo / divisor
    
    def potencia(self, base, expoente):
        return base ** expoente
    
    
    def raiz(self, indice, radicando):
        """
        Função definida apenas para o conjunto dos reais (R)
        Não suporta resultados complexos (números imaginários)
        """
        if indice == 0:
            raise ValueError("O índice não pode ser zero")
        if radicando < 0:
            if indice % 2 == 0:
                raise ValueError("Não existe solução real para radicando negativo com índice par")
            
            # Solução real para radicando negativo e índice ímpar:
            return -((- radicando) ** (1 / indice))

        # Solução real para demais casos:
        return radicando ** (1 / indice)
