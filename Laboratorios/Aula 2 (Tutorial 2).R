# Operações matemáticas básicas
  # Soma
42 + 84
  # Subtração
84 - 42
  # Multiplicação
42 * 2
  # Divisão
42 / 6
  # Potência
2 ^ 5
  # Divisão inteira (Sem resto)
42 %/% 5
  # Resto da Divisão
42 %% 5

# Introduzindo vetores atômicos
  # Criando um vetor atômico (variável)
x <- 42
    # Apesar de ser possível a utilização do símbolo "=", é mais prudente utilizar o "<-" para atribuir valores
x = 42
  # Imprimindo os valores atribuídos ao vetor: basta apenas digitar o nome do vetor
x
    # Também é possível utilizando o comando "print"
print(x)
  # Realizando operações com variáveis
    # Primeiro criaremos outro vetor
y <- 5
  # É possível realizar operações entre dois vetores
x + y
x - y
x * y
x / y
  # Da mesma forma é possível armazenar esses resultados em novos vetores
z1 <- x + y
z2 <- x - y
z3 <- x * y
z4 <- x / y

# Classes de vetores atômicos
  # São três as principais classes de vetores atômicos: numerics, characters e logicals
numero_pi <- 3.14
texto <- "Meu texto"
verdadeiro <- TRUE
    # Para observar a classe dos objetos basta apenas perguntar ao R por isso
class(numero_pi)
class(texto)
class(verdadeiro)
    # Criando vetores com mais de uma observação
vetor_numerico <- c(42, 7, 999, 3.14)
vetor_texto <- c("texto", "a", 'jota', "Miriam", "4")
vetor_logico <- c(TRUE, FALSE, F, F, T)
class(vetor_numerico)
class(vetor_texto)
class(vetor_logico)
      # É interessante observar que
        #1: Vetores numéricos não se importam se usamos números com casas decimais
        #2: Vetores "character" identificam qualquer informação entre parênteses como texto
        #3: Vetores lógicos identificam TRUE e T, FALSE e F da mesma forma desde que maiúsculos

# Exercícios: Qual a classe dos vetores abaixo?
v1 <- c(1, 2, TRUE, 4)
v2 <- c("T", "TRUE", "FALSE", "T")
v3 <- c("1", "2", "3", "4")
v4 <- c(1, "4", 4, 1)
v5 <- c(1, 2, "feijao com arroz")
v6 <- c("Beatriz", "Pedro", TRUE)
v7 <- c(T, T, F, T, F, F, 42)
  # Respostas
class(v1)
    # [1] "numeric"
class(v2)
    # [1] "character"
class(v3)
    # [1] "character"
class(v4)
    # [1] "character"
class(v5)
    # [1] "character"
class(v6)
    # [1] "character"

# Sequências: é possível criar sequências de números utilizando o ":" em substituição à digitação individual de números
sequencia <- 42:66
print(sequencia)
  # Também é possível criar sequências reversas
sequencia_reversa <- 10:1
print(sequencia_reversa)
  # Também é possível combinar sequências em um único vetor...
sequencia_intervalo <- c(1:10, 20:30)
print(sequencia_intervalo)
  # mesmo quando se sobrepõem
sequencia_sobreposicao <- c(10:20, 15:25)
print(sequencia_sobreposicao)
    # Note que, neste último caso, os números sobrepostos são criados uma única vez

# Operações matemáticas com vetores
  # Criemos um vetor com as temperaturas médias em celsius para algum lugar do hemisfério norte entre dezembro e abril de um ano
temperatura_celsius <- c(-7, -10, 5, 12, 21)
temperatura_celsius
  # Da mesma forma que fazemos com vetores atômicos, podemos aplicar operações matemáticas a vetores maiores
temperatura_farenheit <- ((temperatura_celsius / 5) * 9) + 32
temperatura_farenheit

# Nomes dos vetores
names(temperatura_celsius)
  # Vemos que não existem nomes para os valores do vetor, assim atribuiremos estes nomes referentes aos meses
names(temperatura_celsius) <- c("dezembro", "janeiro", "fevereiro", "março", "abril")
names(temperatura_celsius)
  # Outra forma de atribuir os nomes de forma mais elegante é criar um novo vetor para isso
meses_experimento <- c("dezembro", "janeiro", "fevereiro", "março", "abril")
names(temperatura_celsius) <- meses_experimento
names(temperatura_celsius)
  # Note que, sendo vetores nos quais o nome se aplica da mesma forma, também seria possível atribuir nomes ao vetor "temperatura_farenheit" com o vetor anterior
names(temperatura_farenheit) <- meses_experimento
names(temperatura_farenheit)

# Operações entre vetores
  # Criaremos dois vetores para indicar os gastos de uma pessoa com sorvete e café ao longo de duas semanas
semana_1 <- c(32, 20, 15, 20, 18, 19, 40)
semana_2 <- c(32, 21, 12, 12, 24, 21, 50)
  # Antes de realizar as operações, aribuiremos os dias da semana
dias_da_semana <- c("Domingo", "Segunda", "Terca", "Quarta", "Quinta", "Sexta", "Sabado")
names(semana_1) <- dias_da_semana 
names(semana_2) <- dias_da_semana
  # Agora somaremos os gastos nas duas semanas por dia
soma_semanas <- semana_1 + semana_2
print(soma_semanas)
  # Também podemos criar um vetir com as informações das duas semanas
duas_semanas <- c(semana_1, semana_2)
print(duas_semanas)

# Extraindo informações de um subconjunto do vetor
  # É possível observar informações, ainda sobre os gastos por dia da semana, de apenas um dia
semana_1[1]
  # Ou do fim de semana
semana_1[c(1, 7)]
  # Ou dos dias úteis
semana_1[c(2:6)]
    # Estes procedimentos são úteis para extrair informações específicas de um vetor, um subconjunto
  # Também é possível realizar essas operações utilizando os nomes, quando especificado
semana_1["Domingo"]
semana_1[c("Domingo", "Sabado")]
    # No entanto, para perguntar sobre um intervalo, é necessário digitar todos os valores procurados
semana_1[c("Segunda", "Terca", "Quarta", "Quinta", "Sexta")]
      # Para facilitar o processo, podemos criar um vetor que indique os valores do subconjunto 
dias_uteis <- c("Segunda", "Terca", "Quarta", "Quinta", "Sexta")
semana_1[dias_uteis]
      # Muito mais prático, não?
semana_2[dias_uteis]

# Exercício
  # Crie dois novos vetores. No primeiro, anote (invente) o número de palavras que você 
  # escreveu para sua tese/dissertação em cada mês, considerando os últimos seis meses 
  # (setembro a fevereiro). No segundo, anote (chute, novamente) quantos litros de café 
  # você tomou em cada mês.
palavras <- c(4258, 3678, 5413, 1258, 2423, 1864)
cafe <- c(4, 3, 6, 3, 4, 1)
  # Nomeie os elementos dos 2 vetores
meses_dissertacao <- c("Setembro", "Outubro", "Novembro", "Dezembro", "Janeiro", "Fevereiro")
names(palavras) <- meses_dissertacao
names(cafe) <- meses_dissertacao
palavras
    # Setembro   Outubro  Novembro  Dezembro   Janeiro Fevereiro 
    # 4258      3678      5413      1258      2423      1864
cafe
    #  Setembro   Outubro  Novembro  Dezembro   Janeiro Fevereiro 
    #  4         3         6         3         4         1 
  # Calcule sua produtividade em "palavras por Litro de café". Atribua o resultado a um novo vetor
produtividade <- palavras / cafe
  # ou
produtividade <- c(palavras / cafe)
produtividade
     # Setembro    Outubro     Novembro   Dezembro   Janeiro   Fevereiro 
     # 1064.5000   1226.0000   902.1667   419.3333   605.7500   1864.0000 
  # Gere um subcojunto do novo vetor com a produtividade no final 2016 e outro com a produtividade
  # no começo de 2017
fim_2016 <- produtividade[c(1:3)]
inicio_2017 <- produtividade[c(4:6)]
fim_2016
    # Setembro   Outubro   Novembro 
    # 1064.5000 1226.0000  902.1667 
inicio_2017
    #  Dezembro   Janeiro  Fevereiro 
    #  419.3333  605.7500  1864.0000 

# Estatísticas descritivas
  # Criaremos um vetor com maior número de informações, considerando que normalmente trabalhos como muita informação
litros_cafe <- c(4.3, 3.1, 5.3, 5.5, 6.9, 8.3, 9.7, 9.9, 9.1, 7.0, 6.2, 5.6)
  # Agora observaremos as estatísticas descritivas
    # Soma
sum(litros_cafe)
    # Média
mean(litros_cafe)
    # Desvio-padrão
sd(litros_cafe)
    # Variância
var(litros_cafe)
    # Mediana
median(litros_cafe)
    # Valor Máximo
max(litros_cafe)
    # Valor mínimo
min(litros_cafe)
    # Quantis
quantile(litros_cafe, probs = c(0, 0.25, 0.5, 0.75, 1))
      # Todas as funções retornam vetores atômicos, exceto quantis, no qual podemos estabelecer os que queremos observar
quantile(litros_cafe, probs = c(0, 0.2, 0.4, 0.5, 0.6, 0.8, 1))

# Exercício: Com os seus próprios exemplos do exercício acima (palavras e litros de café por mês), use 6 funções acima.
  # Palavras
    # Soma
sum(palavras)
      #[1] 18894
    # Média
mean((palavras))
      #[1] 3149
    # Desvio-padrão
sd(palavras)
      # [1] 1574.141
    # Variância
var(palavras)
      # [1] 2477920
    # Mediana
median(palavras)
      # [1] 3050.5
    # Valor máximo
max(palavras)
      # [1] 5413
    # Valor mínimo
min(palavras)
[1] 1258
    # Quantis
quantile(palavras, probs = c(0, 0.25, 0.5, 0.75, 1))
      # 0%           25%       50%      75%       100% 
      # 1258.00   2003.75   3050.50   4113.00   5413.00
  # Café
    # Soma
sum(cafe)
      # [1] 21    
    # Média
mean(cafe)
    # Desvio-padrão
      # [1] 3.5
    # Variância
var(cafe)
      # [1] 2.7
    # Mediana
median(cafe)
      # [1] 3.5
    # Valor máximo
max(cafe)
      #[1] 6
    # Valor mínimo
min(cafe)
      # [1] 1
    # Quantis
quantile(cafe, probs = c(0, 0.25, 0.5, 0.75, 1))
      # 0%     25%    50%    75%    100% 
      # 1.0    3.0    3.5    4.0    6.0

# Subconjunto vetores (Parte II)
  # Selecionaremos para quais meses o consumo de café foi acima de 7 litros
meses <- c("Janeiro", "Fevereiro", "Marco", "Abril", "Maio", "Junho", 
           "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")
names(litros_cafe) <- meses
selecao <- litros_cafe > 7
litros_cafe[selecao]
    # Ainda que pareça uma operação simples, para bancos de dados com muitas informações isto se torna bastante útil

# Factros e Variáveis categóricas
  # Factor é, basicamente, a classe de vetores em R utilizada para lidar com dados categóricos, nominais ou ordinais
    # Utilizaremos uma variável que só assuma valores "sim" e "não"
yes_no <- c("sim", "nao", "nao", "nao", "sim", "nao")
print(yes_no)
class(yes_no)
    # Utilizaremos a função "factor" para criar o vetor f_yes_no
f_yes_no <- factor(yes_no)
f_yes_no
    # Basicamente, "factors" são vetores numéricos cujos valores estão associados a um rótulo. Os "levels" são esses pares de código numérico + rótulo.
    # Podemos tentar transformar os valores em números
as.numeric(f_yes_no)
      # 1 e 2 representam os valores gerados automaticamente para não e sim, utilizando ordem alfabética
    # Também podemos observar os níveis
levels(f_yes_no)
      # Da mesma forma, podemos alterá-los como fazemos com a função "names"    
levels(f_yes_no) <- c("No", "Yes")
print(f_yes_no)

  # E se os valores forem ordenados?
tamanho <- c("alto", "baixo", "baixo", "medio", "alto", "baixo", "medio")
f_tamanho <- factor(tamanho)
print(f_tamanho)
    # Como segue a ordem alfabética, alto = 1, baixo = 2 e médio = 3
      # Se tentamos observar se existe ordem, encontramos que não
f_tamanho[1]
f_tamanho[2]
f_tamanho[1] > f_tamanho[2]
f_tamanho > "medio"
          # Para ordená-los é preciso utilizar argumentos adicionais
f_tamanho <- factor(tamanho, order = T, levels <- c("baixo", "medio", "alto"))
print(f_tamanho)
    # Agora a ordem segue o que indicamos
f_tamanho[1]
f_tamanho[2]
f_tamanho[1] > f_tamanho[2]
f_tamanho > "medio"

# Exercício
  # Crie um vetor de texto com categorias não ordenáveis.
colors <- c("azul", "amarelo", "branco", "vermelho", "verde")
  # Crie um vetor de fatores a partir do vetor do item anterior.
f_colors <- factor(colors)
f_colors
      # [1] azul     amarelo  branco   vermelho verde   
      # Levels: amarelo azul branco verde vermelho
    # Por curiosidade, veremos os valores atribuídos a cada uma das cores
as.numeric(f_colors)
      # [1] 2 1 3 5 4
  # Traduza os níveis para o inglês (ou para o português se já estiverem em inglês)
levels(f_colors) <- c("blue", "yellow", "white", "red", "green")
f_colors
      # [1] yellow blue   white  green  red   
      # Levels: blue yellow white red green
    # Também observaremos os valores atribuídos
as.numeric(f_colors)
      # [1] 2 1 3 5 4
        # Elas se mantém porque o vetor é criado a partir da ordem estabelecida em português
  # Crie um vetor de texto com categorias ordenáveis.
aval_atendimento <- c("ótimo", "bom", "regular", "ruim", "péssimo")
  # Crie um vetor de fatores a partir do vetor do item anterior.
f_aval_atendimento <- factor(aval_atendimento, order = T, c("péssimo", "ruim", "regular", "bom", "ótimo"))
f_aval_atendimento
  # Compare dois elementos do vetor criado no item anterior
f_aval_atendimento[1]
f_aval_atendimento[2]
f_aval_atendimento[1] > f_aval_atendimento[2]
f_aval_atendimento > "regular"

# Matrizes
  # Matriz seguindo a distribuição por linha
matrix(1:9, byrow = TRUE, nrow = 3)
  # Matriz seguindo a distribuição por coluna
matrix(1:9, byrow = FALSE, nrow = 3)
  # Gerando matrizes a partir de vetores
    # Observamos os vetores...
beatriz <- c(4, 5, 0, 3, 5)
pedro <- c(2, 2, 2, 2, 2)
mateus <- c(0, 0, 12, 0, 0)
    # Criamos um novo vetor unindo os vetores anteriores...
vetor_cafe <- c(beatriz, pedro, mateus)
    # Para, enfim, criar a matriz distribuindo as informações dos vetores iniciais em coluna
cafe <- matrix(vetor_cafe, byrow = FALSE, nrow = 5)
print(cafe)
    # Podemos atribuir nomes às margens da matriz
fregueses <- c("Beatriz", "Pedro", "Mateus")
dias_uteis <- c("Segunda", "Terca", "Quarta", "Quinta", "Sexta")
rownames(cafe) <- dias_uteis
colnames(cafe) <- fregueses
print(cafe)
    # Existe uma forma de gerar a matriz já com os nomes atribuídos com o argumento "dimnames"
cafe <- matrix(vetor_cafe, byrow = FALSE, nrow = 5,
               dimnames = list(dias_uteis, fregueses))
print(cafe)
    # Se quisermos alterar as linhas e colunas basta usar a função "t"
t(cafe)
    # Se quisermos unir os vetores originais como se fossem colunas, a função "cbind"
cbind(beatriz, pedro, mateus)
    # A função "rbind" faz o mesmo tratando os vetores como linhas
rbind(beatriz, pedro, mateus)
    # Para somar os valores nas linhas e colunas usa-se, respectivamente, "rowSums" e "colSums"
rowSums(cafe)
colSums(cafe)
    # É possível gerar os totais nas margens da matriz utilizando as funções de soma e combinação
Total_Coluna <- colSums(cafe)
cafe2 <- rbind(cafe, Total_Coluna)
Total_Linha <- rowSums(cafe2)
cafe2 <- cbind(cafe2, Total_Linha)
print(cafe2)
    # Assim como aplicado a vetores, é possível realizar operações matemáticas
cafe / 3.2
    # Como também é possível realizar operações com matrizes com as mesmas dimensões
matrix(1:9, byrow = TRUE, nrow = 3) + matrix(1:9, byrow = FALSE, nrow = 3)
  # Tudo isso foi realizado para conseguir entender como se seleciona subconjuntos da matriz
    #Selecionar toda a segunda coluna:
cafe[, 2]
    # Selecionar toda a terceira linha:
cafe[3, ]
    # Selecionar o elemento da linha 1 e coluna 3:
cafe[1, 3]
    # Selecionar os elementos 4 e 5 da coluna 1:
cafe[4:5, 1]
    #Selecionar os elementos 1, 3 e 5 da coluna 3:
cafe[c(1,3,5), 3]
    # Selecionar o elemento 4 das colunas 2 e 3:
cafe[4, 2:3]
    # Selecionar a segunda e terça-feira de Pedro:
cafe[c("Segunda", "Terca"), "Pedro"]
    # Selecionar a quarta-feira de todos:
cafe["Quarta",]

# Exercício: Subconjunto de matrizes são fundamentais para o futuro do curso. Seja criativ@ e faça 6 exemplos seus com a matriz "cafe" com a qual trabalhamos.
  # Observar o consumo de café de Pedro ao longo da semana, consumo constante de 2 por dia
cafe[,2]
  # Observar o consumo de café na quarta-feira, observando grande variação
cafe [3,]
  # Mateus parece ter concentrado seu consumo em apenas um dia, vejamos:
cafe[,3]
  # De fato, todo seu consumo foi na quarta-feira
cafe[3,3]
  # Beatriz é quem mais consume café, mas como é distribuído?
cafe[,1]
  # Ao contrário de Mateus, Beatriz somente não consumiu café na quarta-feira
cafe[3,1]
