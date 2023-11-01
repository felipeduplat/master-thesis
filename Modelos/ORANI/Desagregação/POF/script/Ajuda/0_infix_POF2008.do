*********************************************************************************************		
///*LEITURA DOS DADOS DA POF 2008-2009 */		
*********************************************************************************************		
///*REGISTRO: DOMICÍLIO - POF1 / QUADRO 2 (TIPO_REG=01) */		

clear all

infix		///
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                             	  	 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                 	  	 */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                            	 	 */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                             	 	 */
COD_DOMC						9-10	///*NÚMERO DO DOMICÍLIO                          	  	 */
NUM_EXT_RENDA                  	11-12	///*ESTRATO GEOGRÁFICO                           	  	 */
FATOR_EXPANSAO1					13-27	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)       	  	 */
FATOR_EXPANSAO2					27-41	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)	  	 */
PERD_COD_P_VISIT_REALM_EM      	41-44	///*PERÍODO REAL DA COLETA                       	  	 */
QTD_MORADOR_DOMC				45-48	///*QUANTIDADE DE MORADORES                      	  	 */
QTD_UC							49-50	///*QUANTIDADE DE UC                             	  	 */
QTD_FAMILIA						51-52	///*QUANTIDADE DE FAMÍLIAS                       	  	 */
COD_TIPO_DOMC                  	53-54	///*TIPO DE DOMICILIO                            	  	 */
COD_MATERIAL_PAREDE            	55-56	///*MATERIAL QUE PREDOMINA NAS PAREDES EXTERNAS  	  	 */
COD_MATERIAL_COBERTURA         	57-58	///*MATERIAL QUE PREDOMINA NA COBERTURA          	  	 */
COD_MATERIAL_PISO              	59-60	///*MATERIAL QUE PREDOMINA NO PISO               	  	 */
QTD_COMODOS_DOMC				61-62	///*QUANTIDADE DE CÔMODOS                        	  	 */
QTD_COMD_SERV_DORMIT			63-64	///*CÔMODOS SERVINDO DE DORMITÓRIO               	  	 */
COD_AGUA_COMODO					65-66	///*EXISTÊNCIA DE ÁGUA CANALIZADA                	  	 */
COD_ABAST_AGUA					67-68	///*PROVENIÊNCIA DA ÁGUA                         	  	 */
QTD_BANHEIROS					69-70	///*QUANTIDADE DE BANHEIROS                      	  	 */
COD_ESGOTO_SANIT				71-72	///*ESCOADOURO SANITÁRIO                         	  	 */
COD_COND_OCUP					73-74	///*CONDIÇÃO DE OCUPAÇÃO                         	  	 */
COD_TEMPO_MORADIA              	75-76	///*TEMPO DE ALUGUEL                             	  	 */
COD_CONTRATO_DOCUM				77-78	///*TIPO DE CONTRATO DE ALUGUEL                  	  	 */
COD_EXIST_PAVIM					79-80	///*EXISTÊNCIA DE PAVIMENTAÇÃO NA RUA            	  	 */
IMPUT_QTD_COMODOS              	81-81	///*IMPUTAÇÃO - QUANTIDADE DE CÔMODOS                    	 */
IMPUT_QTD_BANHEIROS            	82-82	///*IMPUTAÇÃO - QUANTIDADE DE BANHEIROS                  	 */
IMPUT_ESGOTO                   	83-83	///*IMPUTAÇÃO - ESCOADOURO SANITÁRIO                     	 */
RENDA_BRUTA_MONETARIA			84-99	///*RENDA MONETÁRIA MENSAL DO DOMICÍLIO                  	 */
RENDA_BRUTA_NAO_MONETARIA		100-115	///*RENDA NÃO MONETÁRIA MENSAL DO DOMICÍLIO                  	 */
RENDA_TOTAL						116-131	///*RENDA TOTAL MENSAL DO DOMICÍLIO                          	 */
COD_SERVICO_DISTRIBUICAO       	132-132	///*SERVIÇO DE DISTRIBUIÇÃO DOS CORREIOS                     	 */
ESTRADA_GRANDE_1               	133-133	///*PROXIMIDADE A ESTRADA DE GRANDE CIRCULAÇÃO DE VEÍCULOS   	 */
AREA_1							134-134	///*PROXIMIDADE A ÁREA INDUSTRIAL                            	 */
ESTRADA_FERRO_1                	135-135	///*PROXIMIDADE A ESTRADA DE FERRO EM USO                    	 */
PASSAGEM_1                     	136-136	///*PROXIMIDADE A PASSAGEM DE FIOS DE ALTA TENSÃO            	 */
GASODUTO_1                     	137-137	///*PROXIMIDADE A GASODUTO OU OLEODUTO                       	 */
LIXAO_1                        	138-138	///*PROXIMIDADE A LIXÃO OU DEPÓSITO DE LIXO                	 */
ESGOTO_1                       	139-139	///*PROXIMIDADE A ESGOTO A CÉU ABERTO OU VALÃO               	 */
RIO_1							140-140	///*PROXIMIDADE A RIO, BAÍA, LAGO, AÇUDE OU REPRESA POLUÍDOS 	 */
ENCOSTA_1                      	141-141	///*PROXIMIDADE A ENCOSTA OU ÁREA SUJEITA A DESLIZAMENTO     	 */
LIXO_BIODEGRADAVEL             	142-142	///*SEPARAÇÃO DO LIXO 						 */
LIXO_SEPARADO                  	143-143	///*FINALIDADE DA SEPARAÇÃO DO LIXO 				 */
COD_LIXO                       	144-145	///*DESTINO DO LIXO                                             */
REDE_15							146-146	///*REDE GERAL DE ENERGIA ELÉTRICA                              */
PROPRIA_15                     	147-147	///*FONTE PRÓPRIA PARA ENERGIA ELÉTRICA                         */
DIESEL_16                      	148-148	///*DIESEL/GASOLINA/GÁS PARA ENERGIA ELÉTRICA                   */
SOLAR_16						149-149	///*ENERGIA SOLAR PARA ENERGIA ELÉTRICA                         */
EOLICA_16                      	150-150	///*ENERGIA EÓLICA PARA ENERGIA ELÉTRICA          	 	 */
AGUA_16							151-151	///*ÁGUA PARA ENERGIA ELÉTRICA      			         */
BIODIESEL_16					152-152	///*BIODIESEL PARA ENERGIA ELÉTRICA             	         */
SISTEMA_MISTO_16				153-153	///*SISTEMA MISTO PARA ENERGIA ELÉTRICA         	         */
OUTRA_FONTE_16                 	154-154	///*OUTRA FONTE PARA ENERGIA ELÉTRICA                           */
ENERGIA_17                     	155-155	///*AQUECIMENTO DE ÁGUA POR ENERGIA ELÉTRICA           	 */
GAS_17                         	156-156	///*AQUECIMENTO DE ÁGUA POR GÁS            			 */
ENERGIA_SOLAR_17               	157-157	///*AQUECIMENTO DE ÁGUA POR ENERGIA SOLAR             		 */
LENHA_17                       	158-158	///*AQUECIMENTO DE ÁGUA POR LENHA/CARVÃO 	      		 */
OUTRA_FORMA_17                 	159-159	///*AQUECIMENTO DE ÁGUA POR OUTRA FONTE 		         */
GAS_18                         	160-160	///*FOGÃO A GÁS                				 */
LENHA_18                       	161-161	///*FOGÃO A LENHA                                               */
CARVAO_18						162-162	///*FOGÃO A CARVÃO                                              */
ENERGIA_ELETRICA_18            	163-163	///*FOGÃO A ENERGIA ELÉTRICA                                    */
OUTRO_18                       	164-164	///*FOGÃO COM OUTRA FONTE                                       */
using "D:\OneDrive\POF2008\Dados\T_DOMICILIO_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_DOMICILIO.dta", replace		
clear		
		
///*REGISTRO: PESSOAS - POF1 / QUADROS 3 E 4 (TIPO_REG = 02) */		
* 	INFILE ""...\T_MORADOR_S.txt"" LRECL = 246 MISSOVER"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                             */
COD_UF                         	3-4	///*CÓDIGO DA UF                                 */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                            */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                             */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                          */
NUM_UC                         	11-11	///*NÚMERO DA UC                                 */
NUM_INFORMANTE                 	12-13	///*NÚMERO DO INFORMANTE                         */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                           */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)       */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)*/
COD_REL_PESS_REFE_UC           	44-45	///*CONDIÇÃO NA UNIDADE DE CONSUMO               */
NUM_FAMILIA                    	46-47	///*NÚMERO DA FAMÍLIA                            */
COD_COND_FAMILIA	48-49	///*CONDIÇÃO NA FAMÍLIA                          */
COD_COND_PRESENCA	50-51	///*CONDIÇÃO DE PRESENÇA                         */
DAT_DIA_NASC	52-53	///*DIA DE NASCIMENTO                            */
DAT_MES_NASC	54-55	///*MÊS DE NASCIMENTO                            */
DAT_ANO_NASC	56-59	///*ANO DE NASCIMENTO                            */
IDADE_ANOS	60-62	///*IDADE CALCULADA EM ANOS                      */
IDADE_MES	63-68	///*IDADE CALCULADA EM MESES                     */
IDADE_DIA	69-75	///*IDADE CALCULADA EM DIAS                      */
COD_SEXO                       	76-77	///*SEXO                                         */
COD_SABE_LER                   	78-79	///*SABE LER E ESCREVER                          */
COD_FREQ_ESCOLA	80-81	///*FREQUÊNCIA A ESCOLA OU CRECHE                */
COD_CURSO_FREQ	82-83	///*CURSO QUE FREQUENTA                          */
COD_DUR_PRIMEIRO_GRAU_EH	84-85	///*QUAL A DURAÇÃO DO CURSO DE PRIMEIRO GRAU     */
COD_SERIE_FREQ                 	86-87	///*SÉRIE QUE FREQUENTA                          */
COD_NIVEL_INSTR                	88-89	///*CURSO MAIS ELEVADO QUE FREQUENTOU            */
COD_DUR_PRIMEIRO_GRAU_ERA	90-91	///*QUAL ERA A DURAÇÃO DO CURSO DE PRIMEIRO GRAU */
COD_SERIE_COM_APROVACAO        	92-93	///*ÚLTIMA SERIE CONCLUÍDA                       */
COD_CONCLUIU_CURSO	94-95	///*CONCLUSÃO DO CURSO MAIS ELEVADO              */
ANOS_DE_ESTUDO	96-97	///*ANOS DE ESTUDO                               */
COD_COR_RACA	98-99	///*COR OU RAÇA                                  */
COD_SIT_RECEITA                	100-101	///*ORÇAMENTO TRABALHO E/OU RENDIMENTO           */
COD_SIT_DESPESA                	102-103	///*ORÇAMENTO DESPESA                            */
COD_TEM_CARTAO                 	104-105	///*TEM CARTÃO DE CRÉDITO                        */
COD_EHTITULAR_CARTAO	106-107	///*TITULAR DO CARTÃO DE CRÉDITO                 */
COD_TEM_CHEQUE                 	108-109	///*TEM CHEQUE ESPECIAL                          */
COD_EHTITULAR_CONTA	110-111	///*TITULAR DA CONTA CORRENTE                    */
RENDA_BRUTA_MONETARIA	112-127	///*RENDA MONETÁRIA MENSAL DA UC                 */
RENDA_BRUTA_NAO_MONETARIA	128-143	///*RENDA NÃO-MONETÁRIA MENSAL DA UC             */
RENDA_TOTAL	144-159	///*RENDA TOTAL MENSAL DA UC                     */
COD_GRAVIDA	160-161	///*ESTÁ GRÁVIDA                                 */
NUM_COMPRIMENTO	162-166	///*COMPRIMENTO ORIGINAL                         */
NUM_ALTURA	167-171	///*ALTURA ORIGINAL                              */
NUM_PESO                     	172-176	///*PESO ORIGINAL                                */
NUM_PESO_CRIANCA              	177-181	///*PESO ORIGINAL DAS CRIANÇAS                   */
COMPRIMENTO_IMPUTADO	182-186	///*COMPRIMENTO IMPUTADO                         */
ALTURA_IMPUTADO	187-191	///*ALTURA IMPUTADA                              */
PESO_IMPUTADO                 	192-196	///*PESO IMPUTADO                                */
RENDA_PERCAPITA	197-212	///*RENDA PER CAPITA DA UC                       */
COD_RELIGIAO                   	213-220	///*CÓDIGO DA RELIGIAO                           */
COD_TEM_PLANO                  	221-222	///*TEM PLANO DE SAÚDE                           */
COD_EHTITULAR	223-224	///*É TITULAR DO PLANO DE SAÚDE                  */
COD_NUM_DEPENDENTE             	225-226	///*NÚMERO DE DEPENDENTES DO PLANO DE SAÚDE      */
COD_UNID_CONSUMO               	227-228	///*CÓDIGO DA UNIDADE DE CONSUMO ALIMENTAR       */
TEVE_NECESSIDADE_MEDICAMENTO	229-230	///*TEVE NECESSIDADE DE MEDICAMENTO              */
PRECISOU_ALGUM_SERVICO         	231-232	///*PRECISOU DE ALGUM SERVIÇO DE SAÚDE           */
TEMPO_GESTACAO	233-234	///*TEMPO DE GESTAÇÃO                            */
COD_AMAMENTANDO	235-236	///*ESTÁ AMAMENTANDO                             */
COD_LEITE_MATERNO              	237-238	///*RECEBIMENTO DE LEITE MATERNO                 */
COD_OUTRO_ALIMENTO             	239-240	///*RECEBIMENTO DE OUTRO TIPO DE ALIMENTO        */
MESES_LEITE_MATERNO	241-242	///*NÚMERO DE MESES QUE RECEBEU LEITE MATERNO    */
COD_FREQ_ALIMENTAR	243-244	///*FREQUÊNCIA ALIMENTAR NA ESCOLA               */
COD_ALIMENTO_CONSUMIDO	245-246	///*ALIMENTOS CONSUMIDOS NA ESCOLA               */
using "D:\OneDrive\POF2008\Dados\T_MORADOR_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_MORADOR.dta", replace		
clear		
		
///*REGISTRO: PESSOAS - IMPUTAÇÃO - POF1 / QUADRO 4 (TIPO_REG = 03) */		
* 	INFILE ""...\T_MORADOR_IMPUT_S.txt"" LRECL = 109 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                      */
COD_UF                         	3-4	///*CÓDIGO DA UF                                          */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                     */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                      */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                                   */
NUM_UC                         	11-11	///*NÚMERO DA UC                                          */
NUM_INFORMANTE                 	12-13	///*NÚMERO DO INFORMANTE                                  */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                                    */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)                */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)         */
COD_SABE_LER                   	44-44	///*IMPUTAÇÃO - SABE LER E ESCREVER                       */
COD_FREQ_ESCOLA	45-45	///*IMPUTAÇÃO - FREQUÊNCIA A ESCOLA OU CRECHE             */
COD_CURSO_FREQ	46-46	///*IMPUTAÇÃO - CURSO QUE FREQUENTA                       */
COD_DUR_PRIMEIRO_GRAU_EH	47-47	///*IMPUTAÇÃO - QUAL A DURAÇÃO DO CURSO DE 1º GRAU        */
COD_SERIE_FREQ                 	48-48	///*IMPUTAÇÃO - SERIE QUE FREQUENTA                       */
COD_NIVEL_INSTR                	49-49	///*IMPUTAÇÃO - CURSO MAIS ELEVADO QUE FREQUENTOU         */
COD_DUR_PRIMEIRO_GRAU_ERA	50-50	///*IMPUTAÇÃO - QUAL ERA A DURAÇÃO DO CURSO DE 1º GRAU    */
COD_SERIE_COM_APROVACAO        	51-51	///*IMPUTAÇÃO - ÚLTIMA SERIE CONCLUÍDA                    */
COD_CONCLUIU_CURSO	52-52	///*IMPUTAÇÃO - CONCLUSÃO DO CURSO MAIS ELEVADO           */
COD_TEM_CARTAO                 	53-53	///*IMPUTAÇÃO - TEM CARTÃO DE CRÉDITO                     */
COD_EHTITULAR_CARTAO	54-54	///*IMPUTAÇÃO - TITULAR DO CARTÃO DE CRÉDITO              */
COD_TEM_CHEQUE                 	55-55	///*IMPUTAÇÃO - TEM CHEQUE ESPECIAL                       */
COD_EHTITULAR_CONTA	56-56	///*IMPUTAÇÃO - TITULAR DA CONTA CORRENTE                 */
RENDA_BRUTA_MONETARIA	57-72	///*RENDA MONETÁRIA MENSAL DA UC                          */
RENDA_BRUTA_NAO_MONETARIA	73-88	///*RENDA NÃO MONETÁRIA MENSAL DA UC                      */
RENDA_TOTAL	89-104	///*RENDA TOTAL MENSAL DA UC                              */
COD_TEM_PLANO                  	105-105	///*IMPUTAÇÃO - TEM PLANO DE SAÚDE                        */
COD_EHTITULAR	106-106	///*IMPUTAÇÃO - É TITULAR DO PLANO DE SAÚDE               */
COD_NUM_DEPENDENTE             	107-107	///*IMPUTAÇÃO - NÚMERO DE DEPENDENTES DO PLANO DE SAÚDE   */
COD_LEITE_MATERNO              	108-108	///*IMPUTAÇÃO - RECEBIMENTO DE LEITE MATERNO              */
MESES_LEITE_MATERNO            	109-109	///*IMPUTAÇÃO - NÚMERO DE MESES QUE RECEBEU LEITE MATERNO */
using "D:\OneDrive\POF2008\Dados\T_MORADOR_IMPUT_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_MORADOR_IMPUT.dta", replace		
clear		
		
///*REGISTRO: CONDIÇÕES DE VIDA - POF6 (TIPO_REG = 04) */		
* 	INFILE ""...\T_CONDICOES_DE_VIDA_S.txt"" LRECL = 141 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                      */
COD_UF                         	3-4	///*CÓDIGO DA UF                                          */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                     */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                      */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                                   */
NUM_UC                         	11-11	///*NÚMERO DA UC                                          */
NUM_INFORMANTE                 	12-13	///*NÚMERO DO INFORMANTE                                  */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                                    */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)                */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)         */
COD_COND_VIDA	44-44	///*CÓDIGO DA RENDA FAMILIAR                              */
COD_QTD_ALI                    	45-45	///*QUANTIDADE DE ALIMENTO                                */
COD_TIP_ALI                    	46-46	///*TIPO DE ALIMENTO                                      */
RENDA_BRUTA_MONETARIA	47-62	///*RENDA MONETÁRIA MENSAL DA UC                          */
RENDA_BRUTA_NAO_MONETARIA	63-78	///*RENDA NÃO MONETÁRIA MENSAL DA UC                      */
RENDA_TOTAL	79-94	///*RENDA TOTAL MENSAL DA UC                              */
VAL_REND_MIN	95-105	///*VALOR DA RENDA MENSAL FAMILIAR MÍNIMA                 */
VAL_REC_MIN_ALI	106-116	///*VALOR MÍNIMO MENSAL DOS RECURSOS PARA ALIMENTAÇÃO     */
COD_RAZ_NAO_ALI                	117-117	///*RAZÃO DE NÃO SE ALIMENTAR COMO QUER                   */
COD_COND_SERV_AGUA 		118-118	///*SERVIÇO DE ÁGUA                                       */
COD_COND_COL_LIXO		119-119	///*SERVIÇO DE COLETA DE LIXO                             */
COD_COND_ILU_RUA 		120-120	///*SERVIÇO DE ILUMINAÇÃO DE RUA                          */
COD_LIMPEZA 			121-121	///*SERVIÇO DE LIMPEZA E MANUTENÇÃO DE RUA                */
COD_COND_DREN_CHUV 		122-122	///*SERVIÇO DE ESCOAMENTO DA ÁGUA DE CHUVA                */
COD_FORN_ENER_ELET 		123-123	///*SERVIÇO DE FORNECIMENTO DE ENERGIA ELÉTRICA           */
COD_TRANSPORTE 			124-124	///*SERVIÇO DE TRANSPORTE COLETIVO                        */
COD_EDUCACAO 			125-125	///*SERVIÇO DE EDUCAÇÃO                                   */
COD_SAUDE 				126-126	///*SERVIÇO DE SAÚDE                                      */
COD_LAZERESPORTE 		127-127	///*SERVIÇO DE LAZER E ESPORTE                            */
COD_ESGOTAMENTO 		128-128	///*SERVIÇO DE ESGOTAMENTO SANITÁRIO                      */
COD_POUCO_ESPACO 		129-129	///*POUCO ESPAÇO                                          */
COD_VIZ_BARULHE 		130-130	///*RUA OU VIZINHOS BARULHENTOS                           */
COD_CASA_ESCURA 		131-131	///*CASA ESCURA                                           */
COD_TELHADO_GOT 		132-132	///*TELHADO COM GOTEIRA                                   */
COD_PAR_CHAO_UMID 		133-133	///*FUNDAÇÃO, PAREDES OU CHÃO ÚMIDOS                      */
COD_MADE_DETERIORA 	    134-134	///*MADEIRAS DAS JANELAS,PORTAS OU ASSOALHOS DETERIORADOS */
COD_POL_TRAN_INDU 		135-135	///*POLUIÇÃO OU PROBLEMAS AMBIENTAIS                      */
COD_VIO_AREA_RESID 	    136-136	///*VIOLÊNCIA OU VANDALISMO                               */
COD_INUNDACOES 			137-137	///*INUNDAÇÕES                                            */
COD_COND_MORADA 		138-138	///*CONDIÇÕES DE MORADIA                                  */
COD_ATRASO_ALUG	139-139	///*ATRASO DE ALUGUEL OU PRESTAÇÃO DA RESIDÊNCIA          */
COD_ATRASO_DESP	140-140	///*ATRASO DE DESPESAS COM ÁGUA, ELETRICIDADE E GÁS       */
COD_ATRASO_PRES	141-141	///*ATRASO DE PRESTAÇÕES DE BENS OU SERVIÇOS ADQUIRIDOS   */
using "D:\OneDrive\POF2008\Dados\T_CONDICOES_DE_VIDA_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_CONDICOES_DE_VIDA.dta", replace		
clear		
		
///*REGISTRO: INVENTÁRIO DE BENS DURÁVEIS - POF2 / QUADRO 14 (TIPO_REG = 05) */		
* 	INFILE ""...\T_INVENTARIO_S.txt"" LRECL = 107 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                             */
COD_UF                         	3-4	///*CÓDIGO DA UF                                 */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                            */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                             */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                          */
NUM_UC                         	11-11	///*NÚMERO DA UC                                 */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                           */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)       */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)*/
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                             */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                               */
QTD_ITEM	49-50	///*QUANTIDADE DO ITEM                           */
ANO_AQUISICAO	51-54	///*ANO DA ÚLTIMA AQUISIÇÃO                      */
COD_ESTADO	55-55	///*ESTADO DA ÚLTIMA AQUISIÇÃO                   */
COD_OBTENCAO                   	56-57	///*FORMA DA ÚLTIMA AQUISIÇÃO                    */
COD_IMPUT	58-59	///*CÓDIGO DE IMPUTAÇÃO                          */
RENDA_BRUTA_MONETARIA	60-75	///*RENDA MONETÁRIA MENSAL DA UC                 */
RENDA_BRUTA_NAO_MONETARIA	76-91	///*RENDA NÃO MONETÁRIA MENSAL DA UC             */
RENDA_TOTAL	92-107	///*RENDA TOTAL MENSAL DA UC                     */
using "D:\OneDrive\POF2008\Dados\T_INVENTARIO_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_INVENTARIO.txt.dta", replace		
clear		
		
///*REGISTRO: DESPESA DE 90 DIAS - POF2 / QUADROS 6 A 9 (TIPO_REG = 06) */		
* 	INFILE ""...\T_DESPESA_90DIAS_S.txt"" LRECL = 180 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	49-50	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	51-61	///*VALOR DA DESPESA / AQUISIÇÃO                     */
FATOR_ANUAL	62-63	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	64-68	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	69-79	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	80-95	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	96-97	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	98-113	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	114-129	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	130-145	///*RENDA TOTAL MENSAL DA UC                         */
QTD_ITEM	146-149	///*QUANTIDADE DO ITEM                               */
COD_UNIDADE_MEDIDA             	150-154	///*CÓDIGO DA UNIDADE DE MEDIDA                      */
COD_PESO_VOLUME                	155-159	///*CÓDIGO DO PESO OU VOLUME                         */
QUANTIDADE_FINAL	160-173	///*QUANTIDADE FINAL                                 */
COD_IMPUT_QUANT	174-175	///*CÓDIGO DE IMPUTAÇÃO - QUANTIDADE                 */
COD_LOCAL_COMPRA               	176-180	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
using "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta", replace		
clear		
		
///*REGISTRO: DESPESA DE 12 MESES - POF2 / QUADROS 10 A 13 (TIPO_REG = 07) */		
* 	INFILE ""...\T_DESPESA_12MESES_S.txt"" LRECL = 154 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	49-50	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	51-61	///*VALOR DA DESPESA / AQUISIÇÃO                     */
MES	62-63	///*MÊS DA ÚLTIMA DESPESA                            */
QTD_MESES	64-65	///*NÚMERO DE MESES                                  */
FATOR_ANUAL	66-67	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	68-72	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	73-83	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	84-99	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	100-101	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	102-117	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	118-133	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	134-149	///*RENDA TOTAL MENSAL DA UC                         */
COD_LOCAL_COMPRA               	150-154	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
using "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta", replace		
clear		
		
///*REGISTRO: OUTRAS DESPESAS - POF2 / QUADROS 15 A 18 (TIPO_REG = 08)  */		
* 	INFILE ""...\T_OUTRAS_DESPESAS_S.txt"" LRECL = 151 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	49-50	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	51-61	///*VALOR DA DESPESA / AQUISIÇÃO                     */
COD_ESTADO	62-62	///*ESTADO DE AQUISIÇÃO                              */
FATOR_ANUAL	63-64	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	65-69	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	70-80	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	81-96	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	97-98	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	99-114	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	115-130	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	131-146	///*RENDA TOTAL MENSAL DA UC                         */
COD_LOCAL_COMPRA               	147-151	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
using "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta", replace		
clear		
		
///*REGISTRO: DESPESA COM SERVIÇOS DOMÉSTICOS - POF2 / QUADRO 19 (TIPO_REG = 09) */		
* 	INFILE ""...\T_SERVICO_DOMS_S.txt"" LRECL = 195 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	49-50	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	51-61	///*VALOR DA DESPESA / AQUISIÇÃO                     */
COD_INSS	62-66	///*CÓDIGO DO INSS                                   */
VAL_INSS	67-77	///*VALOR DO INSS                                    */
COD_ESPECIE	78-78	///*CÓDIGO DA ESPÉCIE                                */
MES	79-80	///*MÊS DA ÚLTIMA DESPESA                            */
QTD_MESES	81-82	///*NÚMERO DE MESES                                  */
FATOR_ANUAL	83-84	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	85-89	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	90-100	///*VALOR DA DESPESA DEFLACIONADO                    */
VAL_INSS_CORRIGIDO	101-111	///*VALOR DO INSS DEFLACIONADO                       */
VALOR_ANUAL_EXPANDIDO2	112-127	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
VALOR_INSS_ANUAL_EXPANDIDO2	128-143	///*VALOR DO INSS ANUALIZADO E EXPANDIDO (FATOR2)    */
COD_IMPUT	144-145	///*CÓDIGO DE IMPUTAÇÃO DA DESPESA                   */
COD_IMPUT_INSS	146-147	///*CÓDIGO DE IMPUTAÇÃO DO INSS                      */
RENDA_BRUTA_MONETARIA	148-163	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	164-179	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	180-195	///*RENDA TOTAL MENSAL DA UC                         */
using "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS.dta", replace		
clear		
		
///*REGISTRO: ALUGUEL ESTIMADO - POF1 / QUADRO 2 (TIPO_REG = 10) */                                      		
* 	INFILE ""...\T_ALUGUEL_ESTIMADO_S.txt"" LRECL = 149 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
COD_ITEM	44-48	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	49-50	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	51-61	///*VALOR DA DESPESA / AQUISIÇÃO                     */
MES	62-63	///*MÊS DA ÚLTIMA DESPESA                            */
QTD_MESES	64-65	///*NÚMERO DE MESES                                  */
FATOR_ANUAL	66-67	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	68-72	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	73-83	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	84-99	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	100-101	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	102-117	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	118-133	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	134-149	///*RENDA TOTAL MENSAL DA UC                         */
using "D:\OneDrive\POF2008\Dados\T_ALUGUEL_ESTIMADO_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_ALUGUEL_ESTIMADO.dta", replace		
clear		
		
///*REGISTRO: CADERNETA DE DESPESA - POF3 (TIPO_REG = 11) */		
* 	INFILE ""...\T_CADERNETA_DESPESA_S.txt"" LRECL = 182 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_EXT_RENDA                  	12-13	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	14-28	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	28-42	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	42-43	///*NÚMERO DO QUADRO                                 */
PROD_NUM_QUADRO_GRUPO_PRO      	44-45	///*NÚMERO DO GRUPO DE DESPESA                       */
COD_ITEM	46-50	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	51-52	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	53-63	///*VALOR DA DESPESA / AQUISIÇÃO                     */
FATOR_ANUAL	64-65	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	66-70	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	71-81	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	82-97	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	98-99	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	100-115	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	116-131	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	132-147	///*RENDA TOTAL MENSAL DA UC                         */
METODO_QUANTKG                 	148-149	///*MÉTODO DA QUANTIDADE ADQUIRIDA                   */
QUANT_KG	150-157	///*QUANTIDADE FINAL EM KG                           */
COD_LOCAL_COMPRA               	158-162	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
QTD_ITEM	163-172	///*QUANTIDADE DO ITEM                               */
COD_UNIDADE_MEDIDA             	173-177	///*CÓDIGO DA UNIDADE DE MEDIDA                      */
COD_PESO_VOLUME                	178-182	///*CÓDIGO DO PESO OU VOLUME                         */
using "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta", replace		
clear		
		
///*REGISTRO: DESPESA INDIVIDUAL - POF4 / QUADROS 22 A 50 (TIPO_REG = 12)  */		
* 	INFILE ""...\T_DESPESA_INDIVIDUAL_S.txt"" LRECL = 158 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_INF                        	12-13	///*NÚMERO DO INFORMANTE                             */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	44-45	///*NÚMERO DO QUADRO                                 */
COD_ITEM	46-50	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	51-52	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	53-63	///*VALOR DA DESPESA / AQUISIÇÃO                     */
FATOR_ANUAL	64-65	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	66-70	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	71-81	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	82-97	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	98-99	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	100-115	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	116-131	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	132-147	///*RENDA TOTAL MENSAL DA UC                         */
COD_CARACTERISTICA	148-149	///*CARACTERÍSTICA DOS MEDICAMENTOS                  */
COD_LOCAL_COMPRA               	150-154	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
COD_MOTIVO                     	155-156	///*CÓDIGO DO MOTIVO DA VIAGEM                       */
UF_DESPESA                     	157-158	///*CÓDIGO DA UF DA DESPESA                          */
using "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta", replace		
clear		
		
///*REGISTROS: DESPESA COM VEÍCULOS - POF4 / QUADRO 51 (TIPO_REG = 13) */		
* 	INFILE ""...\T_DESPESA_VEICULO_S.txt"" LRECL = 153 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_INFORMANTE                 	12-13	///*NÚMERO DO INFORMANTE                             */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	44-45	///*NÚMERO DO QUADRO                                 */
COD_ITEM	46-50	///*CÓDIGO DO ITEM                                   */
COD_OBTENCAO                   	51-52	///*FORMA DE AQUISIÇÃO                               */
VAL_DESPESA	53-63	///*VALOR DA DESPESA / AQUISIÇÃO                     */
COD_ESTADO	64-64	///*ESTADO DE AQUISIÇÃO                              */
FATOR_ANUAL	65-66	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	67-71	///*DEFLATOR FATOR                                   */
VAL_DESPESA_CORRIGIDO	72-82	///*VALOR DA DESPESA DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	83-98	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	99-100	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	101-116	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	117-132	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	133-148	///*RENDA TOTAL MENSAL DA UC                         */
COD_LOCAL_COMPRA               	149-153	///*CÓDIGO DO LOCAL DE AQUISIÇAO                     */
using "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta", replace		
clear		
		
///*REGISTROS: RENDIMENTOS E DEDUÇÕES - POF5 / QUADRO 53 (TIPO_REG = 14) */		
* 	INFILE ""...\T_RENDIMENTOS_S.txt"" LRECL = 304 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                       */
COD_UF                         	3-4	///*CÓDIGO DA UF                                           */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                      */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                       */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                                    */
NUM_UC                         	11-11	///*NÚMERO DA UC                                           */
NUM_ORDEM_INFORM               	12-13	///*NÚMERO DO INFORMANTE                                   */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                                     */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)                 */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)          */
NUM_QUADRO                     	44-45	///*NÚMERO DO QUADRO                                       */
COD_TIPO_OCUP                  	46-46	///*TIPO DE TRABALHO                                       */
COD_POSI_OCUPA                 	47-48	///*POSIÇÃO NA OCUPAÇÃO                                    */
COD_RENM_BRUTO                 	49-49	///*FORMA DO ÚLTIMO RENDIMENTO                             */
COD_ITEM	50-54	///*CÓDIGO DO ITEM                                         */
VAL_RENM_BRUTO	55-65	///*VALOR DO ÚLTIMO RENDIMENTO                             */
VAL_MES	66-67	///*MÊS DO ÚLTIMO RENDIMENTO                               */
NUM_MESES_RECEBE               	68-69	///*NÚMERO DE MESES RECEBIDOS                              */
COD_DEDUCAO_VAL	70-70	///*EXISTÊNCIA DE DEDUÇÃO                                  */
COD_ITEM_PREV                  	71-75	///*CÓDIGO DE PREVIDÊNCIA PÚBLICA                          */
VAL_DEDUCAO_PREV	76-86	///*VALOR DA PREVIDÊNCIA PÚBLICA                           */
COD_ITEM_IR                    	87-91	///*CÓDIGO DE IMPOSTO DE RENDA                             */
VAL_DEDUCAO_IR	92-102	///*VALOR DO IMPOSTO RENDA                                 */
COD_ITEM_OUTRA                 	103-107	///*CÓDIGO DE OUTRAS DEDUÇÕES                              */
VAL_DEDUCAO_OUTRA	108-118	///*VALOR DE OUTRAS DEDUÇÕES                               */
FATOR_ANUAL	119-120	///*FATOR DE ANUALIZAÇÃO                                   */
NUM_DEFLATOR	121-125	///*DEFLATOR FATOR                                         */
VAL_RENM_BRUTO_CORRIGIDO	126-136	///*VALOR DO ÚLTIMO RENDIMENTO DEFLACIONADO                */
VAL_DEDUCAO_PREV_CORRIGIDO	137-147	///*VALOR DA PREVIDÊNCIA PÚBLICA DEFLACIONADO              */
VAL_DEDUCAO_IR_CORRIGIDO	148-158	///*VALOR DO IMPOSTO RENDA DEFLACIONADO                    */
VAL_DEDUCAO_OUTRA_CORRIGIDO	159-169	///*VALOR DE OUTRAS DEDUÇÕES DEFLACIONADO                  */
VALOR_ANUAL_EXPANDIDO2	170-185	///*VALOR DO ÚLTIMO REND. ANUALIZADO E EXPANDIDO (FATOR2)  */
VALOR_PREV_ANUAL_EXPANDIDO2	186-201	///*VALOR DA PREV. PÚBLICA ANUALIZADO E EXPANDIDO (FATOR2) */
VALOR_IR_ANUAL_EXPANDIDO2	202-217	///*VALOR DO IMP. RENDA ANUALIZADO E EXPANDIDO (FATOR2)    */
VALOR_OUTRAS_ANUAL_EXPANDIDO2	218-233	///*VALOR DE OUT. DEDUÇÕES ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	234-235	///*CÓDIGO DE IMPUTAÇÃO                                    */
RENDA_BRUTA_MONETARIA	236-251	///*RENDA MONETÁRIA MENSAL DA UC                           */
RENDA_BRUTA_NAO_MONETARIA	252-267	///*RENDA NÃO MONETÁRIA MENSAL DA UC                       */
RENDA_TOTAL	268-283	///*RENDA TOTAL MENSAL DA UC                               */
NUM_HORAS_TRABALHADAS          	284-286	///*NÚMERO DE HORAS TRABALHADAS                            */
COD_OCUP_FINAL                 	287-294	///*CÓDIGO DE OCUPAÇÃO                                     */
COD_ATIV_FINAL	295-302	///*CÓDIGO DE ATIVIDADE                                    */
COD_IMPUT_OCUP_ATIV	303-304	///*CÓDIGO DE IMPUTAÇÃO DE OCUPAÇÃO E ATIVIDADE            */
using "D:\OneDrive\POF2008\Dados\T_RENDIMENTOS_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_RENDIMENTOS.dta", replace		
clear		
		
///*REGISTROS: OUTROS RENDIMENTOS - POF5 / QUADROS 54 A 57 (TIPO_REG = 15) */		
* 	INFILE ""...\T_OUTROS_RECI_S.txt"" LRECL = 192 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_ORD_INFORM                 	12-13	///*NÚMERO DO INFORMANTE                             */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	16-30	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	30-44	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	44-45	///*NÚMERO DO QUADRO                                 */
COD_ITEM	46-50	///*CÓDIGO DO ITEM                                   */
VAL_RECEBIDO	51-61	///*VALOR DO RENDIMENTO                              */
VAL_DEDUCAO	62-72	///*VALOR DA DEDUCAO                                 */
COD_DEDUC	73-77	///*CÓDIGO DA DEDUÇÃO                                */
MES_ULTIMO_RENDIMENTO	78-79	///*MÊS DO ÚLTIMO RENDIMENTO                         */
NUM_MESES_RESGATE               	80-81	///*NÚMERO MESES RECEBIDOS                           */
FATOR_ANUAL	82-83	///*FATOR DE ANUALIZAÇÃO                             */
NUM_DEFLATOR	84-88	///*DEFLATOR FATOR                                   */
VAL_RECEBIDO_CORRIGIDO	89-99	///*VALOR DO RENDIMENTO DEFLACIONADO                 */
VAL_DEDUCAO_CORRIGIDO	100-110	///*VALOR DA DEDUCAO DEFLACIONADO                    */
VALOR_ANUAL_EXPANDIDO2	111-126	///*VALOR DA DESPESA ANUALIZADO E EXPANDIDO (FATOR2) */
VALOR_DEDUC_ANUAL_EXPANDIDO2	127-142	///*VALOR DA DEDUÇÃO ANUALIZADO E EXPANDIDO (FATOR2) */
COD_IMPUT	143-144	///*CÓDIGO DE IMPUTAÇÃO                              */
RENDA_BRUTA_MONETARIA	145-160	///*RENDA MONETÁRIA MENSAL DA UC                     */
RENDA_BRUTA_NAO_MONETARIA	161-176	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */
RENDA_TOTAL	177-192	///*RENDA TOTAL MENSAL DA UC                         */
using "D:\OneDrive\POF2008\Dados\T_OUTROS_RECI_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_OUTROS_RECI.dta", replace		
clear		
		
///*REGISTRO: CONSUMO ALIMENTAR - POF7 / QUADROS 71 E 72 (TIPO_REG = 16) */		
* 	INFILE ""...\T_CONSUMO_S.txt"" LRECL = 152 MISSOVER;"		
infix		
TIPO_REG                       	1-2	///*TIPO DE REGISTRO                                 */
COD_UF                         	3-4	///*CÓDIGO DA UF                                     */
NUM_SEQ                        	5-7	///*NÚMERO SEQUENCIAL                                */
NUM_DV                         	8-8	///*DV DO SEQUENCIAL                                 */
COD_DOMC	9-10	///*NÚMERO DO DOMICÍLIO                              */
NUM_UC                         	11-11	///*NÚMERO DA UC                                     */
NUM_INFORMANTE                 	12-13	///*NÚMERO DO INFORMANTE                             */
NUM_EXT_RENDA                  	14-15	///*ESTRATO GEOGRÁFICO                               */
FATOR_EXPANSAO1	16-31	///*FATOR DE EXPANSÃO 1 (DESENHO AMOSTRAL)           */
FATOR_EXPANSAO2	31-46	///*FATOR DE EXPANSÃO 2 (AJUSTADO P/ ESTIMATIVAS)    */
NUM_QUADRO                     	46-47	///*NÚMERO DO QUADRO                                 */
LOCAL 			   	48-48	///*FONTE DO ALIMENTO CONSUMIDO		      */
HORARIO			    	49-50	///*HORÁRIO DO CONSUMO		                      */
QTD_ITEM				51-58	///*QUANTIDADE CONSUMIDA			      */
COD_UNIDADE		    	59-63	///*CÓDIGO DA UNIDADE DE MEDIDA 1                    */
COD_ITEM		    	64-70	///*CÓDIGO DO TIPO DE ALIMENTO 		      */	
COD_PREPARACAO			71-72	///*CÓDIGO DA FORMA DE PREPARAÇÃO 		      */
COD_IMPUT			    73-73	///*CÓDIGO DE IMPUTAÇÃO DO CONSUMO ALIMENTAR	      */		
QTD_IMPUT			  	74-81	///*QUANTIDADE CONSUMIDA IMPUTADA 		      */
UTILIZA_FREQUENTEMENTE	   	82-82	///*UTILIZA COM FREQUENCIA			      */
RENDA_BRUTA_MONETARIA	 	83-98	///*RENDA MONETÁRIA MENSAL DA UC                     */		
RENDA_BRUTA_NAO_MONETARIA	99-114	///*RENDA NÃO MONETÁRIA MENSAL DA UC                 */			
RENDA_TOTAL			115-130	///*RENDA TOTAL MENSAL DA UC                         */					
COD_UNIDADE_MEDIDA2            	131-135	///*CÓDIGO DA UNIDADE DE MEDIDA 2	              */			
QTD_UNID_MED	136-143	///*QUANTIDADE DA UNIDADE DE MEDIDA EM GRAMAS        */											
QTD_FINAL	144-151	///*QUANTIDADE FINAL EM GRAMAS               	      */
DIA_DA_SEMANA                  	152-152	///*DIA DA SEMANA                            	      */
using "D:\OneDrive\POF2008\Dados\T_CONSUMO_S.txt"		
save "D:\OneDrive\POF2008\Dados\T_CONSUMO.dta", replace		
clear		
