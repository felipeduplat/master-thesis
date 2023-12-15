* master.do
* Luca Tiberti
* luca.tiberti@ecn.ulaval.ca
* Martin Cicowiez
* martin@depeco.econo.unlp.edu.ar

clear all

set more off

* set path
cd "D:\Documentos\Universidade\UFPR\- Dissertação\Referências\A top-down behaviour (TDB) microsimulation - Tiberti et al (2017)\Exercício\Do-Files"

* open log file
capture log close
log using "D:\Documentos\Universidade\UFPR\- Dissertação\Referências\A top-down behaviour (TDB) microsimulation - Tiberti et al (2017)\Exercício\Output\PEP-Microsimulations.log", replace

/*
notation:
  i = current year of simulation
  k = previous year of simulation (i.e., k=i-1)
  s = type of worker according to his/her skills (s=0 for unskilled; s=1 for skilled)
  e = employment category (e=1 for wage workers; e=2 for non-agricultural self-employed; e=3 for farmers; e=4 for not working)
  j = activity sector (1=non-agriculture; 2=agriculture)
  t = loop within the same simulation
  c = commodities (1...30)
*/

* note: in the current version, pov+dist analysis only works with two simul 
* named base and example

local sim ///
  base    ///
  example

foreach scen in `sim' {

  * seed for random numbers generator; relevant for replicability
  set seed 121212

  * number of iterations, used in master.do and compute-welfare.doi
  local iternum = 2
  * number of years, used in master.do and pov+dist-analysis.do
  local yrnum = 20

  
  * start: Definition of Scenario -----------------------------------

//  include "Scen-Files\scen-defn-`scen'.doi"
  include "Scen-Files\scen-defn.doi"

  * end: Definition of Scenario -------------------------------------

  
  * define the program that generate thes random errors for the mlogit
  * reference is Bourguignon, Fournier and Gurgand (2001)
  do "calibrate-ocup.do"

  * iterate over years
  forvalues i = 1(1)`yrnum' {
    
    * if changes are estimated from the preceding year, define the year preceding 
    * the current year; otherwise, use the base year - 0 - if changes are
    * with respect to the base year
//  local k = `i' - 1
    local k=0

    * define the loops for sim`i' (i.e., how many times run sim`i' - it is 
    * suggested to run it a sufficiently large number of times; e.g., 100)
    forvalues t = 1(1)`iternum' {
    
      * load data
      use "..\Raw-Data\Uganda2009.dta", clear
      
      * static ageing = population growth
      * in this example, already included in data -- no need to run pop-growth.doi
      * include pop-growth.doi
      
      * sim changes in occupational categories 
      include "sim-ocup.doi"
   
      * sim changes in labor incomes
      include "sim-labor-inc.doi"

      * sim changes in total household income
      include "sim-hhd-inc.doi"

      }

    * poverty+dist analysis
    include compute-welfare.doi

  }

}

* poverty and distributive analysis
do pov+dist-analysis.do `yrnum'

log close
