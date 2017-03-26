# Chapter 4

Agora que temos o baralho, utilizamos a função "deal" para pegar uma carta.
```
deal <- function() {
  carta <- baralho[1, ]
  assign("baralho", baralho[-1, ], envir = globalenv())
  carta
}
deal()
```

**Selecting Values**
Para extrair um valor de um objeto do R, utiliza-se o nome ddo objeto com dois valores em branco entre chaves separados por vírgula.
```
baraho[ , ]
```
Os espaços em branco entre as chaves so os índices, que têm a funço de dizer ao R quais valores apresentar, de forma que o primeiro índice representa o conjunto das linhas e o segundo das colunas do data frame.

São seis as diferentes formas de se escrever um índice no R, os quais veremos a seguir.

*Positive Integers*

O R trata os inteiros positivos como a notação *ij* da álgebra linear, retornando o valor que representa a *inésima* linha da *j-ésima* coluna.
```
head(baralho)
baralho[1,1]
```
Para extrair mais de um valor, utiliza-se um vetor de positivos inteiros:
``` 
baralho[1, c(1, 2, 3)]
``` 
O R no retira esses valores do objeto, retornando ao fim da operaço. Caso queira-se extrair, é feito com a construço de um vetor.
```
novo <- baralho[1, c(1:3)]
novo
```
Deve-se observar que isso no se limita a data frames, mas a valores em qualqer objetio do R.

*Negative Integers*
