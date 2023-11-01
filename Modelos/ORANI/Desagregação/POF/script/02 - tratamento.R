
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### ORIENTADOR: VINÍCIUS DE ALMEIDA VALE                   #######
####### COORIENTADORA: KÊNIA BARREIRO DE SOUZA                 #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO PARA O BRASIL

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
SCN = read_excel("dados/auxiliares/SCN128.xlsx", sheet = 1)     # produtos de 2008-2009


#--- POF ---

# criar função:
importar = function(path, pattern) {
  files  = list.files(path, pattern = pattern, full.names = TRUE)
  data   = lapply(files, readRDS)
  do.call("bind_rows", data)
}

# rodar função (POF 2008-2009):
POF = list(despesa_09 = importar("dados/POF 2008-2009/", "aluguel|despesa|domestico") %>%
             left_join(SCN, by = "v9001"),
           
           morador_09 = readRDS("dados/POF 2008-2009/morador.rds") %>%
             filter(!v0306 %in% c(17,18,19)) %>%
             mutate(id_fam = paste0(estrato_pof,
                                    tipo_situacao_reg,
                                    cod_upa,
                                    num_dom,
                                    num_uc)) %>%
             group_by(id_fam) %>%
             reframe(rpc = unique(renda_monet_pc)))

# rodar função (POF 2008-2009 e 2017-2018):
#POF = list(despesa_09 = importar("dados/POF 2008-2009/", "aluguel|despesa|domestico") %>%
             #left_join(SCN, by = "v9001"),

           #morador_09 = readRDS("dados/POF 2008-2009/morador.rds") %>%
             #filter(!v0306 %in% c(17,18,19)) %>%
             #mutate(id_fam = paste0(estrato_pof,
                                    #tipo_situacao_reg,
                                    #cod_upa,
                                    #num_dom,
                                    #num_uc)) %>%
             #group_by(id_fam) %>%
             #reframe(rpc = unique(renda_monet_pc)))
           
           #despesa_18 = importar("dados/POF 2017-2018/", "aluguel|coletiva|individual|monetario") %>%
           #  left_join(SCN$prod_18, by = "v9001"),

           #morador_18 = readRDS("dados/POF 2017-2018/morador.rds") %>%
           #  filter(!v0306 %in% c(17,18,19)) %>%
           #  mutate(id_fam = paste0(estrato_pof,
           #                         tipo_situacao_reg,
           #                         cod_upa,
           #                         num_dom,
           #                         num_uc)) %>%
           #  group_by(id_fam) %>%
           #  reframe(rpc = unique(renda_monet_pc)))



#-- TRATAR DADOS -------------------

#--- CRIAR FUNÇÃO ---
despesa = function(df, mor) {
  df %>%
    mutate(id_fam = paste0(estrato_pof,
                           tipo_situacao_reg,
                           cod_upa,
                           num_dom,
                           num_uc)) %>%
    left_join(mor, by = "id_fam") %>%
    filter(v8000_defla != 9999999.99) %>%
    group_by(id_fam, SCN128, rpc) %>%
    reframe(peso    = unique(peso_final),
            despesa = sum(v8000_defla * fator_anualizacao)) %>%
    mutate(quantil  = cut(rpc, breaks = Quantile(rpc, weights = peso, probs = seq(0,1,0.01), na.rm = T),
                          labels = F,
                          include.lowest = T)) %>%
    group_by(SCN128, quantil) %>%
    reframe(despesa = sum(despesa, weights = peso)) %>%
    arrange(quantil) %>%
    pivot_wider(names_from = quantil, values_from = despesa) %>%
    arrange(SCN128)
}


#--- RODAR FUNÇÃO ---
options(scipen=999)
despesa_09 = despesa(POF$despesa_09, POF$morador_09)
#despesa_18 = despesa(POF$despesa_18, POF$morador_18)



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("despesa (2008-2009)" = despesa_09), "output/raw/tabelas.xlsx")

#write_xlsx(list("despesa (2008-2009)" = despesa_09,
                #"despesa (2017-2018)" = despesa_18), "output/raw/tabelas.xlsx")


#--- LIMPAR RESÍDUO ---
gc()
rm(importar, despesa,
   despesa_09, despesa_18)


#--- SALVAR BASE ---
save.image("dados/base.RData")


