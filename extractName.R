#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
# https://github.com/maciekjswat/PKmacro2ODE
#*******************************************************************************
# extractName.R - function which 
# extracts and returns macro names for any macro
#*******************************************************************************

extractName <- function( inputString ){
  
  # print(inputString)
  # split
  L0 <- strsplit( inputString, "[()]" ); # print(L0)

  # assign macro name
  macroName <- L0[[1]][1]; # print(macroName)
  
return(macroName);
}

