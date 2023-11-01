*///////////////////////////////////////////////////////////////////////////////;
*
*		Sintaxe para criar o arquivo de despesas da POF 2002-2003
*
*///////////////////////////////////////////////////////////////////////////////;

* 	Introdu��o
*
*	Para criar o arquivo de despesas da POF 2002-2003 ser� necess�rio
* percorrer 2 passos, a saber:
*
*	- Passo 1: Classifica��o das despesas da POF de acordo com a matriz do IBGE
*	- Passo 2: C�lculo dos grupos de despesas a partir de seus componentes
*

/* Notas: A fun��o int() trunca o n�mero apenas nos valores inteiros, 
  de modo que ao fazer int(x/100) significa que estamos ignorando os dois �ltimos 
  d�gitos do n�mero x;*/


*///////////////////////////////////////////////////////////////////////////////;
*
*		Passo 1: Classifica��o das despesas da POF de acordo com a
*		         matriz das contas nacionais
*
*///////////////////////////////////////////////////////////////////////////////;


* Cria a vari�vel NQuadroItem nos arquivos de despesas, exceto no arquivo da
* caderneta de despesas coletivas (alimenta��o, higine e limpeza);

* Calcula o c�digo do item a partir do n�mero do quadro e do n�mero do item;
*gen NQuadroItem = int((n_quadro*100000 + n_item)/100);
use "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta", clear
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta",replace

use "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta", clear
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta", replace

use "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta", clear
gen DESPESA=( VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta", replace

use "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta", clear
gen DESPESA=( VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta", replace

use "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS.dta", clear
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS1.dta", replace

use "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta", clear
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta", replace

* identificar os bancos
use "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta", clear
gen ID=1
save "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta", replace
use "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta", clear
gen ID=2
save "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta", replace
use "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta", clear
gen ID=3
save "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta", replace
use "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS1.dta", clear
gen ID=4
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS1.dta", replace
use "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta", clear
gen ID=5
save "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta", replace
use "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta", clear
gen ID=6
save "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta", replace

*empilha todos os bancos de filtro
append using "D:\OneDrive\POF2008\Dados\T_DESPESA_12MESES.dta"
append using "D:\OneDrive\POF2008\Dados\T_DESPESA_90DIAS.dta"
append using "D:\OneDrive\POF2008\Dados\T_DESPESA_INDIVIDUAL.dta"
append using "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS1.dta"
append using "D:\OneDrive\POF2008\Dados\T_OUTRAS_DESPESAS.dta"
append using "D:\OneDrive\POF2008\Dados\T_DESPESA_VEICULO.dta"
save "D:\OneDrive\POF2008\Dados\despesasgerais.dta", replace

* OBSERVA��O: Note que o arquivo de invent�rio de bens dur�veis n�o foi utilizado
*  para calcular as despesas das fam�lias, j� que esse arquivo N�O � um arquivo
*  de despesas, mas apenas uma listagem dos bens dur�veis j� existentes nos domic�lios;

* Cria a vari�vel NQuadroItem nas despesas da caderneta de despesas coletivas 
*(alimenta��o, higine e limpeza);
use "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta", clear
* Calcula o c�digo do item a partir do n�mero do grupo e do n�mero do item
* (nesse arquivo, utilizamos o n�mero do grupo, e n�o o n�mero do quadro)
gen NQuadroItem=PROD_NUM_QUADRO_GRUPO_PRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta",replace

* OBSERVA��O: note que no arquivo da caderneta de despesas coletivas, ao inv�s
* de utilizarmos o n�mero do Quadro para construir a vari�vel NQuadroItem, n�s
* utilizamos o n�mero do GRUPO. Por qu�? Por que especificamente no caso desse
* arquivo, o n�mero do Quadro representa apenas o dia da semana em que a fam�lia
* efetuou o gasto. A vari�vel relevante aqui para discriminar os itens � o 
* n�mero do GRUPO, e � ela que � utilizada pelo IBGE no plano tabular para
* classificar os itens de despesas;


* Cria a vari�vel NQuadroItem dos itens referentes ao INSS dos empregados dom�sticos;
*Arquivo fict�cio;
use "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS.dta", clear
* Seleciona apenas os valores positivos de INSS dos empregados dom�sticos;
keep if VAL_INSS_CORRIGIDO>0
* Calcula o c�digo do item a partir do n�mero do quadro e do n�mero do item;
*NQuadroItem = int((NQuadro*100000 + NItem + 50000));
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
gen DESPESA=(VAL_INSS_CORRIGIDO*FATOR_ANUAL)
* OBSERVA��O: note que para construir a vari�vel NQuadroItem, adicionou-se
* 50000 � forma de c�lculo para se criar os c�digos fict�cios que v�o 
* de 19501 a 19548;

* Captura os valores do INSS dos empregados dom�sticos na vari�vel 'valordeflanual';
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_INSS.dta", replace

* Cria a vari�vel NQuadroItem dos itens referentes � contribui��o previdenci�ria;
use "D:\OneDrive\POF2008\Dados\T_RENDIMENTOS.dta", clear
*rename COD_UF UF
*rename NUM_SEQ SEQ 
*rename NUM_DV DV 
*rename NUM_UC UC
*rename COD_DOMC DOMC

keep if  VAL_DEDUCAO_PREV_CORRIGIDO>0
* Calcula o c�digo do item a partir do n�mero do quadro e do n�mero do item
*gen NQuadroItem= n_quadro*100000
*gen NQuadroI=(NQuadroItem + PosOcup*100+300000)
*gen N_quadroitem= int(NQuadroI)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem +  COD_POSI_OCUPA*100)

* OBSERVA��O: note que para construir a vari�vel NQuadroItem, adicionou-se
* 300000 � forma de c�lculo para se criar o quadro fict�cio de no. 56 e os
* c�digos fict�cios de 56001 a 56010;

* Captura os valores da contribu��o previdenci�ria na vari�vel 'valordeflanual'
gen DESPESA = VAL_DEDUCAO_PREV_CORRIGIDO
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\filtroprevidencia.dta", replace


* Junta todos os arquivos de despesas em um �nico arquivo e utiliza a vari�vel
*  constru�da NQuadroItem para classificar as despesas de acordo com o plano
*  tabular do IBGE;

* Gerar identificadores dos bancos

use "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta", clear
gen ID=7
save "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta", replace
use "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_INSS.dta", clear
gen ID=8
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_INSS.dta", replace
use "D:\OneDrive\POF2008\Dados\filtroprevidencia.dta", clear
gen ID=9
save "D:\OneDrive\POF2008\Dados\filtroprevidencia.dta", replace

use "D:\OneDrive\POF2008\Dados\T_ALUGUEL_ESTIMADO.dta", clear
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
gen ID=10
save "D:\OneDrive\POF2008\Dados\T_ALUGUEL_ESTIMADO.dta",replace

use "D:\OneDrive\POF2008\Dados\despesasgerais.dta", clear
append using "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta"
append using "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_INSS.dta"
append using "D:\OneDrive\POF2008\Dados\filtroprevidencia.dta"
append using "D:\OneDrive\POF2008\Dados\T_ALUGUEL_ESTIMADO.dta"
save "D:\OneDrive\POF2008\Dados\despesastotais.dta", replace

**merge com o banco de compatibiliza��o dos codigos pof e codigos matriz
use "D:\OneDrive\POF2008\Dados\despesastotais.dta", clear
sort NQuadroI
merge m:m NQuadroI using "D:\OneDrive\POF2008\Olga\POF_SCN128.dta"
drop if _merge==2
drop _merge
save "D:\OneDrive\POF2008\Dados\filtrototal.dta", replace
**no merge nem o grupo 2 vai ter registros
*tab _merge
*_merge=2 tem 2984 observa�oes (grupos que est�o no cod pof mas que nao apresentaram despesa)
