
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
               sampleSelection)



#--- CARREGAR BASE DE DADOS -------------------------------
load("dados/base.RData")

# configurações:
options(scipen=999)



#--- MODELO DE MICROSSIMULAÇÃO COMPORTAMENTAL -------------

#--- SIMULAÇÃO DE BENCHMARK ---

## ESTIMADORES:
probit = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher + rdpc +
                    nea + nfilhos + casado + ", paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo    = as.formula(paste0("lnrendah ~ educ + experp + I(experp^2) + metro + rural + negro + mulher + ",
                    paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

logit  = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher + ",
                    paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

## EQUAÇÕES:

# Correção de Heckman:
heckman = selection(selection = probit, outcome = mqo, data = sys.frame(sys.parent(design)), method = "2step") # EQUAÇÃO 01

# Renda familiar:
renda_fam = rendah + out_renda                                                                               # EQUAÇÃO 02

# Occupational Choice Model:
logit = glm(formula = discrete, data = pnad_clean, weights = peso)                                           # EQUAÇÃO 03


#--- INTEGRAÇÃO TOP-DOWN ---




#--- EXPORTAR PARA EXCEL-----------------------------------



#--- DROPAR RESÍDUO ---
rm(discrete, mincer)


#--- SALVAR BASE ---
save.image()


