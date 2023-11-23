
///////////////////////////////////////////////////////////////////////////////;
*
*	 Consumo por decil de renda na POF 2008-2009
*
///////////////////////////////////////////////////////////////////////////////;

cd "D:\OneDrive\POF2008"

* Gerar base de dados apenas com identificadores

use "D:\OneDrive\POF2008\Dados\T_MORADOR.dta", clear
keep  TIPO_REG COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC NUM_EXT_RENDA RENDA_PERCAPITA FATOR_EXPANSAO1 FATOR_EXPANSAO2  RENDA_TOTAL
gen renda_pc_int=int(RENDA_PERCAPITA)
duplicates drop
/*
gen SM=RENDA_PERCAPITA/415
duplicates drop

gen familia=0
replace familia=1 if SM>0&SM<=0.25
replace familia=2 if SM>0.25&SM<=0.5
replace familia=3 if SM>0.5&SM<=1
replace familia=4 if SM>1&SM<=2
replace familia=5 if SM>2&SM<=3
replace familia=6 if SM>3&SM<=5
replace familia=7 if SM>5&SM<=10
replace familia=8 if SM>10&SM<=15
replace familia=9 if SM>15&SM<=20
replace familia=10 if SM>20&SM<=30
replace familia=11 if SM>30
replace familia=12 if SM==0
*/

* Gerar quintil
xtile quintil = renda_pc_int [pweight = FATOR_EXPANSAO2], nquantiles(5)

save "D:\OneDrive\POF2008\Dados\ID_expand.dta", replace

use "D:\OneDrive\POF2008\Dados\filtrototal.dta", clear

* Somar todas as despesas por uc e código da matriz
collapse (sum) DESPESA, by(COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC SCN_128)

* Mudar o código da matriz para string
drop if SCN_128==.
tostring SCN_128, replace

save "D:\OneDrive\POF2008\Dados\POF_matriz.dta", replace

* Mergear identificadores com POF_Matrix
merge m:n COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC using "D:\OneDrive\POF2008\Dados\ID_expand.dta"
drop if _merge==2
drop _merge
order  COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC TIPO_REG NUM_EXT_RENDA FATOR_EXPANSAO1 FATOR_EXPANSAO2 RENDA_TOTAL renda_uc_int quintil, first

* Criar variável para contar o número de domicílios
gen n_uc=1

save "D:\OneDrive\POF2008\Dados\POF_matriz.dta", replace

* Gerar banco de dados com a soma do consumo por produto, quintil e UF
use "D:\OneDrive\POF2008\Dados\POF_matriz.dta", clear
merge m:n SCN_128 using "D:\OneDrive\POF2008\SCN_ordem78.dta"
drop _merge SCN_128
collapse (sum) DESPESA* [pweight =  FATOR_EXPANSAO2], by(quintil SCN_78 COD_UF)
drop if COD_UF==.
reshape wide DESPESA, i(SCN_78 quintil) j(COD_UF) 
save "D:\OneDrive\POF2008\Dados\Quintil_SCN78UF.dta", replace
export excel using "Quintil_SCN78UF", firstrow(variables) replace

