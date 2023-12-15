########## Leitura PNAD

# Limpa objetos da memória
rm(list = ls())

# Define pasta onde estão ou serão armazenados arquivos nesta sessão
setwd("D:/OneDrive/PNADC_Anual/Dados")

library(PNADcIBGE)

###########################################
# Usando .txt dados salvos

### 2015, primeira visita

pnadc2015 <- read_pnadc("PNADC_2015_visita1.txt", "input_PNADC_2015_visita1_20220224.txt")
#pnadc2015 <- pnadc_deflator(data_pnadc=pnadc2015, "deflator_PNADC_2019.xls")

# Salva objeto final
saveRDS(pnadc2015,"pnadc2015")

rm(list = ls())


########## Leitura PNAD

# Limpa objetos da memória
rm(list = ls())

# Define pasta onde estão ou serão armazenados arquivos nesta sessão
setwd("D:/OneDrive/PNADC_Anual/Dados")

library(PNADcIBGE)

###########################################
# Usando .txt dados salvos

### 2019, terceiro trimestre

pnadc20193t <- read_pnadc("PNADC_2019_trimestre3.txt", "input_PNADC_trimestre3.txt")
#pnadc20193t <- pnadc_deflator(data_pnadc=pnadc2015, "deflator_PNADC_2019.xls")

# Salva objeto final
saveRDS(pnadc20193t,"pnadc20193t")

rm(list = ls())




