
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### ORIENTADOR: VINÍCIUS DE ALMEIDA VALE                   #######
####### COORIENTADORA: KÊNIA BARREIRO DE SOUZA                 #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/Microssimulação")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               survey,
               stargazer)



#--- CARREGAR BASE DE DADOS -------------------------------
load("dados/base.RData")

# configurações:
options(scipen=999)



#--- MODELO DE MICROSSIMULAÇÃO COMPORTAMENTAL -------------

#--- SIMULAÇÃO DE BENCHMARK ---

## ESTIMADORES:
probit = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                    pea + rdpc + nfilhos + educ_cc + sexo_cc + idade_cc + casado_cc + ",
                    paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo    = as.formula(paste0("lnrendah ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                    mills +",
                    paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

logit  = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher + ",
                    paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

## EQUAÇÕES:

# Correção de Heckman:
    ## 1ª etapa (probit):
step_1      = svyglm(probit, family = quasibinomial(link = "probit"), design = pnad_design)
mills       = dnorm(step_1$linear.predictors) / pnorm(step_1$linear.predictors)
if (length(mills) < nrow(pnad_design)) {
  mills     = c(mills, rep(NA, length.out = nrow(pnad_design) - length(mills)))
}
pnad_design = update(pnad_design, mills = mills)

    ## 2ª etapa (MQO com inversa de mills):
step_2 = svyglm(mqo, design = pnad_design, subset = !is.na(pea), na.action = na.omit)

#---

# Occupational Choice Model:
ocm = svyglm(logit, family = quasibinomial(), design = pnad_design)


#--- INTEGRAÇÃO TOP-DOWN ---




#--- EXPORTAR TABELAS (provisório) -----------------------------------
stargazer(step_1, step_2, type = "text", title =  "Correção de Heckman", align = T, out = "Correção de Heckman.txt")
stargazer(ocm, type = "text", title =  "Occupational Choice Model", align = T, out = "Occupational Choice Model.txt")


#--- DROPAR RESÍDUO ---
rm(probit, mqo, logit, mills)


