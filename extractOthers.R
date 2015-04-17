#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
# https://github.com/maciekjswat/PKmacro2ODE
#*******************************************************************************
# extractOthers.R - function which 
# extracts the macro names from an array of macros 'm'
# returns all but 'compartment' and 'peripheral' once
#*******************************************************************************

extractOthers <- function( m ){
  
  # m = input macro list
  ms <- list();
  for (i in 1:length(m)) {
    ms[i] <- gsub(" ","",m[[i]]); # print(m[i])
    
    m_name <- extractName(m[[i]]); # print(m_name)  
  
    if (m_name == 'compartment' || m_name == 'peripheral') {
      
    } else {
      otherMacros <- c(otherMacros, ms[i]);
    }
  }
  
  return(otherMacros);
}