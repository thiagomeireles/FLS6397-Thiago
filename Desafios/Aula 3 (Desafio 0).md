|Título               | Autor             | Data                  | Output       |
|:-------------------:|:-----------------:|:---------------------:|:------------:| 
|Aula 3 (Desafio 0)   | Thiago Meireles   | 29 de março de 2017   |html_document |

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Desafio 0

Siga as instruções abaixo. Documente **TODOS** os seus passos em um script. Comente no seu script __TODOS__ os seus passos e explique a si mesm@ suas escolhas e estratégias. Colar pedaços de código nesta atividade é permitido e peça ajuda se precisar. Mencione **SEMPRE** em comentários quando a solução encontrada não for sua.

**1- Vá ao [Repositório de Dados Eleitorais do TSE](http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais). Faça o download do arquivo de resultados de 2016 e descompacte-o. Você pode fazer tudo à mão se tiver dificuldade de copiar o modelo do [tutorial 4](https://github.com/leobarone/FLS6397/blob/master/tutorials/tutorial4.Rmd), em que abrimos os dados da MUNIC 2005. (Nome do arquivo: "Votação nominal por município e zona")**

*Primeiro realizamos o download do arquivo .zip e descompactamos os arquivos, observando o nome dos arquivos extraídos, seu tipo e já pensando em como importar*
```
url_resultados <- "http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_2016.zip"
download.file(url_resultados, "elec2016.zip", quiet = F)
unzip("elec2016.zip")
file.remove("elec2016.zip")
list.files()
[1] "LEIAME.pdf"
[2] "votacao_candidato_munzona_2016_AC.txt"                    
[3] "votacao_candidato_munzona_2016_AL.txt"                    
[4] "votacao_candidato_munzona_2016_AM.txt"                    
[5] "votacao_candidato_munzona_2016_AP.txt"                    
[6] "votacao_candidato_munzona_2016_BA.txt"                    
[7] "votacao_candidato_munzona_2016_CE.txt"                    
[8] "votacao_candidato_munzona_2016_ES.txt"                    
[9] "votacao_candidato_munzona_2016_GO.txt"                    
[10] "votacao_candidato_munzona_2016_MA.txt"                    
[11] "votacao_candidato_munzona_2016_MG.txt"                    
[12] "votacao_candidato_munzona_2016_MS.txt"                    
[13] "votacao_candidato_munzona_2016_MT.txt"                    
[14] "votacao_candidato_munzona_2016_PA.txt"                    
[15] "votacao_candidato_munzona_2016_PB.txt"                    
[16] "votacao_candidato_munzona_2016_PE.txt"                    
[17] "votacao_candidato_munzona_2016_PI.txt"                    
[18] "votacao_candidato_munzona_2016_PR.txt"                    
[19] "votacao_candidato_munzona_2016_RJ.txt"                    
[20] "votacao_candidato_munzona_2016_RN.txt"                    
[21] "votacao_candidato_munzona_2016_RO.txt"                    
[22] "votacao_candidato_munzona_2016_RR.txt"                    
[23] "votacao_candidato_munzona_2016_RS.txt"                    
[24] "votacao_candidato_munzona_2016_SC.txt"                    
[25] "votacao_candidato_munzona_2016_SE.txt"                    
[26] "votacao_candidato_munzona_2016_SP.txt"                    
[27] "votacao_candidato_munzona_2016_TO.txt"
```

**2- Importe para o R os resultados eleitorais dos 3 estados do Sul.**

*Em um primeiro momento, carregamos o pacote "readr"*
```
library(readr)
```
*Posteriormente, importamos os arquivos .txt referentes aos 3 estados so Sul*
Rio Grande do Sul
```
rs <- read_delim("~/votacao_candidato_munzona_2016_RS.txt", ";",
                                                escape_double = FALSE, col_names = FALSE
                                                )
```
Santa Catarina
```
sc <- read_delim("~/votacao_candidato_munzona_2016_SC.txt", ";",
                 escape_double = FALSE, col_names = FALSE
)
```
Paraná
```
pr <- read_delim("~/votacao_candidato_munzona_2016_PR.txt", ";",
                   escape_double = FALSE, col_names = FALSE
)
```
*O Codebook nos indica que os textos estão codificados como **Latin 1**, então façamos a condificação das variáveis character para este padrão*
**Nota:** o argumento *fileEncoding* não reconhecia o padrão *latin*, por isso a saída mais trabalhosa.

Rio Grande do Sul
```
Encoding(rs$X5) <- "latin1"
Encoding(rs$X9) <- "latin1"
Encoding(rs$X14) <- "latin1"
Encoding(rs$X22) <- "latin1"
Encoding(rs$X25) <- "latin1"
Encoding(rs$X27) <- "latin1"
```
Santa Catarina
```
Encoding(sc$X5) <- "latin1"
Encoding(sc$X9) <- "latin1"
Encoding(sc$X14) <- "latin1"
Encoding(sc$X22) <- "latin1"
Encoding(sc$X25) <- "latin1"
Encoding(sc$X27) <- "latin1"
```
Paraná
```
Encoding(pr$X5) <- "latin1"
Encoding(pr$X9) <- "latin1"
Encoding(pr$X14) <- "latin1"
Encoding(pr$X22) <- "latin1"
Encoding(pr$X25) <- "latin1"
Encoding(pr$X27) <- "latin1"
```

**3- Com a função *rbind*, junte os 3 *data frames* importados.**

*Geramos um novo data frame, "sul", que compila os data frames dos 3 estados da região Sul.*
```
sul <- rbind(pr, rs, sc
```

**4- Leia até o final as instruções e identifique quais variáveis são necessárias para tarefa. Selecione apenas tais variáveis e renomeia-as (você pode trocar a ordem se achar mais fácil).**

*As variáveis necessárias para os demais exercícios são X16 (Descrição do cargo), X22 (Código da situação de totalização do candidato naquele turno, ou seja, se foi eleito ou não), X24 ou X25 (Sigla do Partido ou Nome do Partido, a primeia parece mais fácil para operacionalizar a questão 8)*

*Assim, existe mais de uma maneira de se selecionar esas variáveis e renomeá-las.*

- Criando vetores para cada variável, atribuindo seus nomes, e gerando um data frame a partir deles
```
cargo <- c(sul$X16)
situacao <- c(sul$X22)
partido <- c(sul$X24)

sul_analise <- data.frame(cargo, situacao, partido)
head(sul_analise)
```
- Gerando um novo data frame a partir do *sul* e atribuindo os nomes posteriomente.
```
sul_analise2 <- data.frame(sul$X16, sul$X22, sul$X24)
names(sul_analise2) <- c("cargo", "situacao", "partido")
head(sul_analise2)
```

**5- Selecione apenas as linhas que contém resultados eleitorais para prefeit@.**

*Selecionamos as linhas que contém os resultados eleitorais para prefeit@ via operadores relacionais. Assim, pediremos que o R selecione todas as linhas para as quais o valor de *cargo* seja *PREFEITO*, originando um novo data frame com essas informações*.
prefeitos_sul <- sul_analise[sul_analise$cargo == "PREFEITO", ]

**6- Selecione apenas as linhas que contém os resultados eleitorais para prefeit@s eleit@s.**

*Aqui podemos pedir para o R realizar a tarefa de duas formas diferentes*

- Em uma delas, podemos pedir para que gere um novo data frame diretamente de *sul_analise* utilizando operadores relacionais que indiquem que queremos somente os dados relativos a *PREFEITOS* na variável *cargo* **E** *ELEITO* na variável *situacao*
```
pref_sul_eleitos <- sul_analise[sul_analise$situacao == "ELEITO" &
                                sul_analise$cargo == "PREFEITO", ]
```

- Em outra, como já geramos um data frame, *prefeitos_sul*, que contém somente as informações relativas às candidaturas a prefeit@, podemos filtrar esses dados somente com aqueles que foram eleit@s e gerar um novo data frame.
```
pref_sul_eleitos2 <- prefeitos_sul[prefeitos_sul$situacao == "ELEITO", ]
```

**7- Quantas linhas restaram? Quantas colunas? (postarei o gabarito ao longo da semana no repositório).**

*Para identificar quantas linhas e colunas restaram ou observamos as informações no Ambiente Global ou pedimos as dimensões do data frame para o R.*
```
dim(pref_sul_eleitos)
[1] 1283    3
```
*Assim, observamos que restaram 1283 linhas (observações) e 3 colunas (variáveis selecionadas no exercício 4)*

**8- Crie, a seu critério, 3 categorias de partido e crie uma nova variável: esquerda, direita, irrelevantes. Dê o nome de partido\_categoria a esta variável.**

*Antes de definir a nova variável, observaremos quais os partidos compõem a análise*
```
levels(pref_sul_eleitos$partido)
 [1] "DEM"     "NOVO"    "PC do B" "PCB"     "PCO"     "PDT"     "PEN"     "PHS"     "PMB"     "PMDB"    "PMN"     "PP"      "PPL"    
[14] "PPS"     "PR"      "PRB"     "PROS"    "PRP"     "PRTB"    "PSB"     "PSC"     "PSD"     "PSDB"    "PSDC"    "PSL"     "PSOL"   
[27] "PSTU"    "PT"      "PT do B" "PTB"     "PTC"     "PTN"     "PV"      "REDE"    "SD"
```
*Utilizando a aproximação de *[[http://www.fgv.br/professor/cesar.zucco/files/PaperLARR2009.pdf | Power & Zucco(2009)]]* () para as posições na legislatura de 2005, classificaremos:*
- *Esquerda: PCdoB, PSB, PT, PPS e PDT;*
- *Direita: PMDB, PSDB, PTB, PL, DEM (então PFL) e PP;*
- *Irrelevantes: aqui tem-se partidos que possuem alguma representatividade (como PSOL e REDE), mas que não foram classificados pela análise utilizada.*

*Agora, vamos gerar uma nova variável, digamos *ideologia*, para classificar os partidos segundo o critério acima, mas que, em um primeiro momento, será composta de missing values*
```
pref_sul_eleitos$ideologia <- NA
```

*Em um segundo momento, reclassificaremos a variável de acordo com o que foi estipulado acima via função *recode*, pertencente ao pacote *dplyr* que será carregado antes da execução*
```
library(dplyr)

pref_sul_eleitos$ideologia <- recode(pref_sul_eleitos2$partido,
                                     "PCdoB" = "Esquerda",
                                     "PSB" = "Esquerda",
                                     "PT" = "Esquerda",
                                     "PPS" = "Esquerda",
                                     "PDT" = "Esquerda",
                                     "PMDB" = "Direita",
                                     "PSDB" = "Direita",
                                     "PTB" = "Direita",
                                     "PL" = "Direita",
                                     "DEM" = "Direita",
                                     "PP" = "Direita",
                                     .default = "Irrelevante"
)
```
*Dessa forma, recodificamos os partidos considerados de Esquerda (que incluem a centro-esquerda), os de direita (que incluem os de centro-direita) e pedimos para a função atribuir àqueles que não foram selecionados para serem classificados como irrelevantes com o argumento *.default*.*


**9- Faça uma tabela da nova variável.**
```
table(pref_sul_eleitos$ideologia)

```
|Direita |Irrelevante|Esquerda| 
|:------:|:---------:|:------:|
|779     |    224    |  278   |
