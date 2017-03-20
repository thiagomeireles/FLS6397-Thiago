# Tutorial 1

Carregando conjunto de base de dados preexistente
```
library(datasets)
```
Abrindo um data frame desse pacote
```
data("mtcars")
```
Abrindo informaçõees sobre o data frame (resumo, codebook, etc.)
```
?mtcars
```
Visualizando o data frame
```
View(mtcars)
```
Visualizando as primeiras seis observações do data frame
```
head(mtcars)
```
Visualizando a estruruda dos dados, ou seja, quantas observações, variáveis, tipo de variável...
```
str(mtcars)
```
Mostrar o número de linhas
```
nrow(mtcars)
```
Mostrar o número de colunas
```
ncol(mtcars)
```
Mostrar o número de linhas e colunas, necessariamente nesta ordem
```
dim(mtcars)
```
Visualizar o nome das variáveis
```
names(mtcars)
```
Editar uma função, no caso "head" para alterar o número de observações apresentadas
```
head(x = mtcars, n = 10)
```
Mesmo da anterior, indicando a não necessidade de escrever "x" e "n", quando conhecida a ordem, ainda que aconselhável para manter claro e não arriscar cometer erros por errar a ordem reconhecida pela linguagem
```
head(mtcars, 10)
```
Limpando o ambiente de trabalho
```
rm(mtcars)
```


*Iniciando a construção de um data frame com informações de notícias*

Criando vetor com o nome dos jornais
```
jornal <- c("Folha de SÃ£o Paulo", "Folha de SÃ£o Paulo", "Folha de SÃ£o Paulo", "El País", "El País", "El País")
```
Criando vetor com a data das notícias
```
date <- c("13/03/2017", "13/03/2017", "13/03/2017", "12/03/2017", "12/03/2017", "12/03/2017")
```
Criando vetor com os títulos das notícias
```
titulo <- c("Em meio à  crise, governo Temer aumenta investimento militar em 35%", "'Lista de Janot' deve ter pedidos para 80 inquéritos ao Supremo", "À espera de delações, Temer lança mão de estratégia para sobreviver até 2018", "Tensão toma conta de Brasília com iminente divulgação da 'delação do fim do mundo'", "Delações da Odebrecht: o que já se sabe e o que mais elas podem conter", "'Na Venezuela não há comida, mas no Brasil sim': a nova fuga da fome na fronteira do norte")
```
Criando vetor com o nome dos autores
```
autor <- c("Igor Gielow e Gustavo Patu", "Letícia Casado", "Leandro Colon", "Talita Bedinelli", "NA", "Marina Rossi")
```
Criando vetor com o número de caracteres
```
caracteres <- c(1653, 985, 1124, 868, 1021, 1780)
```
Criando vetor com classificação binária de conteúdo de política: 1 sim e 0 não
```
politica <- c(1, 1, 1, 1, 1, 1)
```
Criando vetor com classificação binária de conteúdo de esportes: 1 sim e 0 não
```
esportes <- c(0, 0, 0, 0, 0, 0)
```
Criando vetor indicando a presençaa de vídeo na matéria: "Contém vídeo"
```
video <- c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)
```
Observando os objetos criados no workspace
```
ls()
```

*Criando um data frame a partir dos vetores*

Verificando se os vetores possuem o mesmo comprimento
```
length(jornal)
length(date)
length(titulo)
length(autor)
length(caracteres)
length(politica)
length(esportes)
length(video)
```
Criando o data frame compilando os vetores
```
dados <- data.frame(jornal, date, titulo, autor, caracteres, politica, esportes, video)
```
Como o data frame atribui automaticamente o nome dos vetores às variáves, caso desejado pode-se alterar o nome
```
dados1 <- data.frame(newspaper = jornal,
                     date = date,
                     title = titulo,
                     author = autor,
                     n_char = caracteres, politica, esportes, video)
```
Observando as 6 primeiras linhas do data frame
```
head(dados)
```
Observando a estrutura dos dados
```
str(dados)
```
Observando o nome das variÃ¡veis
```
names(dados)
```
Observando as dimensÃµes
```
dim(dados)
```


**Tipos de dados em R e vetores**
*Doubles:* guardar números, como o vetor caracteres criado
Vendo o tipo de vetor criado
```
typeof(caracteres)
```
Realizando operaçõees com o vetor
```
caracteres + 1
caracteres * 2
sum(caracteres)
```
*Logicals:* possibilidade de classificar variáveis binárias com FALSE (F) ou TRUE (T) e não como double, 0 e 1
```
typeof(politica)
typeof(esportes)
typeof(video)
```
Se somar os valores de uma variável logical, considera os valores 0 e 1 para a classificação de false e true, respectivamente
```
video + 1
sum(video)
```
*Character:* variáveis textuais (strings)
```
typeof(jornal)
typeof(titulo)
```


**Abrindo bases externas**

Aqui abriremos a base de dados com a votação nominal por município e zona no Acre em 2014. Para importar, cria-se um data frame a partir da leitura do arquivo txt indicando o caminho no computador, no caso, a pasta "Downloads"
```
votacao_candidato_munzona_2014_AC <- read.table("~/Downloads/votacao_candidato_munzona_2014_AC.txt", 
                                                sep = ";", fileEncoding="latin1")
```


**Exercícios**
1- Quantas linhas e quantas colunas tem o data frame votacao_candidato_munzona_2014_AC? Use as funções que você aprendeu no tutorial.
```
dim(votacao_candidato_munzona_2014_AC)
```
2- Observe as 4 primeiras linhas do data frame com o comando head (só as 4 primeiras).
```
head(votacao_candidato_munzona_2014_AC, 4)
```
3- Use o comando str para examinar o data frame.
```
str(votacao_candidato_munzona_2014_AC)
4- Qual o nome das variáveis?
names(votacao_candidato_munzona_2014_AC)
*Aqui é necessário o codebook para identificação de cada uma das variáveis*

**Colunas como vetores**
Como não é um objeto no ambiente de trabalho, não é possível usar de forma direta
```
mean(V29)
```
Assim é preciso especificar o data frame de origem
```
mean(votacao_candidato_munzona_2014_AC$V29)
```
