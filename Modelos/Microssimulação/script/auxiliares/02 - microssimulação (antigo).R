
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



#--- MODELO DE MICROSSIMULAÇÃO COMPORTAMENTAL -------------

#--- ESTIMADORES ---
probit = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                            chefe_fam + rfpc + nfilhos + ",
                            paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo    = as.formula(paste0("lnrendah ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                            mills + ",
                            paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                            paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))


#--- CRIAR DESENHO AMOSTRAL ---

# configurações:
options(scipen=999)
options(survey.adjust.domain.lonely=TRUE)
options(survey.lonely.psu = "adjust")

# Criar desenho amostral:

    ## função:
desenho = function(df) {
       pop        = df %>% group_by(projpop) %>% summarise(Freq = n())
       pre_design = svydesign(id = ~psu, strata = ~strat, data = df, weights = ~peso_dom, nest = T)
       design     = postStratify(design = pre_design, strata = ~projpop, population = pop)
       return(design)
}


#--- RODAR MICROSSIMULAÇÃO ---

#--- BENCHMARKING:

#for (q in 1:3) {

nome     = paste0("pnad_q",q)
nome_new = paste0("pnad_new_q",q)
reg      = paste0("ocm_q",q)
reg2     = paste0("heck_q",q)
all      = paste0("pnad_all_q",q)
assign(nome, pnad_filter %>% filter(qualif == q))
assign(nome, desenho(get(nome)))

# Correção de Heckman / Occupational Choice Model:

    ## 1ª etapa:
assign(reg, svyglm(probit, family = quasibinomial(link = "probit"), design = get(nome), subset = (qualif == q)))   # rodar modelo de escolha ocupacional;
mills = dnorm(get(reg)$linear.predictors) / pnorm(get(reg)$linear.predictors)                                      # calcular inversa de mills;
assign(nome, update(get(nome), mills = mills))                                                                     # inserir inversa de mills no desenho amostral.

    ## 2ª etapa:
assign(reg2, svyglm(mqo, design = get(nome), subset = (pea == 1 & qualif == q)))                                   # rodar MQO com inversa de mills.

    ## exportar resultados:
#stargazer(get(reg), get(reg2), type = "text",
#          title =  paste0("Resultados das regressões para qualif == ",q),
#          align = T, out = paste0("output/raw/Resultados das regressões (qualif ==",q,").txt"))

# Calcular variáveis preditas:

    ## estimar a renda-hora dos desempregados:
betas         = data.frame(get(reg2)$coefficients) %>% rename(valores = get.reg2..coefficients)
betas         = rownames_to_column(betas, "coeficientes")
preditos_heck = as.numeric(betas[1,2] + betas[-1,2] %*% t(get(nome)$variables[, c("educ", "experp", "experp2", "metro", "rural", "negro", "mulher",
                                                                    "mills", paste0("setor_", c(1:2, 4:6, 8, 12:13)), 
                                                                    paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53)))]))
assign(nome, update(get(nome), lnrh = preditos_heck))

    ## calcular probabilidades do logit:
preditos_ocm  = predict(get(reg), newdata = get(nome)$variables, type = "response")
assign(nome, update(get(nome), prob_trab = preditos_ocm))

    ## arbitrar nota de corte de acordo com taxa de desemprego em 2015:
assign(nome_new, get(nome)$variables %>%
    arrange(prob_trab) %>%
    mutate(trab_new = ifelse(seq_len(nrow(get(nome))) <= round(desemprego * nrow(get(nome))), 0, 1),
           lnrh_new = case_when(trab_new == 1 ~ lnrh, T ~ 0)))

# Cálculo de desigualdade de renda e pobreza:

    ## retornar à base original:
assign(all, pnad_clean %>%
    left_join(get(nome_new) %>% select(id, trab_new, lnrh_new), by = "id") %>%
    mutate(salario  = exp(lnrh_new) * tmes,
           salario  = if_else(is.na(salario), v4718, salario)) %>%
    group_by(id_fam) %>%
    mutate(rfpc_new = (sum(salario, na.rm = T) + sum(out_renda, na.rm = T)) / nfam))


    ## FGT0 (headcount ratio):
#fgt0_total    = svyfgt(~rfpc_new, design = pnad_design, g = 0, abs_thresh = 436) * 100

    ## FGT1 (poverty gap):
#fgt1_total    = svyfgt(~rfpc_new, design = pnad_design, g = 1, abs_thresh = 436) * 100

    ## FGT2 (squared poverty gap):
#fgt2_total    = svyfgt(~rfpc_new, design = pnad_design, g = 2, abs_thresh = 436) * 100

    ## Índice de Gini:
#gini          = svygini(~rfpc_new, design = pnad_design)

    ## Índice de Theil:
#theil         = 


#--- INTEGRAÇÃO TOP-DOWN:



#}


#--- DROPAR RESÍDUO ---
rm()


#--- SALVAR BASE ---
save.image("dados/resultado final.RData")


