
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
               PNADcIBGE,
               readxl)



#--- BAIXAR DADOS ------------------

#--- PNAD CONTÍNUA ---

# escolher variáveis:
var = c("Ano",        # ano;
        "Trimestre",  # trimestre;
        "UF",         # Unidade Federativa;
        "UPA",        # UPA;
        "Estrato",    # estrato;
        "V1008",      # número do domicílio;
        "V1032",      # peso amostral;
        "V1022",      # situação do domicílio (rural x urbano);
        "V2005",      # condição do domicílio;
        "V4013",      # setor de atividade;
        "VD4009",     # ocupação;
        "VD3005",     # anos de estudo;
        "VD4046")     # rendimento recebido em todas as fontes.

# baixar dados:
pnadc = get_pnadc(year = 2022, interview = 5, design = F, labels = F, vars = var) %>% 
  mutate(across(where(is.character), as.numeric)) %>% 
  rename_with(., tolower, everything())

# inserir conversão PNADc x SCN:
SCN68 = read_excel("dados/auxiliares/SCN68.xlsx", sheet = 3)

# inserir deflator:
deflator = read_excel("dados/auxiliares/deflator.xlsx")


#--- ORGANIZAR DADOS -----------------------

pnadc_clean = pnadc %>%
  left_join(SCN68,    by = "v4013") %>%
  left_join(deflator, by = c("ano", "trimestre", "uf")) %>%
  rename(peso  = v1032,
         setor = v4013) %>%
  filter(!v2005 %in% c(17:19)) %>%
  filter(!is.na(vd4046)) %>%
  group_by(trimestre) %>%
  mutate(id         = 1,
         id_fam     = paste0(upa, estrato, v1008),
         renda      = vd4046 * co2e,
         rural      = (v1022 == 2),
         formal     = (vd4009 %in% c(1,3,5,7)),
         nqualif    = (vd3005 %in% 0:5),
         semiqualif = (vd3005 %in% 6:12),
         qualif     = (vd3005 >= 13),
         across(where(is.logical), as.numeric)) %>%
  ungroup() %>%
  select(trimestre, peso, SCN68, setor, id:qualif)


#--- LIMPAR RESÍDUO ---
rm(var, SCN68, pnadc, deflator)
gc()


#--- LIMPAR RESÍDUO ---
save.image("dados/base.RData")


