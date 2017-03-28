```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tutorial 5: Manipulação de dados com a gramática básica do R

O tutorial trata da manipulação de variáveis e observações em um data frame, lidando com boa parte do que se utiliza para organização de dados para pesquisa e se aproximando de outras ferramentas como SPSS, Stata e SAS.

Para cumprir esse objetivo, o foco será no pacote *tydeverse*, não adentrando o pacote *data.tabel*. Essa escolha se dá pela maior simplicidade da liguagem do tydeverse, ainda que em alguns momentos nos deparemos com a "gramática" básica do R e necessitemos conhecê-la, o que se dará em outra etapa.


**Variáveis e data frames**

Aqui trabalharemos com um banco de dados falso (*fake_data*), e, ainda que nos adaptaremos a abrir dados com funções dos pacotes *readr*, *data.table* e *haven*, aqui utilizaremos usar o *read_delim*.
```
library(readr)
url_fake_data <- "https://raw.githubusercontent.com/leobarone/FLS6397/master/data/fake_data.csv"
fake <- read_delim(url_fake_data, delim = ";", col_names = T)
```

A descrição das variáveis do banco de dados está abaixo:

"Fakeland is a very stable democracy that helds presidential elections every 4 years. We are going to work with the fake dataset of Fakeland individual citizens that contains information about their basic fake characteristics and fake political opinions/positions. The variables that our fake dataset are:

- age: age
- sex: sex
- educ: educational level
- income: montly income measured in fake money (FM$)
- savings: total fake money (FM$) in savings account
- marrige: marriage status (yes = married)
- kids: number of children
- party: party affiliation
- turnout: intention to vote in the next election
- vote_history: numbers of presidential elections that turned out since 2002 elections
- economy: opinion about the national economy performance
- incumbent: opinion about the incumbent president performance
- candidate: candidate of preference"


*Exercício*

Utilize as funções que você já conhece -- head, dim, names, str, etc -- para conhecer os dados. Quantas linhas há no data frame? Quantas colunas? Como estão armazenadas cada variável (tipo de dados e classe dos vetores colunas)?

- 30 linhas e 13 colunas: Esta informação aparece nas informações sobre o data frame no Ambiente Global, mas pode ser obtido com a função *dim*.
```
dim(fake)
```
- Os tipos de dados:
```
str(fake)
# age: integer
# sex: character
# educ: character
# income: numeric
# savings: numeric
# marriage: character
# kids: character
# party: character
# turnout: character
# vote_history: integer
# economy: character
# incumbent: character
# candidate: character
```
- Classes:
```
class(fake$age)
# [1] "integer"
class(fake$sex)
# [1] "character"
class(fake$educ)
# [1] "character"
class(fake$income)
# [1] "numeric"
class(fake$savings)
# [1] "numeric"
class(fake$marriage)
# [1] "character"
class(fake$kids)
# [1] "character"
class(fake$party)
# [1] "character"
class(fake$turnout)
# [1] "character"
class(fake$vote_history)
# [1] "integer"
class(fake$economy)
# [1] "character"
class(fake$incumbent)
# [1] "character"
class(fake$candidate)
# [1] "character"
```
