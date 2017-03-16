install.packages("knitr")
knitr::opts_chunk$set(echo = TRUE)
# Carregando conjunto de base de dados preexistente
library(datasets)
# Abrindo um data frame desse pacote
data("mtcars")
# Abrindo informaÃ§Ãµes sobre o data frame (resumo, codebook, etc.)
?mtcars
# Visualizando o data frame
View(mtcars)
# Visualizando as primeiras seis observaÃ§Ãµes do data frame
head(mtcars)
# Visualizando a estruruda dos dados, ou seja, quantas observaÃ§Ãµes, variÃ¡veis, tipo de variÃ¡vel...
str(mtcars)
# Mostrar o nÃºmero de linhas
nrow(mtcars)
# Mostrar o nÃºmero de colunas
ncol(mtcars)
# Mostrar o nÃºmero de linhas e colunas, necessariamente nesta ordem
dim(mtcars)
# Visualizar o nome das variÃ¡veis
names(mtcars)
# Editar uma funÃ§Ã£o, no caso "head" para alterar o nÃºmero de observaÃ§Ãµes apresentadas
head(x = mtcars, n = 10)
# Mesmo da anterior, indicando a nÃ£o necessidade de escrever "x" e "n", quando conhecida a ordem
head(mtcars, 10)
# Limpando o ambiente de trabalho
rm(mtcars)

# Iniciando a construÃ§Ã£o de um data frame com informaÃ§Ãµes de notÃ­cias
# Criando vetor com o nome dos jornais
jornal <- c("Folha de SÃ£o Paulo", "Folha de SÃ£o Paulo", "Folha de SÃ£o Paulo", "El PaÃ­s", "El PaÃ­s", "El PaÃ­s")
# Criando vetor com a data das notÃ­cias
date <- c("13/03/2017", "13/03/2017", "13/03/2017", "12/03/2017", "12/03/2017", "12/03/2017")
# Criando vetor com os tÃ­tulos das notÃ­cias
titulo <- c("Em meio Ã  crise, governo Temer aumenta investimento militar em 35%", "'Lista de Janot' deve ter pedidos para 80 inquÃ©ritos ao Supremo", "Ã espera de delaÃ§Ãµes, Temer lanÃ§a mÃ£o de estratÃ©gia para sobreviver atÃ© 2018", "TensÃ£o toma conta de BrasÃ­lia com iminente divulgaÃ§Ã£o da 'delaÃ§Ã£o do fim do mundo'", "DelaÃ§Ãµes da Odebrecht: o que jÃ¡ se sabe e o que mais elas podem conter", "âNa Venezuela nÃ£o hÃ¡ comida, mas no Brasil simâ: a nova fuga da fome na fronteira do norte")
# Criando vetor com o nome dos autores
autor <- c("Igor Gielow e Gustavo Patu", "LetÃ­cia Casado", "Leandro Colon", "Talita Bedinelli", "N/A", "Marina Rossi")
# Criando vetor com o nÃºmero de caracteres
caracteres <- c(1653, 985, 1124, 868, 1021, 1780)
# Criando vetor com classificaÃ§Ã£o binÃ¡ria de conteÃºdo de polÃ­tica: 1 sim e 0 nÃ£o
politica <- c(1, 1, 1, 1, 1, 1)
# Criando vetor com classificaÃ§Ã£o binÃ¡ria de conteÃºdo de esportes: 1 sim e 0 nÃ£o
esportes <- c(0, 0, 0, 0, 0, 0)
# Criando vetor indicando a presenÃ§a de vÃ­deo na matÃ©ria: "ContÃ©m vÃ­deo"
video <- c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
# Observando os objetos criados no workspace
ls()

# Criando um data frame a partir dos vetores
# Verificando se os vetores possuem o mesmo comprimento
length(jornal)
length(date)
length(titulo)
length(autor)
length(caracteres)
length(politica)
length(esportes)
length(video)
# Criando o data frame compilando os vetores
dados <- data.frame(jornal, date, titulo, autor, caracteres, politica, esportes, video)
# Como o data frame atribui automaticamente o nome dos vetores Ã s variÃ¡veis, Ã© possÃ­vel alterar o nome
dados1 <- data.frame(newspaper = jornal,
                     date = date,
                     title = titulo,
                     author = autor,
                     n_char = caracteres, politica, esportes, video)
# Observando as 6 primeiras linhas do data frame
head(dados)
# Observando a estrutura dos dados
str(dados)
# Observando o nome das variÃ¡veis
names(dados)
# Observando as dimensÃµes
dim(dados)

# Removendo os vetores
rm(author, autor, caracteres, date, esportes, jornal, politica, title, titulo, video)

# Tipos de ddaos em R e vetores
# Doubles: guardar nÃºmeros, como o vetor caracteres criado
# Vendo o tipo de vetor criado
typeof(caracteres)
# Realizando operaÃ§Ãµes com o vetor
caracteres + 1
caracteres * 2
sum(caracteres)
# Logicals: possibilidade de classificar variÃ¡veis binÃ¡rias com FALSE (F) ou TRUE (T) e nÃ£o como double, 0 e 1
typeof(politica)
typeof(esportes)
typeof(video)
  # Se somar os valores de uma variÃ¡vel logical, considera os valores 0 e 1 para a classificaÃ§Ã£o de false e true, respectivamente
video + 1
sum(video)
# Character: variÃ¡veis textuais (strings)
typeof(jornal)
typeof(titulo)

# Abrindo bases externas
votacao_candidato_munzona_2014_AC <- read.table("~/Downloads/votacao_candidato_munzona_2014_AC.txt", sep = ";", fileEncoding="latin1")

# ExercÃ­cios
#1- Quantas linhas e quantas colunas tÃªm o data frame votacao_candidato_munzona_2014_AC? Use as funÃ§Ãµes que vocÃª aprendeu no tutorial.
dim(votacao_candidato_munzona_2014_AC)
#2- Observe as 4 primeiras linhas do data frame com o comando head (sÃ³ as 4 primeiras).
head(votacao_candidato_munzona_2014_AC, 4)
#3- Use o comando str para examinar o data frame.
str(votacao_candidato_munzona_2014_AC)

# CadÃª o nome das variÃ¡veis
names(votacao_candidato_munzona_2014_AC)
# Colunas como vetores
  # Como nÃ£o Ã© um objeto no ambiente de trabalho, nÃ£o Ã© possÃ­vel usar de forma direta
mean(V29)
  # Assim Ã© preciso especificar o data frame de origem
mean(votacao_candidato_munzona_2014_AC$V29)
