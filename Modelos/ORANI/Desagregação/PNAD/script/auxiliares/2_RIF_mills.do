
************************ Discrimination - RIF

use "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015\BASE2015.dta", clear

set matsize 800

set more off

// Drop se militar (2) ou funcionário público (3)
drop if V4706==2
drop if V4706==3

// Drop public sector
drop if SCN_67==60
drop if SCN_67==61
drop if SCN_67==63

cd "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015"

*************************************************************************************************************************************************************
************************************************************* RIF - homens brancos (base) x  homens negros **************************************************
*************************************************************************************************************************************************************

// Creating Heckman correction for selectivity
probit forca casal filhos i.decil [fweight = peso]
predict xb if e(sample), xb
generate mills = normalden(-xb) / (1 - normal(-xb))
//replace mills = 0 if mulheres==0

// At mean
xi: oaxaca logsalhora idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail
outreg2 using mulheres_2013B.xls
xi: oaxaca logsalhora idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 [fweight = peso],xb by(mulheres) weight(1) detail
outreg2 using mulheres_2013B.xls

gen rif_1=.
quietly xi: rifreg logsalhora idade idade2 negros escola i.grupoescol  urbana casal formal  empregador contapropria i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.1) re(rif_1_0)
replace  rif_1=rif_1_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.1) re(rif_1_1)
replace  rif_1=rif_1_1 if mulheres==1

xi: oaxaca rif_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail
outreg2 using mulheres_2013.xls

xi: reg rif_1_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

* e10 - erro para o decil 1, grupo 0
predict e10, residuals
predict decil_1, xb

xi: reg rif_1_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e11, residuals


gen rif_2=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.2) re(rif_2_0)
replace  rif_2= rif_2_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.2) re(rif_2_1)
replace  rif_2= rif_2_1 if mulheres==1

xi: oaxaca rif_2 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_2_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e20, residuals
predict decil_2, xb

xi: reg rif_2_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e21, residuals


gen rif_3=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.3) re(rif_3_0)
replace  rif_3= rif_3_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.3) re(rif_3_1)
replace  rif_3= rif_3_1 if mulheres==1

xi: oaxaca rif_3 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_3_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e30, residuals
predict decil_3, xb

xi: reg rif_3_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e31, residuals


gen rif_4=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.4) re(rif_4_0)
replace  rif_4= rif_4_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.4) re(rif_4_1)
replace  rif_4= rif_4_1 if mulheres==1

xi: oaxaca rif_4 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_4_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e40, residuals
predict decil_4, xb

xi: reg rif_4_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e41, residuals


gen rif_5=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.5) re(rif_5_0)
replace  rif_5= rif_5_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.5) re(rif_5_1)
replace  rif_5= rif_5_1 if mulheres==1

xi: oaxaca rif_5 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_5_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e50, residuals
predict decil_5, xb

xi: reg rif_5_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e51, residuals



gen rif_6=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.6) re(rif_6_0)
replace  rif_6= rif_6_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.6) re(rif_6_1)
replace  rif_6= rif_6_1 if mulheres==1

xi: oaxaca rif_6 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_6_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e60, residuals
predict decil_6, xb

xi: reg rif_6_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e61, residuals


gen rif_7=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.7) re(rif_7_0)
replace  rif_7= rif_7_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.7) re(rif_7_1)
replace  rif_7= rif_7_1 if mulheres==1

xi: oaxaca rif_7 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_7_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e70, residuals
predict decil_7, xb

xi: reg rif_7_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e71, residuals


gen rif_8=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.8) re(rif_8_0)
replace  rif_8= rif_8_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.8) re(rif_8_1)
replace  rif_8= rif_8_1 if mulheres==1

xi: oaxaca rif_8 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_8_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e80, residuals
predict decil_8, xb

xi: reg rif_8_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e81, residuals


gen rif_9=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.9) re(rif_9_0)
replace  rif_9= rif_9_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.9) re(rif_9_1)
replace  rif_9= rif_9_1 if mulheres==1

xi: oaxaca rif_9 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_9_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e90, residuals
predict decil_9, xb

xi: reg rif_9_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e91, residuals


gen rif_10=.
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==0 [fweight = peso], quantile (0.99) re(rif_10_0)
replace  rif_10= rif_10_0 if mulheres==0
quietly xi: rifreg logsalhora idade idade2 negros escola  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills if mulheres==1 [fweight = peso], quantile (0.99) re(rif_10_1)
replace  rif_10= rif_10_1 if mulheres==1

xi: oaxaca rif_10 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso],xb by(mulheres) weight(1) detail vce(robust)
outreg2 using mulheres_2013.xls

xi: reg rif_10_0 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==0

predict e100, residuals
predict decil_10, xb

xi: reg rif_10_1 idade idade2 negros  i.grupoescol  urbana casal formal  empregador contapropria  i.UF i.SCN_67 mills [fweight = peso] if mulheres==1
predict e101, residuals

**********************************************************************************************************************************************************************
***************************** Gerar decis da distribuição dos salários 

***** Identificar os decis no método RIF

forv i=1/10 {
egen rif_`i'm=min(rif_`i'_1) if mulheres==1
}

gen decil1=.
replace decil1=1 if rif_1_1==rif_1m&mulheres==1&decil1==.
replace decil1=2 if rif_2_1==rif_2m&mulheres==1&decil1==.
replace decil1=3 if rif_3_1==rif_3m&mulheres==1&decil1==.
replace decil1=4 if rif_4_1==rif_4m&mulheres==1&decil1==.
replace decil1=5 if rif_5_1==rif_5m&mulheres==1&decil1==.
replace decil1=6 if rif_6_1==rif_6m&mulheres==1&decil1==.
replace decil1=7 if rif_7_1==rif_7m&mulheres==1&decil1==.
replace decil1=8 if rif_8_1==rif_8m&mulheres==1&decil1==.
replace decil1=9 if rif_9_1==rif_9m&mulheres==1&decil1==.
replace decil1=10 if rif_10_1==rif_10m&mulheres==1&decil1==.


************************************************************************************************************************************************
************************************************ Gerar ajustes


************************************************ AJUSTE 1
* ajuste1_11 - ajuste 1, no grupo 1 no decil 1
***** ajuste I - Y observado (reponderado) - estimado pela regressão de homens brancos

gen ajuste1_11=.
replace ajuste1_11=decil_1-rif_1_1 if mulheres==1

gen ajuste1_12=.
replace ajuste1_12=decil_2-rif_2_1 if mulheres==1

gen ajuste1_13=.
replace ajuste1_13=decil_3-rif_3_1 if mulheres==1

gen ajuste1_14=.
replace ajuste1_14=decil_4-rif_4_1 if mulheres==1

gen ajuste1_15=.
replace ajuste1_15=decil_5-rif_5_1 if mulheres==1

gen ajuste1_16=.
replace ajuste1_16=decil_6-rif_6_1 if mulheres==1

gen ajuste1_17=.
replace ajuste1_17=decil_7-rif_7_1 if mulheres==1

gen ajuste1_18=.
replace ajuste1_18=decil_8-rif_8_1 if mulheres==1

gen ajuste1_19=.
replace ajuste1_19=decil_9-rif_9_1 if mulheres==1

gen ajuste1_110=.
replace ajuste1_110=decil_10-rif_10_1 if mulheres==1

gen ajuste1=.
replace ajuste1=ajuste1_11 if mulheres==1&decil1==1
replace ajuste1=ajuste1_12 if mulheres==1&decil1==2
replace ajuste1=ajuste1_13 if mulheres==1&decil1==3
replace ajuste1=ajuste1_14 if mulheres==1&decil1==4
replace ajuste1=ajuste1_15 if mulheres==1&decil1==5
replace ajuste1=ajuste1_16 if mulheres==1&decil1==6
replace ajuste1=ajuste1_17 if mulheres==1&decil1==7
replace ajuste1=ajuste1_18 if mulheres==1&decil1==8
replace ajuste1=ajuste1_19 if mulheres==1&decil1==9
replace ajuste1=ajuste1_110 if mulheres==1&decil1==10


************************************************ AJUSTE 2
* ajuste2_11 - ajuste II, no grupo 1 no decil 1
***** ajuste II - ajuste I + resíduo

gen ajuste2_11=.
replace ajuste2_11=(ajuste1_11+e11) if mulheres==1

gen ajuste2_12=.
replace ajuste2_12=(ajuste1_12+e21) if mulheres==1

gen ajuste2_13=.
replace ajuste2_13=(ajuste1_13+e31) if mulheres==1

gen ajuste2_14=.
replace ajuste2_14=(ajuste1_14+e41) if mulheres==1

gen ajuste2_15=.
replace ajuste2_15=(ajuste1_15+e51) if mulheres==1

gen ajuste2_16=.
replace ajuste2_16=(ajuste1_16+e61) if mulheres==1

gen ajuste2_17=.
replace ajuste2_17=(ajuste1_17+e71) if mulheres==1

gen ajuste2_18=.
replace ajuste2_18=(ajuste1_18+e81) if mulheres==1

gen ajuste2_19=.
replace ajuste2_19=(ajuste1_19+e91) if mulheres==1

gen ajuste2_110=.
replace ajuste2_110=(ajuste1_110+e101) if mulheres==1

gen ajuste2=.
replace ajuste2=ajuste2_11 if mulheres==1&decil1==1
replace ajuste2=ajuste2_12 if mulheres==1&decil1==2
replace ajuste2=ajuste2_13 if mulheres==1&decil1==3
replace ajuste2=ajuste2_14 if mulheres==1&decil1==4
replace ajuste2=ajuste2_15 if mulheres==1&decil1==5
replace ajuste2=ajuste2_16 if mulheres==1&decil1==6
replace ajuste2=ajuste2_17 if mulheres==1&decil1==7
replace ajuste2=ajuste2_18 if mulheres==1&decil1==8
replace ajuste2=ajuste2_19 if mulheres==1&decil1==9
replace ajuste2=ajuste2_110 if mulheres==1&decil1==10

************************************************ AJUSTE 3
* ajuste3_11 - ajuste 3, no grupo 1 no decil 1
***** ajuste 3 - ajuste 2 para ajuste>0

gen ajuste3_11=.
replace ajuste3_11=0 if mulheres==1
replace ajuste3_11=ajuste2_11 if mulheres==1&ajuste2_11>0

gen ajuste3_12=.
replace ajuste3_12=0 if mulheres==1
replace ajuste3_12=ajuste2_12 if mulheres==1&ajuste2_12>0

gen ajuste3_13=.
replace ajuste3_13=0 if mulheres==1
replace ajuste3_13=ajuste2_13 if mulheres==1&ajuste2_13>0

gen ajuste3_14=.
replace ajuste3_14=0 if mulheres==1
replace ajuste3_14=ajuste2_14 if mulheres==1&ajuste2_14>0

gen ajuste3_15=.
replace ajuste3_15=0 if mulheres==1
replace ajuste3_15=ajuste2_15 if mulheres==1&ajuste2_15>0

gen ajuste3_16=.
replace ajuste3_16=0 if mulheres==1
replace ajuste3_16=ajuste2_16 if mulheres==1&ajuste2_16>0

gen ajuste3_17=.
replace ajuste3_17=0 if mulheres==1
replace ajuste3_17=ajuste2_17 if mulheres==1&ajuste2_17>0

gen ajuste3_18=.
replace ajuste3_18=0 if mulheres==1
replace ajuste3_18=ajuste2_18 if mulheres==1&ajuste2_18>0

gen ajuste3_19=.
replace ajuste3_19=0 if mulheres==1
replace ajuste3_19=ajuste2_19 if mulheres==1&ajuste2_19>0

gen ajuste3_110=.
replace ajuste3_110=0 if mulheres==1
replace ajuste3_110=ajuste2_110 if mulheres==1&ajuste2_110>0

gen ajuste3=.
replace ajuste3=ajuste3_11 if mulheres==1&decil1==1
replace ajuste3=ajuste3_12 if mulheres==1&decil1==2
replace ajuste3=ajuste3_13 if mulheres==1&decil1==3
replace ajuste3=ajuste3_14 if mulheres==1&decil1==4
replace ajuste3=ajuste3_15 if mulheres==1&decil1==5
replace ajuste3=ajuste3_16 if mulheres==1&decil1==6
replace ajuste3=ajuste3_17 if mulheres==1&decil1==7
replace ajuste3=ajuste3_18 if mulheres==1&decil1==8
replace ajuste3=ajuste3_19 if mulheres==1&decil1==9
replace ajuste3=ajuste3_110 if mulheres==1&decil1==10

************************************************ AJUSTE 4

* Gerar ajuste 3 ponderado pelo peso

gen rajuste3_11=ajuste3_11*peso if mulheres==1
gen rajuste3_12=ajuste3_12*peso if mulheres==1
gen rajuste3_13=ajuste3_13*peso if mulheres==1
gen rajuste3_14=ajuste3_14*peso if mulheres==1
gen rajuste3_15=ajuste3_15*peso if mulheres==1
gen rajuste3_16=ajuste3_16*peso if mulheres==1
gen rajuste3_17=ajuste3_17*peso if mulheres==1
gen rajuste3_18=ajuste3_18*peso if mulheres==1
gen rajuste3_19=ajuste3_19*peso if mulheres==1
gen rajuste3_110=ajuste3_110*peso if mulheres==1

* Gerar somatório do ajuste 3 reponderado

egen sajuste3_11=sum(rajuste3_11) if mulheres==1
egen sajuste3_12=sum(rajuste3_12) if mulheres==1
egen sajuste3_13=sum(rajuste3_13) if mulheres==1
egen sajuste3_14=sum(rajuste3_14) if mulheres==1
egen sajuste3_15=sum(rajuste3_15) if mulheres==1
egen sajuste3_16=sum(rajuste3_16) if mulheres==1
egen sajuste3_17=sum(rajuste3_17) if mulheres==1
egen sajuste3_18=sum(rajuste3_18) if mulheres==1
egen sajuste3_19=sum(rajuste3_19) if mulheres==1
egen sajuste3_110=sum(rajuste3_110) if mulheres==1

* Gerar participação no Ajuste 3

gen pajuste3_11=.
replace pajuste3_11=rajuste3_11/sajuste3_11 if mulheres==1

gen pajuste3_12=.
replace pajuste3_12=rajuste3_12/sajuste3_12 if mulheres==1

gen pajuste3_13=.
replace pajuste3_13=rajuste3_13/sajuste3_13 if mulheres==1

gen pajuste3_14=.
replace pajuste3_14=rajuste3_14/sajuste3_14 if mulheres==1

gen pajuste3_15=.
replace pajuste3_15=rajuste3_15/sajuste3_15 if mulheres==1

gen pajuste3_16=.
replace pajuste3_16=rajuste3_16/sajuste3_16 if mulheres==1

gen pajuste3_17=.
replace pajuste3_17=rajuste3_17/sajuste3_17 if mulheres==1

gen pajuste3_18=.
replace pajuste3_18=rajuste3_18/sajuste3_18 if mulheres==1

gen pajuste3_19=.
replace pajuste3_19=rajuste3_19/sajuste3_19 if mulheres==1

gen pajuste3_110=.
replace pajuste3_110=rajuste3_110/sajuste3_110 if mulheres==1

* Gerar o ajuste 2 reponderado

* Gerar ajuste 2 ponderado pelo peso

gen rajuste2_11=ajuste2_11*peso if mulheres==1
gen rajuste2_12=ajuste2_12*peso if mulheres==1
gen rajuste2_13=ajuste2_13*peso if mulheres==1
gen rajuste2_14=ajuste2_14*peso if mulheres==1
gen rajuste2_15=ajuste2_15*peso if mulheres==1
gen rajuste2_16=ajuste2_16*peso if mulheres==1
gen rajuste2_17=ajuste2_17*peso if mulheres==1
gen rajuste2_18=ajuste2_18*peso if mulheres==1
gen rajuste2_19=ajuste2_19*peso if mulheres==1
gen rajuste2_110=ajuste2_110*peso if mulheres==1

* Gerar somatório do ajuste 2 reponderado

egen sajuste2_11=sum(rajuste2_11) if mulheres==1
egen sajuste2_12=sum(rajuste2_12) if mulheres==1
egen sajuste2_13=sum(rajuste2_13) if mulheres==1
egen sajuste2_14=sum(rajuste2_14) if mulheres==1
egen sajuste2_15=sum(rajuste2_15) if mulheres==1
egen sajuste2_16=sum(rajuste2_16) if mulheres==1
egen sajuste2_17=sum(rajuste2_17) if mulheres==1
egen sajuste2_18=sum(rajuste2_18) if mulheres==1
egen sajuste2_19=sum(rajuste2_19) if mulheres==1
egen sajuste2_110=sum(rajuste2_110) if mulheres==1

* Gerar ajuste 4

gen ajuste4_11=.
replace ajuste4_11=(pajuste3_11*sajuste2_11)/peso if mulheres==1

gen ajuste4_12=.
replace ajuste4_12=(pajuste3_12*sajuste2_12)/peso if mulheres==1

gen ajuste4_13=.
replace ajuste4_13=(pajuste3_13*sajuste2_13)/peso if mulheres==1

gen ajuste4_14=.
replace ajuste4_14=(pajuste3_14*sajuste2_14)/peso if mulheres==1

gen ajuste4_15=.
replace ajuste4_15=(pajuste3_15*sajuste2_15)/peso if mulheres==1

gen ajuste4_16=.
replace ajuste4_16=(pajuste3_16*sajuste2_16)/peso if mulheres==1

gen ajuste4_17=.
replace ajuste4_17=(pajuste3_17*sajuste2_17)/peso if mulheres==1

gen ajuste4_18=.
replace ajuste4_18=(pajuste3_18*sajuste2_18)/peso if mulheres==1

gen ajuste4_19=.
replace ajuste4_19=(pajuste3_19*sajuste2_19)/peso if mulheres==1

gen ajuste4_110=.
replace ajuste4_110=(pajuste3_110*sajuste2_110)/peso if mulheres==1

************************************************ AJUSTE 5

gen ajuste5=.
replace ajuste5=ajuste4_11 if mulheres==1&decil1==1
replace ajuste5=ajuste4_12 if mulheres==1&decil1==2
replace ajuste5=ajuste4_13 if mulheres==1&decil1==3
replace ajuste5=ajuste4_14 if mulheres==1&decil1==4
replace ajuste5=ajuste4_15 if mulheres==1&decil1==5
replace ajuste5=ajuste4_16 if mulheres==1&decil1==6
replace ajuste5=ajuste4_17 if mulheres==1&decil1==7
replace ajuste5=ajuste4_18 if mulheres==1&decil1==8
replace ajuste5=ajuste4_19 if mulheres==1&decil1==9
replace ajuste5=ajuste4_110 if mulheres==1&decil1==10

************************************************ AJUSTE 6

egen sajuste1_11=sum(ajuste1_11*peso)
egen sajuste1_12=sum(ajuste1_12*peso)
egen sajuste1_13=sum(ajuste1_13*peso)
egen sajuste1_14=sum(ajuste1_14*peso)
egen sajuste1_15=sum(ajuste1_15*peso)
egen sajuste1_16=sum(ajuste1_16*peso)
egen sajuste1_17=sum(ajuste1_17*peso)
egen sajuste1_18=sum(ajuste1_18*peso)
egen sajuste1_19=sum(ajuste1_19*peso)
egen sajuste1_110=sum(ajuste1_110*peso)

**speso é igual para todo o mulheres==1 
egen speso1=sum(peso) if ajuste1_11!=.

gen majuste1_11= sajuste1_11/speso1 if ajuste1_11!=.
gen majuste1_12= sajuste1_12/speso1 if ajuste1_12!=.
gen majuste1_13= sajuste1_13/speso1 if ajuste1_13!=.
gen majuste1_14= sajuste1_14/speso1 if ajuste1_14!=.
gen majuste1_15= sajuste1_15/speso1 if ajuste1_15!=.
gen majuste1_16= sajuste1_16/speso1 if ajuste1_16!=.
gen majuste1_17= sajuste1_17/speso1 if ajuste1_17!=.
gen majuste1_18= sajuste1_18/speso1 if ajuste1_18!=.
gen majuste1_19= sajuste1_19/speso1 if ajuste1_19!=.
gen majuste1_110= sajuste1_110/speso1 if ajuste1_110!=.

egen sdpeso1_11=sum(peso) if ajuste1_11!=.&decil1==1
egen sdpeso1_12=sum(peso) if ajuste1_12!=.&decil1==2
egen sdpeso1_13=sum(peso) if ajuste1_13!=.&decil1==3
egen sdpeso1_14=sum(peso) if ajuste1_14!=.&decil1==4
egen sdpeso1_15=sum(peso) if ajuste1_15!=.&decil1==5
egen sdpeso1_16=sum(peso) if ajuste1_16!=.&decil1==6
egen sdpeso1_17=sum(peso) if ajuste1_17!=.&decil1==7
egen sdpeso1_18=sum(peso) if ajuste1_18!=.&decil1==8
egen sdpeso1_19=sum(peso) if ajuste1_19!=.&decil1==9
egen sdpeso1_110=sum(peso) if ajuste1_110!=.&decil1==10

gen tajuste1_11=sdpeso1_11*majuste1_11 if ajuste1_11!=.
gen tajuste1_12=sdpeso1_12*majuste1_12 if ajuste1_12!=.
gen tajuste1_13=sdpeso1_13*majuste1_13 if ajuste1_13!=.
gen tajuste1_14=sdpeso1_14*majuste1_14 if ajuste1_14!=.
gen tajuste1_15=sdpeso1_15*majuste1_15 if ajuste1_15!=.
gen tajuste1_16=sdpeso1_16*majuste1_16 if ajuste1_16!=.
gen tajuste1_17=sdpeso1_17*majuste1_17 if ajuste1_17!=.
gen tajuste1_18=sdpeso1_18*majuste1_18 if ajuste1_18!=.
gen tajuste1_19=sdpeso1_19*majuste1_19 if ajuste1_19!=.
gen tajuste1_110=sdpeso1_110*majuste1_110 if ajuste1_110!=.

sort decil1 grupo
by decil1 grupo: egen sdajuste3_1=sum(ajuste3*peso)
gen pdajuste3_1=(ajuste3*peso)/sdajuste3_1

gen ajuste6_11=(pdajuste3_1*tajuste1_11)/peso if decil1==1&mulheres==1
gen ajuste6_12=(pdajuste3_1*tajuste1_12)/peso if decil1==2&mulheres==1
gen ajuste6_13=(pdajuste3_1*tajuste1_13)/peso if decil1==3&mulheres==1
gen ajuste6_14=(pdajuste3_1*tajuste1_14)/peso if decil1==4&mulheres==1
gen ajuste6_15=(pdajuste3_1*tajuste1_15)/peso if decil1==5&mulheres==1
gen ajuste6_16=(pdajuste3_1*tajuste1_16)/peso if decil1==6&mulheres==1
gen ajuste6_17=(pdajuste3_1*tajuste1_17)/peso if decil1==7&mulheres==1
gen ajuste6_18=(pdajuste3_1*tajuste1_18)/peso if decil1==8&mulheres==1
gen ajuste6_19=(pdajuste3_1*tajuste1_19)/peso if decil1==9&mulheres==1
gen ajuste6_110=(pdajuste3_1*tajuste1_110)/peso if decil1==10&mulheres==1

gen ajuste6=.
replace ajuste6=ajuste6_11 if decil1==1&mulheres==1
replace ajuste6=ajuste6_12 if decil1==2&mulheres==1
replace ajuste6=ajuste6_13 if decil1==3&mulheres==1
replace ajuste6=ajuste6_14 if decil1==4&mulheres==1
replace ajuste6=ajuste6_15 if decil1==5&mulheres==1
replace ajuste6=ajuste6_16 if decil1==6&mulheres==1
replace ajuste6=ajuste6_17 if decil1==7&mulheres==1
replace ajuste6=ajuste6_18 if decil1==8&mulheres==1
replace ajuste6=ajuste6_19 if decil1==9&mulheres==1
replace ajuste6=ajuste6_110 if decil1==10&mulheres==1

keep ano UF V0102 V0103 renda_dom decil* SCN_67 idade idade2 forca filhos salario sexo mulheres negros raca negros urbana anosest ocup atividade horas salhora logsalhora empregador contapropria formal informal grupoescol casal escola grupo* peso logsal mills ajuste*

save "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015\Discr.dta", replace
