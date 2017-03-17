# Nestre capítulo, a atividade consiste na construção de um baralho de cartas.

# Mas antes, é importante entender os tipos de vetores criados pelo R
  # Doubles: um vetor "double" armazena números, positivos ou negativos, com ou sem casa decimal. De forma geral, o R armazena números como "doubles". O nome se refere ao número de bytes que  computador utiliza para armazenar um número, ainda que algumas funções indiquem esses vetores como "numerics" com o mesmo significado.
double <- c(-2, -1, 0, 1, 2)
typeof(double)
  # Integers: um vetor "integer" se refere a números que não podem ser escritos sem um componente decimal. Não é muito utilizado porque normalmente são salvos como "doubles"
integer <- c(-2L, -1L, 1L, 2L)
typeof(integer)
    # O R não salva como 'integer'a não ser que se adicione o "L", a única diferença para os "doubles". A diferença na aplicação é que os "integers" são definidos de forma mais precisa na memória, a não se que sejam muito pequenos ou grandes), pois utiliza mais do que 64 bits para armazenar os valores.
      # "Doubles" precisam em até 16 casas decimais, sendo que normalmente são utilizados
  # Characters: um vetor "character" salva um pequeno texto, uma string
character <- c("texto 1", "texto 2", "texto 3")
typeof(character)
  # Logicals: um vetor "logical" indica informação de verdadeiro e falso aplicando uma lógica booleana
logical <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
typeof(logical)
  # Complex: armazena números complexos
complex <- c(1 + 1i, 1 + 2i, 3 + 3i)
typeof(complex)
  # Raw: armazena linhas de bytes de dados
raw <- raw(5)
typeof(raw)

# Outras funções para os vetores são a atribuição de nomes, dimensões, matrizes, arranjos e classes
  # Names: atribui nomes aos vetores, podendo se atribuir um único ou diferentes nomes aos valores do vetor. Retomemos o exemplo do dado
die <- 1:6
names(die) <- c("um", "dois", "três", "quatro", "cinco", "seis")
die
    # São rótulos, tanto que se somarmos algum valor aos inicialmente utilizados, os nomes continuam os mesmos
die + 3
    # Para retirar esses rótulos, basta "anular" os nomes
names(die) <- NULL
die
  # Dimensões: aqui ocorre a transformação de um "vetor atômico" em um arranjo n-dimensional. Por exemplo, podemos transformar o vetor "die" em um vetor 2 x 3
dim(die) <- c(2, 3)
die
    # Com percebido, o R reconhece o primeiro valor como linhas e o segundo como colunas
  # Matrizes: a função reorganiza vetores atômicos em matrizes, podendo se definir pelo número de linhas (argumento "nrow") ou de colunas ("ncol")
die <- 1:6
matriz <- matrix(die, nrow = 2)
matriz
  # Arranjos: não é customizável e realiza basicamente a mesma coisa que o comando "dim"
arranjo <- array(c(11:14, 21:24, 31:34), dim = c(2, 2, 3))
arranjo
  # Classes: é um caso especial de um vetor atômico, atribuindo um valor ao tipo de objeto atômico
die <- 1:6
class(die)
matriz <- matrix(die, nrow = 2)
class(matriz)
  # Datas e horários: o R possui classes especiais para representar datas e horários, sendo que o tempo parece uma string/character mesmo sendo uma double de fato
now <- Sys.time()
now
typeof(now)
class(now)
    # POSIXct é um enquadramento utilizado para represnetar datas e horários
    # Para ver o valor do vetor, basta remover a classe
unclass(now)
    # Quando um vetor "double" contém duas classes, POSIXct e POSIXt, indica que está tratando o tempo de uma forma especial. Ao atribuir essas classes para um valor aleatório é possível identificar a data e o tempo indicados
milhao <- 1000000
milhao
class(milhao) <- c("POSIXct", "POSIXt")
milhao
    # Fatores: uma forma especial de armazenar informações categóricas, permitindo armazenar níveis de tratamento e outras variáveis categóricas. Na conversão, o R transforma o vetor em "integers" e armazena o resultado. Como exemplo, utilizaremos um vetor com informações sobre sexo.
sexo <- factor(c("masculino", "feminino", "feminino", "masculino", "feminino"))
sexo
attributes(sexo)
unclass(sexo)
      # Apesar de tornar a inclusão em modelos estatísticos mais simples ao codificar variáveis categóricas como números, podem criar confusão ao parecer como strings/characters e se comportar como "integers".
        # O R tenta converter "character strings" em fatores ao importar ou criar dados. É possível realizar o processo contrário, de converter um fator em "character string"
as.character(sexo)
sexo
attributes(sexo)

# Coerção do R
  # Se um vetor atômico contém uma "character string", o R converterá todos os outros valores em "character string"
  # Se contém "logicals" e "doubles", converterá as "logicals" em números (1 verdadeiro e 0 falso)
    # As mesmas regras de coerção se aplicam quando se tentar realizar operações matemáticas com valores "logicals"
sum(c(TRUE, TRUE, TRUE, FALSE, TRUE))
    # Como no exemplo, 4 indica o total de TRUE e a média representa a proporção de TRUEs
  # Por que é útil? 
    # Isto auxilia na preservação de informações
    # Da mesma forma, vetores, matrizes e arranjos tornam a matemática mais fácil para bases com muitos dados, além de mais rápidas

# Listas: são como vetores atômicos por agrupar dados de forma unidimensional. No entanto, agrupam objetos do R, como vetores e outras listas, e não informações individuais
  # São um tipo básico de objeto no R, como vetores atômicos, utilziaodos para contruir blocos e criar objetos mais sofisticados.
list1 <- list(100:130, "R", list(TRUE, FALSE))
list1

# Data Frames:
