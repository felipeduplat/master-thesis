* calibrate-ocup.do

capture program drop draw 

program define draw 
  capture drop u1-u4 
  capture drop v1-v4 
  capture drop pr 

  tempvar i 

  local y `1' 
  local i 1 
  local k 1 

  gen v1 = uniform() 
  gen v2 = uniform() 
  gen v3 = uniform()
  gen v4 = uniform() 

*!!
* note: given what is done below, no need to generate u1-u4 as random numbers  
  gen u1 = uniform() 
  gen u2 = uniform() 
  gen u3 = uniform() 
  gen u4 = uniform() 
  
  gen ur = 0 
  gen pr = 0 
  
  while `i' < 5 { 
    replace u`i' = -ln(-pr_`i'*ln(v`i')) if `i' == `y' 
    replace ur = u`i' if `i' == `y' 
    replace pr = pr_`i' if `i' == `y' 
    local i = `i' + 1 
  } 
  
  while `k' < 5  { 
    replace u`k' = -ln(exp(-ur)*(pr_`k'/pr) - ln(v`k')) if `k' ~= `y' 
    local k = `k' + 1 
  } 
  
end 
