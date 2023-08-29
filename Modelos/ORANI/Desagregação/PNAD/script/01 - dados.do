
******* UNIVERSIDADE FEDERAL DO PARANÁ                         *******
******* PÓS-GRADUAÇÃO EM DESENVOLVIMENTO ECONÔMICO             *******
******* ORIENTADOR: VINÍCIUS DE ALMEIDA VALE                   *******
******* CO-ORIENTADORA: KÊNIA BARREIRO DE SOUZA                *******
******* DISCENTE: FELIPE DUPLAT LUZ                            *******

*** DISSERTAÇÃO: COMÉRCIO INTERNACIONAL, DESIGUALDADE DE RENDA E POBREZA NO BRASIL: UMA ANÁLISE INTEGRADA DE EQUILÍBRIO GERAL E MICROSSIMULAÇÃO

*--- DEFINIR DIRETÓRIO ---
set more off
global root     "D:/Documentos/Universidade/UFPR/- Dissertação/Modelos/ORANI/Desagregação/PNAD"
global dados    "$root/dados"
global raw      "$root/dados/raw"
global auxiliar "$root/dados/auxiliares"

cd "$root"

*--- BAIXAR DADOS ------------------

*--- PNAD (PESSOAS) ---
datazoom_pnad, years(2015) original("$raw") saving(.) pes ncomp


*--- TRADUTOR ---
merge m:m v9907_novo using "$auxiliar/SCN68.dta"
drop if _merge==2
drop _merge



*--- ORGANIZAR DADOS -----------------------

*--- FILTRAR OBSERVAÇÕES ---
drop if inlist(v0401, 6, 7, 8) | v4719 == . | v4719 == 999999999999


*--- CRIAR DUMMYS ---
gen nqualif    = inrange(anoest, 0, 4)
gen semiqualif = inrange(anoest, 5, 12)
gen qualif     = anoest >= 13


*--- ROTULAR VARIÁVEIS ---
la var nqualif    "=1 se não é qualificação (até Primário)"
la var semiqualif "=1 se é semi-qualificação (até Ensino Médio)"
la var qualif     "=1 se tem qualificação (Ensino Superior)"
rename id_dom id_fam
rename v4732 peso
rename v4719 renda


*--- SELECIONAR VARIÁVEIS ---
keep id_fam peso SCN68 renda nqualif semiqualif qualif



*--- CRIAR TABELAS -----------------------

*--- SETORES POR CEM PERCENTIS DE RENDA ---
gen renda_anual = renda * 12
collapse (sum) peso renda_anual, by(id_fam SCN68)
egen quantil = cut(renda_anual), group(101)
collapse (sum) renda_anual, by(SCN68 quantil)
reshape wide renda_anual, i(SCN68) j(quantil)
foreach var of varlist renda_anual* {
    local newvar : subinstr local var "renda_anual" "HH"
    rename `var' `newvar'
}


*--- SETORES POR QUALIFICAÇÃO ---




*--- EXPORTAR PARA O EXCEL -----------------------







