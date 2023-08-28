#Data: 27 de agosto de 2023
#Resolução dos exercícios do capítulo

#Biblioteca
library(tidyverse)

#Exercícios 8.1.9
#1
ggplot(data = mtcars) 
#Resposta - quando escreve-se apenas a função ggplot sem nenhuma camada adicional, 
#ela retorna uma tela em branco (gráfico não visível). 
#Menciona-se que o seu arggumento é um data frame.

#2
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
#Resposta - o termo 'aes' representa mapeamentos estéticos (aesthetic mappings) e 
#é utilizado para associar as colunas de um data frame às propriedades visuais 
#de um gráfico. Para definir propriedades fixas, como a cor azul (blue), é 
#necessário especificá-las fora do 'aes'.

#3
##Variável contínua (displ)
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, color = displ))

#É criado um degradê para a cor dos pontos. Assim, a depender da intensidade,
#é percebido os valores da variável contínua. 

##Variável categórica (drv)
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))

#Para cada categoria especifica-se uma cor.

#4
ggplot(data = mtcars) +
  geom_point(mapping = aes(x = mpg, y = qsec))

#5
ggplot(data = mtcars) +
  geom_point(mapping = aes(x = vs, y = mpg))

#Resposta - o gráfico de dispersão é apropriado quando há duas variáveis
#contínuas. Por outro lado, quando uma delas é categórica, é possível criar um 
#gráfico que analisa se a distribuição da variável contínua muda conforme a
#categoria. No exemplo, pode-se notar, a priori, que quando o valor da variável 
#vs é 1, seus valores são ligeiramente maiores.

#6
df = read_rds("imdb.rds")
#Visualização
df |> view()

ggplot(data = df)+
  geom_point(mapping = aes(x = nota_imdb, y = orcamento))
