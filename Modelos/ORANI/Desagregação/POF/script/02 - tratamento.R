
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

SCN = list(prod_09  = read_excel("dados/auxiliares/SCN128.xlsx", sheet = 1),     # produtos de 2008-2009
           prod_18  = read_excel("dados/auxiliares/SCN128.xlsx", sheet = 3),     # produtos de 2017-2018
           
           setor_09 = read_excel("dados/auxiliares/SCN68.xlsx",  sheet = 1),     # setor de 2008-2009
           setor_18 = read_excel("dados/auxiliares/SCN68.xlsx",  sheet = 3))     # setor de 2017-2018

#--- POF ---

# criar função:
importar = function(path, pattern) {
  files  = list.files(path, pattern = pattern, full.names = TRUE)
  data   = lapply(files, readRDS)
  do.call("bind_rows", data)
}

# rodar função:
POF = list(despesa_09 = importar("dados/POF 2008-2009/", "aluguel|despesa|domestico") %>%
             left_join(SCN$prod_09, by = "v9001"),
           
           renda_09   = importar("dados/POF 2008-2009/", "rendimento") %>%
             rename("setor" = v53021) %>%
             left_join(SCN$setor_09, by = "setor"),
           
           despesa_18 = importar("dados/POF 2017-2018/", "aluguel|coletiva|individual|monetario") %>%
             left_join(SCN$prod_18, by = "v9001"),
           
           renda_18   = importar("dados/POF 2017-2018/", "rendimento") %>%
             rename("setor" = v53061) %>%
             left_join(SCN$setor_18, by = "setor"),
           
           morador_09 = readRDS("dados/POF 2008-2009/morador.rds") %>%
             filter(!v0306 %in% c(17,18,19)) %>%
             mutate(id_fam = paste0(estrato_pof,
                                    tipo_situacao_reg,
                                    cod_upa,
                                    num_dom,
                                    num_uc)) %>%
             group_by(id_fam) %>%
             reframe(rpc = unique(renda_monet_pc)),
           
           morador_18 = readRDS("dados/POF 2017-2018/morador.rds") %>%
             filter(!v0306 %in% c(17,18,19)) %>%
             mutate(id_fam = paste0(estrato_pof,
                                    tipo_situacao_reg,
                                    cod_upa,
                                    num_dom,
                                    num_uc)) %>%
             group_by(id_fam) %>%
             reframe(rpc = unique(renda_monet_pc)))



#-- TRATAR DADOS -------------------

#--- CRIAR FUNÇÃO ---

# produtos por percentil de renda:
despesa = function(df, mor) {
  df %>%
    mutate(id_fam = paste0(estrato_pof,
                           tipo_situacao_reg,
                           cod_upa,
                           num_dom,
                           num_uc)) %>%
    left_join(mor, by = "id_fam") %>%
    group_by(id_fam, SCN128, rpc) %>%
    reframe(peso    = unique(peso_final),
            despesa = sum(v8000_defla * fator_anualizacao)) %>%
    mutate(quantil  = cut(rpc, breaks = Quantile(rpc, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                          labels = F,
                          include.lowest = T)) %>%
    group_by(SCN128, quantil) %>%
    reframe(despesa = sum(despesa, weights = peso)) %>%
    arrange(quantil, SCN128) %>%
    pivot_wider(names_from = quantil, values_from = despesa) %>%
    arrange(SCN128)
}

# setores por percentil de renda:
renda = function(df, mor) {
  df %>%
  mutate(id_fam = paste0(estrato_pof,
                         tipo_situacao_reg,
                         cod_upa,
                         num_dom,
                         num_uc)) %>%
    left_join(mor, by = "id_fam") %>%
    group_by(id_fam, SCN68, rpc) %>%
    reframe(peso    = unique(peso_final),
            renda   = sum(renda_total * fator_anualizacao)) %>%
    mutate(quantil  = cut(rpc, breaks = Quantile(rpc, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                          labels = F,
                          include.lowest = T)) %>%
    group_by(SCN68, quantil) %>%
    reframe(renda = sum(renda, weights = peso)) %>%
    arrange(quantil, SCN68) %>%
    pivot_wider(names_from = quantil, values_from = renda) %>%
    arrange(SCN68)
}


#--- RODAR FUNÇÃO ---

# despesa:
options(scipen=999)
despesa_09 = despesa(POF$despesa_09, POF$morador_09)
despesa_18 = despesa(POF$despesa_18, POF$morador_18)

# renda:
#renda_09 = renda(POF$renda_09, POF$morador_09)
#renda_18 = renda(POF$renda_18, POF$morador_18)



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("despesa (2008-2009)" = despesa_09,
                "despesa (2017-2018)" = despesa_18), "output/raw/tabelas.xlsx")


#--- LIMPAR RESÍDUO ---
gc()
rm(importar, despesa, renda,
   despesa_09, despesa_18,
   renda_09, renda_18)


#--- SALVAR BASE ---
save.image("dados/base.RData")


