
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### ORIENTADOR: VINÍCIUS DE ALMEIDA VALE                   #######
####### COORIENTADORA: KÊNIA BARREIRO DE SOUZA                 #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO PARA O BRASIL

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/Comex Stat")


#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               writexl)



#--- CARREGAR BASE -------------------
load("dados/base.RData")



#--- CRIAR TABELAS -----------------------

#--- CRIAR FUNÇÃO ---
tabelas = function(df) {
  df %>%
    group_by(SCN, PAIS) %>%
    reframe(valor = sum(VL_FOB)) %>%
    arrange(PAIS) %>%
    pivot_wider(names_from = PAIS, values_from = valor) %>%
    rename("EUA"                  = "1",
           "China"                = "2",
           "Rússia"               = "3",
           "Índia"                = "4",
           "África do Sul"        = "5",
           "Argentina"            = "6",
           "Uruguai"              = "7",
           "Paraguai"             = "8",
           "Venezuela"            = "9",
           "Chile"                = "10",
           "Colômbia"             = "11",
           "Equador"              = "12",
           "Peru"                 = "13",
           "Bolívia"              = "14",
           "México"               = "15",
           "Costa Rica"           = "16",
           "Cuba"                 = "17",
           "El Salvador"          = "18",
           "Guatemala"            = "19",
           "Haiti"                = "20",
           "Honduras"             = "21",
           "Nicarágua"            = "22",
           "Panamá"               = "23",
           "República Dominicana" = "24",
           "União Europeia"       = "25",
           "Resto do mundo"       = "26") %>%
    arrange(SCN)
}


#--- RODAR FUNÇÃO ---
exportacao = tabelas(comercio_clean$exportacao)
importacao = tabelas(comercio_clean$importacao)



#--- EXPORTAR PARA O EXCEL -----------------------
write_xlsx(list("exportação" = exportacao,
                "importação" = importacao), "output/raw/tabelas.xlsx")


