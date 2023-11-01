
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
               readxl,
               curl)



#--- BAIXAR COMEX STAT -----------------------
for (i in c(2015)) {                             # ano 2015
  for (j in c("EXP","IMP")) {                    # exportações e importações
    path = paste0("dados/raw/",j,i,".csv")
    if (file.exists(path)) {print("Dados existentes na pasta.")} else {
      curl_download(paste0("https://balanca.economia.gov.br/balanca/bd/comexstat-bd/ncm/",j,"_",i,".csv"), path)
    }
  }
}



#--- IMPORTAR DADOS -----------------------

#--- CONVERSOR SCN ---
SCN = read_excel("dados/auxiliares/Tradutor.xlsx", sheet = 1)


#--- COMEX STAT ---
comercio = list(
  
  exportacao = do.call("bind_rows",lapply(list.files("dados/raw", "EXP"), function(i)
    read.csv(paste("dados/raw/",i, sep = ""),encoding = "UTF-8", sep = ";"))) %>% 
    left_join(SCN, by = "CO_NCM"),
  
  importacao = do.call("bind_rows",lapply(list.files("dados/raw", "IMP"), function(i)
    read.csv(paste("dados/raw/",i, sep = ""),encoding = "UTF-8", sep = ";"))) %>% 
    left_join(SCN, by = "CO_NCM"))



#--- ORGANIZAR DADOS -----------------------

#--- CRIAR FUNÇÃO ---
comexstat = function(df) {
  df %>%
    mutate(PAIS = case_when(CO_PAIS == 249 ~ 1,  # EUA;
                            CO_PAIS == 160 ~ 2,  # China;
                            CO_PAIS == 676 ~ 3,  # Rússia;
                            CO_PAIS == 361 ~ 4,  # Índia;
                            CO_PAIS == 756 ~ 5,  # África do Sul;
                            
                            CO_PAIS == 63  ~ 6,  # Argentina;
                            CO_PAIS == 845 ~ 7,  # Uruguai;
                            CO_PAIS == 586 ~ 8,  # Paraguai;
                            CO_PAIS == 850 ~ 9,  # Venezuela;
                            CO_PAIS == 158 ~ 10, # Chile;
                            CO_PAIS == 169 ~ 11, # Colômbia;
                            CO_PAIS == 239 ~ 12, # Equador;
                            CO_PAIS == 589 ~ 13, # Peru;
                            CO_PAIS == 97  ~ 14, # Bolívia;
                            CO_PAIS == 493 ~ 15, # México;
                            CO_PAIS == 196 ~ 16, # Costa Rica;
                            CO_PAIS == 199 ~ 17, # Cuba;
                            CO_PAIS == 687 ~ 18, # El Salvador;
                            CO_PAIS == 317 ~ 19, # Guatemala;
                            CO_PAIS == 341 ~ 20, # Haiti;
                            CO_PAIS == 345 ~ 21, # Honduras;
                            CO_PAIS == 521 ~ 22, # Nicarágua;
                            CO_PAIS == 580 ~ 23, # Panamá;
                            CO_PAIS == 647 ~ 24, # República Dominicana;
                            
                            CO_PAIS == 23  ~ 25, # Alemanha;
                            CO_PAIS == 72  ~ 25, # Áustria;
                            CO_PAIS == 87  ~ 25, # Bélgica;
                            CO_PAIS == 111 ~ 25, # Bulgária;
                            CO_PAIS == 163 ~ 25, # Chipre;
                            CO_PAIS == 195 ~ 25, # Croácia;
                            CO_PAIS == 232 ~ 25, # Dinamarca;
                            CO_PAIS == 245 ~ 25, # Espanha;
                            CO_PAIS == 246 ~ 25, # Eslovênia;
                            CO_PAIS == 247 ~ 25, # Eslováquia;
                            CO_PAIS == 251 ~ 25, # Estônia;
                            CO_PAIS == 271 ~ 25, # Finlândia;
                            CO_PAIS == 275 ~ 25, # França;
                            CO_PAIS == 301 ~ 25, # Grécia;
                            CO_PAIS == 355 ~ 25, # Hungria;
                            CO_PAIS == 375 ~ 25, # Irlanda;
                            CO_PAIS == 386 ~ 25, # Itália;
                            CO_PAIS == 427 ~ 25, # Letônia;
                            CO_PAIS == 442 ~ 25, # Lituânia;
                            CO_PAIS == 445 ~ 25, # Luxemburgo;
                            CO_PAIS == 467 ~ 25, # Malta;
                            CO_PAIS == 573 ~ 25, # Países Baixos;
                            CO_PAIS == 603 ~ 25, # Polônia;
                            CO_PAIS == 607 ~ 25, # Portugal;
                            CO_PAIS == 670 ~ 25, # Romênia;
                            CO_PAIS == 764 ~ 25, # Suécia;
                            CO_PAIS == 791 ~ 25, # Rep. Tcheca;
                            
                            CO_PAIS != c(23, 63, 72, 87, 97, 111, 158, 160, 163,
                                         169, 195, 196, 199, 232, 239, 245, 246,
                                         247, 249, 251, 271, 275, 301, 317, 341,
                                         345, 355, 361, 375, 386, 427, 442, 445,
                                         467, 493, 521, 573, 580, 586, 589, 603,
                                         607, 647, 670, 676, 687, 756, 764, 791,
                                         845, 850) ~ 26)) %>%
    select(SCN, CO_PAIS, PAIS, VL_FOB)
}


#--- RODAR FUNÇÃO ---
options(scipen=999)
comercio_clean = list(
  exportacao = comexstat(comercio$exportacao),
  importacao = comexstat(comercio$importacao)
)


#--- LIMPAR RESÍDUO ---
rm(i, j, path, comercio, SCN, comexstat)



#--- SALVAR BASE -------------------
save.image("dados/base.RData")


