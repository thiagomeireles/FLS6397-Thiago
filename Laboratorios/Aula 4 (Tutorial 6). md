---
title: "Aula 4 (Tutorial 4)"
author: "Thiago Meireles"
date: "3 de abril de 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Tutorial 6: Manipulação de dados com a gramática básica do pacote dplyr

**Um primeiro exemplo**

O primeiro exemplo utilizará a base de dados dos saques efetuados pelos beneficiários do Bolsa Família em janeiro de 2017 disponível no [Portal da Transparência](http://www.portaldatransparencia.gov.br/downloads/mensal.asp?c=BolsaFamiliaSacado#exercicios2017).

Sendo um arquivo grande (1.6 Gb), utilizaremos a função *fread* do pacote *data.table*.


```
library(data.table)
lbrary(dplyr)
```

Vamos agora abrir os dados com a função *fread*, que vimos em tutoriais passados.

```
saques <- fread("C:/Users/dcplab/Downloads/201701_BolsaFamiliaSacado.csv", encoding = "Latin-1")
```

Para ver o resultado da importação, observemos as 6 primeiras linhas do banco com a função: *head*.

```
head(saques)
```

E a função *dim* para checar a quantidade de linhas e de colunas:

```
dim(saques)
[1] 12379599       14
```

E a função *names* para observar os nomes das variáveis:

```
names(saques)
```

Nomes com espaços, acentos e caracters especiais são ruins apara trabalhar; outro problema é que a coluna "Valor Parcela" (indicando o valor dos saques) não foi lida como número. Assim, renomearemos algumas variáveis (NIS, UF, Mês do saque, código do município, etc.) e gerar uma nova variável "valor" que interpretará o "Valor da Parcela" como número.

```
saques <- saques %>% 
  rename(nis = `NIS Favorecido`, uf = UF, munic = `Nome Município`, mes = `Mês Referência Parcela`) %>%
  mutate(valor = as.numeric(gsub(",", "", saques$`Valor Parcela`)))
```

Com os nomes mais simples atribuídos às variáveis e *valor* construída, explicaremos os dados, fazendo uma tabelade contagem de saques por UF, um histograma com a distribuição dos valores sacados e uma tabela com a soma dos valores por UF

- Tabela com a contagem dos beneficiários que sacaram em janeiro de 2017 por UF:

```
saques %>% group_by(uf) %>% summarise(contagem = n())
```

- Histograma com a distribuião dos valores sacados em janeiro de 2017:
  
```
hist(saques$valor, main = "Distribuição dos valores sacados em jan/2017", xlab = "R$", ylab = "Frequência")
```

- Somatório dos valores sacados por UF em janeiro de 2017:
  
```
saques %>% group_by(uf) %>% summarise(valores = sum(valor))
```

Vimos, assim, que com poucas linhas geramos informações para compreensão do bolsa família processando uma grande quantidade de dados. Em breve veremos como organizar, manipular e "misturar" bases de dados para extrair informações.

**Introdução ao pacote dplyr**

A linguagem R conta com o desenvolvimento de novas "gramáticas para base de dados", aqui nos centraremos na mais popular delas, o pacote *dplyr*.

Acima vimos algumas funcionalidades e, agora, realizaremos uma versão mais simples com a extração aleatória de 10 mil observações do banco original.

```
library(readr)
saques_amostra_201701 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/saques_amostra_201701.csv", delim = ";", col_names = T)
```

Utilizaremos uma nova função, *glimpse*, para explorar os dados e que é aplicável a *tibbles*:


```
glimpse(saques_amostra_201701)
```

*A função *glimpse* se assemelha à função *str* aplicada a data frames.*

**Renomeando variáveis**

Como muitas vezes obetemos dados com nomes de colunas compostos, com acentuação, cedilha ou outros caracteres especiais, a renomeação de variáveis é algo importante por ser ideal trabalhar com nomes sem espaço - prefercialmente em letras minúsculas, sem acento e número. Assim, renomearemos algumas variáveis do nosso banco de dados.

```
names(saques_amostra_201701)
```

*Explicando a função *rename**

- O primeiro argumento é a base de dados que contém as variáveis que queremos renomear;

- Após a vírgula, inserimos todas as modificações de nomes, também separadas por vírgulas, seguindo a lógica nome\_novo = nome\_velho;

- Caso os nomes possuam espaço, como na base de dados do Bolsa Família, é necessário utilizar o acento agudo antes e depois do nome antigo para que o R delimite sua extensão, como nome\_novo = \´Nome Velho\´.

Exemplifiquemos renomeando as variáveis "UF" e "Nome Município":

```
saques_amostra_201701 <- rename(saques_amostra_201701, uf = UF, munic = `Nome Município`)
```

**Exercício**

Renomeie as variáveis "Código SIAFI Município", "Nome Favorecido", "Valor Parcela", "Mês Competência" e "Data do Saque" como "cod_munic", "nome", "valor", "mes", "data_saque", respectivamente.

```
saques_amostra_201701 <- saques_amostra_201701 %>% 
  rename(cod_munic = `Código SIAFI Município`,
          nome = `Nome Favorecido`, 
          valor = `Valor Parcela`, 
          mes = `Mês Competência`,
          data_saque = `Data do Saque`)
```

**Uma gramática, duas formas**

Percebemos que a sintaxe utilizada para renomear as variáveis é ligeiramente diferente da utilizada anteriormente:

```
saques_amostra_201701 <- saques_amostra_201701 %>% rename(uf = UF, munic = `Nome Município`)
```

O operador *%>%*, chamado *pipe*, retira o banco de dados cujas variáveis são renomeadas de dentro da função *rename*, trazendo uma grande vantagem: permite emendar uma operação de transformação do banco de dados na outra. Mas, a princípio, guardemos que o resultado é o mesmo para qualquer uma das duas formas.


**Selecionando colunas**

Muitos bancos de dados possuem colunas que são claramente descartáveis, como "Código Função", "Código Subfunção", "Código Programa" e "Código Ação" do banco de dados do Bolsa Família que não possuem variação por se referirem ao programa. Assim, manteremos somente as variáveis que renomeamos.

```
saques_amostra_201701 <- select(saques_amostra_201701, uf, munic, cod_munic, nome, valor, mes, data_saque)
```

Ou usando o *pipe* (operador %>%):

```
saques_amostra_201701 <- saques_amostra_201701 %>% select(uf, munic, cod_munic, nome, valor, mes, data_saque)
```


**Operador %>% para "emendar" tarefas**

O operador *pipe* permite colocar o rimeiro argumento da função (o *data frame* no exemplo) fora e antes da função, ou seja, permite a leitura informal do código como "pegue o data frame x e aplique a ele a função y".

É possível aplicar uma cadeia de operações (*pipeline*), que pode ser lida como "pegue o data frame x e aplique a ele a função y, depois w, depois z, etc.".

*A grande vantagem de utiizar o *pipe* é não precisar repetir o nome do data frame diversas vezes ao aplicarmos um conjunto de operações*

Removeremos agora a base de dados e a abriremos novamente, depois veremos como utilizar o *pipe* para "emendar" tarefas:


```
rm(saques_amostra_201701)
saques_amostra_201701 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/saques_amostra_201701.csv", delim = ";", col_names = T)
```

```
saques_amostra_201701 <- saques_amostra_201701 %>% 
  rename(uf = UF, munic = `Nome Município`,
         cod_munic = `Código SIAFI Município`, nome = `Nome Favorecido`,
         valor = `Valor Parcela`, mes = `Mês Competência`, data_saque =`Data do Saque`)  %>%
  select(uf, munic, cod_munic, nome, valor, mes, data_saque)
```

Dessa forma, alteramos os nomes das variáveis e selecionamos as que permaneceriam no banco de dados utilizando uma única sequência de operações, sendo uma forma muito mais econômica de realizar as tarefas

Se observamos as dimensões da base de dados, veremos que ainda possui as 10 mil linhas, mas as colunas foram reduzias a 7.

```
dim(saques_amostra_201701)
[1] 10000     7
```

**Transformando variáveis**
