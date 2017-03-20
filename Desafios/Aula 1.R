# Antes de iniciar a correção dos primeiros comandos é necessário carregar a base de dados "mtcars" presente na biblioteca de banco de dados "datasets"
library(datasets)
data("mtcars")

# Q1)
# Original
Head(mtcars)
# Correção: A linguagem R é sens?vel a mudanças entre maiúsculas e minúsculas, "Head" deve ser "head"
head(mtcars)

# Q2)
#Original
str(Mtcars)
#Correção: Mesmo caso da Q1, "Mtcars" ? "mtcars"
str(mtcars)

# Q3)
# Original
dim[mtcars]
# Correção: Da mesma forma que maiúsculas e minúsculas, chaves e aspas possuem diferenciação na linguagem
dim(mtcars)

# Q4)
# Original
nomes(mtcars)
# Corre??o: O comando está errado pela língua, deve ser em inglês "names"
names(mtcars)

# Q5)
# Original
head(mtcars, x = 10)
# Correção: Aqui são distintas as possibilidades de correção, o erro está nos elementos da função pois é composta por "head(x, n), sendo 10 o n, não x.
head(x = mtcars, n = 10)
head(mtcars, n = 10)
head(x= mtcars, 10)
head(mtcars, 10)

# Q6)
# Original
v1 <- ("pato", "cachorro", "minhoca", "lagarto")
# Correção: É preciso definir a atribuição dos valores ao vetor com "c('valores')", no caso entre aspas por ser uma variável "character", além da separação por vírgulas necessária para qualquer vetor
v1 <- c("pato", "cachorro", "minhoca", "lagarto")

# Q7)
# Original
v2 <- c("1", "2", "3", "4")
v1 + 42
# Correção: A contr?rio das variáveis "character" nas quais se coloca aspas para delimitar os valores os vetores de variáveis numéricas (no caso, uma double) so definidos apenas pela separação em vírgula
v2 <- c(1, 2, 3, 4)
## O Vetor "v1" é nominal, não sendo possível "somar" um valor numérico, ao contrário do vetor "v2"
v2 + 42

#Q8)
# Original
v1 <- c("pato", "cachorro", "minhoca", "lagarto"
# Correção: Para delimitar o vetor é necessário fechar os parênteses
v1 <- c("pato", "cachorro", "minhoca", "lagarto")

# Q9)
# Original: Como explicado em Q7, ? necessário separar os valores atribuídos a vetores numérico apenas por vírgulas
v3 <- c(33 31 40 25 27 40)
# Correção
v3 <- c(33, 31, 40, 25, 27, 40)

# Q10)
# Original
v1 <- c(pato, cachorro, minhoca, lagarto)
# Correção: Necessáras as aspas para cada valor, como indicado em Q6
v1 <- c("pato", "cachorro", "minhoca", "lagarto")

# Q11)
# Original
v1 <- c("pato" "cachorro" "minhoca" "lagarto")
# Correção: Necessária a inclusão das vírgulas entre os valores indicados
v1 <- c("pato", "cachorro", "minhoca", "lagarto")

# Q12)
# Original
v3 <- C(33, 31, 40, 25, 27, 40)
# Correção: Erro na diferenciação entre maiúsculas e minúsculas, como indicado em Q1 e Q2
v3 <- c(33, 31, 40, 25, 27, 40)

#Q13)
# Original
v1 <- c("pato", "cachorro"", "minhoca", "lagarto")
v3 <- c(33, 31, 40, 25, 27, 40)
myData <- data.frame(v1, v3)
# Correção: Erros de digitação, como uma aspa a mais, quebram a leitura do código
v1 <- c("pato", "cachorro", "minhoca", "lagarto")
## Não é possível criar um data frame a partir da união de vetores com número distinto de coluna, como o caso em questão, uma vez que "v1" possui 4 colunas e "v3"" 6. Para fins didáticos, de unir os vetores para construção do data frame, "v3" ser reformulada somente com as 4 primeiras colunas
v3 <- c(33, 31, 40, 25)
myData <- data.frame(v1, v3)

# Q14)
# Original
v1 <- c("pato", "cachorro"", "minhoca", "lagarto")
v4 <- c(33, 31, 40, 25)
myData <- data.frame(v1 = animal, v4 = idade)
# Correção: Na primeira linha, erro de digitação com uma aspa a mais; para criar o data frame ou se usa o v1, v4 e se atribui o nome das variáveis às colunas
v1 <- c("pato", "cachorro", "minhoca", "lagarto")
v4 <- c(33, 31, 40, 25)
myData <- data.frame(v1, v4)
colnames(myData) <- c("animais", "idade)
# Ou cria-se vetores com os nomes utilizados
animais <- c("pato", "cachorro", "minhoca", "lagarto")
idade <- c(33, 31, 40, 25)
myData2 <- data.frame(animais, idade)


# Q15)
# Original
ls
# Correção: Faltaram os parênteses após o comando para indicar quais são os data frames e vetores do ambiente de trabalho
ls()
## Caso quiséssemos identificar quais são as variaáeis dos data frames, bastaria incluir seu nome entre os parênteses
ls(mtcars)
ls(myData)

# Q16)
# Original
v1 <- c("pato", "cachorro", "minhoca", "lagarto")
sum(v1)
# Correção: O comando "sum" soma os valores atribuídos ao vetor. Como a variável é nominal/character esta não é uma propriedade aplicável, diferente de v3 ou v4, por exemplo
v4 <- c(33, 31, 40, 25)
sum(v4)
