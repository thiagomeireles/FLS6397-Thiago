---
title: "Aula 4 (Tutorial 7)"
author: "Thiago Meireles"
date: "7 de abril de 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tutorial 7: Bases de dados relacionais com a gramática básica do pacote dplyr

```{r}
library(dplyr)
```

**Comparação dos pagamentos entre janeiro de 2011 e janeiro de 2017 no Programa Bolsa Família**

Diferentemente do tutorial anterior em que utilizamos um amostra dos dados, trabalharemos aqui com os dados dos Pagamentos do Bolsa Família em Borá, interior de São Paulo, para os anos de 2011 e 2017.

PS: Depois realizar a construção da base de dados como exercício a partir dos dados disponíveis no Portal da Transpatência.

```{r}
library(readr)
pagamentos11 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/pagamentos11.csv", delim = ";", col_names = T)
pagamentos17 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/pagamentos17.csv", delim = ";", col_names = T)
```

Apesar de semelhantes e com a mesma estrutura, esperamos que hava uma variação entre os anos para os beneficiários e os valores pagos, seja por entrada e saída de indivíduos no programa, seja por mudança de município ou pela alteração de valores em decorrência de reajustes e mudanças na estrutura da família.

"Como descobrir tais mudanças? Como saber quem estava em 2011 e também em 2017? Como calcular a variação dos valores para cada beneficiário?"

**Exercício**

Examine as bases de dados "pagamentos11" e "pagamentos17" antes de começarmos a trabalhar com elas. Faça também as seguintes alterações:

- Renomeie as variáveis "NIS Favorecido", "Nome Favorecido" e "Valor Parcela" para "nis", "nome" e "valor", repectivamente.

```{r}
names(pagamentos11)

# 2011
pagamentos11 <- pagamentos11 %>% 
  rename(nis = `NIS Favorecido`, nome = `Nome Favorecido`, valor = `Valor Parcela`) %>%
  mutate(valor = gsub(",", "", valor), valor = as.numeric(valor)) %>%
  select(nis, nome, valor)
         )

# 2017
pagamentos17 <- pagamentos17 %>% 
  rename(nis = `NIS Favorecido`, nome = `Nome Favorecido`, valor = `Valor Parcela`) %>%
  mutate(valor = gsub(",", "", valor), valor = as.numeric(valor)) %>%
  select(nis, nome, valor)
         )
```

- Transforme a variável valor em numérica.

*Segunda linha da caxa anterior*

- Selecione apenas as três variáveis renomeadas.

*Terceira linha a caixa anterior*

- Quantas linhas tem cada base de dados?

```{r}
dim(pagamentos11)

dim(pagamentos17)
```

**Left e Right Join**

Com as bases preparadas e sabendo que existe variação entre os beneficiários, podemos agrupá-las.

A função *join* tem em uma variável que associe observações de uma base com outra como seu elemento central, *nis* para o nosso caso. As funções *left_join* e *right_join* são combinações que mantém todas as linhas de uma das bases de dados mesmo que não exista correspondência na outra tabela, incluindo, respectivamente, as da segunda que encontram correspondência na primeira e as da primeira que encontram correspondência na segunda.

```{r}
comb_left <- left_join(pagamentos11, pagamentos17, by = "nis")
```

Observando o *left_join*, notamos que o número de observações é exatamente o mesmo de *pagamentos11*. Se utilizarmos a função *View*, veremos que parte dos beneficiários de 2011 não se mantiveram em 2017, representadas pelos *missing values* (NA)

```{r}
View(comb_left)
```

Da mesma forma, vimos que as variáveis *nome* e *valor* foram duplicadas, uma com final *.x* e outra com *.y*. Isso ocorre porque as duas bases possuem variáveis com o mesmo nome, sendo a com final *.x* referentes à primeira e a com final *.y* da segunda. Vamos renomeá-las.

```{r}
comb_left <- comb_left %>% rename(valor11 = valor.x, nome11 = nome.x, 
                                  valor17 = valor.y, nome17 = nome.y)
```

Agora vamos executar o *right_join* das mesmas tabelas:

Vamos deixar de lado rapidamente esta primeira combinação e realizar o "right join" das mesmas tabelas:

```{r}
comb_right <- right_join(pagamentos11, pagamentos17, by = "nis")
```

Novamente, vamos renomear as variáveis:

```{r}
comb_right <- comb_right %>% rename(valor11 = valor.x, nome11 = nome.x, 
                                    valor17 = valor.y, nome17 = nome.y)
```

Vemos que as duas operações são exatamente as mesmas, ocorrendo somente a inversão das tabelas em posição.

```{r}
View(comb_right)
```

**Inner e Full Join**

O *inner join* mantém somente as observações que estão em ambas as tabelas, ou seja, somente agrupa os dados presentes para os dois anos. Assim não são observados *missing values*.

```{r}
comb_inner <- inner_join(pagamentos11, pagamentos17, by = "nis")
comb_inner <- comb_inner %>% rename(valor11 = valor.x, nome11 = nome.x, 
                                    valor17 = valor.y, nome17 = nome.y)
```

Por fim, o *full join* inclui todas as observações de ambas as tabelas, independente de correspondência, inserindo *missing values* onde não há.

```{r}
comb_full <- full_join(pagamentos11, pagamentos17, by = "nis")
comb_full <- comb_full %>% rename(valor11 = valor.x, nome11 = nome.x, 
                                  valor17 = valor.y, nome17 = nome.y)
```

**Semi e anti joins**

"Os quatro tipos de "join" apresentados anteriormente cobrem a totalidade de situações de combinação entre tabelas a partir de um "chave", ou seja, de um índice ou variável que permita estabelecer a relação entre elas.

Há, porém, dois outros tipos de "joins" disponíveis no R bastante úteis.

Se quisermos trabalhar apenas em uma única base de dados, por exemplo, pagamentos11, mas queremos saber quais das observações de 2011 também estão na tabela de 2017, então utilizamos a função _semi\_join_. O resultado será semelhante ao da aplicação de _inner\_join_, mas sem que novas colunas com os dados de 2017 tenham sido criadas:

```{r}
comb_semi <- semi_join(pagamentos11, pagamentos17, by = "nis")
```

Por fim, _anti\_join_, tem comportamento semelhante a _semi\_join_, mas, em vez de retornar as observações de 2011 que têm correspondência em 2017, retorna as que nâo têm par em 2017:

```{r}
comb_anti <- anti_join(pagamentos11, pagamentos17, by = "nis")
```

É perfeitamente possível usar o operador %>% (pipe, como é chamado), para os "joins". Basta colocar a base na posição "x" (primeira a ser inserida) antes do operador. Veja um exemplo:"

```{r}
comb_left <- pagamentos11 %>% left_join(pagamentos17, by = "nis")
```

**Exercício**

Respire fundo e gaste um tempo refletindo sobre os "joins". Você acabou de aprender como operar bancos de dados relacionais e pode parecer bastante difícil num primeiro momento.

**Combinação de tabela e agregações cumulativas**

"Vamos supor que queremos calcular os valores total, médio, máximo, etc, por município e, a seguir, apresentar esses valores como colunas para cada observação. Uma maneira eficiente de fazer isso é a usando a combinação de tabelas. Vamos ver como voltando ao exemplo da amostra de saques do Programa Bolsa Família em 2017."

**Exercício**

Abra a base de dados e faça as transformações necessárias (renomear variáveis e transformar a variável valor em numérica) antes de prosseguir. Tente fazê-lo sem olhar a resposta abaixo.


```{r}
library(readr)
saques_amostra_201701 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/saques_amostra_201701.csv", delim = ";", col_names = T)

names(saques_amostra_201701)

saques_amostra_201701 <- saques_amostra_201701 %>%
  rename(uf = UF,
         cod_munic = `Código SIAFI Município`,
         munic = `Nome Município`,
         nis = `NIS Favorecido`,
         nome = `Nome Favorecido`,
         valor = `Valor Parcela`,
         mes = `Mês Competência`,
         data = `Data do Saque`
         ) %>%
  mutate(gsub(",", "", valor), valor = as.numeric(valor)) %>%
  select(uf, cod_munic, munic, nis, nome, valor, mes, data)
)

```


**PaSsos para agregações cumulativas**

Como exemplo, construiremos uma tabela agrupada por municípios usando *group\_by* e *summarize*:

```{r}
valores_munic <- saques_amostra_201701 %>% 
  group_by(cod_munic) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor),
            mediana = median(valor),
            desvio = sd(valor),
            minimo = min(valor),
            maximo = max(valor))
```

Agora temos dois *data frames*: o original, com os dados no nível individual, e o *valores_munic*, com os valores agrupados a nível municipal. Os dois *data frames* podem ser agrupados utilizando *left_join* e originar uma nova base de dados que acrescenta as colunas da nova tabela à original. 

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  left_join(valores_munic, by = "cod_munic")
```

Observamos que foram acrescentadas 7 novas variáveis à base original que apresentam informações agregadas por município (que se repete para todos os indivíduos daquele município).

```{r}
View(saques_amostra_201701)
```


**Exercício**

- Calcule o total de valores por UF em um novo _data frame_.

```{r}
valores_uf <- saques_amostra_201701 %>%
  group_by(uf) %>%
  summarise(soma_uf = sum(valor))
```

- Combine o novo _data frame_ com o original para levar a coluna de total de valores ao último.

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>%
  left_join(valores_uf, by = "uf")
```

- A seguir, calcule quanto cada indivíduo na amostra representa, em termor percentuais (dica: crie uma nova variável utilizando _mutate_).

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(perc_uf = (valor / soma_uf) * 100)
```


