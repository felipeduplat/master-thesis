
# Limpa objetos da memória
rm(list = ls())

library(survey)
library(dplyr)
library(tidyr)

#setwd("D:\\OneDrive\\PNAD_Luiz")
setwd("C:\\Users\\kenia\\OneDrive\\PNAD_Luiz")

pnad <- readRDS(file = "pnadVARIAVEIS")

#-------------------------------pnad <- na.omit(pnad)

options(scipen = 999)

options(survey.lonely.psu = "adjust")

pop_types <- data.frame(ProjPop = unique(pnad$ProjPop), Freq = unique(pnad$ProjPop))

prestratified_design <- svydesign(id = ~ PSU, strata = ~ STRAT, data = pnad, weights = ~PesoDom, nest = TRUE)

pnad_design <- postStratify(design = prestratified_design, strata = ~ProjPop, population = pop_types)


## -------------------- Heckman

# Equa??o de sele??o amostral

seleqn1 <-
  svyglm(
    participa ~ IdadeAnosClasse + Raca + AnosEstudo + Sexo + AnodeReferencia + UF + HomemMulherFilhos,
    family = binomial(link = "probit"),
    design = pnad_design
  )
summary(seleqn1)

# Inversa de Mills

pnad_design$IMR <-
  dnorm(seleqn1$linear.predictors) / pnorm(seleqn1$linear.predictors)
pnad_design <- update(pnad_design, IMR = pnad_design$IMR)

# Primeiro modelo geral

#CARACTERISTICAS PESSOAIS

modelo0 <-
  svyglm(
    lnsalario ~ Idade + Idade2 + AnosEstudo + Raca + Sexo + IMR,
    pnad_design,
    subset = (participa == 1),
    na.action = na.omit
  )

#FamC-lia 

modelo1 <-
  svyglm(
    lnsalario ~ Idade + Idade2 + AnosEstudo + Raca + Sexo + IMR + Chefe + Casal + TotalMor ,
    pnad_design,
    subset = (participa == 1),
    na.action = na.omit
  )

#OcupaC'C#o 

modelo2 <-
  svyglm(
    lnsalario ~ Idade + Idade2 + AnosEstudo + Raca + Sexo + IMR + Chefe + Casal + TotalMor + Previd + PosOcuPrin,
    pnad_design,
    subset = (participa == 1),
    na.action = na.omit
  )

# Ano e regiC#o 

modelo3 <-
  svyglm(
    lnsalario ~ Idade + Idade2 + AnosEstudo + Raca + Sexo + IMR + Chefe + Casal + TotalMor + Previd + PosOcuPrin + regioes + Metro + Urbano + AnodeReferencia,
    pnad_design,
    subset = (participa == 1),
    na.action = na.omit
  )

library(stargazer)

stargazer(modelo0,
          modelo1,
          modelo2,
          modelo3,
          type = "text",
          out = "modelos.txt")

pnad_design$modelo0 <- modelo0$linear.predictors
pnad_design$modelo1 <- modelo1$linear.predictors
pnad_design$modelo2 <- modelo2$linear.predictors
pnad_design$modelo3 <- modelo3$linear.predictors

pnad$amostra = ifelse(!is.na(pnad$lnsalario), 1, 0)

pnad2 = subset(pnad, pnad$amostra == 1)
pnad2$modelo0 <- modelo0$linear.predictors
pnad2$modelo1 <- modelo1$linear.predictors
pnad2$modelo2 <- modelo2$linear.predictors
pnad2$modelo3 <- modelo3$linear.predictors

saveRDS(pnad2, "pnad_reg")

