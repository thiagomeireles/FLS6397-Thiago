# O Capítulo objetiva criar a simulação de um jogo de dados

# Criando a simulação de um dado
die <- 1:6
# Realizando a simulação de uma jogada de um dado
sample(x = die, size = 1)
# Realizando a simulação de uma jogada com DOIS dados
sample(x = die, size = 2, replace = TRUE)

# Criando uma função que some o resultado dos dois dados
roll <- function() {
  die <- 1:6
  dice <- sample(x = die, size = 2, replace = TRUE)
  sum(dice)
}
# Construída a função, a partir do momento em que se pede ela, executa todo o processo indicado pela função
roll()

# Pensando argumentos
# Pode-se contruir uma função baseada em um argumento a ser desenvolvido, como substituindo 
## die por bones, por exemplo. 
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
# Mas, para que execute, deve-se especificar qual o argumento ao qual está submetida a cada 
## utilização da função
roll2(bones = 1:10)
roll2(1:20)
# Outra saída é especificar o argumento na construção da função
roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}
roll2()
