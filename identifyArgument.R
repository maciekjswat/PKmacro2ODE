#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# identifyArgument.R - function checks whether a given argument is present in a macro
#*******************************************************************************

identifyArgument <- function( inputString, argName ){    #  print('inside identifyArgument')
  
  argFlag <- 0; nameList <- list();
  cleanMacro <- gsub(" ","",inputString) 
  
  hitOrNoHit <- grep(argName,inputString)  # returns NUMERIC 1 or 0
  if (length(hitOrNoHit)==0) {
    hitOrNoHit <- 0
  } else if (hitOrNoHit==1) {
  }
  
  return(hitOrNoHit)
}
