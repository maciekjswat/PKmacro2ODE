#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
# https://github.com/maciekjswat/PKmacro2ODE
#*******************************************************************************
# This is the starting point for the conversion tool PKmacro2ODEs
# - start with selecting the approriate 'inputMacro' which refers to
# to an approriate macro set in the 'macroSet' folder
#*******************************************************************************

rm(list=ls())
cat("\014")

# ----------- HOW TO CHOSE A MODEL FROM 'macroSets' FOLDER ------------
# CHOOSE ONE OF THE ADVAN's: advan1/2/3/4/10/11/12.txt
inputMacro <- readLines('macroSets/advan10.txt', n = -1)
# OR few more complex cases
#inputMacro <- readLines('macroSets/example_1comp_kaKtrMtt_k.txt', n = -1)
#inputMacro <- readLines('macroSets/example_complex2.txt', n = -1)
#inputMacro <- readLines('macroSets/example_complex3.txt', n = -1)
#inputMacro <- readLines('macroSets/oneCompWithEffect.txt', n = -1)
#inputMacro <- readLines('macroSets/example10.txt', n = -1)
#inputMacro <- readLines('macroSets/admin2.txt', n = -1)
#inputMacro <- readLines('macroSets/test.txt', n = -1)

# empty list - for macros
m <- list(); mainMacros <- list(); otherMacros <- list(); ODE <- list();
cmtNumber <- list(); cmtAmount <- list(); cmtVolume <- list(); 
cmtConcentration <- list(); 

AENumber = 0; AE <- list();
inputNumber = 0; Input <- list();

for (i in 1: length(inputMacro)) {
  m <- c(m,inputMacro[i])
}

source("macroSplit.R", verbose=FALSE);
source("extractName.R", verbose=FALSE);
source("extractMain.R", verbose=FALSE);
source("extractOthers.R", verbose=FALSE);
source("processMainMacros.R", verbose=FALSE);
source("processOtherMacros.R", verbose=FALSE);
source("valueOfArgument.R", verbose=FALSE);
source("extract_kij.R", verbose=FALSE);
source("process_kij.R", verbose=FALSE);
source("identifyArgument.R", verbose=FALSE);
source("xArgument.R", verbose=FALSE);

# (P1) - EXTRACT MAIN MACROS
resultsM <- extractMain(m);
numberMain <- resultsM[1]; # print(numberMain);
endVector <- 2+as.numeric(numberMain)-1;
mainMacros <- resultsM[2:endVector]; # print(mainMacros);

# (P2) - EXTRACT OTHER MACROS
resultsO <- extractOthers(m);
if (length(resultsO) > 0) {
  otherMacros <- resultsO;
}

# (P3) - PROCESS MAIN MACROS (compartment so far)
for (i in 1:length(mainMacros)) {
  print(''); 
  print(paste('------------- processing main macros:',i,'--------------'))
  
  oneMacro <- as.character(mainMacros[i]);
  processMainMacros(oneMacro,ODE,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
}

# (P4) - PROCESS OTHER MACROS (oral, iv)
if (length(otherMacros) > 0) {
  for (i in 1:length(otherMacros)) {
    print('');
    print(paste('------------- processing other macros:',i,'-------------'))
    oneMacro <- as.character(otherMacros[i]);
    processOtherMacros(oneMacro,ODE,AE,Input,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
  }
}

print('');
print('------------------------------------------------------')
print('------------------RESULTS-----------------------------')
print('------------------------------------------------------')
#print('------------------cmtNumber---------------------------')
#print(cmtNumber); 
#print('------------------cmtAmount---------------------------')
#print(cmtAmount); 
#print('------------------cmtVolume---------------------------')
#print(cmtVolume); 
#print('------------------cmtConcentration--------------------')
#print(cmtConcentration);
print('------------------ODE---------------------------------')
print(ODE);
print('------------------AE----------------------------------')
print(AE);
print('------------------Administrations---------------------')
print(Input);
print('------------------Input Check-------------------------')
for (i in 1:length(m)) {
  print(m[[i]])
}
