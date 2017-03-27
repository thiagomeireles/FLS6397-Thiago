# Chapter 5: Modifying values

Antes de começar a manipular o dataframe, criaremos uma cópia.
```
baralho2 <- baralho
```

**Changing values in place**

*Substituição:* uma das formas de editar os dados  pela substituição simples do valor pré-definido.
```
vetor <- c(0, 0, 0, 0, 0)
vetor
vetor[1]
vetor[1] <- 1000
vetor
```
A substituição também pode ser múltipla, ou seja, alterando mais de um valor ao mesmo tempo indicando os valores originais que devem ser substitudos e os novos a serem atribuídos.
```
vetor[c(1, 3, 5)] <- c(1, 1, 1,)
vetor
vetor[c(3:5)] <- vetor[3:5] +1
vetor
```
*Adição:*Também é possível criar novos valores.
```
vetor[6] <- 1
```
O que pode ser útil para atribuir os valores das cartas do baralho considerando jogos com outras pontuações.
```
baralho2$new <- 1:52
head(baralho2)
```
*Remoção:* Da mesma forma, tambm  possível remover colunas.
```
baralho2$new <- NULL
head(baralho2)
```
*Exemplo:* No jogo "guerra", o Ás recebe o valor de 14 e no de 1. Vamos fazer a substituição.
```
# Primeiro confirmamos quais as observações relativas aos azes.
baralho2[c(13, 26, 39, 52), ]
baralho2[c(13, 26, 39, 52), 3]
baralho2$valor[c(13, 26, 39, 52)]
# Vistos os valores, a substituição:
baralho2$valor[c(13, 26, 39, 52)] <- c(14, 14, 14, 14)
baralho2[c(13, 26, 39, 52), ]
# ou
baralho2$valor[c(13, 26, 39, 52)] <- 14
baralho2[c(13, 26, 39, 52), ]
```
O mesmo procedimento se aplica a vetores, matrizez, arranjos, listas ou data frames.
Mas e se no soubermos quais as observações queremos alterar? Como pedir ao R para indicar esses valores?

**Logical Subsetting**

Utilizamos, para localizar a posição das observaçes que queremos alterar, a ideia de valores lógicos.
```
vetor
vetor[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE)]
```
Ainda que não aparente muita utilidade, veremos como se aplica na localização das observações.

**Logical Tests**
Voc pode comparar dois objetos do R com operadores lgicos, mas faz mais sentido se comparar dois objetos do mesmo tipo de dados. Se comparar objetos de diferentes tipos o R usa suas regras de coerção para evitar a comparação.
*Exercício:* Extraia a coluna carta de baralho2 e teste se cada valor é igual ao ás. Como desafio, use o R para countar rapidamente quantas cartas so iguais ao ás.
```
baralho2$carta
baralho2$carta == "Ás"

```
