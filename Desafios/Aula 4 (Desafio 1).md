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
url_resultados <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
download.file(url_resultados, "resultados.zip")
```

Após realizar o download, descompactamos o arquivo, conferimos a descompactação e removemos o arquivo ".zip".

```{r}
unzip("resultados.zip")
list.files()
file.remove("resultados.zip")
```


Realizamos os mesmos procedimentos para os dados sobre os candidatos:

```{r}
url_candidatos <- "http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2016.zip"
download.file(url_candidatos, "candidatos.zip")
unzip("candidatos.zip")
list.files()
file.remove("candidatos.zip")
```


*2- Importe para o R os resultados eleitorais (Votação nominal por município e zona) e os dados de candidatura (Candidatos)*

Carregaremos, antes de qualquer coisa, os pacotes *data.table* e *dplyr*

```{r}
library(data.table)
library(dplyr)
library(readr)
```

Primeiro importaremos todos os dados dos resultados das eleições de 2016: 

```{r}
res_ac <- read.delim("~/votacao_candidato_munzona_2016_AC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_al <- read.delim("~/votacao_candidato_munzona_2016_AL.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_am <- read.delim("~/votacao_candidato_munzona_2016_AM.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ap <- read.delim("~/votacao_candidato_munzona_2016_AP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ba <- read.delim("~/votacao_candidato_munzona_2016_BA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ce <- read.delim("~/votacao_candidato_munzona_2016_CE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_es <- read.delim("~/votacao_candidato_munzona_2016_ES.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_go <- read.delim("~/votacao_candidato_munzona_2016_GO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ma <- read.delim("~/votacao_candidato_munzona_2016_MA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_mg <- read.delim("~/votacao_candidato_munzona_2016_MG.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ms <- read.delim("~/votacao_candidato_munzona_2016_MS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_mt <- read.delim("~/votacao_candidato_munzona_2016_MT.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_pa <- read.delim("~/votacao_candidato_munzona_2016_PA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_pb <- read.delim("~/votacao_candidato_munzona_2016_PB.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_pe <- read.delim("~/votacao_candidato_munzona_2016_PE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_pi <- read.delim("~/votacao_candidato_munzona_2016_PI.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_pr <- read.delim("~/votacao_candidato_munzona_2016_PR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_rj <- read.delim("~/votacao_candidato_munzona_2016_RJ.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_rn <- read.delim("~/votacao_candidato_munzona_2016_RN.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_ro <- read.delim("~/votacao_candidato_munzona_2016_RO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_rr <- read.delim("~/votacao_candidato_munzona_2016_RR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_rs <- read.delim("~/votacao_candidato_munzona_2016_RS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_sc <- read.delim("~/votacao_candidato_munzona_2016_SC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_se <- read.delim("~/votacao_candidato_munzona_2016_SE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_sp <- read.delim("~/votacao_candidato_munzona_2016_SP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
res_to <- read.delim("~/votacao_candidato_munzona_2016_TO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
```

Unindo os dados importados em único data frame das eleições de 2016 com o *rbind*

```{r}
resultados16 <- rbind(res_ac, res_al, res_am, res_ap, res_ba, res_ce, res_es, res_go, res_ma, res_mg, res_ms, res_mt, res_pa, res_pb, res_pe, res_pi, res_pr, res_rj, res_rn, res_ro, res_rr, res_rs, res_sc, res_se, res_sp, res_to)
```

Como faremos o mesmo de uma forma mais elegante em seguida, removeremos todos os data frames (exceto os estados do Sul que serão utilizados a frente)

```{r}
rm(res_ac, res_al, res_am, res_ap, res_ba, res_ce, res_es, res_go, res_ma, res_mg, res_ms, res_mt, res_pa, res_pb, res_pe, res_pi, res_rj, res_rn, res_ro, res_rr, res_se, res_sp, res_to, resultados16)
```

Agora realizaremos os mesmos procedimentos para as informações dos candidatos:

```{r}
cand_ac <- read.delim("~/consulta_cand_2016_AC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_al <- read.delim("~/consulta_cand_2016_AL.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_am <- read.delim("~/consulta_cand_2016_AM.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ap <- read.delim("~/consulta_cand_2016_AP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ba <- read.delim("~/consulta_cand_2016_BA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ce <- read.delim("~/consulta_cand_2016_CE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_es <- read.delim("~/consulta_cand_2016_ES.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_go <- read.delim("~/consulta_cand_2016_ES.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ma <- read.delim("~/consulta_cand_2016_MA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_mg <- read.delim("~/consulta_cand_2016_MG.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ms <- read.delim("~/consulta_cand_2016_MS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_mt <- read.delim("~/consulta_cand_2016_MT.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_pa <- read.delim("~/consulta_cand_2016_PA.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_pb <- read.delim("~/consulta_cand_2016_PB.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_pe <- read.delim("~/consulta_cand_2016_PE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_pi <- read.delim("~/consulta_cand_2016_PI.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_pr <- read.delim("~/consulta_cand_2016_PR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_rj <- read.delim("~/consulta_cand_2016_RJ.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_rn <- read.delim("~/consulta_cand_2016_RN.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_ro <- read.delim("~/consulta_cand_2016_RO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_rr <- read.delim("~/consulta_cand_2016_RR.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_rs <- read.delim("~/consulta_cand_2016_RS.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_sc <- read.delim("~/consulta_cand_2016_SC.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_se <- read.delim("~/consulta_cand_2016_SE.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_sp <- read.delim("~/consulta_cand_2016_SP.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
cand_to <- read.delim("~/consulta_cand_2016_TO.txt", header = F, sep = ";", fileEncoding = "Latin1", stringsAsFactors = F)
```


```{r}
candidatos <- rbind(cand_ac, cand_al, cand_am, cand_ap, cand_ba, cand_ce, cand_es, cand_go, cand_ma, cand_mg, cand_ms, cand_mt, cand_pa, cand_pb, cand_pe, cand_pi, cand_pr, cand_rj, cand_rn, cand_ro, cand_rr, cand_rs, cand_sc, cand_se, cand_sp, cand_to)
```

```{r}
rm(cand_ac, cand_al, cand_am, cand_ap, cand_ba, cand_ce, cand_es, cand_go, cand_ma, cand_mg, cand_ms, cand_mt, cand_pa, cand_pb, cand_pe, cand_pi, cand_rj, cand_rn, cand_ro, cand_rr, cand_se, cand_sp, cand_to, candidatos)
```

Antes de realizar de uma fomra mais elegante, removeremos todos os arquivos .txt importados anteriormente e importaremos de forma direta. Verificaremos no final com o list files para ver se foram removidos de fato.

```{r}
txt <- paste(list.files(pattern = "txt"))
file.remove(txt)
list.files()
rm(txt)
```

Em uma forma mais elegante, podemos imprimir os arquivos no formato ".txt" da pasta padrão utilizada pelo R (aqui sabemos que somente temos os arquivos das eleições de 2016). Após isso, geramos uma lista com os 26 data frames, um para cada estado. Por fim, utilizamos o *ldply* (do pacote *plyr*, que não estava instalado em nosso computador) para agrupar a lista de data frames em um único data frame.

Faremos isso primeiramente com os dados dos resultados:

- Realizando o download e removendo o arquivo ".zip":

```{r}
download.file(url_resultados, "resultados.zip")
unzip("resultados.zip")
list.files()
file.remove("resultados.zip")
```

- Gerando uma lista de data frames a partir dos arquivos ".txt" para agruparmos em um único data frame posteriormente:

```{r}
install.packages("plyr")
library(plyr)

estados <- paste(list.files(pattern = "txt"))

lista16 <- lapply(estados, read.delim, sep=";", header=FALSE, fileEncoding = "Latin1", stringsAsFactors = F)

resultados16 <- ldply(lista16, data.frame)
```

- Criado nosso data frame, retiraremos os arquivos utilizados para importar os dados do nosso HD.

```{r}
file.remove(estados)
rm(estados, lista16)
```

E agora com os dados dos candidatos:

- Realizando o download e removendo o arquivo ".zip":

```{r}
download.file(url_candidatos, "candidatos.zip")
unzip("candidatos.zip")
list.files()
file.remove("candidatos.zip")
```

- Gerando uma lista de data frames a partir dos arquivos ".txt" para agruparmos em um único data frame posteriormente após remover os arquivos referentes ao Brasil (BR) e Distrito Federal (DF), ambos vazios:

```{r}
file.remove("consulta_cand_2016_BR.txt", "consulta_cand_2016_DF.txt")

candidatos <- paste(list.files(pattern = "txt"))

lista16_2 <- lapply(candidatos, read.delim, sep=";", header=FALSE, fileEncoding = "Latin1", stringsAsFactors = F)

candidatos16 <- ldply(lista16_2, data.frame)
```

- Criado nosso data frame, retiraremos os arquivos utilizados para importar os dados do nosso HD.

```{r}
file.remove(candidatos)
rm(candidatos, lista16_2)
```


*3- Crie dois _data frames_ denominados _resultados e _candidatos_, com informações sobre votação e candidaturas dos 3 estados do sul, respectivamente.*

Podemos realizar a tarefa de duas formas. A primeira é utilizando a função *rbind* para agrupar as linhas correspondentes aos estados do Sul.

```{r}
sul_resultados16 <- rbind(res_pr, res_rs, res_sc)
sul_candidatos16 <- rbind(cand_pr, cand_rs, cand_sc)
```

Já a segunda é extrair os dados dos estados do Sul a partir dos data frames *resultados16* e *candidatos16* que contêm as informações dos outros 26 data frames com o auxílio do *tidyverse*.

```{r}
library(tidyverse)

sul_resultados <- resultados16 %>% filter(V6 == "RS" |
                             V6 == "SC" |
                             V6 == "PR"
                           )

sul_candidatos <- candidatos16 %>% filter(V6 == "RS" |
                             V6 == "SC" |
                             V6 == "PR"
                           )
```

Após vermos que os resultados são iguais, manteremos apenas um dos data frames criados para os candidatos e um para os resultados:

```{r}
rm(sul_candidatos16, sul_resultados16)
```

**Parte 2 - _data frame_ resultados**

*4- Selecione apenas as linhas que contém resultados eleitorais para prefeit@.*

Selecionaremos os dados para prefeito nos data frames *sul_resultados* com o argumento *filter*.

```{r}
sulpref_resultados <- sul_resultados %>% filter(V16 == "PREFEITO")
```

*5- Mantenha no banco de dados apenas as linhas que contém informações sobre UF, código do município, número do partido, número do candidat@, voto, com os seguintes nomes, respectivamente: uf, cod_munic, partido, num_cand e voto.*

Considerando que o número do partido e o número do candidato seriam a mesma variável, aplicamos a sigla do partido em substituição a "número do partido". Assim, selecionamos a partir do *codebook* (Readme.pdf) as variáveis com as informações desejadas

```{r}
sulprefeitos_resultados <- sulpref_resultados %>% 
  rename(uf = V6, cod_mun = V8, part = V24, num_cand = V23, voto = V29) %>%
  select(uf, cod_mun, part, num_cand, voto) 
```

  Os exercícios 4 e 5 poderiam ser realizados em um único comando

```{r}
sulprefeitos_resultados2 <- sul_resultados %>% filter(V16 == "PREFEITO") %>%
  rename(uf = V6, cod_mun = V8, part = V24, num_cand = V23, voto = V29) %>%
  select(uf, cod_mun, part, num_cand, voto) 
```

Visto que o resultado seria o mesmo, removemos o segundo data frame para não gerar confusão no Ambiente Global:

```{r}
rm(sulprefeitos_resultados2)
```

**Parte 3 - _data frame_ candidatos**

*6- Selecione apenas as linhas que contém candidaturas a prefeit@.*

Selecionaremos os dados para prefeito nos data frames *sul_candidatos* com o argumento *filter*.

```{r}
sulpref_candidatos <- sul_candidatos %>% filter(V10 == "PREFEITO")
```

*7- Mantenha no banco de dados apenas as linhas que contém informações sobre UF, número do partido, número do candidat@, descrição da ocupação, descrição do sexo e descrição de grau de instrução, com os seguintes nomes, respectivamente: uf, partido, num_cand, ocup, sexo e educ.*

Selecionaremos as **colunas** com as informações solicitadas, também a partir do *codebook* citado:

```{r}
sulprefeitos_candidatos <- sulpref_candidatos %>%
  rename(uf = V6, cod_mun = V7, part = V19, num_cand = V18, ocup = V26, sexo = V31, educ = V33) %>%
  select(uf, cod_mun, part, num_cand, ocup, sexo, educ) 
```

Os exercícios 6 e 7 poderiam ser realizados em um único comando:

```{r}
sulprefeitos_candidatos2 <- sul_candidatos %>% filter(V10 == "PREFEITO") %>%
  rename(uf = V6, cod_mun = V7, part = V19, num_cand = V18, ocup = V26, sexo = V31, educ = V33) %>%
  select(uf, part, num_cand, ocup, sexo, educ)
```

Como vemos que o resultado é o mesmo, excluímos um dos data frames.

```{r}
rm(sulprefeitos_candidatos2)
```

**Parte 4 - agregando e combinando por município**

*8- Usando as funções _group\_by_ e _sumarise_, produza um novo _data frame_ que contém o total de votos por município. Chame esse novo _data frame_ de _resultado\_mun.*

```{r}
resultado_mun <- sulprefeitos_resultados %>%
  group_by(cod_mun) %>%
  summarise(votos_mun = sum(voto))
```

*9- Combine os _data frames_ resultado e resultado\_mun usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente.*

```{r}
sulprefeitos_resultados <- sulprefeitos_resultados %>%
  left_join(resultado_mun, by = "cod_mun")
```

*10- Calcule para este novo _data frame_ uma nova variável chamada "prop_mun", que corresponde ao total de voto do candidato no município em relação ao total de votos recebdidos por todos os candidatos no município (vamos ignorar a existência de votos na legenda para fins didáticos).*

```{r}
sulprefeitos_resultados <- sulprefeitos_resultados %>%
  mutate(prop_mun = (voto / votos_mun))
```


**Parte 5 - agregando e combinando por candidato**

*11- Usando as funções _group\_by_ e _sumarise_, produza um novo _data frame_ que contém o total de votos pela combinação de UF e número de candidato. Chame esse novo _data frame_ de _resultado\_cand_.*

A combinação de UF e número de candidato, por se tratar dos prefeitos, gerará o total de votos que o partido recebeu no estado - e não o total de votos que o candidato recebeu no estado.

```{r}
sulprefeitos_resultados_cand <- sulprefeitos_resultados %>%
  group_by(uf, num_cand) %>%
  summarise(votos_estado = sum(votos_mun))
```

*12- Combine os _data frames_ resultado e resultado\_cand usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente. Note devemos usar um vetor no argumento "by" para combinarmos os _data frames_ por UF e número do candidato (ex: by = c("uf", "num_cand"))*

```{r}
sulprefeitos_resultados_cand <- sulprefeitos_resultados_cand %>%
  left_join(sulprefeitos_resultados, by = c("uf", "num_cand"))
```

*13- Calcule para este novo _data frame_ uma nova variável chamada "prop_cand", que corresponde ao total de voto do candidato no município em relação ao total de votos do candidato.*

Como dito no exercício 11, o a variável *prop_cand* indicará a proporção de votos que o partido recebeu no município em relação ao total de votos que o partido recebeu no estado.

```{r}
sulprefeitos_resultados_cand <- sulprefeitos_resultados_cand %>%
  mutate(prop_est = (votos_mun / votos_estado))
```

**Parte 6 - combinando resultados e candidaturas**

*14- Combine os _data frames_ resultado e candidatos usando alguma função do tipo "_join_". Chame o novo _data frame_ de _resultado_, sobrescrevendo o _data frame_ existente. . Note devemos usar um vetor no argumento "by" para combinarmos os _data frames_ por UF e número do candidato (ex: by = c("uf", "num_cand"))*

Como são candidatos a prefeito, com diferentes indivíduos possuindo *num_cand* iguais em diferentes municípios, realizaremos o *join* para os dois data frames considerando as variáveis *uf*, *cod_mun* e *num_cand*. Colocaremos também a variável *part* para não ficar duplicada, uma vez que possui as mesmas informações de *num_cand*

```{r}
sulprefeitos_resultados <- left_join(sulprefeitos_resultados, sulprefeitos_candidatos, by = c("uf", "cod_mun", "num_cand", "part"))
```

**Parte 7 - treinando tabelas de resultados**

*15- Produza uma tabela que indique o total de votos recebido por cada partido.*

```{r}
votos_partido <- sulprefeitos_resultados %>%
  group_by(part) %>%
  summarise(total_votos = sum(voto))
```

*16- Produza uma tabela com o total de votos por ocupação d@s candidat@s.*

```{r}
votos_ocup <- sulprefeitos_resultados %>%
  group_by(ocup) %>%
  summarise(total_votos = sum(voto))
```

*17- Produza uma tabela com o total de votos por sexo d@s candidat@s.*

```{r}
votos_sexo <- sulprefeitos_resultados %>%
  group_by(sexo) %>%
  summarise(total_votos = sum(voto))
```

*18- Produza uma tabela com o total de votos por grau de escolaridade d@s candidat@s.*

```{r}
votos_educ <- sulprefeitos_resultados %>%
  group_by(educ) %>%
  summarise(total_votos = sum(voto))
```

