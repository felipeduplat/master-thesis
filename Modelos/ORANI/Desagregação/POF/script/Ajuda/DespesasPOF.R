

setwd("D:/TESE/POF/Dados")

#PASSO 1: DESPESAS
#Lendo base de dados:
#SCN67 é a classificação das despesas conforme o SCN para 67 atividades:

despesas<- readRDS(file = "1.despesas_pof.rds")

despesas2 <-  despesas %>%
  group_by(COD_UPA, NUM_DOM, NUM_UC, SCN67) %>%
  summarise(despesa = sum(DESPESA)) %>%
  arrange(SCN67)

#Arquivo final das despesas da POF classificado para SCN67 e por domicílio:
DESPESAS <-  pivot_wider(despesas2, names_from = SCN67, values_from = despesa)

str(DESPESAS)

rm(list = ls()[!ls() %in% c("DESPESAS")])

#PASSO 2 : (Felipe) Criar decil com a base de morador

#base de morador 

morador <- readRDS("dados/POF 2008-2009/MORADOR.rds")

morador <- morador %>%
  mutate(codigo = paste(COD_UPA, NUM_DOM, sep = ""))

#(Felipe) AQUI ENCONTRAR FUNÇÃO PARA PERCENTIL E APLICAR NA COLUNA DE RENDA_TOTAL:
#MANTER A COLUNA REFERENTE A RENDA E AOS ANOS DE ESTUDO
#AO FIM, APLICA GROUP_BY POR CODIGO DE DOMICILIO PQ VAI PRECISAR JUNTAR COM AS DESPESAS:


#(Tânia) No meu caso, as famílias não são agrupadas por renda, mas por idade:

morador <- morador %>%
  mutate(groupage = case_when (V0403 >= 0 & V0403 <= 4 ~ "0-4",
                               V0403 > 4 & V0403 <= 9 ~ "5-9",
                               V0403 > 9 & V0403 <= 14 ~ "10-14",
                               V0403 > 14 & V0403 <= 19 ~ "15-19",
                               V0403 > 19 & V0403 <= 24 ~ "20-24",
                               V0403 > 24 & V0403 <= 29 ~ "25-29",
                               V0403 > 29 & V0403 <= 34 ~ "30-34",
                               V0403 > 34 & V0403 <= 39~ "35-39",
                               V0403 > 39 & V0403 <= 44 ~ "40-44",
                               V0403 > 44 & V0403 <= 49 ~ "45-49",
                               V0403 > 49 & V0403 <= 54 ~ "50-54",
                               V0403 > 54 & V0403 <= 59 ~ "55-59",
                               V0403 > 59 & V0403 <= 64 ~ "60-64",
                               V0403 > 64 & V0403 <= 69  ~ "65-69",
                               V0403 > 69 & V0403 <= 74 ~ "70-74",
                               V0403 > 74 & V0403 <= 79  ~ "75-79",
                               V0403 > 79 & V0403 <= 84  ~ "80-84",
                               V0403 > 84 & V0403 <= 89  ~ "85-89",
                               V0403 > 89 ~ "90+"
  ))


idade <-  idade %>%
  select(groupage, V0403, codigo) %>%
  group_by(codigo) %>%
  count(groupage)

idade2 <- pivot_wider(idade, names_from = groupage, values_from = n)

idade2 <- replace_na(idade2, list(crianças =0, adolescentes = 0, adultos=0, idosos1=0, idosos2=0, idosos3=0))



# PASSO 3: junta arquivo das DESPESAS com o arquivo de morador que tem a classificação da renda(percentil)

desp_total <- despesas%>%
  inner_join(idade, by = c("codigo"))



