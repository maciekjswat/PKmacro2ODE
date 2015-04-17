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
#inputMacro <- readLines('macroSets/advan12.txt', n = -1)
# OR few more complex cases
#inputMacro <- readLines('macroSets/oneCompWithEffect.txt', n = -1)
#inputMacro <- readLines('macroSets/example9.txt', n = -1)
#inputMacro <- readLines('macroSets/example10.txt', n = -1)
#inputMacro <- readLines('macroSets/example_1comp_kaKtrMtt_k.txt', n = -1)
inputMacro <- readLines('macroSets/example_oneIVthreeORAL.txt', n = -1)
#inputMacro <- readLines('macroSets/example_complex2.txt', n = -1)
#inputMacro <- readLines('macroSets/example_complex3.txt', n = -1)
#inputMacro <- readLines('macroSets/complexTest.txt', n = -1)

#inputMacro <- readLines('macroSets/test2.txt', n = -1)

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
numberMain <- resultsM[1];
endVector <- 2+as.numeric(numberMain)-1;
mainMacros <- resultsM[2:endVector];

# (P2) - EXTRACT OTHER MACROS
resultsO <- extractOthers(m);
if (length(resultsO) > 0) {
  otherMacros <- resultsO;
}

# (P3) - PROCESS MAIN MACROS (compartment & peripheral)
for (i in 1:length(mainMacros)) {
  cat('',"\n"); 
  cat(paste('----------------------- processing macro',i,'---------------------'),"\n")
  oneMacro <- as.character(mainMacros[i]);
  processMainMacros(oneMacro,ODE,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
}

# (P4) - PROCESS OTHER MACROS
if (length(otherMacros) > 0) {
  for (i in 1:length(otherMacros)) {
    cat('',"\n");
    cat(paste('----------------------- processing macro',i+length(mainMacros),'--------------------'),"\n")
    oneMacro <- as.character(otherMacros[i]);
    processOtherMacros(oneMacro,ODE,AE,Input,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
  }
}

cat('',"\n")
cat('---------------------------------------------------------------',"\n")
cat('------------------------RESULTS--------------------------------',"\n")
cat('---------------------------------------------------------------',"\n")
cat('--- cmtNumber array ---',"\n")
cat( paste( cmtNumber, collapse = "\n" ), "\n" );  
cat('--- cmtAmount array  ---',"\n")
cat( paste( cmtAmount, collapse = "\n" ), "\n" );
cat('--- cmtVolume array  ---',"\n")
cat( paste( cmtVolume, collapse = "\n" ), "\n" );
cat('--- cmtConcentration array  ---',"\n")
cat( paste( cmtConcentration, collapse = "\n" ), "\n" );
cat('------------------------ODE------------------------------------',"\n")
cat( paste( ODE, collapse = "\n" ), "\n" );
cat('------------------------AE-------------------------------------',"\n")
cat( paste( AE, collapse = "\n" ), "\n" );  
cat('------------------------Administrations------------------------',"\n")
cat( paste( Input, collapse = "\n" ), "\n\n" );
cat('------------------------Input Check----------------------------',"\n")
cat( paste( m, collapse = "\n" ), "\n" ); 
cat('',"\n")
cat('------------------------HAPPY END------------------------------',"\n")
cat('---------------------------------------------------------------',"\n")

