
####### UNIVERSIDADE FEDERAL DO PARANÁ                         #######
####### PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             #######
####### DOCENTE: VINÍCIUS DE ALMEIDA VALE                      #######
####### DISCENTE: FELIPE DUPLAT LUZ                            #######

### DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

#--- DEFINIR DIRETÓRIO ---
setwd("D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/POF")

#--- CARREGAR OS PACOTES ---
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse,
               curl,
               utils)



#--- BAIXAR DADOS ------------------

# POF 2008-2009:
path = "dados/POF 2008-2009/raw/- pof_08-09.zip"
if (file.exists(path)) {print("POF 2008-2009 já baixada.")} else {
  curl_download("https://ftp.ibge.gov.br/Orcamentos_Familiares/Pesquisa_de_Orcamentos_Familiares_2008_2009/Microdados/Dados_20220413.zip",
                "dados/POF 2008-2009/raw/- pof_08-09.zip")
}
unzip(zipfile = "dados/POF 2008-2009/raw/- pof_08-09.zip", exdir = "dados/POF 2008-2009/raw/")

# POF 2017-2018:
path = "dados/POF 2017-2018/raw/- pof_17-18.zip"
if (file.exists(path)) {print("POF 2017-2018 já baixada.")} else {
  curl_download("https://ftp.ibge.gov.br/Orcamentos_Familiares/Pesquisa_de_Orcamentos_Familiares_2017_2018/Microdados/Dados_20230713.zip",
                "dados/POF 2017-2018/raw/- pof_17-18.zip")
}
unzip(zipfile = "dados/POF 2017-2018/raw/- pof_17-18.zip", exdir = "dados/POF 2017-2018/raw")



#--- CRIAR RDS: POF 2008-2009 ------------------

# domicílio:
path = "dados/POF 2008-2009/domicilio.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_DOMICILIO_S.txt",
                   widths = c(2,2,3,1,2,2,14,14,4,4,2,2,2,2,2,2,2,2,2,
                              2,2,2,2,2,2,2,1,1,1,16,16,16,1,1,1,1,1,1,
                              1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","ESTRATO_POF","PESO",
                                 "PESO_FINAL","PERIODO_REAL","QTD_MORADOR_DOMC","QTD_UC",
                                 "QTD_FAMILIA","V0202","V0203","V0204","V0205","V0206","V0207",
                                 "V0208","V0209","V0210","V0211","V0219","V0221","V0222",
                                 "V0223","IMPUT_QTD_COMODOS","IMPUT_QTD_BANHEIROS","IMPUT_ESGOTO",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL","V0224",
                                 "V02011","V02012","V02013","V02014","V02015","V02016","V02017",
                                 "V02018","V02019","V0212","V0213","V0214","V02151","V02152",
                                 "V02161","V02162","V02163","V02164","V02165","V02166","V02167",
                                 "V02171","V02172","V02173","V02174","V02175","V02181","V02182",
                                 "V02183","V02184","V02185","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# morador:
path = "dados/POF 2008-2009/morador.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_MORADOR_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,2,2,2,2,2,2,
                              4,3,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,
                              2,2,2,2,2,16,16,16,2,5,5,5,5,5,5,5,
                              16,8,2,2,2,2,2,2,2,2,2,2,2,2,2,6,1,
                              1,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "V0306","NUM_FAMILIA","COND_FAMILIA",
                                 "V0401","V04041","V04042","V04043","IDADE_ANOS","IDADE_MES",
                                 "IDADE_DIA","V0405","V0418","V0419","V0420","V0421","V0422",
                                 "V0425","V0426","V0427","V0428","ANOS_ESTUDO","V0429","V0441",
                                 "V0442","V0443","V0444","V0445","V0446","RENDA_MONETARIA",
                                 "RENDA_NAO_MONETARIA","RENDA_TOTAL","V0406","V0433",
                                 "V0434","V0436","V0437","COMPRIMENTO_IMPUTADO","ALTURA_IMPUTADA",
                                 "PESO_IMPUTADO","RENDA_MONET_PC","V04301","V0438","V0439",
                                 "V0440","V0447","TEVE_NECESSIDADE_MEDICAMENTO",
                                 "PRECISOU_ALGUM_SERVICO","V0407","V0408","V0415","V0416",
                                 "V0417","V0423","V0424","COD_UPA","TIPO_SITUACAO_REG",
                                 "NIVEL_INSTRUCAO_MORADOR","NIVEL_INSTRUCAO_PESS_REF"),
                   dec=".") %>% 
            rename_with(., tolower, everything()), path)
}

# morador_imput:
path = "dados/POF 2008-2009/morador_imput.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_MORADOR_IMPUT_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,16,16,16,1,1,1,1,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "COD_SABE_LER","COD_FREQ_ESCOLA","COD_CURSO_FREQ",
                                 "COD_DUR_PRIMEIRO_GRAU_EH","COD_SERIE_FREQ",
                                 "COD_NIVEL_INSTR","COD_DUR_PRIMEIRO_GRAU_ERA",
                                 "COD_SERIE_COM_APROVACAO","COD_CONCLUIU_CURSO",
                                 "COD_TEM_CARTAO","COD_EHTITULAR_CARTAO","COD_TEM_CHEQUE",
                                 "COD_EHTITULAR_CONTA","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                                 "RENDA_TOTAL","COD_TEM_PLANO","COD_EHTITULAR",
                                 "COD_NUM_DEPENDENTE","COD_LEITE_MATERNO","MESES_LEITE_MATERNO"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# condições de vida:
path = "dados/POF 2008-2009/condicoes_vida.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_CONDICOES_DE_VIDA_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,1,1,1,16,16,16,11,11,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "V6101","V6104","V6105","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                                 "RENDA_TOTAL","V6102","V6103","V6106","V61071","V61072",
                                 "V61073","V610710","V61074","V61075","V61076","V61077","V61078",
                                 "V61079","V610711","V61081","V61082","V61083","V61084","V61085",		        
                                 "V61086","V61087","V61088","V61089","V6109","V61101","V61102", 		    
                                 "V61103","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# inventário:
path = "dados/POF 2008-2009/inventario.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_INVENTARIO_S.txt",
                   widths = c(2,2,3,1,2,1,2,14,14,2,5,2,4,1,
                              2,2,16,16,16,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM",
                                 "NUM_UC","ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO",
                                 "COD_ITEM","V9005","V1404","V9012","V9002","COD_IMPUT",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                                 "V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# despesa - 90 dias:
path = "dados/POF 2008-2009/despesa_90d.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_DESPESA_90DIAS_S.txt",
                   widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,2,5,11,16,
                               2,16,16,16,4,5,5,14,2,5,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                                 "V9002","V8000","FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA",
                                 "VALOR_ANUAL_EXPANDIDO","COD_IMPUT","RENDA_MONETARIA",
                                 "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9005","V9007","V9009",                
                                 "QTD_FINAL","COD_IMPUT_QUANTIDADE","V9004","V9001",
                                 "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# despesa - 12 meses:
path = "dados/POF 2008-2009/despesa_12m.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_DESPESA_12MESES_S.txt",
                   widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,2,2,2,5,
                               11,16,2,16,16,16,5,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                                 "V9002","V8000","V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR",
                                 "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                                 "V9004","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# outras despesas:
path = "dados/POF 2008-2009/outras_despesas.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_OUTRAS_DESPESAS_S.txt",
                   widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,1,2,5,
                               11,16,2,16,16,16,5,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                                 "V9002","V8000","V9012","FATOR_ANUALIZACAO","DEFLATOR",
                                 "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                                 "V9004","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# serviços domésticos:
path = "dados/POF 2008-2009/servicos_domesticos.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_SERVICO_DOMS_S.txt",
                   widths = c(2,2,3,1,2,1,2,14,14,2,5,2,11,5,11,
                              1,2,2,2,5,11,11,16,16,2,2,16,16,16,
                              7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                                 "V9002","V8000","COD_INSS","V1904","V1905","V9010","V9011",
                                 "FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA","V1904_DEFLA",
                                 "VALOR_ANUAL_EXPANDIDO","VALOR_INSS_ANUAL_EXPANDIDO",
                                 "COD_IMPUT","COD_IMPUT_INSS","RENDA_MONETARIA",
                                 "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9001",
                                 "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# aluguel estimado:
path = "dados/POF 2008-2009/aluguel_estimado.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_ALUGUEL_ESTIMADO_S.txt",
                   widths = c(2,2,3,1,2,1,2,14,14,2,5,2,11,
                              2,2,2,5,11,16,2,16,16,16,7,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                                 "V9002","V8000","V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR",
                                 "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                                 "V9001","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# caderneta coletiva:
path = "dados/POF 2008-2009/caderneta_despesa.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_CADERNETA_DESPESA_S.txt",
                   widths = c(2,2,3,1,2,1,2,14,14,2,2,5,2,11,2,5,
                              11,16,2,16,16,16,2,8,5,10,5,5,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","NUM_GRUPO",
                                 "COD_ITEM","V9002","V8000","FATOR_ANUALIZACAO","DEFLATOR",
                                 "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                                 "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                                 "METODO_QUANTIDADE","QTD_FINAL","V9004","V9005","V9007",
                                 "V9009","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# despesa individual:
path = "dados/POF 2008-2009/despesa_individual.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_DESPESA_INDIVIDUAL_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,2,5,2,11,2,5,11,16,
                              2,16,16,16,2,5,2,2,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "NUM_QUADRO","COD_ITEM","V9002","V8000","FATOR_ANUALIZACAO",
                                 "DEFLATOR","V8000_DEFLA","VALOR_ANUAL_EXPANDIDO",
                                 "COD_IMPUT","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                                 "RENDA_TOTAL","V2905","V9004","V4104","V4105","V9001",
                                 "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}
# despesa com veículos:
path = "dados/POF 2008-2009/despesa_veiculo.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_DESPESA_VEICULO_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,2,5,2,11,
                              1,2,5,11,16,2,16,16,16,5,7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "NUM_QUADRO","COD_ITEM","V9002","V8000","V9012",
                                 "FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA",
                                 "VALOR_ANUAL_EXPANDIDO","COD_IMPUT","RENDA_MONETARIA",
                                 "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9004","V9001",
                                 "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# rendimento do trabalho:
path = "dados/POF 2008-2009/rendimento_trabalho.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_RENDIMENTOS_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,2,1,2,1,5,11,
                              2,2,1,5,11,5,11,5,11,2,5,11,11,11,
                              11,16,16,16,16,2,16,16,16,3,8,8,2,7,
                              3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "NUM_QUADRO","COD_TIPO_OCUP","V5303","V53042","COD_ITEM",
                                 "V8500","V9010","V9011","V5305","COD_ITEM_PREV","V53061",
                                 "COD_ITEM_IR","V53062","COD_ITEM_OUTRA","V53063",
                                 "FATOR_ANUALIZACAO","DEFLATOR","V8500_DEFLA","V53061_DEFLA",
                                 "V53062_DEFLA","V53063_DEFLA","VALOR_ANUAL_EXPANDIDO",
                                 "VALOR_PREV_ANUAL_EXPANDIDO","VALOR_IR_ANUAL_EXPANDIDO",
                                 "VALOR_OUTRAS_ANUAL_EXPANDIDO","COD_IMPUT","RENDA_MONETARIA",
                                 "RENDA_NAO_MONETARIA","RENDA_TOTAL","V53041","V53011",
                                 "V53021","COD_IMPUT_OCUP_ATIV","V9001","SEQ_LINHA",
                                 "COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>% 
            rename_with(., tolower, everything()), path)
}

# outros rendimentos:
path = "dados/POF 2008-2009/outros_rendimentos.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_OUTROS_RECI_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,14,14,2,5,11,11,
                              5,2,2,2,5,11,11,16,16,2,16,16,16,
                              7,3,6,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                                 "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                                 "NUM_QUADRO","COD_ITEM","V8500","V8501","COD_DEDUCAO",
                                 "V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR","V8500_DEFLA",
                                 "V8501_DEFLA","VALOR_ANUAL_EXPANDIDO","VALOR_DEDUCAO_ANUAL_EXPANDIDO",
                                 "COD_IMPUT","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                                 "RENDA_TOTAL","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# consumo alimentar:
path = "dados/POF 2008-2009/consumo_alimentar.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2008-2009/raw/T_CONSUMO_S.txt",
                   widths = c(2,2,3,1,2,1,2,2,15,15,2,1,2,8,
                              5,7,2,1,8,1,16,16,16,5,8,8,1),
                   na.strings=c(" "),
                   col.names = c("TIPO_REG", "COD_UF", "NUM_SEQ", "NUM_DV", "COD_DOM",
                                 "NUM_UC", "NUM_INFORMANTE", "NUM_EXT_RENDA", "FATOR_EXPANSAO1",
                                 "FATOR_EXPANSAO2", "NUM_QUADRO", "LOCAL", "HORARIO",
                                 "QTD_ITEM", "COD_UNIDADE", "COD_ITEM", "COD_PREPARACAO",
                                 "COD_IMPUT", "QTD_IMPUT", "UTILIZA_FREQUENTEMENTE",
                                 "RENDA_BRUTA_MONETARIA", "RENDA_BRUTA_NAO_MONETARIA",
                                 "RENDA_TOTAL", "COD_UNIDADE_MEDIDA2", "QTD_UNID_MED",
                                 "QTD_FINAL", "DIA_DA_SEMANA"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}



#--- CRIAR RDS: POF 2017-2018 ------------------

# domicílio:
path = "dados/POF 2017-2018/domicilio.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/DOMICILIO.txt",
                   widths = c(2,4,1,9,2,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "V0201", "V0202", 
                                 "V0203", "V0204", "V0205", "V0206", "V0207",
                                 "V0208", "V0209", "V02101", "V02102",
                                 "V02103", "V02104", "V02105", "V02111",
                                 "V02112", "V02113", "V0212", "V0213",
                                 "V02141", "V02142", "V0215", "V02161", 
                                 "V02162", "V02163", "V02164", "V0217", 
                                 "V0219", "V0220", "V0221", "PESO",
                                 "PESO_FINAL", "V6199"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# morador:
path = "dados/POF 2017-2018/morador.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/MORADOR.txt",
                   widths = c(2,4,1,9,2,1,2,2,1,2,2,4,3,1,1,
                              1,1,1,2,1,2,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,
                              2,1,2,14,14,10,1,20,20,20,20),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", 
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "COD_INFORMANTE",
                                 "V0306", "V0401", "V04021", "V04022", "V04023",
                                 "V0403", "V0404", "V0405", "V0406", "V0407",
                                 "V0408", "V0409", "V0410", "V0411", "V0412",
                                 "V0413", "V0414", "V0415", "V0416", 
                                 "V041711", "V041712", "V041721", "V041722",
                                 "V041731", "V041732", "V041741", "V041742",
                                 "V0418", "V0419", "V0420", "V0421", "V0422",
                                 "V0423", "V0424", "V0425", "V0426", "V0427",
                                 "V0428", "V0429", "V0430", "ANOS_ESTUDO",
                                 "PESO", "PESO_FINAL", "RENDA_TOTAL",
                                 "NIVEL_INSTRUCAO", "RENDA_DISP_PC","RENDA_MONET_PC",    
                                 "RENDA_NAO_MONET_PC","DEDUCAO_PC"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# qualidade de vida do morador:
path = "dados/POF 2017-2018/morador_quali_vida.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/MORADOR_QUALI_VIDA.txt",
                   widths = c(2,4,1,9,2,1,2,20,20,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,2,20,20,14,14),
                   na.strings=c(" "),
                   col.names = c("UF","ESTRATO_POF","TIPO_SITUACAO_REG","COD_UPA",           
                                 "NUM_DOM","NUM_UC","COD_INFORMANTE","CONTAGEM_PONDERADA",
                                 "FUNCAO_PERDA","V201","V202","V204","V205","V206",              
                                 "V207","V208","V209","V210","V211","V212","V214","V215",              
                                 "V216","V217","V301","V302","V303","V304","V305","V306",              
                                 "V307","V308","V401","V402","V403","V501","V502","V503",              
                                 "V504","V505","V506","V601","V602","V603","V604","V605",              
                                 "V606","V607","V608","V609","V610","V611","V701","V702",              
                                 "V703","V704","V801","V802","V901","V902","GRANDE_REGIAO",     
                                 "C1","C2","C3","C4","C5","C6","C7","RENDA_DISP_PC",     
                                 "RENDA_DISP_PC_SS","PESO","PESO_FINAL" ),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# aluguel estimado:
path = "dados/POF 2017-2018/aluguel_estimado.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/ALUGUEL_ESTIMADO.txt",
                   widths = c(2,4,1,9,2,1,2,7,2,10,2,2,12,10,1,2,14,14,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                                 "V9001", "V9002", "V8000", "V9010", "V9011",
                                 "DEFLATOR", "V8000_DEFLA", "COD_IMPUT_VALOR",
                                 "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# despesa coletiva:
path = "dados/POF 2017-2018/despesa_coletiva.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/DESPESA_COLETIVA.txt",
                   widths = c(2,4,1,9,2,1,2,2,7,2,4,10,2,2,1,
                              10,1,12,10,10,1,1,2,14,14,10,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                                 "SEQ", "V9001", "V9002", "V9005", "V8000",
                                 "V9010", "V9011", "V9012", "V1904",
                                 "V1905", "DEFLATOR", "V8000_DEFLA",
                                 "V1904_DEFLA", "COD_IMPUT_VALOR",
                                 "COD_IMPUT_QUANTIDADE", "FATOR_ANUALIZACAO",
                                 "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# serviço não monetário (POF 2):
path = "dados/POF 2017-2018/servico_nao_monetario_pof2.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/SERVICO_NAO_MONETARIO_POF2.txt",
                   widths = c(2,4,1,9,2,1,2,2,7,2,10,2,2,10,
                              1,12,10,10,1,2,14,14,10,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                                 "SEQ", "V9001", "V9002", "V8000", "V9010",
                                 "V9011", "V1904", "V1905", "DEFLATOR",
                                 "V8000_DEFLA", "V1904_DEFLA", "COD_IMPUT_VALOR",
                                 "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL","V9004"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# inventário:
path = "dados/POF 2017-2018/inventario.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/INVENTARIO.txt",
                   widths = c(2,4,1,9,2,1,2,2,7,2,
                              2,4,1,14,14,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                                 "SEQ", "V9001", "V9005", "V9002", "V1404",
                                 "V9012", "PESO", "PESO_FINAL","RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# caderneta coletiva:
path = "dados/POF 2017-2018/caderneta_coletiva.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/CADERNETA_COLETIVA.txt",
                   widths = c(2,4,1,9,2,1,2,3,7,2,10,12,
                              10,1,2,14,14,10,9,4,5,9,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                                 "SEQ", "V9001", "V9002", "V8000", "DEFLATOR",
                                 "V8000_DEFLA", "COD_IMPUT_VALOR",
                                 "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL",
                                 "V9005", "V9007", "V9009", "QTD_FINAL","V9004"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# despesa individual:
path = "dados/POF 2017-2018/despesa_individual.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/DESPESA_INDIVIDUAL.txt",
                   widths = c(2,4,1,9,2,1,2,2,2,7,2,10,2
                              ,2,1,1,1,12,10,1,2,14,14,10,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFORMANTE", "QUADRO", "SEQ", "V9001",
                                 "V9002", "V8000", "V9010", "V9011", "V9012",
                                 "V4104", "V4105", "DEFLATOR", "V8000_DEFLA",
                                 "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                                 "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# serviço não monetário (POF 4):
path = "dados/POF 2017-2018/servico_nao_monetario_pof4.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/SERVICO_NAO_MONETARIO_POF4.txt",
                   widths = c(2,4,1,9,2,1,2,2,2,7,2,10,2,2,
                              1,1,12,10,1,2,14,14,10,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", 
                                 "COD_INFORMANTE", "QUADRO", "SEQ",
                                 "V9001", "V9002", "V8000", "V9010", "V9011",
                                 "V4104", "V4105", "DEFLATOR", "V8000_DEFLA",
                                 "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                                 "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# restrição de produtos ou serviços de saúde:
path = "dados/POF 2017-2018/restricao_saude.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/RESTRICAO_PRODUTOS_SERVICOS_SAUDE.txt",
                   widths = c(2,4,1,9,2,1,2,2,
                              2,7,1,14,14,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFORMANTE", "QUADRO", "SEQ","V9001",
                                 "V9013", "PESO", "PESO_FINAL", "RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# rendimento do trabalho:
path = "dados/POF 2017-2018/rendimento_trabalho.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/RENDIMENTO_TRABALHO.txt",
                   widths = c(2,4,1,9,2,1,2,2,1,1,7,1,1,1,1,1,1,7,7,
                              7,7,2,2,3,1,12,10,10,10,10,1,1,14,14,
                              10,4,5),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFORMANTE", "QUADRO", "SUB_QUADRO",
                                 "SEQ", "V9001", "V5302", "V53021", "V5303",
                                 "V5304", "V5305", "V5307", "V8500", "V531112",
                                 "V531122", "V531132", "V9010", "V9011",
                                 "V5314", "V5315", "DEFLATOR", "V8500_DEFLA",
                                 "V531112_DEFLA", "V531122_DEFLA",
                                 "V531132_DEFLA", "COD_IMPUT_VALOR",
                                 "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL","V53011","V53061"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# outros rendimentos:
path = "dados/POF 2017-2018/outros_rendimentos.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/OUTROS_RENDIMENTOS.txt",
                   widths = c(2,4,1,9,2,1,2,2,2,7,10,10,2,
                              2,12,10,10,1,1,14,14,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFORMANTE", "QUADRO", "SEQ", "V9001",
                                 "V8500", "V8501", "V9010", "V9011",
                                 "DEFLATOR", "V8500_DEFLA", "V8501_DEFLA",
                                 "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                                 "PESO", "PESO_FINAL", "RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# condições de vida:
path = "dados/POF 2017-2018/condicoes_vida.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/CONDICOES_VIDA.txt",
                   widths = c(2,4,1,9,2,1,2,1,6,5,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,1,1,1,14,14,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC", "COD_INFORMANTE",
                                 "V6101", "V6102", "V6103", "V61041", "V61042",
                                 "V61043", "V61044", "V61045", "V61046", 
                                 "V61051", "V61052", "V61053", "V61054",
                                 "V61055", "V61056", "V61057", "V61058",
                                 "V61061", "V61062", "V61063", "V61064",
                                 "V61065", "V61066", "V61067", "V61068",
                                 "V61069", "V610610", "V610611", "V61071",
                                 "V61072", "V61073", "V6108", "V6109",
                                 "V6110", "V6111", "V6112", "V6113", "V6114",
                                 "V6115", "V6116", "V6117", "V6118", "V6119",
                                 "V6120", "V6121", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# características da dieta:
path = "dados/POF 2017-2018/caracteristicas_dieta.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/CARACTERISTICAS_DIETA.txt",
                   widths = c(2,4,1,9,2,1,2,1,1,1,1,
                              1,1,1,1,1,1,1,1,1,1,1,
                              1,1,1,1,3,3,14,15,10),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFORMANTE", "V7101", "V7102",
                                 "V71031", "V71032", "V71033", "V71034",
                                 "V71035", "V71036", "V71037", "V71038",
                                 "V7104", "V71051", "V71052", "V71053",
                                 "V71054", "V71055", "V71056", "V71A01",
                                 "V71A02", "V72C01", "V72C02", "PESO",
                                 "PESO_FINAL", "RENDA_TOTAL"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}

# consumo alimentar:
path = "dados/POF 2017-2018/consumo_alimentar.rds"
if (file.exists(path)) {print("Base existente.")} else {
  saveRDS(read.fwf("dados/POF 2017-2018/raw/CONSUMO_ALIMENTAR.txt",
                   widths = c(2,4,1,9,2,1,2,2,2,4,2,7,3,
                              2,1,1,1,1,1,1,1,1,1,1,1,1,
                              1,1,2,2,7,9,6,14,14,14,14,
                              14,14,14,14,14,14,14,14,
                              14,14,14,14,14,14,14,14,
                              14,14,14,14,14,14,14,14,
                              14,14,15,10,15,1),
                   na.strings=c(" "),
                   col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                                 "COD_UPA", "NUM_DOM", "NUM_UC",
                                 "COD_INFOR,MANTE", "QUADRO", "SEQ",
                                 "V9005", "V9007", "V9001", "V9015",
                                 "V9016", "V9017", "V9018", "V9019",
                                 "V9020", "V9021", "V9022", "V9023",
                                 "V9024", "V9025", "V9026", "V9027",
                                 "V9028", "V9029", "V9030",
                                 "COD_UNIDADE_MEDIDA_FINAL",
                                 "COD_PREPARACAO_FINAL", "GRAMATURA1",
                                 "QTD", "COD_TBCA", "ENERGIA_KCAL",
                                 "ENERGIA_KJ", "PTN", "CHOTOT", "FIBRA",
                                 "LIP", "COLEST", "AGSAT", "AGMONO",
                                 "AGPOLI", "AGTRANS", "CALCIO", "FERRO",
                                 "SODIO", "MAGNESIO", "FOSFORO", "POTASSIO",
                                 "COBRE", "ZINCO", "VITA_RAE", "TIAMINA",
                                 "RIBOFLAVINA", "NIACINA", "PIRIDOXAMINA",
                                 "COBALAMINA", "VITD", "VITE", "VITC",
                                 "FOLATO", "PESO", "PESO_FINAL",
                                 "RENDA_TOTAL", "DIA_SEMANA", "DIA_ATIPICO"),
                   dec=".") %>%
            rename_with(., tolower, everything()), path)
}


#--- EXCLUIR RESÍDUO ---
rm(path)


