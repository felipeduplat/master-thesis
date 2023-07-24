
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### DOCENTE: VINÍCIUS DE ALMEIDA VALE                      #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/POF")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               readxl,
               DescTools,
               writexl)



#-- IMPORTAR DADOS: SCN -------------------

# 2008-2009:
scn_09 = read_excel("dados/POF 2008-2009/SCN128.xlsx")

# 2017-2018:
scn_18 = read_excel("dados/POF 2017-2018/SCN67.xlsx")



#-- IMPORTAR DADOS: POF -------------------

#--- CRIAR FUNÇÃO ---
importar = function(path, pattern) {
  files  = list.files(path, pattern = pattern, full.names = TRUE)
  data   = lapply(files, readRDS)
  do.call("bind_rows", data)
}


#--- RODAR FUNÇÃO ---

# POF 2008-2009:
morador_09 = readRDS("dados/POF 2008-2009/morador.rds")
despesa_09 = importar("dados/POF 2008-2009/", "despesa|aluguel") %>%
  left_join(scn_09, by = "v9001")

# POF 2017-2018:
morador_18 = readRDS("dados/POF 2017-2018/morador.rds")
despesa_18 = importar("dados/POF 2017-2018/", "aluguel|despesa|coletiva") %>%
  left_join(scn_18, by = "v9001")



#-- TRATAR DADOS -------------------
gc()

#--- CRIAR FUNÇÃO ---

# despesa:
organizar_d = function(df) {
  return(df %>%
           mutate(id_fam = paste0(estrato_pof,
                                  tipo_situacao_reg,
                                  cod_upa,
                                  num_dom,
                                  num_uc, sep = "")) %>%
           group_by(id_fam, scn) %>%
           reframe(despesa = sum(v8000_defla)) %>%
           arrange(scn) %>%
           filter(!is.na(scn)) %>%
           pivot_wider(names_from = scn, values_from = despesa))
}

# morador:
organizar_m = function(df) {
  return(df %>%
           filter(!is.na(renda_monet_pc)) %>%      # dropar  missing
           filter(!v0306 %in% c(17:19)) %>%        # dropar pensionista, emp doméstico(a) e parente do emp
           mutate(id_fam = paste0(estrato_pof,
                                  tipo_situacao_reg,
                                  cod_upa,
                                  num_dom,
                                  num_uc, sep = "")) %>%
           group_by(id_fam) %>%
           reframe(rfpc = unique(renda_monet_pc),
                   peso = unique(peso_final)) %>%
           mutate(quantil = cut(rfpc, breaks = Quantile(rfpc, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                                labels = F,
                                include.lowest = T)) %>%
           select(!peso) %>%
           arrange(quantil) %>%
           pivot_wider(names_from = quantil, values_from = rfpc))
}

#--- RODAR FUNÇÃO ---
despesa_09 = organizar_d(despesa_09)
despesa_18 = organizar_d(despesa_18)
morador_09 = organizar_m(morador_09)
morador_18 = organizar_m(morador_18)



#--- EXPORTAR PARA O EXCEL -----------------------
gc()
write_xlsx(list("Despesas (2008-2009)" = despesa_09,
                "Morador  (2008-2009)" = morador_09,
                "Despesas (2017-2018)" = despesa_18,
                "Morador  (2017-2018)" = morador_18), "output/Tabelas.xlsx")


#--- SALVAR BASE ---
save.image("base.RData")

#--- LIMPAR RESÍDUO ---
rm(importar, organizar_d, organizar_m,
   scn_09, scn_18)


