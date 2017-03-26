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
