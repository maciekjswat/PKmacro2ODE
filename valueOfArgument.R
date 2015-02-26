#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# valueOfArgument.R - function returns 'argValue' for each
# 'argName' in a macro, if assigned, e.g. 
# macroName(argName1=argValue1,argName2,argName3=argValue3,...)
#*******************************************************************************

valueOfArgument <- function( inputString, argName ){    #  print('inside valueOfArgument')
    
  # first split
  L0 <- strsplit( inputString, "[()]" );                # print(L0)

  # assign macro name
  macroName <- L0[[1]][1];                              # print(macroName)
  
  # extract the second all-pairs-string
  prePAIRS <- strsplit(L0[[1]][2],",");                 # print('prePAIRS'); print(prePAIRS)

  # extract pairs and put in a list
  PAIRS <- list()
  for (i in 1:length(prePAIRS[[1]]))
  {
    # remove empty space
    cleanPAIR <- gsub(" ","",prePAIRS[[1]][i]);
    PAIRS <- c(PAIRS, cleanPAIR);                       # print('PAIRS'); print(PAIRS)
  }
  
  # go over all argNames and find the 'argName'
  for (i in 1:length(prePAIRS[[1]]))
  {
    NamesValues <- strsplit(PAIRS[[i]],"[=]")
    
    if (NamesValues[[1]][1] == argName) {
      if (is.na(NamesValues[[1]][2])) {                 # if argValue=NA then
          VOA <- 'noValue'
      } else {
          VOA <- NamesValues[[1]][2];
        }
    }
  }

  return(VOA)
}
