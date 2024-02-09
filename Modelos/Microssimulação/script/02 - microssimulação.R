
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
               convey,
               openxlsx)



#--- CARREGAR BASE DE DADOS -------------------------------
load("dados/base.RData")



#--- MODELO DE MICROSSIMULAÇÃO COMPORTAMENTAL -------------

#--- ESTIMADORES ---
probit   = as.formula(paste0("trab     ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                             chefe_fam + rfpc + nfilhos + ",
                             paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo      = as.formula(paste0("lnrendah ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                             mills + ",
                             paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                             paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))

mqo_sim3 = as.formula(paste0("lnrendah_sim3 ~ educ + experp + I(experp^2) + metro + rural + negro + mulher +
                             mills + ",
                             paste0("setor_", c(1:2,4:6,8,12:13), collapse = " + "), " + ",
                             paste0("uf_", c(11:17, 21:29, 31:33, 41:43, 50:53), collapse = " + ")))


#--- CRIAR FUNÇÕES ---

# Desenho amostral:

    ## configurações:
options(scipen=999)
options(survey.adjust.domain.lonely=TRUE)
options(survey.lonely.psu = "adjust")

    ## função:
desenho = function(df) {
       pop        = df %>% group_by(projpop) %>% summarise(Freq = n())
       pre_design = svydesign(id = ~psu, strata = ~strat, data = df, weights = ~peso_dom, nest = T)
       design     = postStratify(design = pre_design, strata = ~projpop, population = pop)
       return(design)
}


# Retorno à base original:

    ## função:
retorno = function(df_1, df_2, df_3) {
    benchmarking = pnad_clean %>%
    left_join(df_1 %>% select(id, trab_new_1 = trab_new, lnrh_new_1 = lnrh_new), by = "id") %>%
    left_join(df_2 %>% select(id, trab_new_2 = trab_new, lnrh_new_2 = lnrh_new), by = "id") %>%
    left_join(df_3 %>% select(id, trab_new_3 = trab_new, lnrh_new_3 = lnrh_new), by = "id") %>%
    mutate(trab_new = case_when(qualif == 1 ~ trab_new_1,
                                qualif == 2 ~ trab_new_2,
                                qualif == 3 ~ trab_new_3),
           lnrh_new = case_when(qualif == 1 ~ lnrh_new_1,
                                qualif == 2 ~ lnrh_new_2,
                                qualif == 3 ~ lnrh_new_3),
           salario  = exp(lnrh_new) * tmes,
           salario  = if_else(is.na(salario), v4718, salario)) %>%
    group_by(id_fam) %>%
    mutate(rfpc_new = (sum(salario, na.rm = T) + sum(out_renda, na.rm = T)) / nfam) %>%
    ungroup()
}


# Modelo de geração de renda familiar:

    ## função:
microssimulacao = function(mqo, q, i, desemp) {

        ## variáveis: 
    nome       = paste0("pnad_q",q)
    nome_new   = paste0("pnad_new_q",q)
    reg        = paste0("ocm_q",q)
    reg2       = paste0("heck_q",q)
    desemp     = paste0("desemprego")
    desemp_new = paste0("desemp_",q)
    all        = paste0("pnad_all_q",q)
    
        ## filtrar por qualificação:
    assign(nome, pnad_filter %>% filter(qualif == q))
    
        ## aplicar desenho amostral:
    assign(nome, desenho(get(nome)))


        ## Correção de Heckman / Occupational Choice Model:

            ## 1ª etapa:
    assign(reg, svyglm(probit, family = quasibinomial(link = "probit"), design = get(nome), subset = (qualif == q)))   # rodar modelo de escolha ocupacional;
    mills = dnorm(get(reg)$linear.predictors) / pnorm(get(reg)$linear.predictors)                                      # calcular inversa de mills;
    assign(nome, update(get(nome), mills = mills))                                                                     # inserir inversa de mills no desenho amostral.

            ## 2ª etapa:
    assign(reg2, svyglm(mqo, design = get(nome), subset = (pea == 1 & qualif == q)))                                   # rodar MQO com inversa de mills.

    
        ## exportar resultados das regressões:
    result = capture.output(stargazer(get(reg), get(reg2), type = "html",
            title =  paste0("Resultados das regressões para qualif == ",q," (",i,")"),
            align = T, out = paste0("output/raw/Resultados das regressões para qualif ==",q," (",i,").html")))


        ## Calcular variáveis preditas:

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
        mutate(trab_new = ifelse(seq_len(nrow(get(nome))) <= round(get(desemp) * nrow(get(nome))), 0, 1),
            lnrh_new = case_when(trab_new == 1 ~ lnrh, T ~ 0)))
}


#--- RODAR FUNÇÕES ---

# Benchmarking:
for (q in 1:3) {
    bench = paste0("bench_",q)
    assign(bench, microssimulacao(mqo, q, "benchmarking", desemp))
}

    ## retornar à base original:
benchmarking = retorno(bench_1, bench_2, bench_3)


# Integração top-down:
for (q in 1:3) {
    integr = paste0("integr_",q)
    assign(integr, microssimulacao(mqo_sim3, q, "integração", desemp_new))
}

    ## retornar à base original:
integracao = retorno(integr_1, integr_2, integr_3)


#--- CALCULAR POBREZA E DESIGUALDADE DE RENDA ---

# Criar survey adequado:
bench_design = convey_prep(desenho(benchmarking))
integr_design = convey_prep(desenho(integracao))
bench_lista  = list()
integr_lista  = list()


# Criar função:

    ## FGT:
fgt = function(x, df, q, abs_thresh) {
  return(svyfgt(~rfpc_new, design = subset(df, qualif == x), g = q, abs_thresh = abs_thresh, na.rm = TRUE))
}

    ## Gini:
gini = function(g, df) {
  return(svygini(~rfpc_new, design = subset(df, qualif == g), na.rm = TRUE))
}


# linhas de pobreza:
ext = 126.79             # linha de pobreza extrema  (U$1,90 para valores de 12/2015);
abs = 367.02             # linha de pobreza absoluta (U$5,50 para valores de 12/2015);


# Aplicar função:

    ## Benchmarking:
for (i in 1:3) {

    ## FGT0 (headcount ratio)
  bench_lista$fgt0_ext_[i] = fgt(i, bench_design, 0, ext)
  bench_lista$fgt0_abs_[i] = fgt(i, bench_design, 0, abs)
  
    ## FGT1 (poverty gap)
  bench_lista$fgt1_ext_[i] = fgt(i, bench_design, 1, ext)
  bench_lista$fgt1_abs_[i] = fgt(i, bench_design, 1, abs)
  
    ## FGT2 (squared poverty gap)
  bench_lista$fgt2_ext_[i] = fgt(i, bench_design, 2, ext)
  bench_lista$fgt2_abs_[i] = fgt(i, bench_design, 2, abs)
  
    ## índice de Gini:
  bench_lista$gini_[i]     = gini(i, bench_design)
}

    ## Integração:
for (i in 1:3) {

    ## FGT0 (headcount ratio)
  integr_lista$fgt0_ext_[i] = fgt(i, integr_design, 0, ext)
  integr_lista$fgt0_abs_[i] = fgt(i, integr_design, 0, abs)
  
    ## FGT1 (poverty gap)
  integr_lista$fgt1_ext_[i] = fgt(i, integr_design, 1, ext)
  integr_lista$fgt1_abs_[i] = fgt(i, integr_design, 1, abs)
  
    ## FGT2 (squared poverty gap)
  integr_lista$fgt2_ext_[i] = fgt(i, integr_design, 2, ext)
  integr_lista$fgt2_abs_[i] = fgt(i, integr_design, 2, abs)
  
    ## índice de Gini:
  integr_lista$gini_[i]     = gini(i, integr_design)
}


#--- EXPORTAR RESULTADOS ---
wb = createWorkbook()
addWorksheet(wb, sheetName = "Benchmarking")
addWorksheet(wb, sheetName = "Integração")
writeData(wb, sheet = "Benchmarking", x = bench_lista,  startCol = 2, startRow = 3, colNames = T)
writeData(wb, sheet = "Integração",   x = integr_lista, startCol = 2, startRow = 3, colNames = T)
saveWorkbook(wb, file = "output/raw/resultados.xlsx", overwrite = T)


#--- DROPAR RESÍDUO ---
rm(list=setdiff(ls(), c("bench_design", "integr_design",
                        "bench_lista",  "integr_lista")))


