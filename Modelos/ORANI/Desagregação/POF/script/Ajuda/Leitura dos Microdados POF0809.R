# LEITURA DOS DADOS DA POF 2008-2009 - R

  
# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_20200917.zip
# Exemplo: setwd("c:/POF20082009/Dados/")
setwd("") 


# REGISTRO: DOMICÍLIO - POF1 / QUADRO 2 (TIPO_REG=01)

DOMICILIO <- 
  read.fwf("T_DOMICILIO_S.txt" 
           , widths = c(2,2,3,1,2,2,14,14,4,4,2,2,2,2,2,2,2,2,2,
                        2,2,2,2,2,2,2,1,1,1,16,16,16,1,1,1,1,1,1,
                        1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,1,6,1
           )
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","ESTRATO_POF","PESO",
                           "PESO_FINAL","PERIODO_REAL","QTD_MORADOR_DOMC","QTD_UC",             
                           "QTD_FAMILIA","V0202","V0203","V0204","V0205","V0206","V0207",
                           "V0208","V0209","V0210","V0211","V0219","V0221","V0222",
                           "V0223","IMPUT_QTD_COMODOS","IMPUT_QTD_BANHEIROS","IMPUT_ESGOTO",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL","V0224",
                           "V02011","V02012","V02013","V02014","V02015","V02016","V02017",
                           "V02018","V02019","V0212","V0213","V0214","V02151","V02152",
                           "V02161","V02162","V02163","V02164","V02165","V02166","V02167",
                           "V02171","V02172","V02173","V02174","V02175","V02181","V02182",             
                           "V02183","V02184","V02185","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DOMICILIO,"DOMICILIO.rds")


# REGISTRO: PESSOAS - POF1 / QUADROS 3 E 4 (TIPO_REG = 02) */
  
MORADOR <- 
  read.fwf("T_MORADOR_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,2,2,2,2,2,2,
                        4,3,6,7,2,2,2,2,2,2,2,2,2,2,2,2,2,
                        2,2,2,2,2,16,16,16,2,5,5,5,5,5,5,5,
                        16,8,2,2,2,2,2,2,2,2,2,2,2,2,2,6,1,
                        1,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "COND_UNIDADE_CONSUMO","NUM_FAMILIA","COND_FAMILIA",
                           "V0401","V04041","V04042","V04043","IDADE_ANOS","IDADE_MES",
                           "IDADE_DIA","V0405","V0418","V0419","V0420","V0421","V0422",
                           "V0425","V0426","V0427","V0428","ANOS_ESTUDO","V0429","V0441",
                           "V0442","V0443","V0444","V0445","V0446","RENDA_MONETARIA",
                           "RENDA_NAO_MONETARIA","RENDA_TOTAL","V0406","V0433",
                           "V0434","V0436","V0437","COMPRIMENTO_IMPUTADO","ALTURA_IMPUTADA",
                           "PESO_IMPUTADO","RENDA_PERCAPITA","V04301","V0438","V0439",
                           "V0440","V0447","TEVE_NECESSIDADE_MEDICAMENTO",
                           "PRECISOU_ALGUM_SERVICO","V0407","V0408","V0415","V0416",
                           "V0417","V0423","V0424","COD_UPA","TIPO_SITUACAO_REG",
                           "NIVEL_INSTRUCAO_MORADOR","NIVEL_INSTRUCAO_PESS_REF")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(MORADOR,"MORADOR.rds")


# REGISTRO: PESSOAS - IMPUTAÇÃO - POF1 / QUADRO 4 (TIPO_REG = 03)
MORADOR_IMPUT <- 
  read.fwf("T_MORADOR_IMPUT_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,1,1,1,1,1,1,
                        1,1,1,1,1,1,1,16,16,16,1,1,1,1,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "COD_SABE_LER","COD_FREQ_ESCOLA","COD_CURSO_FREQ",
                           "COD_DUR_PRIMEIRO_GRAU_EH","COD_SERIE_FREQ",
                           "COD_NIVEL_INSTR","COD_DUR_PRIMEIRO_GRAU_ERA",
                           "COD_SERIE_COM_APROVACAO","COD_CONCLUIU_CURSO",
                           "COD_TEM_CARTAO","COD_EHTITULAR_CARTAO","COD_TEM_CHEQUE",
                           "COD_EHTITULAR_CONTA","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                           "RENDA_TOTAL","COD_TEM_PLANO","COD_EHTITULAR",
                           "COD_NUM_DEPENDENTE","COD_LEITE_MATERNO","MESES_LEITE_MATERNO")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(MORADOR_IMPUT,"MORADOR_IMPUT.rds")


# REGISTRO: CONDIÇÕES DE VIDA - POF6 (TIPO_REG = 04)

CONDICOES_VIDA <- 
  read.fwf("T_CONDICOES_DE_VIDA_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,1,1,1,16,16,16,11,11,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "V6101","V6104","V6105","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                           "RENDA_TOTAL","V6102","V6103","V6106","V61071","V61072",
                           "V61073","V610710","V61074","V61075","V61076","V61077","V61078",
                           "V61079","V610711","V61081","V61082","V61083","V61084","V61085",		        
                           "V61086","V61087","V61088","V61089","V6109","V61101","V61102", 		    
                           "V61103","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CONDICOES_VIDA,"CONDICOES_VIDA.rds")


# REGISTRO: INVENTÁRIO DE BENS DURÁVEIS - POF2 / QUADRO 14 (TIPO_REG = 05)

INVENTARIO <- 
  read.fwf("T_INVENTARIO_S.txt" 
           , widths = c(2,2,3,1,2,1,2,14,14,2,5,2,4,1,
                        2,2,16,16,16,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM",
                           "NUM_UC","ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO",
                           "COD_ITEM","V9005","V1404","V9012","V9002","COD_IMPUT",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                           "V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(INVENTARIO,"INVENTARIO.rds")


# REGISTRO: DESPESA DE 90 DIAS - POF2 / QUADROS 6 A 9 (TIPO_REG = 06)

DESPESA_90DIAS <- 
  read.fwf("T_DESPESA_90DIAS_S.txt"
           , widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,2,5,11,16,
                         2,16,16,16,4,5,5,14,2,5,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                           "V9002","V8000","FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA",
                           "VALOR_ANUAL_EXPANDIDO","COD_IMPUT","RENDA_MONETARIA",
                           "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9005","V9007","V9009",                
                           "QTD_FINAL","COD_IMPUT_QUANTIDADE","V9004","V9001",
                           "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_90DIAS,"DESPESA_90DIAS.rds")


# REGISTRO: DESPESA DE 12 MESES - POF2 / QUADROS 10 A 13 (TIPO_REG = 07)

DESPESA_12MESES <- 
  read.fwf("T_DESPESA_12MESES_S.txt"
           , widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,2,2,2,5,
                         11,16,2,16,16,16,5,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                           "V9002","V8000","V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR",
                           "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                           "V9004","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_12MESES,"DESPESA_12MESES.rds")


# REGISTRO: OUTRAS DESPESAS - POF2 / QUADROS 15 A 18 (TIPO_REG = 08)

OUTRAS_DESPESAS <- 
  read.fwf("T_OUTRAS_DESPESAS_S.txt"
           , widths = c( 2,2,3,1,2,1,2,14,14,2,5,2,11,1,2,5,
                         11,16,2,16,16,16,5,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                           "V9002","V8000","V9012","FATOR_ANUALIZACAO","DEFLATOR",
                           "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                           "V9004","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(OUTRAS_DESPESAS,"OUTRAS_DESPESAS.rds")


# REGISTRO: DESPESA COM SERVIÇOS DOMÉSTICOS - POF2 / QUADRO 19 (TIPO_REG = 09)

SERVICO_DOMS <- 
  read.fwf("T_SERVICO_DOMS_S.txt" 
           , widths = c(2,2,3,1,2,1,2,14,14,2,5,2,11,5,11,
                        1,2,2,2,5,11,11,16,16,2,2,16,16,16,
                        7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                           "V9002","V8000","COD_INSS","V1904","V1905","V9010","V9011",
                           "FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA","V1904_DEFLA",
                           "VALOR_ANUAL_EXPANDIDO","VALOR_INSS_ANUAL_EXPANDIDO",
                           "COD_IMPUT","COD_IMPUT_INSS","RENDA_MONETARIA",
                           "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9001",
                           "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(SERVICO_DOMS,"SERVICO_DOMS.rds")


# REGISTRO: ALUGUEL ESTIMADO - POF1 / QUADRO 2 (TIPO_REG = 10)

ALUGUEL_ESTIMADO <- 
  read.fwf("T_ALUGUEL_ESTIMADO_S.txt" 
           , widths = c(2,2,3,1,2,1,2,14,14,2,5,2,11,
                        2,2,2,5,11,16,2,16,16,16,7,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","COD_ITEM",
                           "V9002","V8000","V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR",
                           "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                           "V9001","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(ALUGUEL_ESTIMADO,"ALUGUEL_ESTIMADO.rds")


# REGISTRO: CADERNETA DE DESPESA - POF3 (TIPO_REG = 11)

CADERNETA_COLETIVA <- 
  read.fwf("T_CADERNETA_DESPESA_S.txt" 
           , widths = c(2,2,3,1,2,1,2,14,14,2,2,5,2,11,2,5,
                        11,16,2,16,16,16,2,8,5,10,5,5,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "ESTRATO_POF","PESO","PESO_FINAL","NUM_QUADRO","NUM_GRUPO",
                           "COD_ITEM","V9002","V8000","FATOR_ANUALIZACAO","DEFLATOR",
                           "V8000_DEFLA","VALOR_ANUAL_EXPANDIDO","COD_IMPUT",
                           "RENDA_MONETARIA","RENDA_NAO_MONETARIA","RENDA_TOTAL",
                           "METODO_QUANTIDADE","QTD_FINAL","V9004","V9005","V9007",
                           "V9009","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CADERNETA_COLETIVA,"CADERNETA_COLETIVA.rds")


# REGISTRO: DESPESA INDIVIDUAL - POF4 / QUADROS 22 A 50 (TIPO_REG = 12)

DESPESA_INDIVIDUAL <- 
  read.fwf("T_DESPESA_INDIVIDUAL_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,2,5,2,11,2,5,11,16,
                        2,16,16,16,2,5,2,2,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "NUM_QUADRO","COD_ITEM","V9002","V8000","FATOR_ANUALIZACAO",
                           "DEFLATOR","V8000_DEFLA","VALOR_ANUAL_EXPANDIDO",
                           "COD_IMPUT","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                           "RENDA_TOTAL","V2905","V9004","V4104","V4105","V9001",
                           "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_INDIVIDUAL,"DESPESA_INDIVIDUAL.rds")


# REGISTROS: DESPESA COM VEÍCULOS - POF4 / QUADRO 51 (TIPO_REG = 13)

DESPESA_VEICULO <- 
  read.fwf("T_DESPESA_VEICULO_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,2,5,2,11,
                        1,2,5,11,16,2,16,16,16,5,7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "NUM_QUADRO","COD_ITEM","V9002","V8000","V9012",
                           "FATOR_ANUALIZACAO","DEFLATOR","V8000_DEFLA",
                           "VALOR_ANUAL_EXPANDIDO","COD_IMPUT","RENDA_MONETARIA",
                           "RENDA_NAO_MONETARIA","RENDA_TOTAL","V9004","V9001",
                           "SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_VEICULO,"DESPESA_VEICULO.rds")


# REGISTROS: RENDIMENTOS E DEDUÇÕES - POF5 / QUADRO 53 (TIPO_REG = 14)

RENDIMENTO_TRABALHO <- 
  read.fwf("T_RENDIMENTOS_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,2,1,2,1,5,11,
                        2,2,1,5,11,5,11,5,11,2,5,11,11,11,
                        11,16,16,16,16,2,16,16,16,3,8,8,2,7,
                        3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
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
                           "COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
           )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(RENDIMENTO_TRABALHO,"RENDIMENTO_TRABALHO.rds")


# REGISTROS: OUTROS RENDIMENTOS - POF5 / QUADROS 54 A 57 (TIPO_REG = 15)

OUTROS_RENDIMENTOS <- 
  read.fwf("T_OUTROS_RECI_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,14,14,2,5,11,11,
                        5,2,2,2,5,11,11,16,16,2,16,16,16,
                        7,3,6,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG","COD_UF","NUM_SEQ","NUM_DV","NUM_DOM","NUM_UC",
                           "COD_INFORMANTE","ESTRATO_POF","PESO","PESO_FINAL",
                           "NUM_QUADRO","COD_ITEM","V8500","V8501","COD_DEDUCAO",
                           "V9010","V9011","FATOR_ANUALIZACAO","DEFLATOR","V8500_DEFLA",
                           "V8501_DEFLA","VALOR_ANUAL_EXPANDIDO","VALOR_DEDUCAO_ANUAL_EXPANDIDO",
                           "COD_IMPUT","RENDA_MONETARIA","RENDA_NAO_MONETARIA",
                           "RENDA_TOTAL","V9001","SEQ_LINHA","COD_UPA","TIPO_SITUACAO_REG")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(OUTROS_RENDIMENTOS,"OUTROS_RENDIMENTOS.rds")


# REGISTRO: CONSUMO ALIMENTAR - POF7 / QUADROS 71 E 72 (TIPO_REG = 16)

CONSUMO_ALIMENTAR <- 
  read.fwf("T_CONSUMO_S.txt" 
           , widths = c(2,2,3,1,2,1,2,2,15,15,2,1,2,8,5,
                        7,2,1,8,1,16,16,16,5,8,8,1)
           , na.strings=c(" ")
           , col.names = c("TIPO_REG", "COD_UF", "NUM_SEQ", "NUM_DV", "COD_DOM",
                           "NUM_UC", "NUM_INFORMANTE", "NUM_EXT_RENDA", "FATOR_EXPANSAO1",
                           "FATOR_EXPANSAO2", "NUM_QUADRO", "LOCAL", "HORARIO",
                           "QTD_ITEM", "COD_UNIDADE", "COD_ITEM", "COD_PREPARACAO",
                           "COD_IMPUT", "QTD_IMPUT", "UTILIZA_FREQUENTEMENTE",
                           "RENDA_BRUTA_MONETARIA", "RENDA_BRUTA_NAO_MONETARIA",
                           "RENDA_TOTAL", "COD_UNIDADE_MEDIDA2", "QTD_UNID_MED",
                           "QTD_FINAL", "DIA_DA_SEMANA")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CONSUMO_ALIMENTAR,"CONSUMO_ALIMENTAR.rds")

