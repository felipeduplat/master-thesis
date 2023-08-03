
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



#-- IMPORTAR DADOS -------------------

#--- CONVERSOR SCN ---

# produtos:
SCN128_09 = read_excel("dados/auxiliares/SCN128.xlsx", sheet = 1) # 2008-2009
SCN128_18 = read_excel("dados/auxiliares/SCN128.xlsx", sheet = 3) # 2017-2018

# setores:
SCN68_09 = read_excel("dados/auxiliares/SCN68.xlsx",  sheet = 1)  # 2008-2009
SCN68_18 = read_excel("dados/auxiliares/SCN68.xlsx",  sheet = 3)  # 2017-2018


#--- POF ---

# criar função:
importar = function(path, pattern) {
  files  = list.files(path, pattern = pattern, full.names = TRUE)
  data   = lapply(files, readRDS)
  do.call("bind_rows", data)
}

# rodar função:
pof_09 = list(despesa = importar("dados/POF 2008-2009/", "despesa|aluguel|domesticos") %>%
                left_join(SCN128_09, by = "v9001"),
              
              renda = importar("dados/POF 2008-2009/", "trabalho") %>%
                rename("setor" = v53021) %>%
                left_join(SCN68_09, by = "setor"))

pof_18 = list(despesa = importar("dados/POF 2017-2018/", "despesa|aluguel|monetario") %>%
                left_join(SCN128_18, by = "v9001"),
              
              renda = importar("dados/POF 2017-2018/", "trabalho") %>%
                rename("setor" = v53061) %>%
                left_join(SCN68_18, by = "setor"))



#-- TRATAR DADOS -------------------
gc()

#--- CRIAR FUNÇÃO ---

# despesa:
despesa = function(df) {
  df$despesa %>%
    mutate(id_fam = paste0(estrato_pof,
                           tipo_situacao_reg,
                           cod_upa,
                           num_dom,
                           num_uc)) %>%
    group_by(id_fam, SCN128) %>%
    reframe(peso    = unique(peso_final),
            despesa = sum(v8000_defla),
            renda   = sum(renda_total)) %>%
    mutate(quantil  = cut(renda, breaks = Quantile(renda, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                         labels = F,
                         include.lowest = T)) %>%
    group_by(SCN128, quantil) %>%
    reframe(despesa = sum(despesa)) %>%
    arrange(quantil) %>%
    pivot_wider(names_from = quantil, values_from = despesa)
}

# renda:
renda = function(df) {
  df$renda %>%
  mutate(id_fam = paste0(estrato_pof,
                         tipo_situacao_reg,
                         cod_upa,
                         num_dom,
                         num_uc)) %>%
    group_by(id_fam, SCN68) %>%
    reframe(peso    = unique(peso_final),
            renda   = sum(renda_total)) %>%
    mutate(quantil  = cut(renda, breaks = Quantile(renda, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                          labels = F,
                          include.lowest = T)) %>%
    group_by(SCN68, quantil) %>%
    reframe(renda = sum(renda)) %>%
    arrange(quantil) %>%
    pivot_wider(names_from = quantil, values_from = renda)
}


#--- RODAR FUNÇÃO ---

# despesa:
despesa_09 = despesa(pof_09)
despesa_18 = despesa(pof_18)

# renda:
renda_09 = renda(pof_09)
renda_18 = renda(pof_18)



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("despesa (2008-2009)" = despesa_09,
                "renda (2008-2009)"   = renda_09,
                "despesa (2017-2018)" = despesa_18,
                "renda (2017-2018)"   = renda_18), "output/Tabelas (POF).xlsx")


#--- LIMPAR RESÍDUO ---
rm(importar, despesa, renda,
   SCN128_09, SCN128_18, SCN68_09, SCN68_18)


#--- SALVAR BASE ---
save.image("dados/base.RData")


