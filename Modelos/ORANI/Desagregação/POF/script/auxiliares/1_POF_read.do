*///////////////////////////////////////////////////////////////////////////////;
*
*		Sintaxe para criar o arquivo de despesas da POF 2002-2003
*
*///////////////////////////////////////////////////////////////////////////////;

* 	Introdução
*
*	Para criar o arquivo de despesas da POF 2002-2003 será necessário
* percorrer 2 passos, a saber:
*
*	- Passo 1: Classificação das despesas da POF de acordo com a matriz do IBGE
*	- Passo 2: Cálculo dos grupos de despesas a partir de seus componentes
*

/* Notas: A função int() trunca o número apenas nos valores inteiros, 
  de modo que ao fazer int(x/100) significa que estamos ignorando os dois últimos 
  dígitos do número x;*/


*///////////////////////////////////////////////////////////////////////////////;
*
*		Passo 1: Classificação das despesas da POF de acordo com a
*		         matriz das contas nacionais
*
*///////////////////////////////////////////////////////////////////////////////;


* Cria a variável NQuadroItem nos arquivos de despesas, exceto no arquivo da
* caderneta de despesas coletivas (alimentação, higine e limpeza);

* Calcula o código do item a partir do número do quadro e do número do item;
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

* OBSERVAÇÃO: Note que o arquivo de inventário de bens duráveis não foi utilizado
*  para calcular as despesas das famílias, já que esse arquivo NÃO É um arquivo
*  de despesas, mas apenas uma listagem dos bens duráveis já existentes nos domicílios;

* Cria a variável NQuadroItem nas despesas da caderneta de despesas coletivas 
*(alimentação, higine e limpeza);
use "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta", clear
* Calcula o código do item a partir do número do grupo e do número do item
* (nesse arquivo, utilizamos o número do grupo, e não o número do quadro)
gen NQuadroItem=PROD_NUM_QUADRO_GRUPO_PRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
gen DESPESA=(VAL_DESPESA_CORRIGIDO*FATOR_ANUAL)
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_CADERNETA_DESPESA.dta",replace

* OBSERVAÇÃO: note que no arquivo da caderneta de despesas coletivas, ao invés
* de utilizarmos o número do Quadro para construir a variável NQuadroItem, nós
* utilizamos o número do GRUPO. Por quê? Por que especificamente no caso desse
* arquivo, o número do Quadro representa apenas o dia da semana em que a família
* efetuou o gasto. A variável relevante aqui para discriminar os itens é o 
* número do GRUPO, e é ela que é utilizada pelo IBGE no plano tabular para
* classificar os itens de despesas;


* Cria a variável NQuadroItem dos itens referentes ao INSS dos empregados domésticos;
*Arquivo fictício;
use "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS.dta", clear
* Seleciona apenas os valores positivos de INSS dos empregados domésticos;
keep if VAL_INSS_CORRIGIDO>0
* Calcula o código do item a partir do número do quadro e do número do item;
*NQuadroItem = int((NQuadro*100000 + NItem + 50000));
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem + COD_ITEM)
gen DESPESA=(VAL_INSS_CORRIGIDO*FATOR_ANUAL)
* OBSERVAÇÃO: note que para construir a variável NQuadroItem, adicionou-se
* 50000 à forma de cálculo para se criar os códigos fictícios que vão 
* de 19501 a 19548;

* Captura os valores do INSS dos empregados domésticos na variável 'valordeflanual';
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\T_SERVICO_DOMS_INSS.dta", replace

* Cria a variável NQuadroItem dos itens referentes à contribuição previdenciária;
use "D:\OneDrive\POF2008\Dados\T_RENDIMENTOS.dta", clear
*rename COD_UF UF
*rename NUM_SEQ SEQ 
*rename NUM_DV DV 
*rename NUM_UC UC
*rename COD_DOMC DOMC

keep if  VAL_DEDUCAO_PREV_CORRIGIDO>0
* Calcula o código do item a partir do número do quadro e do número do item
*gen NQuadroItem= n_quadro*100000
*gen NQuadroI=(NQuadroItem + PosOcup*100+300000)
*gen N_quadroitem= int(NQuadroI)
gen NQuadroItem= NUM_QUADRO*100000
gen NQuadroI=(NQuadroItem +  COD_POSI_OCUPA*100)

* OBSERVAÇÃO: note que para construir a variável NQuadroItem, adicionou-se
* 300000 à forma de cálculo para se criar o quadro fictício de no. 56 e os
* códigos fictícios de 56001 a 56010;

* Captura os valores da contribução previdenciária na variável 'valordeflanual'
gen DESPESA = VAL_DEDUCAO_PREV_CORRIGIDO
keep COD_UF NUM_SEQ NUM_DV COD_DOMC NUM_UC DESPESA NQuadroI RENDA_TOTAL
save "D:\OneDrive\POF2008\Dados\filtroprevidencia.dta", replace


* Junta todos os arquivos de despesas em um único arquivo e utiliza a variável
*  construída NQuadroItem para classificar as despesas de acordo com o plano
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

**merge com o banco de compatibilização dos codigos pof e codigos matriz
use "D:\OneDrive\POF2008\Dados\despesastotais.dta", clear
sort NQuadroI
merge m:m NQuadroI using "D:\OneDrive\POF2008\Olga\POF_SCN128.dta"
drop if _merge==2
drop _merge
save "D:\OneDrive\POF2008\Dados\filtrototal.dta", replace
**no merge nem o grupo 2 vai ter registros
*tab _merge
*_merge=2 tem 2984 observaçoes (grupos que estão no cod pof mas que nao apresentaram despesa)
