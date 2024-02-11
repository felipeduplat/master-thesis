
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
pacman::p_load(bit64,
               data.table,
               descr,
               readxl,
               tidyverse,
               survey,
               fastDummies,
               readxl,
               DescTools)



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


#--- TRADUTOR ---
SCN68 = read_excel("dados/auxiliares/SCN68.xlsx", sheet = 1)


#--- UNIR BASES ---
pnad = merge(pnad_pes, pnad_dom, 
             by = c("v0101", "uf", "v0102", "v0103"),
             all.x  = T) %>%
       left_join(SCN68, by = "v9907")



#--- ORGANIZAR DADOS -----------------------

#--- ARRUMAR BASE ---
pnad_clean = pnad %>%
       rename(peso_pes = v4729, peso_fam = v4732, peso_dom = v4611,
              projpop  = v4609, strat = v4617, psu = v4618, rfpc = v4742) %>%
       mutate(v4718    = case_when(v4718 >= 999999999 ~ NA_real_, T ~ v4718),
              v4720    = case_when(v4720 >= 999999999 ~ NA_real_, T ~ v4720),
              rfpc     = case_when(rfpc  >= 999999999 ~ NA_real_, T ~ rfpc)) 



#--- PARÂMETROS UTILIZADOS ---

# Taxa de desemprego (PNAD contínua Anual 2015):
#https://sidra.ibge.gov.br/tabela/4562#resultado
desemprego = 0.089

# Simulação 03:
sal_sim3 = read_excel("dados/auxiliares/sim3.xlsx", sheet = 1)
emp_sim3 = read_excel("dados/auxiliares/sim3.xlsx", sheet = 2)

# taxa de desemprego após o choque:
desemp_1 = desemprego * (1 + emp_sim3$sim3_05[1] / 100)
desemp_2 = desemprego * (1 + emp_sim3$sim3_05[2] / 100)
desemp_3 = desemprego * (1 + emp_sim3$sim3_05[3] / 100)


#--- CRIAR VARIÁVEIS ---
pnad_clean = pnad_clean %>%
  mutate(id                 = row_number(),                                              # identificador;
         id_fam             = paste0(v0101, uf, v0102, v0103),                           # id das famílias;
         qualif             = case_when(v4803  %in% 0:11  ~ 1,                           # =1 se não tem qualificação;
                                        v4803  %in% 12:15 ~ 2,                           # =2 se tem ensino médio;
                                        v4803    >= 16    ~ 3),                          # =3 se tem ensino superior ou mais;
         trab               = if_else(v4805   == 1, 1, 0),                               # =1 se ocupado;
         pea                = if_else(v4704   == 1, 1, 0),                               # =1 se economicamente ativo;
         casado             = if_else(v4011   == 1, 1, 0),                               # =1 se casado;
         filhos             = if_else(v0402   == 3 & v8005 <=6, 1, 0),                   # =1 se filho com até seis anos;
         chefe_fam          = if_else(v0402   == 1, 1, 0),                               # =1 se chefe de família;
         negro              = if_else(v0404 %in% c(4,8), 1, 0),                          # =1 se negro;
         mulher             = if_else(v0302   == 4, 1, 0),                               # =1 se mulher;
         metro              = if_else(v4727   == 1, 1, 0),                               # =1 se está numa região metropolitana;
         rural              = if_else(v4728 %in% 4:8, 1, 0),                             # =1 se está na zona rural;
         educ               = v4803 - 1,                                                 # anos de estudo ajustado;
         experp             = v8005 - v9892 - 6,                                         # experiência potencial;
         experp2            = experp * experp,                                           # experiência potencial quadrática;
         tmes               = v9058 * 4,                                                 # horas trabalhadas no mês;
         lnrendah           = log(v4718 / tmes),                                         # log da renda-hora dos indivíduos;
         lnrendah           = case_when(lnrendah < 0 ~ NA_real_, T ~ lnrendah),          # transformar <= 0 em NA;
         lnrendah           = case_when(is.na(lnrendah) ~ 0, T ~ lnrendah),              # transformar todos os NAs em zero;
         lnrendah           = case_when(trab == 0 ~ lnrendah == NA_real_, T ~ lnrendah), # transformar log da renda-hora dos desempregados em NA;
         lnrendah_sim3_1    = lnrendah * (1 + sal_sim3$sim3_05[1] / 100),                        # Log da renda-hora após o choque da terceira simulação do ORANIG-BR (w1lab_io);
         lnrendah_sim3_2    = lnrendah * (1 + sal_sim3$sim3_05[2] / 100),                        # Log da renda-hora após o choque da terceira simulação do ORANIG-BR (w1lab_io);
         lnrendah_sim3_3    = lnrendah * (1 + sal_sim3$sim3_05[3] / 100),                        # Log da renda-hora após o choque da terceira simulação do ORANIG-BR (w1lab_io);
         out_renda = case_when(v4720 - v4718 < 0 ~ 0,                                    # renda de todas as outras fontes, exceto trabalho;
                               is.na(v4720)      ~ v4718,
                               is.na(v4718)      ~ v4720,
                               T                 ~ v4720 - v4718),
         setor              = case_when(v4816 %in% c(7,9:11) ~ 6, T ~ v4816)) %>%        # criando setor de serviços;
  dummy_cols(select_columns = "uf") %>%                                                  # dummy para cada estado brasileiro (SP como default);
  dummy_cols(select_columns = "setor") %>%                                               # dummy para cada setor produtivo (ind. de transf. como default);
  group_by(id_fam) %>%
  mutate(nfam = n(),
         nfilhos = sum(filhos, na.rm = F)) %>%
  ungroup() %>%
  mutate(nfilhos = if_else(v0402 %in% c(1,2), nfilhos, 0),                               # quantidade de filhos por chefe de família.
         filtro  = as.integer(if_all(c(trab, educ, experp, metro, rural, negro, mulher,
                                       chefe_fam, rfpc, nfilhos, setor, uf), ~ !is.na(.)))) %>%
  select(peso_pes, peso_fam, peso_dom, projpop, strat, psu, SCN68,
         v4718, v4720, rfpc, id:filtro, -setor_3, -setor_NA, -uf_35)


#--- CRIAR QUANTIS DE RENDA ---
quantil = pnad_clean %>%
       filter(!is.na(rfpc)) %>%
       group_by(id_fam, rfpc) %>%
       reframe(rfpc = unique(rfpc)) %>%
       mutate(quantil = cut(rfpc, breaks = quantile(unique(rfpc), probs = seq(0,1,0.01), na.rm = T),
                        labels = F,
                        include.lowest = T))

pnad_clean = left_join(pnad_clean, quantil, by = "id_fam") %>%
       select(-rfpc.x) %>% rename(rfpc = rfpc.y)


#--- FILTRO DA INVERSA DE MILLS ---
pnad_filter = pnad_clean %>%
       subset(filtro == 1) %>%
       ungroup()


#--- DROPAR RESÍDUO ---
rm(dicpes, end_pes, dicdom, end_dom, SCN68,
   emp_sim3, sal_sim3, pnad_pes, pnad_dom,
   quantil, pnad)


#--- SALVAR BASE ---
save.image("dados/base.RData")


