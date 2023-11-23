if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, srvyr, tidyr, purrr, rio, factoextra)

# id_dom = ESTRATO_POF + TIPO_SITUACAO_REG + COD_UPA + NUM_DOM
# id_fam = ESTRATO_POF + TIPO_SITUACAO_REG + COD_UPA + NUM_DOM + NUM_UC

# dirs
data_path <- "../data"
tradutor <- "../tradutores"

# dados
despesa_inv <- import(file.path(data_path, "despesa_individual.rds"))
consumo <- import(file.path(data_path, "consumo_alimentar.rds"))
caderneta_col <- import(file.path(data_path, "caderneta_coletiva.rds"))
morador <- import(file.path(data_path, "morador.rds"))
domicilio <- import(file.path(data_path, "domicilio.rds"))
tradutor_alim <- import(file.path(tradutor, "tradutor_alimentacao.xls"))

# merge consumo com características do domicilio e morador
morador_dom <- morador %>%
    mutate(
        id_uc = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC),
        id_dom = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM)
        ) %>%
    left_join(domicilio, by = c("ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM"))

consumo_dom <- consumo %>%
    left_join(morador_dom, by = c("ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM", "NUM_UC"))

# caderneta coletiva dados sobre alimentação
cad_alimento <- caderneta_col %>%
    mutate(
        codigo = round(V9001/100), # elimina últimos dígitos de sinônimos
        valor_mensal = (V8000_DEFLA * FATOR_ANUALIZACAO * PESO_FINAL)/12
    ) %>%
    filter(codigo < 86001 | codigo > 89999)

# despesa individual dados sobre alimentação
desp_alimento <- despesa_inv %>%
    mutate(
        codigo = round(V9001/100),
        valor_mensal = (V8000_DEFLA * FATOR_ANUALIZACAO * PESO_FINAL)/12
    ) %>%
    filter(QUADRO == 24 | codigo %in% c(41001, 48018, 49075, 49089))

# empilha os dois dataframes
desp_cad <- bind_rows(cad_alimento, desp_alimento)

# numero de domicilios, numero UC (unidade de consumo)!
n_dom_pop <- morador %>%
    group_by(UF, ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC) %>%
    reframe(peso_dom = unique(PESO_FINAL)) %>%
    reframe(sum(peso_dom)) %>%
    pull

morador_desp <- right_join(desp_cad, morador, by = c("ESTRATO_POF", "TIPO_SITUACAO_REG", "COD_UPA", "NUM_DOM", "NUM_UC"), relationship = "many-to-many")

morador %>%
    group_by(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC) %>%
    reframe(a = unique(PESO_FINAL)) %>%
    reframe(sum(a))

morador_desp %>%
    group_by(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC) %>%
    reframe(a=unique(PESO_FINAL.y)) %>%
    reframe(sum(a))

names(morador_desp)

# merge com o tradutor de tabelas
desp_cad_tr <- left_join(desp_cad, tradutor_alim, by = c("codigo"="Codigo"))

desp_cad_tr %>%
    group_by(Nivel_1) %>%
    reframe(gasto_medio_mensal = sum(valor_mensal)/n_dom_pop)

despesa_inv %>%
    mutate(valor_mensal = (V8000_DEFLA * FATOR_ANUALIZACAO * PESO_FINAL)/12) %>%
    filter(round(V9001/1000) == 3800) %>%
    group_by(UF) %>%
    reframe(a = sum(valor_mensal)/n_dom_pop) %>%
    arrange(desc(a)) %>%
    print(n = Inf)

### caderneta de alimento somente 
cad_alimento_tr <- cad_alimento %>%
    left_join(tradutor_alim, by = c("codigo"="Codigo"))

cad_alimento_tr %>%
    mutate(id_fam = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC)) %>%
    group_by(id_fam, Nivel_3) %>%
    filter(Nivel_3 == 1011) %>%
    summarise(soma=sum(QTD_FINAL*FATOR_ANUALIZACAO*PESO_FINAL)/sum(PESO_FINAL)) %>%
    summary

wide_cad <- cad_alimento_tr %>%
    mutate(
        id_fam = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC)
    ) %>%
    group_by(id_fam, Nivel_3) %>%
    reframe(
        descri = unique(Descricao_3),
        kg_pc_a = sum(QTD_FINAL * FATOR_ANUALIZACAO * PESO_FINAL)/sum(PESO_FINAL)
    ) %>%
    pivot_wider(names_from = c(Nivel_3, descri), values_from = kg_pc_a, values_fill = 0) %>%
    select(!id_fam)

wide_cad_a <- wide_cad %>%
    select(!ends_with("NA_NA"))

summary(wide_cad_a)

# autovalores e autovetores
cor_cad <- cor(wide_cad_a)

var_total <- sum(diag(cor_cad))

ev_cad <- eigen(cor_cad)$values

evec_cad <- eigen(cor_cad)$vectors

eigen(cor_cad)

head(evec_cad)

pct_exp <- (ev_cad/var_total)*100

# function pca
pca_cad <- prcomp(wide_cad_a, scale = T, center = T)

summary(pca_cad)

screeplot(pca_cad, type = "l", npcs = 60, main = "autovalores das variáveis")
abline(h = 1, lty = 5)

pca_var <- pca_cad$sdev^2

pvar <- pca_var/sum(pca_var)*100

pvar %>%
    cumsum

plot(pvar, xlab = "", ylab = "% explicada", type = "b", main = "Proporção explicada")

biplot(pca_cad)

fviz_eig(pca_cad, addlabels = T, ncp = 20)

fviz_contrib(pca_cad, choice = "var", axes = 1, top = 10, title = "dim 1 contrib")

fviz_pca_ind(pca_cad, geom.ind = "point", pointshape = 21,
    pointsize = 2, col.ind = "black",
    palette = "jco", addEllipses = TRUE, label = "var",
    col.var = "black", repel = TRUE)


##
