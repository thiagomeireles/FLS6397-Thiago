---
title: "Aula 4 (Tutorial 6)"
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

```{r}
library(data.table)
library(dplyr)
```

Vamos agora abrir os dados com a função *fread*, que vimos em tutoriais passados.

```{r}
saques <- fread("C:/Users/dcplab/Downloads/201701_BolsaFamiliaSacado.csv", encoding = "Latin-1")
```

Para ver o resultado da importação, observemos as 6 primeiras linhas do banco com a função: *head*.

```{r}
head(saques)
```

E a função *dim* para checar a quantidade de linhas e de colunas:

```{r}
dim(saques)
```

E a função *names* para observar os nomes das variáveis:

```{r}
names(saques)
```

Nomes com espaços, acentos e caracters especiais são ruins apara trabalhar; outro problema é que a coluna "Valor Parcela" (indicando o valor dos saques) não foi lida como número. Assim, renomearemos algumas variáveis (NIS, UF, Mês do saque, código do município, etc.) e gerar uma nova variável "valor" que interpretará o "Valor da Parcela" como número.

```{r}
saques <- saques %>% 
  rename(nis = `NIS Favorecido`, uf = UF, munic = `Nome Município`, mes = `Mês Referência Parcela`) %>%
  mutate(valor = as.numeric(gsub(",", "", saques$`Valor Parcela`)))
```

Com os nomes mais simples atribuídos às variáveis e *valor* construída, explicaremos os dados, fazendo uma tabelade contagem de saques por UF, um histograma com a distribuição dos valores sacados e uma tabela com a soma dos valores por UF

- Tabela com a contagem dos beneficiários que sacaram em janeiro de 2017 por UF:

```{r}
saques %>% group_by(uf) %>% summarise(contagem = n())
```

- Histograma com a distribuião dos valores sacados em janeiro de 2017:

```{r}
hist(saques$valor, main = "Distribuição dos valores sacados em jan/2017", xlab = "R$", ylab = "Frequência")
```

- Somatório dos valores sacados por UF em janeiro de 2017:
  
```{r}
saques %>% group_by(uf) %>% summarise(valores = sum(valor))
```

Vimos, assim, que com poucas linhas geramos informações para compreensão do bolsa família processando uma grande quantidade de dados. Em breve veremos como organizar, manipular e "misturar" bases de dados para extrair informações.

**Introdução ao pacote dplyr**

A linguagem R conta com o desenvolvimento de novas "gramáticas para base de dados", aqui nos centraremos na mais popular delas, o pacote *dplyr*.

Acima vimos algumas funcionalidades e, agora, realizaremos uma versão mais simples com a extração aleatória de 10 mil observações do banco original.

```{r}
library(readr)
saques_amostra_201701 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/saques_amostra_201701.csv", delim = ";", col_names = T)
```


Utilizaremos uma nova função, *glimpse*, para explorar os dados e que é aplicável a *tibbles*:

```{r}
glimpse(saques_amostra_201701)
```

*A função *glimpse* se assemelha à função *str* aplicada a data frames.*

**Renomeando variáveis**

Como muitas vezes obetemos dados com nomes de colunas compostos, com acentuação, cedilha ou outros caracteres especiais, a renomeação de variáveis é algo importante por ser ideal trabalhar com nomes sem espaço - prefercialmente em letras minúsculas, sem acento e número. Assim, renomearemos algumas variáveis do nosso banco de dados.

```{r}
names(saques_amostra_201701)
```

*Explicando a função *rename**

- O primeiro argumento é a base de dados que contém as variáveis que queremos renomear;

- Após a vírgula, inserimos todas as modificações de nomes, também separadas por vírgulas, seguindo a lógica nome\_novo = nome\_velho;

- Caso os nomes possuam espaço, como na base de dados do Bolsa Família, é necessário utilizar o acento agudo antes e depois do nome antigo para que o R delimite sua extensão, como nome\_novo = \´Nome Velho\´.

Exemplifiquemos renomeando as variáveis "UF" e "Nome Município":

```{r}
saques_amostra_201701 <- rename(saques_amostra_201701, uf = UF, munic = `Nome Município`)
```

**Exercício**

Renomeie as variáveis "Código SIAFI Município", "Nome Favorecido", "Valor Parcela", "Mês Competência" e "Data do Saque" como "cod_munic", "nome", "valor", "mes", "data_saque", respectivamente.

```{r}

saques_amostra_201701 <- saques_amostra_201701 %>% 
  rename(cod_munic = `Código SIAFI Município`,
          nome = `Nome Favorecido`, 
          valor = `Valor Parcela`, 
          mes = `Mês Competência`,
          data_saque = `Data do Saque`)
```

**Uma gramática, duas formas**

Percebemos que a sintaxe utilizada para renomear as variáveis é ligeiramente diferente da utilizada anteriormente:

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% rename(uf = UF, munic = `Nome Município`)
```

O operador *%>%*, chamado *pipe*, retira o banco de dados cujas variáveis são renomeadas de dentro da função *rename*, trazendo uma grande vantagem: permite emendar uma operação de transformação do banco de dados na outra. Mas, a princípio, guardemos que o resultado é o mesmo para qualquer uma das duas formas.


**Selecionando colunas**

Muitos bancos de dados possuem colunas que são claramente descartáveis, como "Código Função", "Código Subfunção", "Código Programa" e "Código Ação" do banco de dados do Bolsa Família que não possuem variação por se referirem ao programa. Assim, manteremos somente as variáveis que renomeamos.

```{r}
saques_amostra_201701 <- select(saques_amostra_201701, uf, munic, cod_munic, nome, valor, mes, data_saque)
```

Ou usando o *pipe* (operador %>%):

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% select(uf, munic, cod_munic, nome, valor, mes, data_saque)
```


**Operador %>% para "emendar" tarefas**

O operador *pipe* permite colocar o rimeiro argumento da função (o *data frame* no exemplo) fora e antes da função, ou seja, permite a leitura informal do código como "pegue o data frame x e aplique a ele a função y".

É possível aplicar uma cadeia de operações (*pipeline*), que pode ser lida como "pegue o data frame x e aplique a ele a função y, depois w, depois z, etc.".

*A grande vantagem de utiizar o *pipe* é não precisar repetir o nome do data frame diversas vezes ao aplicarmos um conjunto de operações*

Removeremos agora a base de dados e a abriremos novamente, depois veremos como utilizar o *pipe* para "emendar" tarefas:


```{r}
rm(saques_amostra_201701)
saques_amostra_201701 <- read_delim("https://raw.githubusercontent.com/leobarone/FLS6397/master/data/saques_amostra_201701.csv", delim = ";", col_names = T)
```

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  rename(uf = UF, munic = `Nome Município`,
         cod_munic = `Código SIAFI Município`, nome = `Nome Favorecido`,
         valor = `Valor Parcela`, mes = `Mês Competência`, data_saque =`Data do Saque`)  %>%
  select(uf, munic, cod_munic, nome, valor, mes, data_saque)
```

Dessa forma, alteramos os nomes das variáveis e selecionamos as que permaneceriam no banco de dados utilizando uma única sequência de operações, sendo uma forma muito mais econômica de realizar as tarefas

Se observamos as dimensões da base de dados, veremos que ainda possui as 10 mil linhas, mas as colunas foram reduzias a 7.

```{r}
dim(saques_amostra_201701)
```

**Transformando variáveis**

Algumas variáveis, como a *valor*, podem ser lidas como texto por conterem a vírgula como separador de milhar. A função *mutate* auxilia em problemas como esse por realizar transformações nas variáveis existentes ou gerar novas. Vejamos alguns exemplos mais importantes.

- Gerar uma nova variável com os nomes dos beneficiários em minúsculo usando a função *tolower*:

```{r}
glimpse(saques_amostra_201701)
saques_amostra_201701 <- saques_amostra_201701 %>% mutate(nome_min = tolower(nome))
```

ou, em uma forma alternativa:

```{r}
saques_amostra_201701 <- mutate(saques_amostra_201701, nome_min = tolower(nome))
```

- Em um exemplo  mais difícil, substituiremos a vírgula por um vazio em um texto e, em seguida, indicar que o texto é um número. Ou seja, em vez de criarmos uma nova variável *valor*, apenas alteraremos a já existente duas vezes. Para isso utilzaremos a função *gsub* para a substituição e a função *as.numeric* para converter o texto em número:


```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_num = gsub(",", "", valor)) %>% 
  mutate(valor_num = as.numeric(valor_num))
```

Não é necessário utilizar a função *mutate* duas vezes, podendo ser realizada como nas duas formas abaixo:


```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_num = as.numeric(gsub(",", "", valor)))
```

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_num = gsub(",", "", valor), valor_num = as.numeric(valor_num))
```

Para ressaltar, a operação *as.character* realiza o oposto da *as.numeric*, ou seja, transforma variáveis com números em texto.

- Em outro exemplo, faremos duas operações separadas que originarão duas novas variáveis: (1) dividiremos o valor por 3.2 para gerar converter o valor em dólares; e (2) somaremos R$ 10 ao valor somente para ver a transformação:

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_dolar = valor / 3.2, valor10 = valor_num + 10)
```

Vejamos agora todas as novas variáveis no banco de dados:

```{r}
View(saques_amostra_201701)
```

Por enquanto vimos que operações de soma, subtração, divisão, multiplicação, módulo entre variáveis e valores são válidas e de fácil execução como nos exemplos acima. Mas não são apenas transformações matemáticas as possíveis.

- Neste exemplo, converteremos a variável valor em uma nova variável que indique se o valor sacado é "Alto" (acima de R\$ 300) ou "Baixo" (Abaixo de R\$ 300) com o argumento *cut*:


```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_categorico = cut(valor_num, c(0, 300, Inf), c("Baixo", "Alto")))
```


- Para recodificar uma variável de texto, um pouco mais trabalhosa, utilizaremos a função *recode*. No exemplo faremos isso com a variável *mes*, a qual contém os valores 11/2016", "12/2016" e "01/2017" em nossa amostra. Geraremos uma nova variável copiando os valores da variável original e substituindo cada um dos valores pelo ano:


```{r}
table(saques_amostra_201701$mes)
```


```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(ano = mes,
         ano = replace(ano, ano == "11/2016", "2016"),
         ano = replace(ano, ano == "12/2016", "2016"),
         ano = replace(ano, ano == "01/2017", "2017"))
```


```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(ano = recode(mes, "11/2016" = "2016", "12/2016" = "2016", "01/2017" = "2017"))
```

Assim, percebemos que basta inserir a expressão de transformação que queremos dentro da função mutate. Os argumentos *as.numeric*, *as.character*, *cut*, *replace* e *recode* permitem realizar qualquer transformação que envolva textos e números. 

As variáveis *factor* são excessão por enquanto, já as vimos em tutoriais anteriores.

Para expressões regulares, é recomendável a leitura do arquivo help da função *gsub*, incluindo, entre outras, *grep* e *regexpre*.


**Exercício**

Use os exemplos acima para gerar novas variáveis conforme instruções abaixo:

- Faça uma nova divisão da variável "valor" a seu critério. Chame a nova variável de "valor\_categorico2".

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_categorico2 = cut(valor_num, c(0, 500, Inf), c("Baixo", "Alto")))
```

- Cria uma variável "valor_euro", que é o valor calculado em Euros.

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
      mutate(valor_euro = valor / 3.3)
```

Considerando o Euro como R$ 3.20, geramos a nova variável.

- Recodifique "valor\_categorico" chamando as categorias de "Abaixo de R\$300" e "Acima de R\$300". Chame a nova variável de "valor\_categorico3".

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(valor_categorico3 = recode(valor_categorico,"Baixo" = "Abaixo de R$ 300", "Alto" = "Acima de R$ 300"))
```


- Usando a função _recode_ Recodifique "mes" em 3 novos valores: "Novembro", "Dezembro" e "Janeiro". Chame a nova variável de "mes\_novo".

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(mes_novo = recode(mes, "11/2016" = "Novembro", "12/2016" = "Dezembro", "01/2017" = "Janeiro"))
```

- Usando a função _replace_ Recodifique "mes" em 3 novos valores: "Novembro", "Dezembro" e "Janeiro". Chame a nova variável de "mes\_novo2".

```{r}
saques_amostra_201701 <- saques_amostra_201701 %>% 
  mutate(mes_novo2 = mes,
         mes_novo2 = replace(mes_novo2, mes_novo2 == "11/2016", "Novembro"),
         mes_novo2 = replace(mes_novo2, mes_novo2 == "12/2016", "Dezembro"),
         mes_novo2 = replace(mes_novo2, mes_novo2 == "01/2017", "Janeiro"))
```


**Filtrando linhas**

Em algumas situações queremos utilziar apenas um conjunto de linhas do banco de dados, para isso, podemos filtrar apenas os caraso que nos interessam, como no exemplo:

```{r}
saques_amostra_ES <- saques_amostra_201701 %>% filter(uf == "ES")
```

ou 

```{r}
saques_amostra_ES <-filter(saques_amostra_201701, uf == "ES")
```

A novidade não está na função *filter*, mas na condição *uf == "ES"*, que indica a seleção das linhas da variável *uf* que possuam valor igual a *ES*.

Por que utilizar duas vezes o sinal de igualdade (==)?

- Utilizamos o igual para *atribuir* valores, mas aqui estamos comparando duas coisas, ou seja, verificando se o conteúdo de cada linha é igual a um valor;

- Outras possibildiades seriam maior (>), maior ou igual (>=), menor (<), menor ou igual (<=) e diferente (!=)

- Como comparamos os valores para de cada linha a um texto, usamos as aspas no *"ES"*;


Se quisermos selecionar, por exemplo, apenas os dados da região centro-Oeste, devemos atender a esse critério. No caso, geraremos um novo *data frame*:

```{r}
saques_amostra_CO <- saques_amostra_201701 %>% 
  filter(uf == "MT" | uf == "MS" | uf == "Df" | uf == "GO")
```

Aqui queremos que quatro condições sejam atendidas, então utilizamos uma barra vertical que representa "ou"

Se quisermos estabelecer condições para seleção de linhas a partir de mais de uma variável, como, por exemplo, incluir as observações do Mato Grosso referentes a 2016. Utilizamos, neste caso, o símbolo para "e", representado por *&*:

```{r}
saques_amostra_MT_2016 <- saques_amostra_201701 %>% filter(uf == "MT" & ano == "2016")
```

Também podemos escrever o comando separando as condições por vírgula e dispensar o operador "&":

```{r}
saques_amostra_MT_2016 <- saques_amostra_201701 %>% filter(uf == "MT", ano == "2016")
```

É possível combinar quantas condições forem necessárias, somente se atentando à ordem das condições se houver ambiguidade com a utilização de parênteses da mesma forma aplicada a operações aritméticas.


*Exercício*

- Crie um novo _data frame_ apenas com as observações cujo mês de competência é janeiro.

```{r}
saques_amostra_jan <- saques_amostra_201701 %>% filter(mes_novo == "Janeiro")
```

- Crie um novo _data frame_ apenas com as observações cujo valor é superior a R\$ 500.

```{r}
saques_amostra_valoralto <- saques_amostra_201701 %>% filter(valor_num > 500)
```

- Crie um novo _data frame_ apenas com as observações da região Sul.

```{r}
saques_amostra_sul <- saques_amostra_201701 %>% filter(uf == "RS" | uf == "SC" | uf == "PR")
```


*Agrupando*

A despeito de todas as transformações realizadas até agora, as unidades de análise continuaram  aser os saques realizados no nível individual. E se quisermos trabalhar em um nível mais agregado?

Como exemplo, criaremos um novo *data frame* com as informações agregadas ao nível da Unidade Federada. Para isso, utilizaremos simultaneamente duas funções: *group_by* e *summarise*, as que possuem significado literal, uma vez que a primeira indica a inserção de variáveis nas quais agruparemos os dados e na segunda condensaremos o banco de dados e as demais variáveis. Para contarmos quantas linhas pertencem a cada UF, a variável de grupo, usamos a função *n()*.

```{r}
contagem_uf <- saques_amostra_201701 %>% 
  group_by(uf) %>% 
  summarise(contagem = n())
```

Pra tornar o processo um pouco mais complexo, além a contagem, realizaremos a soma, a média, a mediana, o desvio padrão, o mínimo e máximo valores em um único resultado. Para isso, acrescentearemos novas operações na função *summarize* as separando por vírgula.

```{r}
valores_uf <- saques_amostra_201701 %>% 
  group_by(uf) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor),
            mediana = median(valor),
            desvio = sd(valor),
            minimo = min(valor),
            maximo = max(valor))
```

Para observar o resutado, utilizamos a função *View*

```{r}
View(valores_uf)
```


*"A sessão *Useful Summary Functions* do livro *R for Data Science* traz uma relação mais completa de funçoes que podem ser usandas com *summarise*. O ["cheatsheet" da RStudio](https://github.com/rstudio/cheatsheets/raw/master/source/pdfs/data-transformation-cheatsheet.pdf) oferece uma lista para uso rápido."*

**Exercício**

Usando a variável "mes_novo", calcule a contagem, soma e média de valores para cada mês.

```{r}
valores_mes <- saques_amostra_201701 %>% 
  group_by(mes_novo) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor))

View(valores_mes)
```


**Mais de um grupo**

Quando quisermos agrupar por mais de uma variável, como *mes* e *uf*, combinamos os grupos:

```{r}
contagem_uf_mes <- saques_amostra_201701 %>% 
  group_by(uf, mes) %>% 
  summarise(contagem = n())
```

Devemos observar que cada uf é repetida duas ou três vezes, ou seja, uma para cada mês. Cada grupo fera uma nova coluna e as linhas representam a combinação de grupos de cada variável presente nos dados.

Por fim, também é possível utilizar variáveis de grupo em conjunto e gerar um sumário com diversas variáveis, como no próximo exemplo que combina parte dos dois anteriores:

```{r}
valores_uf_mes <- saques_amostra_201701 %>% 
  group_by(uf, mes) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor),
            desvio = sd(valor))
```

**Novo *data frame* ou tabela para análise?**

As funções *group_by* e *summarize* podem ser utilizadas para produzir uma tabela para análise, como feito anteriormente, ou para gerar um novo *data frame*. A escolha está condicionada ao tamanho da redução que geraremos no banco de dados.

*Exemplo:* "podemos gerar os totais de valores transferidos para cada município (que, se tivessemos o banco completo, geraria um banco de aprox. 5,5 mil linhas) para, a seguir, inserí-lo nos dados originais como coluna. Por enquanto, ainda não aprendemos a relacionar dois *data frames* entre si, mas vejamos como seria a base de dados com municípios como linhas:""

```{r}
saques_amostra_munic <- saques_amostra_201701 %>% 
  group_by(munic) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor))
```

**Ordenando a base de dados**

Não existe muito sentido no ordenamento de bases muito grandes; no entanto, o mesmo não se aplica quando trabalhamos com bases de dados de pequena escala, podendo convir o ordenamento da tabela por alguma variável de interesse (apesar da discussão na sessão anteror, faz pouco sentido diferenciar tabela de *data frame* pois se tornaram praticamente sinônimos aqui)

Um exemplo pode ser o ordenamento crescente da tabela de valores por UF considerando a soma de valores com o comando *arrange*:

```{r}
valores_uf <- valores_uf %>% arrange(soma)
```

Poderíamos, também, ter usando o comando ao gerar a tabela:

```{r}
valores_uf <- saques_amostra_201701 %>% 
  group_by(uf) %>% 
  summarise(contagem = n(),
            soma = sum(valor),
            media = mean(valor),
            mediana = median(valor),
            desvio = sd(valor),
            minimo = min(valor),
            maximo = max(valor)) %>%
  arrange(soma)
```

Caso queiramos ordenar uma tabela em ordem decrescente, utilizamos o argumento *desc*. Aplicaremos ele à média de valores por UF.

```{r}
valores_uf <- valores_uf %>% arrange(desc(media))
```

Se quisermos ordenar por mais e uma variável, as colocamos por ordem de prioridade e separamos por vírgula, como no exemplo do ordenamento decrescente da mediana e depois pelo crescente do máximo executado abaixo:

```{r}
valores_uf <- valores_uf %>% arrange(desc(mediana), maximo)
```
