
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### DOCENTE: VINÍCIUS DE ALMEIDA VALE                      #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/PNADc")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               DescTools,
               writexl)



#--- CARREGAR DADOS -------------------
load("dados/base.RData")



#--- CRIAR TABELA -----------------------

#--- CRIAR FUNÇÃO ---
renda = pnadc_clean %>%
  group_by(id_fam, SCN68, peso, rpc, qualificacao) %>%
  reframe(renda  = sum(renda)) %>%
  mutate(quantil = cut(rpc, breaks = Quantile(rpc, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                       labels = F,
                       include.lowest = T),
         quantil_qualif =  ) %>%
  group_by(SCN68, quantil) %>%
  reframe(renda = sum(renda * 12, weights = peso)) %>%
  arrange(quantil) %>%
  pivot_wider(names_from = quantil, values_from = renda)


#--- RODAR FUNÇÃO ---
options(scipen=999)
pnadc_renda = 



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("qualificação" = qualificacao), "output/raw/tabela.xlsx")


