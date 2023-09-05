#Biblioteca
library(tidyverse)

#Base de dados
df<- read_rds("imdb.rds")
##Visualização
df |> view()

#Exercício 1
df |> filter(!is.na(orcamento)) |>  
  select(ano, orcamento) |> group_by(ano) |> 
  summarise(media_orcamento_anual = mean(orcamento, na.rm = TRUE)) |> 
  ggplot() +
  geom_line(mapping = aes(x = media_orcamento_anual, y = ano)) +
  scale_y_continuous(limits = c(1900, 2020),
                     breaks = seq(1910, 2020, by = 10)
  )

#Exercício 2
df |> filter(!is.na(orcamento)) |>  
  select(ano, orcamento) |> group_by(ano) |> 
  summarise(media_orcamento_anual = mean(orcamento, na.rm = TRUE)) |> 
  ggplot() +
  geom_col(mapping = aes(y = media_orcamento_anual, x = ano))+
  scale_x_continuous(limits = c(1930, 2020),
                     breaks = seq(1910, 2020, by = 10)
  )

#Exercício 3
df<- df |> mutate(lucro = receita - orcamento)

#Filtrar as cinco empresas que tem os maiores lucros
top_cinco = df |> select(producao, lucro) |> 
  group_by(producao) |> summarise(top_cinco_lucro = sum(lucro)) |> 
  arrange(desc(top_cinco_lucro)) %>%
  head(5) |> 
  pull(producao)

df |> filter(producao %in% top_cinco) |> select(producao, lucro) |> 
  ggplot()+
  geom_boxplot(mapping = aes(x = producao, y = lucro))

#Exercício 4

diretores <- c(
  "Steven Spielberg", 
  "Quentin Tarantino", 
  "Robert Zemeckis",
  "Martin Scorsese"
)

df %>% 
  filter(direcao %in% diretores) %>% 
  group_by(ano, direcao) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_point() +
  geom_line() +
  facet_wrap(vars(direcao))


#A função facet_wrap() é uma parte importante do pacote ggplot2 no R e 
#é usada para criar múltiplos painéis (subgráficos) em uma única trama (gráfico) 
#com base em uma variável categórica

#facet_wrap() ajuda na criação de painéis que compartilham o mesmo tipo de 
#gráfico, tornando a comparação entre grupos mais fácil.


df %>% 
  filter(direcao %in% diretores) %>% 
  group_by(ano, direcao) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE)) %>% 
  ggplot(aes(x = ano, y = nota_media)) +
  geom_point() +
  geom_line() +
  facet_wrap(vars(direcao), ncol = 1)

#Exercício 5
df<- df |> mutate(nota_8 =
                    if_else(nota_imdb>8,1,0))

df |> select(nota_8, ano) |> group_by(ano) |> 
  summarise(total_filme_8 = sum(nota_8)) |> 
  ggplot() +
  geom_col(mapping = aes(y = total_filme_8, x = ano))+
  scale_x_continuous(limits = c(1920, 2020),
                     breaks = seq(1920, 2019, by = 15)
  )
