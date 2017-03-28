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
[1] "integer"

class(fake$sex)
[1] "character"

class(fake$educ)
[1] "character"

class(fake$income)
[1] "numeric"

class(fake$savings)
[1] "numeric"

class(fake$marriage)
[1] "character"

class(fake$kids)
[1] "character"

class(fake$party)
[1] "character"

class(fake$turnout)
[1] "character"

class(fake$vote_history)
[1] "integer"

class(fake$economy)
[1] "character"

class(fake$incumbent)
[1] "character"

class(fake$candidate)
[1] "character"
```

**Data frame como conjunto de vetores**

Para utilizar as variáveis do data frame como vetores, usa-se o símbolo *$* (cifrão) separando o nome do data frame do nome da variável, como no exemplo:

```
print(fake$age)
```
Podemos fazer uma cópia do vetor "age" que não seja variável "fake"? Sim:
```
idade <- fake$age
print(idade)
```
Isto é necessário porque podemos encontrar mais de um data frame no mesmo workspace que possuam variáveis com o mesmo nome. É como se construíssemos um endereço que evita ambiguidade.

*Outros exemplos simples de como usar variáveis de um data frame em outras funções (algumas das quais veremos no futuro, mas você já pode ir se acostumando à linguagem).*

Gráfico de distribuição de uma variável contínua:
```
plot(density(fake$age), main = "Distribuição de Idade", xlab = "Idade")
```
Gráfico de dispersão de duas variáveis contínuas:
```
plot(fake$age, fake$savings, main = "Idade x Poupança", xlab = "Idade", ylab = "Poupança")
```
Tabela de uma variável categórica (contagem):
```
table(fake$party)
```
Tabela de duas entradas para duas variávels categóricas (contagem):
```
table(fake$party, fake$candidate)
```

**Dimensões em um data frame**

O data frame, assim como a matriz, possui as dimensões de linha e coluna. Para selecionar elementos de um data frame podemos utilziar colchetes separados por uma vírgula separando os dois argumentos *[linha, coluna]*, como nos exemplos abaixo:

Quinta linha:
```
fake[5, ]
```
Quinta e a oitava:
```
fake[c(5,8), ]
```
As linhas 4 a 10:
```
fake[4:10,]
```
Segunda coluna:
```
fake[, 2]
```
Note que o resultado é semelhante ao de:
```
fake$sex
```
*No entanto, no primeiro caso estamos produzindo um data frame de uma única coluna, enquanto no segundo estamos produzinho um vetor. Exceto pela classe, são idênticos.*
Segunda e sétima colunas:
```
fake[, c(2,7)]
```
Três primeiras colunas:
```
fake[, 1:3]
```

**Dimensões em um data frame**

O data frame, assim como a matriz, possui as dimensões de linha e coluna. Para selecionar elementos de um data frame podemos utilziar colchetes separados por uma vírgula separando os dois argumentos *[linha, coluna]*, como nos exemplos abaixo:

Quinta linha:
```
fake[5, ]
```
Quinta e a oitava:
```
fake[c(5,8), ]
```
As linhas 4 a 10:
```
fake[4:10,]
```
Segunda coluna:
```
fake[, 2]
```
Note que o resultado é semelhante ao de:
```
fake$sex
```
*No entanto, no primeiro caso estamos produzindo um data frame de uma única coluna, enquanto no segundo estamos produzinho um vetor. Exceto pela classe, são idênticos.*
Segunda e sétima colunas:
```
fake[, c(2,7)]
```
Três primeiras colunas:
```
fake[, 1:3]
```

*Exercício*

Qual é a idade do 17o. indivíduo? Qual é o candidato de preferência do 25o. indivíduo?
- Idade do 17° indivíduo:
```
fake[17, "age"]
# 37
```
- Candidato de preferência do 25°↓ indivíduo;
```
fake[25, "candidate"]
# Trampi
```

**Seleção de colunas com nomes das variáveis**

Assim como feito no exercício anterior, como as colunas possuem nome (fato comum e regra trabalharmos muito mais com os nomes das colunas), podemos utilizar seus nomes no lugar de suas posições para selecioná-las.
```
fake[, c("age", "income", "party")]
```
No entanto, utilizaro o operador ":" não se aplicar porque só se aplica em sequências de números inteiros.
```
fake[, "age":"sex"]
```

"Vamos super que acabamos de abrir os resultados eleitorais do Rio Grande do Sul nas eleições de 2016 retirados do Repositório de Dados Eleitorais do TSE (exatamente como faremos na atividade que segue este tutorial). Há um número grande de colunas desnecessárias a análise dos resultados (por exemplo, o ano da eleição, a hora da extração dos dados, etc). Para liberar memória do computador e trabalhar com um data frame menor, fazemos uma seleção de colunas exatamente como acima, seja usando sua posição ou seu nome e geramos um data frame novo (ou sobrescrevemos o atual). Veja um exemplo com "fake":""
```
new_fake <- fake[, c("age", "income", "party", "candidate")]
```
"E se quiseremos todas as colunas menos "turnout" e "vote_history"? Podemos usar a função setdiff, que gera a diferença entre dois vetores, por exemplo, o vetor com todos os nomes de colunas (gerado com a função names) e o vetor com as colunas que desejamos excluir. Vamos guardar o resultado em "new_fake2"
```
selecao_colunas <- setdiff(names(fake), c("turnout", "vote_history"))
print(selecao_colunas)
new_fake2 <- fake[,selecao_colunas]
```

**Selecionando linhas com o operadores relacionais**

Como selecionar linhas, muito mais numerosas que as colunas, em um banco de dados?

Utilizamos operadores relacionais.

Um exemplo pode ser obtido na seleção dos indivíduos que pretendam votar na próxima eleição (variável *turnout*).

```
fake$turnout == "Yes"
```
Podemos *guardar* esse vetor lógico em um novo objeto.
```
selecao_linhas <- fake$turnout == "Yes"
print(selecao_linhas)
```
Em seguida, inserimos esse vetor lógico na posição das linhas dentro dos colchetes, gerando um novo data frame com os dados que atendam a essa condição:

```
fake_will_vote <- fake[selecao_linhas, ]
```
"Basicamente, para fazermos uma seleção podemos usar a posição das linhas (ou das colunas), seus nomes ou um vetor lógico do mesmo tamanho das linhas (ou colunas). Sequer precisamos fazer o passo a passo acima."

Vejamos um exemplo gerando um data frame com os indivíduos que se posicionam como "Independent":
```
fake_independents <- fake[fake$party == "Independent", ]
```
Também é posível combinar as condições usando os operadores lógicos (*ou*, *e*, *não*) para seleções mais complexas:
```
fake_married_no_college_yong <- fake[fake$marriage == "Yes" & 
                                       fake$age <= 30 & 
                                       !(fake$educ == "College Degree or more"), ]
```

*Exercício*

Produza um novo data frame com apenas 4 variáveis -- "age", "income", "economy" e "candidate" -- e que contenha apenas eleitores homens, ricos ("income" maior que FM$ 3 mil, que é dinheiro pra caramba em Fakeland) e inclinados a votar no candidato "Trampi".
```
fake_conditions <- fake[fake$sex == "Male" &
                          fake$income > 3000 &
                          fake$candidate == "Trampi", c("age", "income", "economy", "candidate")
                        ]
```
Quais as dimensões do novo data frame? Qual é a idade média dos eleitores no novo data frame? Qual é a soma da renda no novo data frame?
- Dimensões: 3 linhas e 4 colunas
```
dim(fake_conditions)
[1] 3 4
```
- Idade média: 35.34 anos
```
mean(fake_conditions$age)
[1] 35.33333
```
- Soma das rendas: 16931.48
```
sum(fake_conditions$income)
[1] 16931.48
```

**Função subset**

A função subset também permite realizar a seleção de linhas, podendo ser entendida como uma maneira mais simples e elegante.
```
fake_independents <- subset(fake, party == "Independent")
```

**Criando uma nova coluna**

Criar uma nova coluna em um data frame é trivial.

Geraremos uma coluna "vazia", ou seja, apenas com "missing values" (*NA* para o R).
```
fake$vazia <- NA
```
Podemos criar uma coluna a partir e outra(s), como no exemplo a seguir com poupança (*savings* convertida para real, sendo um FM$1 = R$ 14) e *savings_year* (média da poupança por anos do indivíduo a partir dos 18)
```
fake$poupanca <- fake$savings / 17
fake$savings_year <- fake$savings / (fake$age - 18)
```
È possível utilizar qualquer operação de vetores vistas nos tutoriais anteriores, **desde que** os vetores tenham sempre o mesmo tamanho, não sendo um problema em data frames.

Caso queiramos substituir o conteúdo de uma variável, o procedimento é o mesmo, mas atribuindo o resultado da operação ao vetor existente.
```
fake$age <- fake$age  * 12
```

**Substituindo valores em um variável**

"Vamos *traduzir* para o português a variável "party". Faremos isso alterando cada uma das categorias individualmente e, por enquanto, sem usar nenhuma função que auxilie a substituição de valores. Começemos com uma tabela simples da variável *party*"
```
table(fake$party)
```
"Agora, observe o resultado do código abaixo:""
```
fake$party[fake$party == "Independent"]
```
"Fizemos um subconjunto de apenas uma variável do data frame, e não do data frame todo. Note a ausência da vírgula dentro do colchetes, pois Se atribuirmos algo a essa selação, por exemplo, o texto *Independentes*, substituiremos os valores da seleção:""
```
fake$party[fake$party == "Independent"] <- "Independente"
```
*"Importante: a seleção do vetor (colchetes) está à direita do símbolo de atribuição."*

```
table(fake$party)
```

*Exercício*
Traduza para o português as demais categorias da variável "party".
- Traduzindo a categoria *Conservative Party*
```
fake$party[fake$party == "Conservative Party"] <- "Partido Convervador"
```
- Traduzindo a categoria *Socialist Party*
```
fake$party[fake$party == "Socialist Party"] <- "Partido Socialista"
```
- Observando a tabela com os novos nomes
```
table(fake$party)
```   
|Independente | Partido Convervador| Partido Socialista |
|:-----------:|:------------------:|:------------------:|
|     15      |         6          |         9          |

          
**Substituição com o comando replace**

Também é possível substituir valores em uma mesma variável com a função replace, como no exemplo a seguir.
```
fake$sex <- replace(fake$sex, fake$sex == "Female", "Mulher")
fake$sex <- replace(fake$sex, fake$sex == "Male", "Homem")
table(fake$sex)
```
|Homem|Mulher| 
|:---:|:----:| 
|15   |  15  |

