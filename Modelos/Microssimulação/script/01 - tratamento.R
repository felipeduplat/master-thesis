
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
pacman::p_load(bit64,
               data.table,
               descr,
               readxl,
               tidyverse,
               survey,
               fastDummies)



#--- BAIXAR DADOS --------------------------

#--- PNAD PESSOAS ---
dicpes  = read_excel("docs/dicpes.xlsx")
end_pes = dicpes$inicio + dicpes$tamanho - 1
fwf2csv(fwffile = "dados/raw/PES2015.txt", csvfile = "dados/raw/dadospes.csv", names = dicpes$variavel, begin = dicpes$inicio, end = end_pes)
pnad_pes = fread(input = "dados/raw/dadospes.csv", sep = "auto", sep2 = "auto", integer64 = "double") %>%
           mutate(across(where(is.character), as.numeric)) %>% 
           rename_with(., tolower, everything())


#--- PNAD DOMICÍLIOS ---
dicdom  = read_excel("docs/dicdom.xlsx")
end_dom = dicdom$inicio + dicdom$tamanho - 1
fwf2csv(fwffile = "dados/raw/DOM2015.txt", csvfile = "dados/raw/dadosdom.csv", names = dicdom$variavel, begin = dicdom$inicio, end = end_dom)
pnad_dom = fread(input = "dados/raw/dadosdom.csv", sep = "auto", sep2 = "auto", integer64 = "double") %>%
           mutate(across(where(is.character), as.numeric)) %>% 
           rename_with(., tolower, everything())


#--- UNIR BASES ---
pnad = merge(pnad_pes, pnad_dom, 
             by = c("v0101", "uf", "v0102", "v0103"),
             all.x  = T)



#--- ORGANIZAR DADOS -----------------------

#--- ARRUMAR BASE ---
pnad_clean = pnad %>%
  rename(peso_pes = v4729, peso_fam = v4732, peso_dom = v4611,
         projpop = v4609, strat = v4617, psu = v4618, rdpc = v4742) %>%
  mutate(v4718 = case_when(v4718 == 999999999 ~ NA_real_, T ~ v4718))


#--- CRIAR DUMMIES ---
pnad_clean = pnad_clean %>%
  mutate(id_fam    = paste0(v0101, uf, v0102, v0103),                      # id das famílias;
         qualif = case_when(v4803  %in% 0:4  ~ 1,                          # =1 se não tem qualificação;
                            v4803  %in% 5:12 ~ 2,                          # =2 se tem ensino médio;
                            v4803    >= 13   ~ 3),                         # =3 se tem ensino superior ou mais;
         trab      = if_else(v9001   == 1, 1, 0),                          # =1 se trabalha;
         nea       = if_else(v4704   == 2, 1, 0),                          # =1 se não economicamente ativo;
         casado    = if_else(v4011   == 1, 1, 0),                          # =1 se casado;
         filhos    = if_else(v0402   == 3, 1, 0),                          # =1 se filho;
         negro     = if_else(v0404 %in% c(4,8), 1, 0),                     # =1 se negro;
         mulher    = if_else(v0302   == 4, 1, 0),                          # =1 se mulher;
         metro     = if_else(v4727   == 1, 1, 0),                          # =1 se está numa região metropolitana;
         rural     = if_else(v4728 %in% 4:8, 1, 0),                        # =1 se está na zona rural;
         educ      = v4803 - 1,                                            # anos de estudo ajustado;
         experp    = v8005 - v9892 - 6,                                    # experiência potencial;
         tmes      = v9058 * 4,                                            # horas trabalhadas no mês;
         rendah    = v4718 / tmes,                                         # renda-hora dos indivíduos;
         lnrendah  = log(v4718 / tmes),                                    # log da renda-hora dos indivíduos;
         lnrendah  = case_when(lnrendah <= 0 ~ NA_real_, T ~ lnrendah),    # transformar <= 0 em NA;
         out_renda = v4720 - 4719,                                         # renda de outras fontes (exceto trabalho);
         setor     = case_when(v4816 %in% c(7,9:11) ~ 6, T ~ v4816)) %>%   # criando setor de serviços;
  dummy_cols(select_columns = "uf",    remove_selected_columns = T)  %>%   # dummy para cada estado brasileiro (SP como default);
  dummy_cols(select_columns = "setor", remove_selected_columns = T)  %>%   # dummy para cada setor produtivo (ind. de transf. como default).
  group_by(id_fam) %>%
  mutate(nfilhos = sum(filhos, na.rm = F)) %>%
  ungroup() %>%
  mutate(nfilhos  = if_else(v0402 %in% 1:2,  nfilhos, 0),                  # qtd. de filhos de chefes de família e cônjuges;
         educ_cc  = if_else(v0402 %in% 1:2, educ   , NA_real_),            # anos de estudo ajustado de chefes e cônjuges;
         sexo_cc  = if_else(v0402 %in% 1:2, sexo   , NA_real_),            # sexo de chefes e cônjuges;
         idade_cc = if_else(v0402 %in% 1:2, v8005  , NA_real_)) %>%        # idade de chefes e cônjuges.
  select(peso_pes, peso_fam, peso_dom, projpop, strat,
         psu, rpc, id_fam:idade_cc, -setor_3, -uf_35)



#--- CRIAR DESENHO AMOSTRAL ---

# configuraçãoes:
options(survey.lonely.psu = "adjust")

# desenho amostral:
pop        = data.frame(projpop = unique(pnad_clean$projpop), freq = unique(pnad_clean$projpop))
pre_design = svydesign(id = ~psu, strata = ~strat, data = pnad_clean, weights = ~peso_dom, nest = T)
design     = postStratify(design = pre_design, strata = ~projpop, population = pop)


#--- DROPAR RESÍDUO ---
rm(dicpes, end_pes, dicdom, end_dom, pnad_pes,
   pnad_dom,pnad, pnad_clean, pop, pre_design)


#--- SALVAR BASE ---
save.image("dados/base.RData")


