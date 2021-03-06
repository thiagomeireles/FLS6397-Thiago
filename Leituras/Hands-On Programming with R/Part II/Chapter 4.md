| Title    | Author        |Date               | Output      |
|:--------:|:-------------:|:-----------------:|:-----------:|
|Chapter 4 |Thiago Meireles|24 de março de 2017|html_document|
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Chapter 4: R Notation

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
Deve-se observar que isso no se limita a data frames, mas a valores em qualqer objeto do R.

*Negative Integers*

Os negativos inteiros fazem exatamente o oposto, ou seja, retornam todos os elementos do objeto *exceto* o índice negativo.
```
baralho[-(2:52), 1:3]
```
São mais eficientes que os positivos inteiros para formar um subconjunto que inclua maior parte dos dados do data frame ou objeto.
Se tentarmos usar um inteiro negativo com um positivo no mesmo índice, o R no aceitará; mas ele permite que sejam construídos índices positivo e negativo de forma separada para formar um subconjunto de um mesmo objeto, como no exemplo utilizado acima.

*Zero*

Quando utiliza-se o zero, que no é um inteiro positivo ou negativo, o R reconhece como um tipo de subconjunto vazio, retornando nada, ou seja, no  muito útil.
```
baralho[0,0]
```

*Blank Spaces*

Espaços em branco indicam ao R que deve extrair todos os valores de uma dimenso, ou seja, é útil para extrair informaçes de toda uma coluna ou linha de um data frame.
```
baralho[1, ]
```

*Logical Values*

Se criado um vetor de TRUE e FALSE como índice, o R indicar cada TRUE e FALSE para uma linha ou coluna do dta frame. Para funcionar, ele deve possuir a mema dimenso da linha ou coluna a ser lida para formar o subconjunto.
```
baralho[1, c(TRUE, TRUE, FALSE)]
colunas <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
F, F, F, F, F, F, F, F, F, F, F, F, F, F)
baralho[colunas, ]
```

*Names*

É possvel, também, perguntar por elementos pelo nome do objeto, normalmente utilizado para extrair as colunas de um data frame quando possuem nomes.
```
baralho[1, c("carta", "naipe", "valor")]
baralho[ , "valor"]
```

**Deal a card**

*Exercício:*
Complete o seguinte cdigo para gerar uma funço que retorne a primeira linha do data frame:
```
deal1 <- function(cards) {
# ?
}
```
Como saída, pode-se indicar na função criada anteriormente para indicar a primeira linha com todas as colunas:
```
deal <- function() {
  carta <- baralho[1, ]
  assign("baralho", baralho[1, ], envir = globalenv())
  carta
}
deal()
```

**Shuffle Cards**
Em um baralho real, a ordem das cartas é reordenada aleatoriamente no "embaralhar", enquanto o baralho criado possui cada carta em uma linha de forma odernada, de forma que para "embaralhar"  necessrio reordenar as linhas de forma aleatória.
*Como fazer isso?*
Se você quer as linhas reordenadas aleatoriamente, ento voc precisa reordenar as linhas de 1 a 52 e forma aleatria e utilizar os resultados como um índice das linhas e depois gerar um novo data frame reordenado utilizando o índice.
```
aleatorio <- sample(1:52, size = 52)
aleatorio
baralho2 <- baralho[aleatorio, ]
head(baralho2)
```
*Exercício:* Aplique as ideias acima para gerar uma funço de reordenamento do baralho.
```
embaralhar <- function(carta) {
  random <- sample(1:52, size = 52)
  carta[random, ]
}
baralho2 <- embaralhar(baralho)
deal2 <- function() {
  carta <- baralho2[1, ]
  assign("baralho2", baralho2[1, ], envir = globalenv())
  carta
}
carta2 <- deal2()
```

**Dollar Signs and Double Brackets**

Dois tipos de objeto são um segundo sistema opcional de notação.
*Cifrão*
Ele permite extrair valores de listas e data frames, sendo bastante utilizado. Um exemplo de como funciona:
```
baralho$valor
```
Assim, o R retorna todos os valores da coluna como um vetor. A utilidade da notaço porque possibilita observar as varieis dos conjuntos de dados dentro do data frame
*Nesse sentido, você pode utilizar uma funço como mdia e mediana dos valores de uma varivel. Elas esperam um vetor de valor como input e baralho$valor pode ser este vetor.*
```
mean(baralho$valor)
median(baralho$valor)
```
Tambm é possvel utilizar a notação em elementos de uma lista caso tenham nomes, dando uma vantagem aqui tambm. O R retorna uma nova lista com os elementos requisitados, desde que requira aapenas um elemento
```
lista <- list(numeros = c(1, 2), logical = TRUE, strings = c("a", "b", "c"))
lista
lista[1]
```
O resultado  uma lista menor com um elemento, o vetor c(1,2), mas o R no trabalha com listas, de forma que funções como *sum(list[1])* retornam erro.
```
lista$numeros
sum(lista$numeros)
```
Caso os elementos da lista no tenham nomes ou voc prefira no usá-los, pode-se utilizar dois colchetes em vez de um para gerar o subconjunto, oferecendo a mesma coisa que o $. 
```
lista[[1]]
```
