# Botando o Computador para trabalhar


**Operadores relacionais**

| Operador       | Símbolo |
| -------------- |:-------:| 
| Igual          | ==      |
| Diferente      | !=      |
| Maior          | >       |
| Maior ou igual | >=      |
| Menor          | <       |
| Menor ou igual | <=      |

*Exemplos*
```
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
```
Os operadores relacionais também valem para textos!!!
```
"texto" == "texto"
"texto" == "texTo"
"texto" != "texto"
```
Observando o segundo exemplo, vemos mais uma vez que o R é "case sensitive", diferenciando maiúsculas e minúsculas

*Textos também podem ser ordenados*
```
"a" > "b"
"a" < "b"
"A" < "b"
"A" > "a"
```
Aqui vemos que quanto mais para o final do alfabeto, maior; bem como maiúscula maior que minúscula

*A regra se aplica inclusive entre entre palavras inteiras*
```
"cachorro" < "cachorro quente"
"churrasco de gato" >  "cachorro quente"
```
Aqui vemos a mesma lógica

*E para valores lógicos?*
```
TRUE == 1
FALSE == 0
TRUE > FALSE
```
As "logicals" são variáveis binárias que assumem valor 0 e 1 para F e T respectivamente

*Também é possível estabelecer operações relacionais com vetores*
```
x <- 5
y <- 10
x > y
```

**Operadores Relacionais e Vetores**

É possível comparar um vetor a um valor, de forma que compara cada observação do vetor
```
votos16 <- c(1030, 551, 992, 345, 203, 2037)
votos16 >= 1000
```
Da mesma forma, compara os valores entre dois vetores.

*O exemplo compara os votos dos mesmos candidatos para 2012 e 2016*
```
votos12 <- c(890, 354, 950, 400, 50, 3416)
votos16 > votos12
```


**Operadores lógicos (Booleanos)**

| Operador | Símbolo |
| -------- |:-------:| 
| E        | &       |
| Ou       | \|      |
| Não      | !       |

*Seguindo os dados do exemplo anterior, podemos verificar todos os candidatos que obtivaram acima de 500 (exclusive) E abaixo de 1500 (inclusive) votos*
```
votos16 > 500 & votos16 <= 1500
```
*Ao utilizar "E", se uma das proposições for falsa, a combinação também o é*
```
votos16 < 500 | votos12 > 1500
```
*Já para "OU", se uma das proposições é verdadeira, a combinação também é*
```
!TRUE
!(5 > 3)
!(votos16 > 500 & votos16 <= 1500)
```
*O "NÃO" tem como função reverter uma proposição*
```
sum(votos16 > votos12)
```
Lembremos que vetores lógicos podem ser tratados como se fossem zeros e uns


**Cláusulas condicionais**

| Operador |
| -------- |
| If       |
| Else     |
| If Else  |

Um dos usos mais importantes dos operadores relacionais e lógicos é na construção de cláusulas condicionais.

*Exemplo de uso de condicional com x negativo*
```
x <- -23

if (x < 0){
  x <- -x
}

print(x)
```
*Exemplo de uso de condicional com x positivo*
```
x <- 23

if (x < 0){
  x <- -x
}

print(x)
```
Alguns pontos importantes sobre as condicionais:
* A condição que o "if" deve atender vem entre parênteses
* A instrução a ser atendida caso a cláusula seja verdadeira deve vir dentro das chaves
* É boa prática abrir a chave em uma linha, escrever as instruções e outra e fechar as chaves na linha seguinte ao fim das instruções
* Outra boa prática é desalinhas as instruções do restante do código, chamada de "identar"

*Exemplo: trabalhando com os dados criados sobre as eleições de 2012 e 2016, suponhamos que sejam necessários 700 votos para eleição. A partir disso, criaremos uma nova variável "status" que receberá o valor "eleito" caso o candidato receba mais de 700 votos. Supondo uma votação de 800:*
```
votos <- 800

if (votos > 700){
  status <- "eleito"
}

print(status)
```
*Se quisermos dar o valor "não eleito" à variável "status" em caso de receber menos de 700 votos, usamos o "else" para indicar o que fazer em todos os casos em que a condição "if" não for atendida*
```
if (votos > 700){
  status <- "eleito"
} else {
  status <- "não eleito"
}

print(status)
```
*Pensando em uma regra mais complexa, na qual é "eleito" com mais de 1200 votos, fica como "suplente" se receber entre 700 (exclusive) e 1200 (inclusive), e, por fim, "não eleito" caso receba menos de 700 votos*
```
if (votos > 1200){
  status <- "eleito"
} else if (votos > 700  & votos <= 1200){
  status <- "suplente"
} else {
  status <- "nao eleito"
}

print(status)
```
**Exercício:**

*Anote quantos cafés você no fim de semana*
```
cafe <- 2
```
*Reprense com condicionais a regra: se você tomou 3 ou mais, imprima "Hummm, café!". Se você tomou menos de 3, imprima "zzzzzz".*
```
if (cafe >= 3){
  status <- "Humm, café!"
} else if (cafe < 3){
  status <- "zzzzzz"
}

print(status)
```

**Repetindo tarefas - while loop**
É possível pedir que o computador execute uma tarefa de forma repetida enquanto as instruções não forem atendidas a um custo muito baixo

*No exemplo aqui pediremos para que imprima, na variável "contador", o número "atual" e some mais um enquanto a variável contador for igual ou menor a 42 inciando no 1.*
```
contador <- 1

while (contador <= 42) {
  print(contador)
  contador <- contador + 1
}

print(contador)
```
Ou seja, aqui pede-se para que o contador permaneça rodando até chegar a 42 e some um, ou seja ,"faça enquanto (...)"
* Para evitar um "loop infinito" devemos nos atentar à condição inicial será alterada a cada iteração e ao critério de parada


*Aqui tornaremos as coisas mais complicadas ao inserir uma condição à proposição anterior. Todas as vezes que o número for múltiplo de 2 (par) o número não será impresso*
```
contador <- 1

while (contador <= 42) {
  if ((contador %% 2) != 0){
    print(contador)
  }
  contador <- contador + 1
}

print(contador)
```


**Repetindo tarefas - for loop**

Também é possível estipular um número de vezes em que queremos que a condição se repita como alternativa à condição final. Altera-se a ideia de "enquanto x faça y" para "para todo *i* em *a* até *b*"
```
for (i in 1:42){
  print(i)
}
```
Aqui lê-se "para cada *i* em 1 até 42, faça". Dessa forma, o loop varia o *i* a cada iteração a partir da sequência.

*Exemplo: contar na sequência inversa*
```
for (i in 42:1){
  print(i)
}
```
*Exemplo: a regra anterior, contar até 42 e somar 1*
```
for (i in 1:42){
  print(i + 1)
}
```
*Exemplo: contar até 42 com a condição de não imprimir os pares*
```
for (i in 1:42){
  if((i %% 2) != 0){
    print(i)
  }
}
```
A ideia de *for loops* não se aplica somente a números quando se aplica o "in" em qualquer vetor

*Exemplo: regiões brasileiras"
```
vetor_regioes <- c("norte", "nordeste", "sudeste","sul", "centro-oeste")

for (regiao in vetor_regioes){
  print(regiao)
}
```
A ideia de utilizar loops está na economia de tempo com a automatização de tarefas (ou utilização de um código mais curto para aplicar o mesmo comando várias vezes).


**Escrevendo funções**

Após nos familiarizarmos com diversas funções da linguagem R, chegou a hora de pensar na construção de nossas próprias funções

*Como exemplo, criaremos uma função para conversão de Farenheit para Celsius"
```
conversor <- function(farenheit){
  celsius <- ((farenheit - 32) / 9) * 5
  return(celsius)
}

conversor(212)
conversor(32)
```
É intuitivo observar que a função construída tem seus argumentos  (inseridos no parênteses após "function") e o corpo da função (utiliza os argumentos para realizar a tarefa).
 

**Exercícios**

*Crie uma função chamada "quadrado" que recebe um número "x" e retorna o quadrado de x.*
```
quadrado <- function(x){
  sqrx <- (x^2)
  return(sqrx)
}
quadrado(4)
quadrado(8)
```
*Crie uma função que recebe um valor em reais e retorna o valor em dólares (use a 3.2 como cotação do dólar)*
```
cambio <- function(reais){
  dolares <- (reais/3.2)
  return(dolares)
}

cambio(3.2)
cambio(1200)
```
*Crie uma função que recebe um valor em reais e uma cotação do dólar e retorna o valor em dólares.*
```
cambio <- function(reais, cotacao){
  dolares <- (reais / cotacao)
  return(dolares)
}

cambio(20, 3.2)
cambio(15, 3.12)
```
