###################################################

setwd("D:/OneDrive/PNADC_Anual/Dados")

# Limpa objetos da memória
rm(list = ls())

library(tidyverse)
library(dplyr)
library(survey)
library(srvyr)
library(stargazer)

pnadc2015 <- readRDS(file="pnadc_2015")

# Modifica o objeto com a seleção de variáveis para survey
{
	spnadc <- as_survey_design(pnadc2015)
	design <-
		svydesign(
			ids = ~ UPA ,
			# Declara a unidade amostral mais granular
			strata = ~ Estrato ,
			# Declara a variÃ¡vel que contÃ©m os estratos
			weights = ~ V1032 ,
			# Declara variÃ¡vel com pesos
			data = spnadc ,
			# Declara base de microdados
			variables = NULL,
			nest = TRUE          # Declara que os estratos podem conter identificaÃ§Ãµes identicas para UPA's distintas
		)
}

# Tabulações
{
	
	# número de trabalhadores por UF e setor
	svytable(~ UF + formal, spnadc)
	svytable(~ SCN_35 + formal, spnadc)
	
	# Renda média, e renda total
	svymean( ~ rendatrab, spnadc, na.rm = TRUE)
	
	svyby(~ rendatrab,
				~ factor(SCN_35) + factor(formal) ,
				spnadc ,
				svytotal ,
				na.rm = TRUE)
	
	formal = svyby(~ rendatrab,
								 ~ factor(SCN_35) + factor(formal) ,
								 spnadc ,
								 svytotal ,
								 na.rm = TRUE)
	write_csv(formal, "formal.csv")

	formalUF = svyby(~ rendatrab,
									 ~ factor(UF) + factor(formal) ,
									 spnadc ,
									 svytotal ,
									 na.rm = TRUE)
	write_csv(formalUF, "formalUF.csv")
	
	formalUF_HOU = svyby(~ rendatrab,
											 ~ factor(UF) + factor(formal) + factor(decil) ,
											 spnadc ,
											 svytotal ,
											 na.rm = TRUE)
	write_csv(formalUF_HOU, "formalUF_HOU.csv")

}

