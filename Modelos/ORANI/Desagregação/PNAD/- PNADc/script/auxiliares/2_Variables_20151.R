###################################################

#setwd("D:/OneDrive/PNADC_Anual/Dados")
setwd("C:/Users/kenia/OneDrive/PNADC_Anual/Dados")

# Limpa objetos da mem?ria
rm(list = ls())

library(tidyverse)
library(dplyr)
library(survey)
library(srvyr)
library(readr)
library(statar)

pnadc <- as.data.frame(readRDS(file = "pnadc2015"))
comp <-  as.data.frame(read_delim("Comp_scn35.csv", delim = ";"))
pnadc$V4013 <- as.numeric(pnadc$V4013)
pnadc <- merge(pnadc, comp, by="V4013", all.x = TRUE)

# Vari?veis calibragem informal 
{
# Formal
pnadc$formal = factor(
	ifelse(
		pnadc$VD4009 == "01" |
			pnadc$VD4009 == "03" |
			pnadc$VD4009 == "05" |
			pnadc$VD4009 == "07" |
			pnadc$VD4009 == "08" &
			pnadc$V4019 == 1 | pnadc$VD4009 == "09" & pnadc$V4019 == 1,
		1,
		ifelse(
			pnadc$VD4009 == "02" |
				pnadc$VD4009 == "04" |
				pnadc$VD4009 == "06" |
				pnadc$VD4009 == "10" |
				pnadc$VD4009 == "08" &
				pnadc$V4019 == 2 | pnadc$VD4009 == "09" & pnadc$V4019 == 2,
			0,
			0
		)
	),
	labels = c("informal", "formal")
)

# Setor p?blico ou privado
pnadc$privado = 
	ifelse(
		pnadc$V4012 == 1 |
			pnadc$V4012 == 3 |
			pnadc$V4012 == 5 |
			pnadc$V4012 == 6 |
			pnadc$VD4009 ==  7,
		1,
		ifelse(
			pnadc$V4012 == 2 |
				pnadc$VD4009 == 4,
			0,
			0
		))

# Ajuste para setor p?blico
pnadc$SCN_35 = ifelse(
	pnadc$SCN_35 == 30 &
		pnadc$privado == 1,
	31,
	ifelse(pnadc$SCN_35 == 32 & pnadc$privado == 1, 33, pnadc$SCN_35)
)

# Rendimento do trabalho principal
pnadc$rendaprin = as.numeric(pnadc$VD4016)

# Rendimento domiciliar pc
pnadc$rendadompc= as.numeric(pnadc$VD5011)

pnadc$decil = xtile(pnadc$rendadompc, 10)

}

# Outras vari?veis
{
# Gera dummy para mulher
pnadc$mulher = factor(ifelse(pnadc$V2007 == 2, 1, ifelse(pnadc$V2007 == 1, 0, NA)), labels=c("homem","mulher"))

# Tabula a vari?vel, sem peso amostral
# summary.factor(pnadc$mulher)

# Dummy para participa da for?a de trabalho
pnadc$participa = factor(ifelse(pnadc$VD4001 == 1, 1, ifelse(pnadc$VD4001 == 2, 0, NA)), labels=c("n?o participa","participa"))

# Dummy para estar ocupado(a) 
pnadc$ocupado = factor(ifelse(pnadc$VD4002 == 1, 1, ifelse(pnadc$VD4002 == 2, 0, NA)), labels=c("desocupado","ocupado"))

# Dummy para chefe de domic?lio
pnadc$chefe = factor(ifelse(pnadc$VD2002 == "01", 1, 0))

# Dummy para adultos (respons?vel e conjuge do respons?vel)
pnadc$adultos = as.numeric(ifelse(pnadc$VD2002 == "01", 1, ifelse(pnadc$VD2002 == "02", 1, 0)))

# Filhos e enteados no domic?lio
pnadc$filhos = as.numeric(ifelse(pnadc$VD2002 == "03", 1, ifelse(pnadc$VD2002 == "04", 1, 0)))

# Cor/ra?a do indiv?duo
####### pnadc$corraca = as.numeric(pnadc$V2010)
pnadc$branco = factor(ifelse(pnadc$V2010 == 1, 1, 0), labels=c("n?o branco","branco"))

# Agrupamento ocupacional 
######## as a factor #caracteristica qualitativa
pnadc$gr_ocup = factor(pnadc$VD4011)

# Idade
pnadc$idade = as.numeric(pnadc$V2009)
pnadc$idade2 = as.numeric(pnadc$V2009 ^ 2)
#pnadc$idade_break = cut(pnadc$V2009, breaks = c(24, 35, 45, 59))

# Anos de Estudo
pnadc$anos_estudo = as.numeric(pnadc$VD3005)

# Dummy para residentes da regi?o metropolitana
pnadc$metro = factor(ifelse(pnadc$V1023 == 1, 1, ifelse(pnadc$V1023 == 2, 1, 0)),
										 labels = c("metropolina", "n?o metropolitana"))
#summary(pnadc$metro)

# Cria um identificador de domic?lio
pnadc$dom = as.numeric(paste(pnadc$UPA, pnadc$V1008, pnadc$V1014, sep =""))

# N?mero de filhos no domic?lio
pnadc = pnadc %>%
	group_by(dom) %>%
	mutate(nfilhos = sum(filhos, na.rm = FALSE))

#-------------------------------------------------------#

# Filhos de 0 a 5 anos
pnadc$filhos05 = as.numeric(ifelse(
	pnadc$VD2002 == "03" & pnadc$V2009 <= 5,
	1,
	ifelse(pnadc$VD2002 == "04" &
				 	pnadc$V2009 <= 5, 1, 0)
))

# N?mero de filhos no domic?lio de 0-5anos
pnadc = pnadc %>%
	group_by(dom) %>%
	mutate(nfilhos05 = sum(filhos05, na.rm = FALSE))

#-------------------------------------------------------#

# Vari?vel de intera??o entre mulher e filhos **
pnadc$nfilhos_m = factor(as.numeric(pnadc$nfilhos) * as.numeric(pnadc$mulher))

# Rendimento per capita habitualmente recebido
pnadc$rendapc = pnadc$VD5011
pnadc$lnrendapc = as.numeric(ifelse(pnadc$VD5011 > 0, log(pnadc$VD5011), NA))

# Rendimento do trabalho principal
pnadc$rendaprin = as.numeric(pnadc$VD4016)

# Rendimento todos os trabalhos
pnadc$rendatrab = as.numeric(pnadc$VD4019)

# Rendimento domiciliar
pnadc$rendadom= as.numeric(pnadc$VD5011)

# Rendimento domiciliar pc
pnadc$rendadompc= as.numeric(pnadc$VD5012)

# N?mero de pessoas que habitam o domic?lio 
pnadc$habitantes = as.numeric(pnadc$VD2003)

# Peso amostral
pnadc$peso = pnadc$V1032

# Experiencia
pnadc = mutate (pnadc, exp = case_when(V40401 <= 11 ~ 0, V40402 <= 11 ~ 1, V40403 >
																			 	2 ~ V40403))
}

# Selecionar uma parte da base de dados (para liberar mem?ria)
# Selecionando vari?veis
{sel_var <-
	c(
		"UPA",
		"V1031",
		"Estrato",
		"posest",
		"V1030",
		"V1032",
		"Ano",
		"Trimestre",
		"UF",
		"mulher",
		"participa",
		"ocupado",
		"chefe",
		"adultos",
		"filhos",
		"branco",
		"gr_ocup",
		"formal",
		"idade",
		"idade2",
		"anos_estudo",
		"metro",
		"dom",
		"filhos05",
		"nfilhos05",
		"nfilhos_m",
		"nfilhos",
		"lnrendapc",
		"rendapc",
		"rendaprin",
		"rendatrab",
		"rendadom",
		"rendadompc",
		"decil",
		"habitantes",
		"SCN_35",
		"V4013",
		"peso" ,
		"exp"
	)
}

# Salvando vari?veis selecionadas
pnadc2015 <-
	subset(pnadc, select = sel_var)
saveRDS(pnadc2015, "pnadc_2015")

# Limpa da mem?ria o banco de dados completo
rm(pnadc)
