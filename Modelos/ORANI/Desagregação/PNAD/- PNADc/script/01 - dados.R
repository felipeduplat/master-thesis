
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
        "V2005",      # condição do domicílio;
        "V4013",      # setor de atividade;
        "VD3005",     # anos de estudo;
        "VD5007",     # rendimento recebido em todas as fontes (habitual de todos os trabalhos e efetivo de outras fontes).
        "VD5008")     # rendimento per capita recebido em todas as fontes (habitual de todos os trabalhos e efetivo de outras fontes).

# baixar dados:
pnadc = get_pnadc(year = 2022, interview = 1, design = F, labels = F, vars = var) %>% 
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
  filter(!v2005 %in% c(17:19),
         !is.na(vd5007),
         !is.na(vd5008),
         vd5007 != 999999999,
         vd5008 != 999999999) %>%
  group_by(trimestre) %>%
  mutate(id_fam       = paste(upa, v1008, v1014, sep = ""),
         renda        = vd5007 * co2e,
         rpc          = vd5008 * co2e,
         qualificacao = case_when(vd3005 %in% 0:5  ~ 1,
                                  vd3005 %in% 6:12 ~ 2,
                                  vd3005 >=   13   ~ 3),
         across(where(is.logical), as.numeric)) %>%
  ungroup() %>%
  select(trimestre, peso, SCN68, setor, id_fam:qualificacao)


#--- LIMPAR RESÍDUO ---
rm(var, SCN68, pnadc, deflator)
gc()


#--- SALVAR BASE ---
save.image("dados/base.RData")


