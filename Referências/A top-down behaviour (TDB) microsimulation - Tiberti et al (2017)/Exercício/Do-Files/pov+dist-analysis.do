* pov+dist-analysis.do

args yrnum

* to test:
if "`yrnum'" == "" {
  local yrnum = 5
  capture log close
  log using "..\Output\tmp-rep.log", replace
}



drop _all


* define matrix to store simulation results; one row per year
local dum = `yrnum'
matrix fgtdecomp = J(`dum',7,.) 
matrix colnames fgtdecomp = time welfare wage nonWageNonAg nonWageAg CPI Total
matrix list fgtdecomp

* initialize counter; second row of matrix distindic
local cnt = 1


* decomposition analysis by income factors (Shapley rule - adecomp routine)
forvalues i=1(1)`yrnum' {
  use "..\Output\sim`i'-base.dta", clear

  summ welfare*

  append using "..\Output\sim`i'-example.dta"
  * some minor adjustments are necessary as the sum of factors sometimes do not give exactly the new real income
  * (i.e., the sum of median values!=median value)
  gen check_`i' = (welfare + delta_hh_wage_sim`i' + delta_2_sim`i' + delta_3_sim`i') / cpi_sim`i'
  gen diff_`i'_ = (welfare_sim`i' - check_`i') * cpi_sim`i'
  gen diff_`i'  = (welfare_sim`i' - check_`i') * cpi_sim`i'
  egen sum_`i'  = rsum(delta_hh_wage_sim`i' delta_2_sim`i' delta_3_sim`i')

  foreach var of varlist delta_hh_wage_sim`i' delta_2_sim`i' delta_3_sim`i' {
    gen w_`var'   = `var'/sum_`i'
    replace `var' = `var' + w_`var'*diff_`i' if diff_`i'_!=0
    replace `var' = 0 if `var'==.
  }

  * adecomp does not allow the use of string variable in by option
  egen sim_alt = group(sim)
  adecomp welfare_sim`i' welfare delta_hh_wage_sim`i' delta_2_sim`i' delta_3_sim`i' cpi_sim`i' ///
    [w=wgt09_sim`i'], id(pid) by(sim_alt) eq((c1+c2+c3+c4)/c5) varpl(z) in(fgt0) std
  * start: save results
  matrix tmp = r(b)
  matrix fgtdecomp[`cnt',1] = `i'
  matrix fgtdecomp[`cnt',2] = tmp[1,3]
  matrix fgtdecomp[`cnt',3] = tmp[2,3]
  matrix fgtdecomp[`cnt',4] = tmp[3,3]
  matrix fgtdecomp[`cnt',5] = tmp[4,3]
  matrix fgtdecomp[`cnt',6] = tmp[5,3]
  matrix fgtdecomp[`cnt',7] = tmp[6,3]
  
  * end: save results  
    
  * increase counter
  local cnt = `cnt' + 1  
}




* the following commands use DASP
* to install DASP, follow the instructions below)
/*
net from http://dasp.ecn.ulaval.ca/modules/DASP_V2.3/dasp
net install dasp_p1, force
net install dasp_p2, force
net install dasp_p3, force
net install dasp_p4, force
*/

* declare survey design
svyset ea [pweight=wgt09_sim`i'], strata(stratum)

* define matrix to store dist results; one row per year
local dum = `yrnum'+1
matrix distindic = J(`dum',7,.) 
matrix list distindic
matrix colnames distindic = time FGT0_base FGT0_example FGT1_base FGT1_example Gini_base Gini_example

* observed (initial) poverty rate
ifgt welfare, alpha(0) pline(100)
matrix tmp = e(est) 
matrix distindic[1,1] = 0
matrix distindic[1,2] = tmp[1,1]
matrix distindic[1,3] = tmp[1,1]
* observed (initial) poverty gap rate
ifgt welfare, alpha(1) pline(100)
matrix tmp = e(est) 
matrix distindic[1,4] = tmp[1,1]
matrix distindic[1,5] = tmp[1,1]
* observed (initial) gini coeff
igini welfare
matrix tmp = e(est) 
matrix distindic[1,6] = tmp[1,1]
matrix distindic[1,7] = tmp[1,1]

* define matrix to store diff gini results; one row per year
matrix diginiindic = J(`dum',9,.) 
matrix list diginiindic
matrix colnames diginiindic = time gini_base standardDe_base gini_example standardDe_example diff ///
standardDe_diff lowBound_diff upperBound_diff ///


* define matrix to store diff fgt results; one row per year
matrix difgtindic = J(`dum',13,.) 
matrix list difgtindic
matrix colnames difgtindic = time FGT0_base FGT0_example diff0 standardDev0 lowBound0 upperBound0 ///
FGT1_base FGT1_example diff1 standardDev1 lowBound1 upperBound1



* initialize counter; second row of matrix distindic
local cnt = 2

forvalues i=1(1)`yrnum' {

  use "C:\uga2010\microsim-2017-01-19\Output\welfare_sim`i'-base.dta", clear
  merge 1:1 hhid pid using "..\Output\welfare_sim`i'-example.dta"

  * declare survey design
  svyset ea [pweight=wgt09_sim`i'], strata(stratum)
  
  ifgt welfare welfare_sim`i'_base welfare_sim`i'_example, alpha(0) pline(100)
  * start: save results
  matrix tmp = e(est)  
  matrix distindic[`cnt',1] = `i'       //time
  matrix distindic[`cnt',2] = tmp[2,1]  //fgt0 sim base
  matrix distindic[`cnt',3] = tmp[3,1]  //fgt0 sim example

  ifgt welfare welfare_sim`i'_base welfare_sim`i'_example, alpha(1) pline(100)
  matrix tmp = e(est)  
  matrix distindic[`cnt',4] = tmp[2,1]  //fgt1 sim base
  matrix distindic[`cnt',5] = tmp[3,1]  //fgt1 sim example

  igini welfare welfare_sim`i'_base welfare_sim`i'_example
  matrix tmp = e(est)  
  matrix distindic[`cnt',6] = tmp[2,1]  //gini sim base
  matrix distindic[`cnt',7] = tmp[3,1]  //gini sim example

  matrix list distindic
  * end: save results

  
  display "===###=== Running digini ===###==="

  digini welfare_sim`i'_base welfare_sim`i'_example
  matrix tmp1 = e(d1)
  matrix tmp2 = e(d2)
  matrix tmp3 = e(di)
  matrix diginiindic[`cnt',1] = `i'
  matrix diginiindic[`cnt',2]  = tmp1[1,1] //gini base  
  matrix diginiindic[`cnt',3]  = tmp1[1,2] //gini base standard dev
  matrix diginiindic[`cnt',4]  = tmp2[1,1] //gini non-base base  
  matrix diginiindic[`cnt',5]  = tmp2[1,2] //gini non-base standard dev
  matrix diginiindic[`cnt',6]  = tmp3[1,1] //gini difference
  matrix diginiindic[`cnt',7]  = tmp3[1,2] //gini difference standard dev  
  matrix diginiindic[`cnt',8]  = tmp3[1,5] //gini difference low bound  
  matrix diginiindic[`cnt',9]  = tmp3[1,6] //gini difference high bound  

  matrix list diginiindic


  display "===###=== Running difgt ===###==="
  
  difgt welfare_sim`i'_base welfare_sim`i'_example, alpha(0) pline1(100) pline2(100)
  matrix tmp1 = e(b)
  matrix tmp2 = e(di)
  matrix difgtindic[`cnt',1] = `i'
  matrix difgtindic[`cnt',2] = tmp1[1,1] //FGT0 base
  matrix difgtindic[`cnt',3] = tmp1[1,3] //FGT0 non-base
  matrix difgtindic[`cnt',4] = tmp2[1,1] //Difference
  matrix difgtindic[`cnt',5] = tmp2[1,2] //Standard Dev
  matrix difgtindic[`cnt',6] = tmp2[1,3] //Low Bound
  matrix difgtindic[`cnt',7] = tmp2[1,4] //Upper Bound
  matrix list difgtindic

  difgt welfare_sim`i'_base welfare_sim`i'_example, alpha(1) pline1(100) pline2(100)
  matrix tmp1 = e(b)
  matrix tmp2 = e(di)
  matrix difgtindic[`cnt',8]  = tmp1[1,1] //FGT1 base
  matrix difgtindic[`cnt',9]  = tmp1[1,3] //FGT1 non-base
  matrix difgtindic[`cnt',10] = tmp2[1,1] //Difference
  matrix difgtindic[`cnt',11] = tmp2[1,2] //Standard Dev
  matrix difgtindic[`cnt',12] = tmp2[1,3] //Low Bound
  matrix difgtindic[`cnt',13] = tmp2[1,4] //Upper Bound
  matrix list difgtindic
  

  display "===###=== Running cfgt ===###==="  
  
  cfgt welfare_sim`i'_base welfare_sim`i'_example, alpha(0) type(nor) min(50) max(150) xline(100) 
  graph save "..\Output\Graphs\cfgt-`i'.gph", replace

  display "===###=== Running cfgts2d ===###==="  
  
  cfgts2d welfare_sim`i'_base welfare_sim`i'_example, alpha(0) min(50) max(150)
  graph save "..\Output\Graphs\cfgts2d-`i'.gph", replace

  
  * prepare the data to draw growth incidence curves
  collapse(mean) welfare_sim`i'_base welfare_sim`i'_example wgt09_sim`i' ea stratum [aw=wgt09_sim`i'], by(perc_sim0)

  gen ln_perc_base`i' = ln(1 + welfare_sim`i'_base)
  gen ln_perc_example`i' = ln(1+welfare_sim`i'_example)

  gen growth_sim`i' = (ln_perc_example`i' - ln_perc_base`i')*100

  * draw non-parametric curve of growth rates along the whole distribution
  cnpe growth_sim`i', xvar(perc_sim0) min(0) max(100) band(3.0) ytitle(% growth VS BaU) ///
    xtitle(percentiles) yline(0) title("") ytitle(, size(small)) xtitle(, size(small)) legend(size(small)) xline(29.4)
  graph save "..\Output\Graphs\cnpe-`i'.gph", replace


  * increase counter
  local cnt = `cnt' + 1  

}


*### show and save fgt decomp results
matrix list fgtdecomp
* save results in distindic.xlsx
drop _all
* create variables from matrix fgtdecomp
svmat fgtdecomp, names(col)
export excel using "..\Output\report.xlsx", firstrow(variables) sheet("fgtdecomp") sheetmodify cell(A2)


*### show and save diff gini results
matrix list diginiindic
* save results in distindic.xlsx
drop _all
* create variables from matrix difgtindic
svmat diginiindic, names(col)
export excel using "..\Output\report.xlsx", firstrow(variables) sheet("diginiindic") sheetmodify cell(A2)

*### show and save diff fgt results
matrix list difgtindic
* save results in distindic.xlsx
drop _all
* create variables from matrix difgtindic
svmat difgtindic, names(col)
export excel using "..\Output\report.xlsx", firstrow(variables) sheet("difgtindic") sheetmodify cell(A2)


*### show and save dist results
matrix list distindic

* save results in distindic.xlsx
drop _all
* create variables from matrix distindic
svmat distindic, names(col)
export excel using "..\Output\report.xlsx", firstrow(variables) sheet("distindic") sheetmodify cell(A2)


