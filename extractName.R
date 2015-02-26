#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# extractName.R - function which 
# extracts and returns macro names for any macro
#*******************************************************************************

extractName <- function( inputString ){
  
  # print('------- inside extractName -------')
  # print(inputString)
  # split
  L0 <- strsplit( inputString, "[()]" ); # print(L0)

  # assign macro name
  macroName <- L0[[1]][1]; # print(macroName)
  
return(macroName);
}

