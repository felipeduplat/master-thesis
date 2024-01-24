
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### DOCENTE: VINÍCIUS DE ALMEIDA VALE                      #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/PNAD")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(bit64,
               data.table,
               descr,
               readxl,
               tidyverse)



#--- BAIXAR DADOS ------------------

#--- PNAD ---
dicpes  = read_excel("docs/dicpes.xlsx")
end_pes = dicpes$inicio + dicpes$tamanho - 1
fwf2csv(fwffile = "dados/raw/PES2015.txt", csvfile = "dados/raw/dadospes.csv", names = dicpes$variavel, begin=dicpes$inicio, end=end_pes)
pnad = fread(input = "dados/raw/dadospes.csv", sep = "auto", sep2 = "auto", integer64 = "double") %>%
  mutate(across(where(is.character), as.numeric)) %>% 
  rename_with(., tolower, everything())


#--- TRADUTOR ---
SCN68 = read_excel("dados/auxiliares/SCN68.xlsx", sheet = 1)



#--- ORGANIZAR DADOS -----------------------
pnad_clean = pnad %>%
  left_join(SCN68, by = "v9907") %>%
  rename(peso  = v4732,
         renda = v4719,
         rpc   = v4750) %>%
  filter(!v0401 %in% c(6:8)) %>%
  filter(!is.na(renda) & !is.na(rpc)) %>%
  filter(renda != 999999999999, rpc != 999999999999) %>%
  mutate(id_fam = paste0(v0101, uf, v0102, v0103),
         qualif = case_when(v4803 %in%  0:11 ~ 1,
                            v4803 %in% 12:15 ~ 2,
                            v4803   >= 16    ~ 3)) %>%
  ungroup() %>%
  select(peso, SCN68, renda, rpc, id_fam:qualif)


#--- LIMPAR RESÍDUO ---
rm(dicpes, end_pes, SCN68, pnad)


#--- SALVAR BASE ---
save.image("dados/base.RData")


