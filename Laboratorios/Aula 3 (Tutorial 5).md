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

**Recodificando uma variável**

Outra função importante é a recodificação de uma variável, como no exemplo de transformar uma variável contíuna (*income*) em uma variável categórica (*rich*), com ricos com renda maior a FM$ 3 mil para *rich* e *not rich* para rendas menores.
```
fake$rich <- NA
fake$rich[fake$income > 3000] <- "rich"
fake$rich[fake$income <= 3000] <- "not rich"
table(fake$rich)
```
|not rich  |   rich   |
|:--------:|:--------:|
|19        | 11       |


*Exercício*

Utilize o que você aprendeu sobre transformações de variáveis neste tutorial e o sobre fatores ("factors") no tutorial 2 para transformar a variável "rich" em fatores.
```
fake$f_rich <- factor(fake$rich)
str(fake$f_rich)
levels(fake$f_rich)
```

*Exercício (mais um)*

Crie a variável "kids2" que indica se o indivíduo tem algum filho (TRUE) ou nenhum (FALSE). Dica: essa é uma variável de texto, e não numérica.
```
fake$kids2 <- fake$kids != "0"
table(fake$kids2)
```
|FALSE     |  TRUE    |
|:--------:|:--------:|
|   22     |  8       | 

**Recodificando uma variável contínua com a função cut**

A função cut também é utilizada para recodificar variáveis contínuas.
```
fake$rich2 <- cut(fake$income, 
                  breaks = c(-Inf, 3000, Inf), 
                  labels = c("não rico", "rico"))
table(fake$rich2)
```
|não rico  |    rico  | 
|:--------:|:--------:|
|      19  |     11   | 

"Algumas observações importantes:
- se a nova variável tiver 2 categorias, precisamos de 3 "break points"; "-Inf" e "Inf" são os símbolos do R para menos e mais infinito, respectivamente;
- por padrão, o R nao inclui o primeiro "break point" na primeira categoria, exceto se o argumento "include.lowest" for alterado para TRUE;
- também por padrão, os intervalos são fechados à direita, e abertos à esquerda (ou seja, incluem o valor superior que delimita o intervalor, mas não o inferior), exceto se "right" o argumento for alterado para FALSE."

*Exercício*

Crie a variável "poupador", gerada a partir de *savings_year* (que criamos anteriormente, antes de transformar "age" em meses), e que separa os indivíduos que poupam muito (mais de FM/$ 1000 por ano) dos que poupam pouco. Use a função cut.
```
fake$poupador <- cut(fake$savings_year, 
                  breaks = c(-Inf, 1000, Inf), 
                  labels = c("não poupador", "poupador"))
table(fake$poupador)
```
|não poupador |    poupador |
|:-----------:|:-----------:|
|          22 |            8| 

**Recodificando uma variável contínua com a função recode**

"O equivalente da função cut para variáveis categóricas, estejam elas como texto ou como fatores é a função recode, do pacote *dplyr*. Seu uso é simples e intuitivo. Vamos recodificar como exemplo a variável *educ*""
```
install.packages("dplyr")
library(dplyr)
fake$college <- recode(fake$educ, 
                       "No High School Degree" = "No College",
                       "High School Degree" = "No College",
                       "College Incomplete" = "No College",
                       "College Degree or more" = "College")
table(fake$college)
```
|   College No| College     |
|:-----------:|:-----------:|
|         7   |      23     |

"Podemos comparar as mudanças com uma tabela de 2 entradas""
```
table(fake$college, fake$educ)
```
|          |  College Degree or more| College Incomplete |High School Degree |No High School Degree|
|:--------:|:----------------------:|:------------------:|:-----------------:|:-------------------:|
| College  |               7        |          0         |         0         |            0        |
|No College|                     0  |                6   |              14   |                  3  |

*Exercício*

Crie a variável "economia", que os indivíduos que avaliam a economia (variável "economy") como "Good" ou melhor recebem o valor "positivo" e os demais recebem "negativo".
```
fake$economy <- recode(fake$economy, 
                       "About average" = "Not Positive",
                       "Bad" = "Not Positive",
                       "Don't Know" = "Not Positive",
                       "Very Bad" = "Not Positive",
                       "Good" = "Positive",
                       "Very good" = "Positive")
table(fake$economy)
```
|Not Positive |    Positive  |
|:-----------:|:------------:|
|         23  |          7   |

**Ordenar linhas e remover linhas duplicadas**

A funçãpo *order* permite gerar um vetor que indica qual a posição que cada linha deveria receber no ordenamento desejado.
```
ordem <- order(fake$income)
print(ordem)
```
"Se aplicarmos um vetor numérico com um novo ordenaemnto à parte destinada às linhas no colchetes, receberemos o data frame ordenado:""
```
fake_ordenado <- fake[ordem, ]
head(fake_ordenado)
```
A função *order* pode ser aplicada diretamente nos colchetes.
```
fake_ordenado <- fake[order(fake$income), ]
```
Para duplicar os dados utiliza-se a função *rbind*, *empilhando* data frames.
```
fake_duplicado <- rbind(fake, fake[1:10, ])
```
Se ordenarmos, veremos alguns valores duplicados.
```
fake_duplicado[order(fake_duplicado$income), ]
```
Podemos remover os valores duplicados utilizando o operador lógico *não* para ficar com todas as linhas não duplicadas.
```
fake_novo <- fake_duplicado[!duplicated(fake_duplicado),]
fake_novo
```


**Item Adicional - Renomeando variáveis**

Antes de aprende a forma *simples* de renomear variáveis, aprenderemos a mais trabalhosa.

"Podemos observar os nomes das variáveis de um data frame usando o comando names"
```
names(fake)
```
"Os nomes das colunas são um vetor. Para renomear as variáveis, basta substituir o vetor de nomes por outro. Por exemplo, vamos manter todas as variáveis com o mesmo nome, exceto as três primeiras""
```
names(fake) <- c("idade", "sexo", "educacao", "income", "savings", "marriage", "kids", "party", "turnout", "vote_history", "economy", "incumbent", "candidate", "vazia", "poupanca", "savings_year", "rich", "rich2", "college")
head(fake)
```
"Você não precisa de um vetor com todos os nomes sempre que precisar alterar algum. Basta conhecer a posição da variável que quer alterar. Veja um exemplo com "marriage", que está na sexta posição.
```
names(fake)[6] <- "casado"
```
"Simples, porém um pouco mala."
