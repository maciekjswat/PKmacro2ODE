#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# extractMain.R - function which 
# extracts the macro names from an array of macros 'm'
# returns the 'main' once: 'compartment' and 'peripheral'
#*******************************************************************************

extractMain <- function( m ){
  
  # m = macroSet
  ms <- list();
  for (i in 1:length(m)) {
    ms[i] <- gsub(" ","",m[[i]]); # print(m[i])
    
    m_name <- extractName(m[[i]]); # print(m_name)  
    
    if (m_name == 'compartment' || m_name == 'peripheral') {
      mainMacros <- c(mainMacros, ms[i]);
    }
  }
  
  return(c(length(mainMacros),mainMacros));
}