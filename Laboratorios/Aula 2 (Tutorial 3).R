# Botando o Computador para trabalhar

# Operadores relacionais ("==" igual, "!=" diferente, ">" maior, ">=" maior ou igual, "<" menor, "<=" menor ou igual)
  # Exemplos
42 == 41
42 != 41
(2 + 2) == (3 + 1)
(2 + 2) != (3 + 1)
5 > 3
5 < 3
42 > 42
42 < 41
42 >= 42
42 <= 41
  # Os operadores relacionais também valem para textos!!!
"texto" == "texto"
"texto" == "texTo"
"texto" != "texto"
      # Observando o segundo exemplo, vemos mais uma vez que o R é "case sensitive", diferenciando maiúsculas e minúsculas
  # Textos também podem ser ordenados
"a" > "b"
"a" < "b"
"A" < "b"
"A" > "a"
      # Aqui vemos que quanto mais para o final do alfabeto, maior; bem como maiúscula maior que minúscula
  # Inclusive entre palavras inteiras
"cachorro" < "cachorro quente"
"churrasco de gato" >  "cachorro quente"
      # Aqui vemos a mesma lógica
  # E para valores lógicos?
TRUE == 1
FALSE == 0
TRUE > FALSE
      # As "logicals" são variáveis binárias que assumem valor 0 e 1 para F e T respectivamente
  # É possível estabelecer operações relacionais com vetores também
x <- 5
y <- 10
x > y

# Operadores Relacionais e Vetores
  # É possível comparar um vetor a um valor, de forma que compara cada observação do vetor
votos16 <- c(1030, 551, 992, 345, 203, 2037)
votos16 >= 1000
  # Da mesma forma, compara os valores entre dois vetores. O exemplo compara os votos dos mesmos candidatos para 2012 e 2016
votos12 <- c(890, 354, 950, 400, 50, 3416)
votos16 > votos12

# Operadores lógicos (Booleanos): "E" (&), "OU" (|) e "NÃO" (!) 
  # Seguindo os dados do exemplo anterior, podemos verificar todos os candidatos que obtivaram acima de 500 (exclusive) E abaixo de 1500 (inclusive) votos
votos16 > 500 & votos16 <= 1500
    # Ao utilizar "E", se uma das proposições for falsa, a combinação também o é 
votos16 < 500 | votos12 > 1500
    # Já para "OU", se uma das proposições é verdadeira, a combinação também é
!TRUE
!(5 > 3)
!(votos16 > 500 & votos16 <= 1500)
    # O "NÃO" tem como função reverter uma proposição
sum(votos16 > votos12)
    # Lembremos que vetores lógicos podem ser tratados como se fossem zeros e uns

# Cláusulas condicionais
