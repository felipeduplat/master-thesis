/******************************************************************************************************************/
/*************************************** ESR - 15/12/2022 - PNAD 2015 *********************************************/
/******************************************************************************************************************/


* GERAR BANCO DE DADOS COM OS DECIS DE RENDA PER CAPITA DAS UNIDADES DOMICILIARES (PARA O MODELO DE IO)

use "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015", clear

replace V4742=. if V4742>125000
gen renda_dom=int(V4742)
xtile decil = renda_dom [pweight = V4729], nquantiles(10)

** JUNTAR COM A COMPATIBILIZAÇÃO DE ATIVIDADES DA MATRIZ DE IO PARA O MODELO DE EGC
/* V9907==99888 são atividades mão-definidas 275 foram dropadas para PNAD2013*/
replace V9907=. if V9907==99888

merge m:1 V9907 using "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015\SCN_67.dta"
drop if _merge==2
drop _merge

**********************************************************************************************************************
****************************************************************** Gerando variáveis PES2015

rename V0101 ano

gen idade=V8005
replace idade=. if V8005==999

drop if idade<=16
drop if idade>=65
drop if idade==.

gen idade2=idade^2

/* salário - rendimento mensal do trabalho principal */
replace V4718=. if V4718>=3000000
gen salario=V4718
replace salario=. if V4718>100000
replace salario=. if salario==0

gen ocupado=. 
replace ocupado=1 if V4805==1
replace ocupado=0 if V4805==2

/* 1- homens; 0-Mulheres*/
gen sexo=.
replace sexo=1 if V0302==2
replace sexo=0 if V0302==4

gen mulheres=.
replace mulheres=1 if sexo==0
replace mulheres=0 if sexo==1

/* 1 são brancos; 0 são pretos e pardos */
gen raca=.
replace raca=1 if V0404==2
replace raca=0 if V0404==4
replace raca=0 if V0404==8

gen negros=.
replace negros=1 if raca==0
replace negros=0 if raca==1

gen metro=. 
replace metro=1 if V4727==1
replace metro=0 if V4727==2
replace metro=0 if V4727==3

gen urbana=.
replace urbana=1 if V4728==1
replace urbana=1 if V4728==2
replace urbana=1 if V4728==3
replace urbana=0 if V4728==4
replace urbana=0 if V4728==5
replace urbana=0 if V4728==6
replace urbana=0 if V4728==7
replace urbana=0 if V4728==8

gen anosest=(V4803-1)
replace anosest=. if V4803==17

gen ocup=V9906

gen atividade=V9907

gen horas=V9058
replace horas=. if V9058==99
replace horas=. if horas==0
replace salario=. if horas==0

gen salhora=(salario/(4*horas))

gen logsal=log(salario)

gen logsalhora=log(salhora)

replace V4715=. if V4715>=11

gen empregador=0
replace empregador=1 if V4715==9 
replace empregador=. if V4715==.

gen contapropria=0
replace contapropria=1 if V4715==10
replace contapropria=. if V4715==.

gen formal=0
replace formal=1 if V4715==1
replace formal=1 if V4715==2
replace formal=1 if V4715==3
replace formal=1 if V4715==6
replace formal=. if V4715==.

gen informal=0
replace informal=1 if V4715==4
replace informal=1 if V4715==5
replace informal=1 if V4715==7
replace informal=1 if V4715==8
replace informal=. if V4715==.

gen grupoescol=.
replace grupoescol=0 if anosest>=0&anosest<=3
replace grupoescol=1 if anosest>3&anosest<=7
replace grupoescol=2 if anosest>7&anosest<=10
replace grupoescol=3 if anosest>10&anosest<=14
replace grupoescol=4 if anosest>=15

gen casal=0
replace casal=1 if V4723==1
replace casal=1 if V4723==2
replace casal=1 if V4723==3
replace casal=1 if V4723==4

gen filhos=0
replace filhos=1 if V4723>=2&V4723<=8

gen escola=0
replace escola=1 if V0602==2
replace escola=. if V0602==.

gen forca=.
replace forca=1 if salario>0
replace forca=0 if salario==.

/*rename V0102 controle
rename V0103 serie
rename V0301 ordem
rename V3033 ano_nasc */
rename V4729 peso
*drop V* v*

*order  ano UF controle serie ordem ano_nasc grupo, first

save "C:\Users\kenia\OneDrive\1. Artigos\Discrimination\2015\BASE2015.dta", replace