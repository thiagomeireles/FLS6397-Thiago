```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tutorial 4: Abrindo dados no R

**Pacotes no R**

Para instalar um novo pacote no R disponível no CRAN (The Comprehensive R Archive Network) é utilizada a função *install.packages*, como no exemplo a seguir:
```
install.packages("beepr")
```
Uma vez instalado, utilizamos a função *library* para carregar o pacote da biblioteca.
```
library(beepr)
```
A função library tem as aspas como opcional e resultado semelhante é obtido com a função *require*.

**Abrindo dados com as funções do pacote utils**

Alguns pacotes já são carregados na inicialização do R, como o *utils*, o qual contém as funções mais conhecidas para abertura de dados de texto, sendo a *read.table* a mais sua principal função.
```
args(read.table)
```
Para carregar o arquivo desejado, é necessário indicar como primeiro argumento o *working directory* (wd), ou seja, o caminho completo do arquivo.

**Caminhos no R**

Mas como descobrir meu wd?
```
getwd()
```
E como alterar meu wd?
```
setwd("C:\\User\\Documents")
```
Um detalhe fundamental para quem usa o Windows é que os caminhos DEVEM ser escritos com DUAS barras e não uma, como no exemplo. No Linux isto não é necessário.

Quando quisermos abrir mais de uma arquivo que esteja em uma mesma pasta (diferente do wd indicado acima), podemos gerar um objeto que indique o caminho para não ter que digitar a cada utilização e utilizar a função *file.path* para cada arquivo armazenado.
```
pasta <- "C:\\Users\\Downloads"
path_file1 <- file.path(pasta, "file1.txt")
path_file2 <- file.path(pasta, "file2.txt")
```
Ainda que não pareça muito útil no momento, pensar na combinação das funções acima com loops para abrir diversos arquivo.

**read.table**

Utilizando um exemplo com uma amostra de tamanho 50 retirado do Portal da Transparência, com o *file* disponível no repositório do curso.
```
file1 <- "https://raw.githubusercontent.com/leobarone/FLS6397/master/data/bf_amostra_hv.csv"
```
Como contém cabeçalho, ou seja, o nome das variáveis na primeira linha, informaremos "header = T".
```
dados <- read.table(file1, header = T, sep = ",")
head(dados)
```
Se escolhessemos "header = F" o R leria o nome das variáveis como observações, gerando automaticamente v1, v2, etc. Com isso todas as variáveis seriam lidas como *factor* ou *character* a depender das características da variável.
```
dados2 <- read.table(file1, header = F, sep = ",")
head(dados2)
str(dados2)
```
Vamos observar uma versão sem o nome das variáveis na primeira linha
```
file2 <- "https://raw.githubusercontent.com/leobarone/FLS6397/master/data/bf_amostra_nv.csv"
```
Dessa forma, como não há cabeçalho, os nomes das variáveis são inseridos automaticamente
```
dados3 <- read.table(file2, header = F, sep = ",")
head(dados3)
```
E se cometessemos o erro de pedir o cabeçalho?
```
dados4 <- read.table(file2, header = T, sep = ",")
head(dados4)
```
*A primeira linha de dados se torna o nome das variáveis (inclusive os números antecedidos por um "X").*

Ambos arquivos têm o mesmo separador: vírgula. O argumento "sep" permite indicar qual é o separador.

Não há muita graça em observar os exemplos com separadores diferente, mas vejamos como abrí-los. Os mais comuns, além da vírgula, são o ponto e vírgula e o tab, este último representado pelo símbolo "\t"
```
# Ponto e virgula
file3 <- "https://raw.githubusercontent.com/leobarone/FLS6397/master/data/bf_amostra_hp.csv"
dados5 <- read.table(file3, header = T, sep = ";")
head(dados5)

file4 <- "https://raw.githubusercontent.com/leobarone/FLS6397/master/data/bf_amostra_ht.csv"
dados6 <- read.table(file4, header = T, sep = "\t")
head(dados6)
```
- Outras funções da família *read.table* fazem parte do pacote *utils*, sendo diferenciadas pelo separador de coluna ("," para read.csv, ";" para read.csv2, "\t" para read.delim e read.delim2) eo separador decimal
- Como padrão, *read.table* entende que os campos de cada coluna entre aspas duplas (quote = "\""), de forma que *quote = ""* indica que não há nada.
- O argumento *dec* é utilizado para o separador decimal, sendo impostante por no padrão brasileiro utilizarmos a vírgula e não o ponto.

Quando buscamos importar apenas um subconjunto das linhas, podemos utilizar as funções *skip* para pular algumas linhas e *nrows* para indicar o número máximo de linhas a se abrir. Estas funções são bastante úteis por permitirem abrir uma fração pequena do banco de dados, especialmente se for desconhecido e muito grande, para conhecer os demais argumentos (*header*, *sep*, etc.) com baixo custo de tempo.

*Exemplo:* Pular as 3 primeiras linhas
```
dados7 <- read.table(file2, header = T, sep = ",", skip = 3)
head(dados7)
```
*Exemplo:* Para abrir apenas 20 linhas:
```
dados8 <- read.table(file2, header = T, sep = ",", nrows = 20)
head(dados8)
```
*Exemplo:* Combinando, para abrir da linha 11 à linha 30:
```
dados9 <- read.table(file1, header = T, sep = ",", skip = 10, nrows = 30)
head(dados9)
```
Definir a classe das variáveis a ser importadas pode ser interessante, e utiliza-se um vetor com o argumento com a classe para cada coluna.
```
dados10 <- read.table(file1, header = T, sep = ",", 
  colClasses = c("character", "numeric", "character", "numeric", "numeric"))
str(dados10)
```
Quando não especificamos o tipo de dados da coluna, a função *read.table* tenta identificá-los, sendo que, normalmente, as funções de abertura de dados do pacote *utils* indentifica as colunas de texto normalmente como *factors* ainda que não sejam. Vejamos os dados abertos anteriormente:
```
str(dados)
str(dados2)
str(dados3)
...
```
Para evitar este inconveniente, deve-se informar o parâmetro *StringsAsFactors = F*, porque o padrão é "T". O incômodo é tão grande com o argumento que muitos chegam a alterar a configuração básica da função
```
dados11 <- read.table(file1, header = T, sep = ",", stringsAsFactors = F)
str(dados11)
```
Diferente do que ocorreu em "dados", por exemplo, "uf" e "munic" agora foram importadas como "character".

Por fim, são comuns problemas na abertura de arquivos com caracteres especiais, pois o encoding varia de acordo com o sistema operacional e aplicativo no qual foi gerado, de forma que são diferentes as formas de transformar 0 e 1 em vogais acentuadas, cedilhas, etc.

*O parâmetro "fileEncoding" é utilizado para resolver esse problema ao indicar qual o "encoding" esperado. No entanto, não é possível descobrir automaticamente o "encoding" de um arquivo, sendo preciso conhecer como ele foi gerado - por produção própria ou por acesso à documentação - ou com processo de tentativa e erro.*

*Encodings comuns:* "latin 1", "latin2" e utf8, mas existem diversos outros.


**Tibbles e tidyverse**

*Tibble:*
É um tipo específico de data frame, se diferenciando à forma que os dados aparecem no console quando "imprimimos" o objeto, ao "subsetting" (seleção de linhas) e à adoção de "stringAsFactors = F" como padrão.

*readr:* é um pacote componente do *tidyverse* que contém funções para abrir dados em .txt semelhantes ao *utils*, mas que possui algumas vantagens:
- Velocidade de abertura
- Simplificação de argumentos
- Produção de tibbles como resultado da importação
```
library(readr)
```
A função análoga a *read.table* é *read_delim*.
```
dados12 <- read_delim(file1, delim = ",")
dados12
```
Diferente dos data frames gerados com o *read.table*, não precisamos utilizar o head para imprimir as primeiras linhas. Os *tibbles* têm, como output, uma fração do banco, a informação de linhas e coluna e os tipos de variável abaixo dos nomes das colunas. *delim* é o argumento que substitui *sep* na função *readr*.

Observe que não utilizamos head para imprimir as primeiras linhas. Essa é uma característica de tibbles: o output contém uma fração do banco, a informação sobre número de linhas e colunas, e os tipos de cada variável abaixo dos nomes das colunas. "delim" é o argumento que entra no lugar de "sep" ao utilizarmos as funções do readr.
```
# A tibble: 50 × 5
      uf codmunic                      munic        nis valor
   <chr>    <int>                      <chr>      <int> <int>
1     PI     1115                 LUZILANDIA 2147483647   167
2     RS     8953                    VACARIA 2147483647   124
3     SP     7145                   SOROCABA 2147483647   248
4     RN     1927               SERRA DO MEL 2147483647   202
5     MA      899 SANTA QUITERIA DO MARANHAO 2147483647   178
6     PE     2635       CARNAUBEIRA DA PENHA 2147483647   256
7     MA      849             PACO DO LUMIAR 2147483647   131
8     RN     1741                    MACAIBA 2147483647   242
9     PE     2457    JABOATAO DOS GUARARAPES 2147483647   163
10    ES     5663                   LINHARES 2147483647   163
# ... with 40 more rows
```
Como padrão, o *read_delim* importa a primeira linha como nome das variáveis. O argumento *header* é substituído pelo *col_names*, que deve ser "FALSE" para dados que não contenham os nomes das variáveis, como *file2*.
```
dados13 <- read_delim(file2, col_names = F, delim = ",")
dados13
```
É possível atribuir nomes às colunas utilizando de um vetor:
```
dados14 <- read_delim(file2, col_names = c("estado", "municipio_cod", "municipio_nome",
                                         "NIS", "transferido"),
                    delim = ",")
dados14
```
As funções *skip* e *nrows* encontram correspondência em *skip* e *n_max* no *read_delim*.

Por fim, *col_types* realiza a função de *colClasses* trazendo a vantadem de não precisar um vetor com os tipos de dados para cada variável.

Como realizar isso?

*Basta escrever uma sequência de caracteres onde "c" = "character, "d" = "double", "l" = "logical" e "i" = "integer"*

```
dados15 <- read_delim(file1, delim = ",", col_types = "cicid")
dados15
```
Assim, fornece uma alternativa muito mais limpa e econômica.

*read_csv e read_tsv:*
São as versões de *read_delim* para arquivos sepadaros por vírgula e por tabulação, respectivamente

*Do ponto de vista forma, as três funções de importação de dados de texto do pacote readr geram objetos que pertecem à classe de data frames e também às classes tbl e tbl_df, que são as classes de tibbles.*

**Outra gramática para dados em R: data.table**

No curso são utilizadas duas "gramáticas" para os dados em R: a dos pacotes básicos e a do tidyverse. Uma terceira alternativa é o pacote *data.table*, não trabalhado no curso, e que guarda algumas poucas semelhanças com SQL.
```
library(data.table)
```
No entanto, duas funções do pacote são bastante úteis: *fread* e *fwrite*, utilizadas para importar e exportar dados de texto.
```
class(dados)
```
Vantagens de utilizar o *fread*
- Detecta automaticamente as características do arquivo de texto para (1) definir limitadores, (2) cabeçalho, (3) tipos de dados da coluna, etc.
- É extremamente rápida em comparação às demais, tanto que o "f" vem de "Fast and friendly file finagler"
```
dados15 <- fread(file1)
head(dados15)
```
Além de ser um data.frame, o objeto criado pelo *fread* também é da classe data.table e aceita a "gramática" deste pacote.

Também é importante dizer que os argumentos para *fread* ler um arquivo são muito parecidos aos de *data.table*


**Dados em arquivos editores de planilhas**

Para obter dados em formato *.xls* ou *.xlsx* de forma direta existem dois pacotes: *readxl* e *gdata*. Aqui o conteúdo se limitará ao *readxl*.
```
library(readxl)
```


**Um pouco sobre donwload e manipulação de arquivos**

Como exemplo, utilizaremos o MUNIC 2005, Pesquisa Perfil dos Municípios Brasileiros de 2005 produzida pelo IBGE. Para isso, será feito o download para acessar o arquivo localmente, e faremos isso de forma automatizada e descompactaremos o arquivo.

Para isso, em um primeiro momento guardaremos o endereço url em um objeto e faremos o dwonload.
*Na função "dowload.file" o primeiro argumento é o url e o segundo o nome do arquivo que será salvo (para salvar em quaquer pasta basta gerar o caminho completo com o "file.path"*
```
url_arquivo <- "ftp://ftp.ibge.gov.br/Perfil_Municipios/2005/base_MUNIC_2005.zip"
download.file(url_arquivo, "munic2005.zip", quiet = F)
```
*O argumento "quiet = F" serve para não imprimir "os números" do download, evitando poluição*

O conteúdo da pasta será extraído com o *unuzip*
```
unzip("munic2005.zip")
```
Para observar todos os arquivos da pasta, utilizamos o *list.file*.
```
list.files()
```
Podemos aproveitar e excluir o arquivo *.zip* temporário.
```
file.remove("temp.zip")
```

**Voltando às planilhas**

Aqui utilizaremos o arquivo "Base 2005.xls" e, para não repetir seu nome várias vezes, criaremos um objeto que contém o endereço do arquivo no computador (ou somente o nome do arquivo entre aspas se estiver no wd).
```
arquivo <- "Base 2005.xls"
```
Para observar as planilhas do arquivo utilizamos o *excel_sheets*.
```
excel_sheets(arquivo)
```
São 11 planilhas diferentes, sendo a primeira o Dicionário (que não é uma base de dados). As outras possuem formato adequado para data frame, sendo que vamos importar os dados das "Variáveis externas", tarefa que pode ser executada de duas formas:
```
# 1
transporte <- read_excel(arquivo, "Variáveis externas")

# 2
transporte <- read_excel(arquivo, 11)
```
a função *read_excel* aceita as funções do pacote *readr*, em como os argumentos *col_names*, *col_types* e *skip*.
```
file.remove("Base 2005.xls")
```

**Dados de SPSS, Stata e SAS**

Para importação de dados de outros softwares estatísticos existem dois pacotes, *foreign*, mais antigo e conhecido, e *haven*, parte do tydeverse. Por mais que sejam parecidos, a recomendação é pelo segundo.
```
library(haven)
```
Há, basicamente, cinco funções de importação de dados no *haven*
- *read_sas* para dados em SAS
- *read_stata* e *read_dta*: para dados em formatos *.dta* gerados pelo Stata
- *read_sav* e *read_por*: um para cada formato de dados do SPSS
O uso, como era de se esperar, é bastante similar ao que vimos no tutorial todo.

*Exemplo*
Utilizaremos o *Latinobarômetro 2015* (disponível para SAS, Stata, SPSS e R), mas faremos o processo manual de pegar os dados em função do site ser "cheiro de javascript" (o que gera mais trabalho para o download automático)

"Deixo abaixo uma breve descrição do Latinobarômetro que "roubei" de outro curso que ministrei. É possível que façamos exercícios com o Latinobarômetro no futuro, dado que é um banco de dados com muitas (muitas mesmo) variáveis categóricas, posto que é survey.
2011 Latinobarometer

The second dataser is the 2015 Latinobarometer. This is a very popular survey on democracy and elections in Latin America and the original can be found here. Latinobarometer contains data on several Latin American Countries. We are going to use the data on Brazil only. "Barometers" are very good source of public opinion data regarding issues of political regime, civil liberties, economic performance of governments and etc. I am sure this dataset can be source of lots of dissertations of students in political economy and comparative politics.

We will use the dataset to formulate hypothesis about the brazilian electorate and explore our creativity. This is why it will be very important that we spend some time exploring the dictionary, whose .pdf is available both in english and spanish (although not in portuguese, even though it exists). It is a consolidated survey, so don't be frustrated if the data you are looking for is not ther and look for something else.""


**Abrindo os dados com haven**

Vejamos o uso das funções em arquivos de diferentes formatos:
```
# SPSS
lat <- read_spss("C:/Users/dcplab/Downloads/Latinobarometro_2015_Eng.sav")
head(lat)

# Stata
lat2 <- read_stata("C:/Users/dcplab/Downloads/Latinobarometro_2015_Eng.dta")
head(lat2)
```
Simples assim.

Há critérios de conversão de variáveis categóricas, rótulos e etc, adotados pelo R ao importar arquivos de outras linguagens, mas você pode descobrí-los testando sozinho.


**Arquivos .RData**

*.RData:* Este é o formato de dados do R? Sim e não.

Começando pelo "não": um arquivo .RData não é um arquivo de base de dados em R, ou seja, não contém um data frame. Ele contém um workspace inteiro!

Para salvar um arquivo .RData sem usar o "botão do disquete", use a função save.image:
```
save.image("myWorkspace.RData")
```
Para abrir um arquivo .RData, por exemplo, o do Latinobarômetro ou o que você acabou de salvar, use a função load:
```
# Latinobarometro
load("/home/acsa/FLS/Latinobarometro_2015_Eng.rdata")

# Workspace do tutorial
load("myWorkspace.RData")

file.remove("myWorkspace.RData")
```
