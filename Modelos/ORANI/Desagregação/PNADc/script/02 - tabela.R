
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



#--- CRIAR TABELAS -----------------------

# setores por percentil de renda:
renda = pnadc_clean %>%
  group_by(id_fam, SCN68) %>%
  reframe(peso   = unique(peso),
          renda  = sum(renda)) %>%
  mutate(quantil = cut(renda, breaks = Quantile(renda, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                        labels = F,
                        include.lowest = T)) %>%
  group_by(SCN68, quantil) %>%
  reframe(renda = sum(renda)) %>%
  arrange(quantil) %>%
  pivot_wider(names_from = quantil, values_from = renda)

# setores por qualificação:
qualificacao = pnadc_clean %>%
  filter(!is.na(renda)) %>%
  group_by(SCN68) %>%
  reframe("não qualificado"  = sum(renda[nqualif    == 1]),
          "semi-qualificado" = sum(renda[semiqualif == 1]),
          "qualificado"      = sum(renda[qualif     == 1]),
          "total"            = sum(renda))



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("renda"        = renda,
                "qualificação" = qualificacao), "output/Tabelas (PNADc).xlsx")


