---
Aluno: "Thiago Meireles"
Curso: "Doutorado em Ciência Política"
NUSP: 8867565
Data: "10 de abril de 2017"
---

# Desafio 1

**Parte 1 - abrindo os dados**

*1- Vá ao [Repositório de Dados Eleitorais do TSE](http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais). Faça o download do arquivo de resultados de 2016 e descompacte-o. Você pode fazer tudo à mão se tiver dificuldade de copiar o modelo do [tutorial 4](https://github.com/leobarone/FLS6397/blob/master/tutorials/tutorial4.Rmd), em que abrimos os dados da MUNIC 2005. (Nome do arquivo: "Votação nominal por município e zona")*

Primeiro realizamos o download do arquivo

```{r}
url_tse <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
download.file(url_tse, "2016.zip")
```

Após realizar o download, descompactamos o arquivo, conferimos a descompactação e removemos o arquivo ".zip".

```{r}
unzip("2016.zip")
list.files()
file.remove("2016.zip")
```


*2- Importe para o R os resultados eleitorais (Votação nominal por município e zona) e os dados de candidatura (Candidatos)*

Carregaremos, antes de qualquer coisa, os pacotes *data.table* e *dplyr*

```{r}
library(data.table)
library(dplyr)
library(readr)
```


```{r}
ac <- read.delim("~/votacao_candidato_munzona_2016_AC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
al <- read.delim("~/votacao_candidato_munzona_2016_AL.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
am <- read.delim("~/votacao_candidato_munzona_2016_AM.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ap <- read.delim("~/votacao_candidato_munzona_2016_AP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ba <- read.delim("~/votacao_candidato_munzona_2016_BA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ce <- read.delim("~/votacao_candidato_munzona_2016_CE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
es <- read.delim("~/votacao_candidato_munzona_2016_ES.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
go <- read.delim("~/votacao_candidato_munzona_2016_GO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ma <- read.delim("~/votacao_candidato_munzona_2016_MA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
mg <- read.delim("~/votacao_candidato_munzona_2016_MG.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ms <- read.delim("~/votacao_candidato_munzona_2016_MS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
mt <- read.delim("~/votacao_candidato_munzona_2016_MT.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
pa <- read.delim("~/votacao_candidato_munzona_2016_PA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
pb <- read.delim("~/votacao_candidato_munzona_2016_PB.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
pe <- read.delim("~/votacao_candidato_munzona_2016_PE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
pi <- read.delim("~/votacao_candidato_munzona_2016_PI.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
pr <- read.delim("~/votacao_candidato_munzona_2016_PR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
rj <- read.delim("~/votacao_candidato_munzona_2016_RJ.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
rn <- read.delim("~/votacao_candidato_munzona_2016_RN.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
ro <- read.delim("~/votacao_candidato_munzona_2016_RO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
rr <- read.delim("~/votacao_candidato_munzona_2016_RR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
rs <- read.delim("~/votacao_candidato_munzona_2016_RS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
sc <- read.delim("~/votacao_candidato_munzona_2016_SC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
se <- read.delim("~/votacao_candidato_munzona_2016_SE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
sp <- read.delim("~/votacao_candidato_munzona_2016_SP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
to <- read.delim("~/votacao_candidato_munzona_2016_TO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
```

Unindo os dados importados em único data frame das eleições de 2016 com o *rbind*

```{r}
estados <- c(ac, al, am, ap, ba, ce, es, go, ma, mg, ms, mt, pa, pb, pe, pi, pr, rj, rn, ro, rr, rs, sc, se, sp, to)
dados <- rbind(ac, al, am, ap, ba, ce, es, go, ma, mg, ms, mt, pa, pb, pe, pi, pr, rj, rn, ro, rr, rs, sc, se, sp, to)
```

Como faremos o mesmo de uma forma mais elegante em seguida, removeremos todos os data frames (exceto os estados do Sul que serão utilizados a frente)

```{r}
rm(ac, al, am, ap, ba, ce, es, go, ma, mg, ms, mt, pa, pb, pe, pi, rj, rn, ro, rr, se, sp, to, dados)
```


Em uma forma mais elegante, podemos imprimir os arquivos no formato ".txt" da pasta padrão utilizada pelo R (aqui sabemos que somente temos os arquivos das eleições de 2016). Após isso, geramos uma lista com os 26 data frames, um para cada estado. Por fim, utilizamos o *ldply* (do pacote *plyr*, que não estava instalado em nosso computador) para agrupar a lista de data frames em um único data frame.

```{r}
estados <- paste(list.files(pattern = "txt"))

lista16 <- lapply(estados, read.delim, sep=";", header=FALSE, fileEncoding = "Latin1", stringsAsFactors = F)

install.packages("plyr")
library(plyr)

elec16 <- ldply(lista16, data.frame)
```

Criado nosso data frame, retiraremos os arquivos utilizados para importar os dados do nosso HD.

```{r}
file.remove(estados, lista16)
```



*3- Crie dois _data frames_ denominados _resultados e _candidatos_, com informações sobre votação e candidaturas dos 3 estados do sul, respectivamente.*

Podemos realizar a tarefa de duas formas. A primeira é utilizando a função *rbind* para agrupar as linhas correspondentes aos estados do Sul.

```{r}
sul_16 <- rbind(pr, rs, sc)
```

Já a segunda é extrair os dados dos estados do Sul a partir do data frame *elec16* que contém as informações dos outros 26 data frames com o auxílio do *tidyverse*.

```{r}
sul16 <- elec16 %>% filter(V6 == "RS" |
                             V6 == "SC" |
                             V6 == "PR"
                           )
```

Manteremos apenas um dos data frames criados:

```{r}
rm(sul_16)
```

Selecionados os estados do Sul, geraremos dos novos data frames vazios a partir de *sul16*, um que receberá as informações dos resultados e outro as informações dos candidatos, conforme os próximos passos.

```{r}
# candidatos

sul_candidatos <- data.frame()

# resultados
sul_resultados <- data.frame()
```


**Parte 2 - _data frame_ resultados**

*4- Selecione apenas as linhas que contém resultados eleitorais para prefeit@.*

Selecionaremos os dados para prefeito no data frame *sul16*, o que se aplicará para a construção dos dois data frames aqui.

```{r}
sulpref <- sul16 %>% filter(V16 == "PREFEITO")
```

*5- Mantenha no banco de dados apenas as linhas que contém informações sobre UF, código do município, número do partido, número do candidat@, voto, com os seguintes nomes, respectivamente: uf, cod_munic, partido, num_cand e voto.*

Considerando que o número do partido e o número do candidato seriam a mesma variável, aplicamos a sigla do partido em substituição a "número do partido". Assim, selecionamos a partir do *codebook* (Readme.pdf) as variáveis com as informações desejadas

```{r}
sul_resultados <- sulpref %>%
  rename(uf = V6, cod_mun = V8, part = V24, num_cand = V23, voto = V30) %>%
  select(uf, cod_mun, part, num_cand, voto) 
```

Os exercícios 4 e 5 poderiam ser realizados em um único comando

```{r}
sul_resultados2 <- sul16 %>% filter(V16 == "PREFEITO")
  rename(uf = V6, cod_mun = V8, part = V24, num_cand = V23, voto = V29) %>%
  select(uf, cod_mun, part, num_cand, voto) 
```

Visto que o resultado seria o mesmo, removemos o segundo data frame para não gerar confusão no Ambiente Global:

```{r}
rm(sul_resultados2)
```

**Parte 3 - _data frame_ candidatos**

*6- Selecione apenas as linhas que contém candidaturas a prefeit@.*

Já selecionamos as linhas para candidaturas a prefeito no exercício *4*.

*7- Mantenha no banco de dados apenas as linhas que contém informações sobre UF, número do partido, número do candidat@, descrição da ocupação, descrição do sexo e descrição de grau de instrução, com os seguintes nomes, respectivamente: uf, partido, num_cand, ocup, sexo e educ.*

Selecionaremos as **colunas** com as informações solicitadas, também a partir do *codebook* citado:

```{r}
sul_candidatos <- sulpref %>%
  rename(uf = V6, part = V24, num_cand = V23, voto = V30) %>%
  select(uf, cod_mun, part, num_cand, voto) 
```



**Parte 4 - agregando e combinando por município**

*8- Usando as funções _group\_by_ e _sumarise_, produza um novo _data frame_ que contém o total de votos por município. Chame esse novo _data frame_ de _resultado\_mun.*

*9- Combine os _data frames_ resultado e resultado\_mun usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente.*

*10- Calcule para este novo _data frame_ uma nova variável chamada "prop_mun", que corresponde ao total de voto do candidato no município em relação ao total de votos recebdidos por todos os candidatos no município (vamos ignorar a existência de votos na legenda para fins didáticos).*

**Parte 5 - agregando e combinando por candidato**

*11- Usando as funções _group\_by_ e _sumarise_, produza um novo _data frame_ que contém o total de votos pela combinação de UF e número de candidato. Chame esse novo _data frame_ de _resultado\_cand_.*

*12- Combine os _data frames_ resultado e resultado\_cand usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente. Note devemos usar um vetor no argumento "by" para combinarmos os _data frames_ por UF e número do candidato (ex: by = c("uf", "num_cand"))*

*13- Calcule para este novo _data frame_ uma nova variável chamada "prop_cand", que corresponde ao total de voto do candidato no município em relação ao total de votos do candidato.*

**Parte 6 - combinando resultados e candidaturas**

*14- Combine os _data frames_ resultado e candidatos usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente. . Note devemos usar um vetor no argumento "by" para combinarmos os _data frames_ por UF e número do candidato (ex: by = c("uf", "num_cand"))*

**Parte 7 - treinando tabelas de resultados**

*15- Produza uma tabela que indique o total de votos recebido por cada partido.*

*16- Produza uma tabela com o total de votos por ocupação d@s candidat@s.*

*17- Produza uma tabela com o total de votos por sexo d@s candidat@s.*

*18- Produza uma tabela com o total de votos por grau de escolaridade d@s candidat@s.*

(Dica: use as funções _group\_by_ e _sumarise_)
