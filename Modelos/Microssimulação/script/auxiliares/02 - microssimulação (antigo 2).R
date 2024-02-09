
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### ORIENTADOR: VINÍCIUS DE ALMEIDA VALE                   #######
####### COORIENTADORA: KÊNIA BARREIRO DE SOUZA                 #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO PARA O BRASIL

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/Microssimulação")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               survey,
               stargazer,
               convey)



#--- CARREGAR BASE DE DADOS -------------------------------
load("dados/base.RData")

# configurações:
options(scipen=999)
options(survey.adjust.domain.lonely=TRUE)
options(survey.lonely.psu = "adjust")



#--- MODELO DE MICROSSIMULAÇÃO COMPORTAMENTAL -------------

#--- ESTIMADORES ---
probit = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                            chefe_fam + rfpc + nfilhos + ",
                            paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo    = as.formula(paste0("lnrendah ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                            mills + ",
                            paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                            paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

logit  = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                            chefe_fam + nfilhos + ",
                            paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))


#--- RODAR MICROSSIMULAÇÃO ---

### BENCHMARKING:

# Correção de Heckman:

    ## 1ª etapa:
step_1      = svyglm(probit, family = quasibinomial(link = "probit"), design = pnad_design) # rodar probit;
mills       = dnorm(step_1$linear.predictors) / pnorm(step_1$linear.predictors)             # calcular inversa de mills;
pnad_design = update(pnad_design, mills = mills)                                            # inserir inversa de mills no desenho amostral.

    ## 2ª etapa:
step_2 = svyglm(mqo, design = pnad_design, subset = (pea == 1))                             # rodar MQO com inversa de mills.

# Occupational Choice Model:

    ## rodar logit:
ocm = svyglm(logit, family = quasibinomial(), design = pnad_design)                         # rodar modelo de escolha ocupacional.

    ## exportar resultados (para apreciação):
stargazer(step_1, step_2, type = "text", title =  "Correção de Heckman (benchmarking)",       align = T, out = "output/raw/Resultados - Correção de Heckman.txt")
stargazer(ocm,            type = "text", title =  "Occupational Choice Model (benchmarking)", align = T, out = "output/raw/Resultados - Occupational Choice Model.txt")

# Variáveis preditas:

    ## estimar a renda-hora dos desempregados:
betas         = data.frame(step_2$coefficients) %>% rename(valores = step_2.coefficients)
betas         = rownames_to_column(betas, "coeficientes")
preditos_heck = as.numeric(betas[1,2] + betas[-1,2] %*% t(pnad_design$variables[, c("educ", "experp", "experp2", "metro", "rural", "negro", "mulher",
                                                                    "mills", paste0("setor_", c(1:2, 4:6, 8, 12:13)), 
                                                                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53)))]))
pnad_design   = update(pnad_design, lnrh = preditos_heck)

    ## calcular probabilidades do logit:
preditos_ocm  = predict(step_1, newdata = pnad_design$variables, type = "response")
pnad_design   = update(pnad_design, prob_trab = preditos_ocm)

    ## arbitrar nota de corte de acordo com taxa de desemprego em 2015:
pnad_new      = pnad_design$variables %>%
    arrange(prob_trab) %>%
    mutate(trab_new = ifelse(seq_len(nrow(pnad_design)) <= round(desemprego * nrow(pnad_design)), 0, 1),
           sal_new  = case_when(trab_new == 1 ~ lnrh, T ~ 0))

# Cálculo de desigualdade de renda e pobreza:

    ## ajustar base:
pnad_design = convey_prep(desenho(pnad_new))

    ## FGT0 (headcount ratio):
fgt0ext_total = svyfgt(~sal_new, design = pnad_design, g = 0, abs_thresh = 151) * 100
fgt0_total    = svyfgt(~sal_new, design = pnad_design, g = 0, abs_thresh = 436) * 100

    ## FGT1 (poverty gap):
fgt1ext_total = svyfgt(~sal_new, design = pnad_design, g = 1, abs_thresh = 151) * 100
fgt1_total    = svyfgt(~sal_new, design = pnad_design, g = 1, abs_thresh = 436) * 100

    ## FGT2 (squared poverty gap):
fgt2ext_total = svyfgt(~sal_new, design = pnad_design, g = 2, abs_thresh = 151) * 100
fgt2_total    = svyfgt(~sal_new, design = pnad_design, g = 2, abs_thresh = 436) * 100

    ## Índice de Gini:
gini          = svygini(~sal_new, design = pnad_design)


