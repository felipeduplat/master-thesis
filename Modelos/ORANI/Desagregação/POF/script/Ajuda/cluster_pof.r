if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, rio, factoextra, NbClust, FactoMineR, geobr)

# dirs
data_path <- "../data"

# dados
geo_estados <- read_state(year = 2018, showProgress = FALSE)
consumo <- import(file.path(data_path, "consumo_alimentar.rds")) %>%
    mutate(
        codigo = round(V9001/100), # coloca em 5 digitos o cod dos alimentos
        id_fam = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC) # cria uma variável para identificar famílias
    )
morador <- import(file.path(data_path, "morador.rds")) %>%
    mutate(
        id_fam = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM, NUM_UC),
        id_dom = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM)
        )
domicilio <- import(file.path(data_path, "domicilio.rds")) %>%
    mutate(id_dom = paste0(ESTRATO_POF, TIPO_SITUACAO_REG, COD_UPA, NUM_DOM))
tradutor_alim <- import(file.path(data_path, "tradutor_alimentacao.xls"))

# juntando a tabela de consumo com o tradutor para especificação dos alimentos
# excluindo denominações regionais e sinônimos
consumo_tr <- consumo %>%
    left_join(tradutor_alim, by = c("codigo"="Codigo"))

# merge do consumo com características do domicilio e morador
morador_dom <- morador %>%
    left_join(domicilio, by = "id_dom")

consumo_dom <- consumo_tr %>%
    left_join(morador_dom, by = "id_fam")

#################################################################################
consumo_dom %>%
    filter(V0306 == 1) %>%
    group_by(id_fam) %>%
    reframe(
        educ_pref = unique(ANOS_ESTUDO),
        idade_pref = unique(V0403),
        renda_pc = unique(PC_RENDA_MONET)
    ) %>%
    right_join(consumo_dom, by = "id_fam") -> consumo_dom

gc()

consumo_dom %>%
    group_by(id_fam, Nivel_2, Descricao_2) %>%
    reframe(
        qtd = sum(ENERGIA_KCAL),
        renda = unique(renda_pc),
        educacao = unique(educ_pref),
        idade = unique(idade_pref)
    ) %>%
    pivot_wider(names_from = c(Nivel_2, Descricao_2), values_from = qtd, values_fill = 0) %>%
    filter(`106_Frutas` != 0) %>%
    mutate(q_renda = as_factor(ntile(renda, 5))) %>%
    ggplot(aes(q_renda, log(`106_Frutas`))) +
    geom_boxplot()

# a nivel estadual e por tipo de situação
# somando consumo (gramas) e colocando as variáveis na coluna
wide_consumo <- consumo_dom %>%
    group_by(UF, TIPO_SITUACAO_REG, Nivel_2, Descricao_2) %>%
    reframe(
        qtd = mean(QTD),
        renda = mean(renda_pc),
        educacao = mean(educ_pref),
        idade = mean(idade_pref)
    ) %>%
    pivot_wider(names_from = c(Nivel_2, Descricao_2), values_from = qtd, values_fill = 0) %>%
    #select(!id_fam) %>%
    select(!ends_with("NA_NA")) %>%
    mutate_at("TIPO_SITUACAO_REG", ~if_else(.x == 2,0,1)) %>%
    left_join(geo_estados, by = c("UF"="code_state")) %>%
    mutate(UFTIPO = paste0(name_state, TIPO_SITUACAO_REG)) %>%
    select(!code_region)

wide_consumo <- wide_consumo %>%
    group_by(UFTIPO) %>%
    summarize_if(is.numeric, mean) %>%
    ungroup %>%
    filter(!UFTIPO %in% c("Distrito Federal1", "São Paulo1")) %>%
    tibble::column_to_rownames("UFTIPO")


wide_consumo_s <- wide_consumo %>%
    select(-c(UF, TIPO_SITUACAO_REG))

# estatísticas descritivas
summary(wide_consumo_s)

# matriz de correlação
wide_consumo_s %>%
    cor %>%
    corrplot::corrplot(.,type = "lower")

cor(wide_consumo_s$renda, wide_consumo_s$`106_Frutas`)

# análise hierárquica
dist_e <- dist(wide_consumo_s, method = "euclidean")

ward_d <- hclust(d = dist_e, method = "ward.D2")

cor(dist_e, cophenetic(ward_d))

avg_d <- hclust(dist_e, method = "average")

cor(dist_e, cophenetic(avg_d))

# dendograma
fviz_dend(avg_d, cex = 0.5)

nb <- NbClust(wide_consumo_s, distance = "euclidean", method = "average", index = "all")

nb$Best.nc

fviz_dend(
  avg_d,
  k = 6,
  cex = 0.5,
  color_labels_by_k = TRUE,
  rect = T
)

# usando PCA
acp = PCA(wide_consumo_s, ncp = Inf)

hcpc <- HCPC(acp, nb.clust = -1)

plot.HCPC(hcpc, choice = "bar", title = "")

hcpc[["desc.var"]][["quanti"]][["1"]]
hcpc[["desc.var"]][["quanti"]][["2"]]
hcpc[["desc.var"]][["quanti"]][["3"]]

# não hierárquico
set.seed(992)

k_mean <- kmeans(scale(wide_consumo_s), 3, nstart = 30)

fviz_cluster(
    k_mean, data = scale(wide_consumo_s), ellipse.type = "euclid",
    star.plot = TRUE, repel = TRUE, ggtheme = theme_minimal()
)

k_mean$cluster

m_wide_consumo <- cbind(wide_consumo, cluster=k_mean$cluster)

# mapa
#ggplot(m_wide_consumo) + # base dos dados
#  geom_sf(aes(fill = code_state, col = code_state)) + # dados a serem plotados
#  theme(legend.position = c(.9,.7)) + # posição da legenda
#  labs(title = "")
wide_consumo %>%
    cbind(cluster = k_mean$cluster) %>%
    left_join(geo_estados, by = c("UF"="code_state")) %>%
    filter(TIPO_SITUACAO_REG == 0) %>%
    mutate(cluster = as_factor(cluster)) %>%
    ggplot() +
    geom_sf(aes(fill = cluster, geometry = geom)) +
    theme(legend.position = c(.9,.7))
