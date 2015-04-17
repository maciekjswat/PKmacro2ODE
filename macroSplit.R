#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
# https://github.com/maciekjswat/PKmacro2ODE
#*******************************************************************************

macroSplitFct <- function( inputString ){
  # rm(list=setdiff(ls(), 'inputString'))  print(inputString)
  
  # empty list - for collection of the 'amount' attribute names  
  # required to for use in equations later when constructing rate terms
  amountNames <- list()
  
  # firsat split
  L0 <- strsplit( inputString, "[()]" ); # print(L0)

  # assign macro name
  macroName <- L0[[1]][1]; #  print(macroName)
  
  # extract the second all-pairs-string
  prePAIRS <- strsplit(L0[[1]][2],","); #  print(prePAIRS);

  # extract pairs
  PAIRS <- list();
  for (i in 1:length(prePAIRS[[1]]))
  {
    PAIRS <- c(PAIRS, prePAIRS[[1]][i]);
  }

  #extract argNames & argValues
  argNames <- list(); # initialise list
  argValues <- list(); # initialise list
  for (i in 1:length(prePAIRS[[1]]))
  {
    NamesValues <- strsplit(PAIRS[[i]],"[=]");
   
    argNames <- c(argNames, NamesValues[[1]][1]);
    argValues <- c(argValues, NamesValues[[1]][2]);
    
    if (NamesValues[[1]][1] == "amount") {
      amountNames <- c(amountNames,NamesValues[[1]][2]); #print(amountNames)
    }
  }
  
outputDescription <- c('outputDescription','amountNames','macroName','argNames','argValues')
return(list(outputDescription,amountNames,macroName,argNames,argValues));
}

