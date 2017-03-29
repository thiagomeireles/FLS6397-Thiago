| Title    | Author        |Date               | Output      |
|:--------:|:-------------:|:-----------------:|:-----------:|
|Chapter 2 |Thiago Meireles|17 de março de 2017|html_document|
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Chapter 2: Packages and Help Pages

O capítulo tem duas metas principais em termos de execução: (1) ver se o dado é justo e (2) viciá-lo

Como utilizará o 'qplot' para visualizar se o dado é justo, é necessário instalar o pacote ggplot2
```
install.packages("ggplot2")
```

Após a instalação, é necessário carregar o pacote instalado antes utilizá-lo em toda nova sessão do R
```
library(ggplot2)
```

*Vamos testar o qplot?*

Para isso, criaremos os vetores para o plano cartersiano, x e y:
```
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
y <- x^3
qplot(x, y)
``` 
Vimos que os eixos x e y formam um scatterplot.

*E para ver a distribuição de apenas uma dessas variáveis?*
Podemos usar o histograma, mas, para isso, criaremos um novo vetor no qual valores se repitam:
```
z <- c(1, 2, 3 ,2 ,2, 4, 4, 5, 6, 2)
qplot(z, binwidth = 1)
qplot(z, bins = 5)
```
Nota-se que são duas as opções para definir a largura de cada barra. A primeira é mais prática, especialmente porque utilizamos bases com muitas observações e teremos maior dificuldade em interpretar o gráfico.

Removendo os vetores criados
```
rm(x, y, z)
```

*Usando o histograma para ver se o dado é justo*
- Primeiro, recriamos a função para jogar o dado duas vezes, como no Capítulo 1:
```
die <- 1:6
roll <- function() {
  die <- 1:6
  dice <- sample(x = die, size = 2, replace = TRUE)
  sum(dice)
}
```
- Utilizamos a função  "replicate" para simular 10.000 jogadas gerando um data frame para criar um histograma
```
replicate(10000, roll())
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)
```
Como o histograma se aproximará de uma pirâmide, sabemos que os dados são justos.

*Mas, e agora? Como gerar um dado "injusto"?*
Vamos olhar para a ajuda da função sample e ver o que ela nos diz
```
?sample()
??sample()
```

Apesar do pacote nos indicar somente que existe o argumento "prob", não nos indica como funciona. Nesse caso, deve-se saber que são indicadas as probabilidades de cada um dos valores seguindo a ordem do vetor construído.

Aqui atribuiremos que o número 6 tem 3 vezes mais chances de sair quando comparado aos outros valores do dado
```
die <- 1:6
roll2 <- function() {
  die <- 1:6
  dice <- sample(x = die, size = 2, replace = TRUE, prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}
rolls2 <- replicate(10000, roll2())
qplot(rolls2, binwidth = 1)
```

Caso utilizássemos uma amostra menor, digamos 10 jogadas, não teríamos a ideia do dado viciado. Isso só é possível em decorrência da grande amostra utilizada.
