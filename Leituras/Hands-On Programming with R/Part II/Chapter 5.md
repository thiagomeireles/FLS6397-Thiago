| Title    | Author        |Date               | Output      |
|:--------:|:-------------:|:-----------------:|:-----------:|
|Chapter 5 |Thiago Meireles|24 de março de 2017|html_document|
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Chapter 5: Modifying values

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

Você pode comparar dois objetos do R com operadores lgicos, mas faz mais sentido se comparar dois objetos do mesmo tipo de dados. Se comparar objetos de diferentes tipos o R usa suas regras de coerção para evitar a comparação.

*Exercício:* Extraia a coluna carta de baralho2 e teste se cada valor é igual ao ás. Como desafio, use o R para countar rapidamente quantas cartas so iguais ao ás.
```
baralho2$carta
baralho2$carta == "As"

sum(baralho2$carta == "As")
```
Como Exercício adicional, localizaremos as cartas em um terceiro baralho "embaralhado"
```
baralho3 <- baralho[aleatorio, ]

baralho3$carta == "As"
```

Em síntese, os testes lógicos permitem selecionar valores dentro de um objeto; já os subconjuntos lógicos são uma ótima ferramenta para identificar, extrair e modificar valores individuais no conjunto de dados.

*Exercício:*
Assinale um valor de 1 para cada carta no baralho4 que seja de copas.
```
baralho4 <- baralho
baralho4$valor <- 0
baralho4$naipe == "Copas"
baralho4$valor[baralho4$naipe == "Copas"] <- 1
baralho4$valor[baralho4$naipe == "Copas"]
```

**Boolean Operators**

Operadores booleanos combinam mútiplos testes lógicos em um único teste.

*Exercise*
Tente converter estas sentenças em testes com o código R a partir de objetos definidos:
```
w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "Fevereiro"
z <- c("Segunda", "Terça", "Quarta")
```
- w é positivo?
```
w > 0
[1] FALSE FALSE  TRUE
```
- x é maior que 10 e menor que 20?
```
x > 10 & x < 20
[1] FALSE  TRUE
```
- O objeto y é a palavra "Fevereiro"?
```
y == "Fevereiro"
[1] TRUE
```
- Todos os valores em z são dias da semana?
```
dias_semana <- c("Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado")

all(z %in% dias_semana)
[1] TRUE
```
Trazendo um último jogo, o *blackjack* (Vinte e um), no qual todas as figuras tem um valor igual a sua carta, sendo o valor de 10 aplicado ao rei, rainha e valete, e os Ases recebendo valor de 10 ou 1, dependendo do resultado final do jogo. Vamos aplicar os valores corretos a essas cartas a partir de um baralho novo.
```
baralho5 <- baralho
```
Vamos, primeiro, aplicar o valor de 10 às figuras.
```
figuras <- baralho5$carta %in% c("Rei", "Rainha", "Valete")
baralho5$valor[figuras] <- 10
head(baralho5, 13)
```
O valor que o "Ás" assume depende das outras cartas nas mãos do jogador, sendo, assim, um caso de falta de informação.

**Missing Information**

___na.rm___

Muitas das funções do R vem com argumentos opcionais, sendo o *na.rm* responsável por ignorar NAs na hora de executar uma função, uma vez que qualquer operação que contenha missings é reconhecida como missing pelo R. Vejamos um exemplo:
```
c(NA, 1:50)

mean(c)
[1] NA
Warning message:
In mean.default(c) : argumento não é numérico nem lógico: retornando NA

mean(c(NA, 1:50))
[1] NA

mean(c(NA, 1:50), na.rm = TRUE)
[1] 25.5
```

___is.na___

Assim como as funções, os operadores lógicos também possuem dificuldades em encontrar os *missing values* no R, assim adota-se a função *is.na* para lidar com a situação. Vejamos:
```
NA == NA
[1] NA

c(1, 2, 3, NA) == NA
[1] NA NA NA NA

is.na(NA)
[1] TRUE

vec <- c(1, 2, 3, NA)
is.na(vec)
[1] FALSE FALSE FALSE  TRUE
```

Assim, a saída encontrada para lidar com o baralho de *blackjack* seria atribuir um valor NA aos Ases para indicar que não se sabe o valor final de cada "ÁS", além de previnir pontuações acidentais em uma mão antes de determinar seu valor:
```
baralho5$valor[baralho5$carta == "As"] <- NA
head(baralho5, 13)

    carta   naipe valor
1     Rei Espadas    10
2  Rainha Espadas    10
3  Valete Espadas    10
4     Dez Espadas    10
5    Nove Espadas     9
6    Oito Espadas     8
7    Sete Espadas     7
8    Seis Espadas     6
9   Cinco Espadas     5
10 Quatro Espadas     4
11   Tres Espadas     3
12   Dois Espadas     2
13     As Espadas    NA
```
