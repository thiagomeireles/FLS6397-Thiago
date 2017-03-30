| Title    | Author        |Date               | Output      |
|:--------:|:-------------:|:-----------------:|:-----------:|
|Chapter 6 |Thiago Meireles|29 de março de 2017|html_document|
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Chapter 6: Environments

Construímos duas funções para o baralho, *deal* e *aleatorio*, a primeira para pegar uma carta no topo e a segunda para gerar um novo baralho com as cartas em uma ordem aleatória. De forma geral, temos duas funções que usam o baralho mas não o manipulam. Assim, o objetivo deste capítulo é corrigir essas funções para lidar com essa questão da manipulação do data frame.

**Environments**

O R, assim como os sistmas operacionais que criam uma organização para os arquivos em pastas e subpastas, usa um sistema para salvar seus objetos. Cada objeto do R é salvo dentro de um *ambiente*, algo como uma pasta do computador, sendo cada ambiente ligado a outro ambiente, um ambiente em um nível superior, que cria ambientes hierárquicos.

Para ver o sistema do ambiente do R, usamos a função *paravens* do pacote *devtools* (foi removida do pacote pois está no *pryr*), retornando uma lista dos ambientes que a sessão atual do R está utilizando, sendo o output dependente de quais pacotes foram carregados.
```
install.packages("pryr")
library(pryr)
parenvs(all = TRUE)
```

Deve-se ressaltar que a analogia à organização das pastas de arquivos no computador não é completamente correta, uma vez que o ambiente está na memória RAM.

Cada ambiente está conecato a um ambiente raiz/pai, o que torna mais fácil compreender a árvore de ambientes do R, mas tenhamos em mente que não é possível olhar para um ambiente e identificar o que a "filha" é

**Working with environments**

O R possui algumas funções que ajudam a explorar a árvore de ambientes.

- Primeiro, você pode se referir a qualquer um dos ambientes em sua árvore com o *as.environment*, apresentando seu nome (como uma *character string*) e retorna o ambiente correspondente:
```
as.environment("package:stats")
```
- Três ambientes na ávore possuem suas próprias funções: O *ambiente global* (R_Global_Env), o *ambiente base* (baseenv) e o *ambiente vazio* (emptyenv):
```
globalenv()
baseenv()
emptyenv()
```
- Agora, podemos dar uma olhada no ambiente pai com a função *parent.env*:
```
parent.env(globalenv())
```
- Podemos notar que o ambiente vazio é o único sem um ambiente pai:
```
parent.env(emptyenv())
```
- Também é possível observar os objetos salvos no ambiente com *ls*, que retorna apenas os nomes dos objetos, ou *ls.str*, que retorna um resumo sobre a estrutrua de cada objeto:
```
ls(emptyenv())
ls(globalenv())
```
- Também é possível utilizar a sintaxe *$* para acessar um objeto específico do ambiente:
```
head(globalenv()$baralho, 3)
```
- Podemos usar a função *assign* para salvar um objeto dentro de um ambiente particular ao (1) atribuir um nome ao novo objeto (como character string), (2) atribuir o valor ao novo objeto e (3) salvar o objeto no ambiente.
```
assign("new", "Hello Global", envir = globalenv())
globalenv()$new
```
*Notemos que a função *assign* funciona de maneira similar a *<-*, de forma que se um objeto já existe com o nome atribuído, a função sobrescreverá sem pedir permissão. Assim, apesar de útil para atualizar objetos, pode gerar alguma dor de cabeça*


**The Active Environments**


**Scoping Rule**


**Assignment**


**Evaluation**


**Closures**









