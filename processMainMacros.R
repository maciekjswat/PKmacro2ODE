#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# processMainMacros.R function
# to process main macros - one marco at a time
#*******************************************************************************

processMainMacros <- function( inputString, ODE, cmtNumber, cmtAmount, cmtVolume, cmtConcentration ){
  
  print('processMainMacros: processing cleaned input cleanMacro')
  cleanMacro <- gsub(" ","",inputString) 
  print(cleanMacro)
  
  output <- macroSplitFct(cleanMacro)  # print(paste('function output:',output[1]))

#  amountNames <- output[2]  # print(amountNames)
  macroName <- output[3]  # print(macroName)
  argNames <- output[4]  # print(argNames)
  argValues <- output[5]  # print(argValues)

  k<-length(ODE)+1;
  if (macroName == 'compartment') {
    cmtNumber <<- c(cmtNumber, as.numeric(valueOfArgument(cleanMacro,'cmt'))) # update 'cmtNumber' vector 
    cmtAmount <<- c(cmtAmount, valueOfArgument(cleanMacro,'amount'))          # update 'cmtAmount' vector 
    cmtVolume <<- c(cmtVolume, valueOfArgument(cleanMacro,'volume'))          # update 'cmtVolume' vector 
    cmtConcentration <<- c(cmtConcentration, valueOfArgument(cleanMacro,'concentration'))   # update 'cmtConcentration' vector 
    for (i in 1:length(argNames[[1]])) {
      if (argNames[[1]][i] == 'amount') {
        ODE[k] <<- paste('d',argValues[[1]][i],"/dt=",sep='')
      }
    }
  }
  
  if (macroName == 'peripheral' ) {
    # extract 'kij' argument
    # print(''); print('processMainMacros: extract_kij')
    kij <- extract_kij(cleanMacro)
    
    # process_kij: input i,j -> output: from comp 'i', peripheral comp id 'j'
    print('processMainMacros: process_kij')
    ijIndexes <- process_kij(kij[1]);
    fromCompIndex <- ijIndexes[1];      # usually the central compartment
    periphCompIndex <- ijIndexes[2];
    inverted_kij <- paste('k',ijIndexes[2],ijIndexes[1],sep = '')
    
    cmtNumber <<- c(cmtNumber, periphCompIndex)                               # update 'cmtNumber' vector - add peripheral
    cmtAmount <<- c(cmtAmount, valueOfArgument(cleanMacro,'amount'))          # update 'cmtAmount' vector
    cmtVolume <<- c(cmtVolume, valueOfArgument(cleanMacro,'volume'))          # update 'cmtVolume' vector
    cmtConcentration <<- c(cmtConcentration, valueOfArgument(cleanMacro,'concentration'))   # update 'cmtConcentration' vector
    for (i in 1:length(argNames[[1]])) {
      if (argNames[[1]][i] == 'amount') {
        ODE[k] <<- paste('d',argValues[[1]][i],'/dt= ',kij[1],'*',cmtAmount[fromCompIndex],' - ',inverted_kij,'*',valueOfArgument(cleanMacro,'amount'),sep='')
      }
    }
    ODE[fromCompIndex] <<- paste(ODE[fromCompIndex],' - ',kij[1],'*',cmtAmount[fromCompIndex],' + ',inverted_kij,'*',valueOfArgument(cleanMacro,'amount'),sep='')
  }

  # paste return
  returnVector <- c(ODE,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
  return(returnVector)
}
