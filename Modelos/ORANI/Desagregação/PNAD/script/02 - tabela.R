
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### DOCENTE: VINÍCIUS DE ALMEIDA VALE                      #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/PNAD")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               DescTools,
               writexl)



#--- CARREGAR DADOS -------------------
load("dados/base.RData")
options(scipen=999)



#--- CRIAR TABELAS -----------------------

# setores por percentil de renda e qualificação:
renda_qualif = pnad_clean %>%
  group_by(id_fam, peso, SCN68, qualif, rpc) %>%
  reframe(renda  = sum(renda)) %>%
  mutate(quantil = cut(rpc, breaks = quantile(unique(rpc), probs = seq(0,1,0.01), na.rm = T),
                        labels = F,
                        include.lowest = T)) %>%
  group_by(SCN68, quantil, qualif) %>%
  reframe(renda = sum(renda * 12, weights = peso)) %>%
  arrange(quantil, qualif) %>%
  pivot_wider(names_from = c(quantil, qualif), values_from = renda) %>%
  arrange(SCN68)



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("PNAD 2015 | renda e qualif." = renda_qualif), "output/raw/tabelas.xlsx")


