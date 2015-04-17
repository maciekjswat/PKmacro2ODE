#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
# https://github.com/maciekjswat/PKmacro2ODE
#*******************************************************************************
# extract_kij.R - function extracts 'kij=numerical/string' 
# expressions from a peripheral macro
#*******************************************************************************

extract_kij <- function( inputString ){    #  print('inside extract_kij')
    
  # first split
  L0 <- strsplit( inputString, "[()]" );                # print(L0)

  # assign macro name
  macroName <- L0[[1]][1];                              # print(macroName)
#  if (macroName == 'peripheral') {
#    print('correct peripheral macro')
#  }
  
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

  hitFlag = 0
  # go over all argNames and find the 'argName'
  for (i in 1:length(prePAIRS[[1]]))
  {
 #   print(paste('pair number i:',i))
    NamesValues <- strsplit(PAIRS[[i]],"[=]")
    
    hitOrNoHit1 = regexpr('k[0-9][0-9]$',NamesValues[[1]][1])
    hitOrNoHit2 = regexpr('k[0-9][0-9][0-9][0-9]$',NamesValues[[1]][1])
    hitOrNoHit3 = regexpr('k_[0-9]_[0-9]$',NamesValues[[1]][1])
    hitOrNoHit4 = regexpr('k_[0-9][0-9]_[0-9][0-9]$',NamesValues[[1]][1])
    while (hitFlag < 1) {
      if (hitOrNoHit1[1]==1 || hitOrNoHit2[1]==1 || hitOrNoHit3[1]==1 || hitOrNoHit4[1]==1 ) { # print(hitOrNoHit1[1]) print(hitOrNoHit2[1]) print(hitOrNoHit3[1]) print(hitOrNoHit4[1])
        if (is.na(NamesValues[[1]][2])) {                 # if argValue not available (NA=na)
          kArgumentName <- NamesValues[[1]][1]
          kArgumentValue <- 'noValue'
        } else {
          kArgumentName <- NamesValues[[1]][1]
          kArgumentValue <- NamesValues[[1]][2]
        }
        hitFlag = hitFlag + 1;
      }   
    }
  }

  bindResults <- c(kArgumentName,kArgumentValue)
  return(bindResults)
}
