#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# processOtherMacros.R function
# to process OTHER macros - one marco at a time
#*******************************************************************************

processOtherMacros <- function( inputString,ODE,AE,AENumber,Input,cmtNumber,cmtAmount,cmtVolume,cmtConcentration ){
  
  inputMacro2clean <- gsub(" ","",inputString) 
  print('processOtherMacros: cleaned input inputMacro2clean')
  print(inputMacro2clean)
  
  output <- macroSplitFct(inputMacro2clean)  #print(paste('function output:',output[1]))

#  amountNames <- output[2]  # print(amountNames)
  macroName <- output[3]  # print(macroName)
  argNames <- output[4]  # print(argNames)
  argValues <- output[5]  # print(argValues)

# ORAL
  if ((macroName == 'absorption') || (macroName == 'oral')) {
    for (i in 1:length(argNames[[1]])) {
      
      # ka
      if ((identifyArgument(inputMacro2clean,'ka')==1) && (identifyArgument(inputMacro2clean,'Ktr')==0)) {
        targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))     # print('ODE[1]') print(ODE[1]) print('ODE[targetCompNo]') print(ODE[targetCompNo])

        if (valueOfArgument(inputMacro2clean,'ka')=='noValue') {
          kaArgument='ka';
        } else {
          kaArgument=valueOfArgument(inputMacro2clean,'ka');
        }
        
        ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' + ',kaArgument,'*Ad',length(cmtNumber)+1,sep='')
        # create new depot compartment
        ODE[length(cmtNumber)+1] <<- paste('dAd',length(cmtNumber)+1,'/dt= - ',kaArgument,'*Ad',length(cmtNumber)+1,sep='')
        
        cmtAmount <<- c(cmtAmount, paste('Ad',length(cmtNumber)+1,sep = ''))   # update 'cmtAmount' vector 
        targetCompAmount <- paste('Ad',length(cmtNumber)+1,sep = '')
        
        # ka & Ktr/Mtt
      } else if ( (identifyArgument(inputMacro2clean,'ka')==1) && (identifyArgument(inputMacro2clean,'Ktr')==1)) {
        targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))     # print('ODE[1]') print(ODE[1]) print('ODE[targetCompNo]') print(ODE[targetCompNo])
        
        # extend Ac with 'ka*Aa' 'absorption' compartment
        ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' + ka*Aa',sep='')
        # create new 'absorption' compartment
        ODE[length(cmtNumber)+1] <<- paste('dAa/dt = exp[log(F*Dose)) + log(Ktr) + n*log(Ktr*(t-t_Dose)) - Ktr*(t-t_Dose) - log(n!)] - ka*Aa',sep='')
        
        cmtAmount <<- c(cmtAmount, 'Aa')                                # update 'cmtAmount' vector 
        targetCompAmount <- paste('Dose',sep = '')
        
        # Tk0
      } else if ( (identifyArgument(inputMacro2clean,'Tk0')==1)) {
        targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))     # print('ODE[1]') print(ODE[1]) print('ODE[targetCompNo]') print(ODE[targetCompNo])
        
        ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' + Tk0',targetCompNo,sep='')
        # create new depot compartment
        ODE[length(cmtNumber)+1] <<- paste('dAd',length(cmtNumber)+1,'/dt= - Tk0',targetCompNo,sep='')
        
        cmtAmount <<- c(cmtAmount, paste('Ad',length(cmtNumber)+1,sep = ''))   # update 'cmtAmount' vector 
        targetCompAmount <- paste('Ad',length(cmtNumber)+1,sep = '')
      }
      cmtNumber <<- c(cmtNumber, length(cmtNumber)+1)                 # update 'cmtNumber' vector 
      cmtVolume <<- c(cmtVolume, 'noValue')                           # update 'cmtVolume' vector 
      cmtConcentration <<- c(cmtConcentration, 'noValue')             # update 'cmtConcentration' vector 
    }
    
    # this part needed for the information about the 'Input'
    # second loop for 'adm' or 'type' -> output are 'admTypeType' and 'admType'
    hitFlag = 0;
    for (j in 1:length(argNames[[1]])) {
      while (hitFlag < 1) {
        if (argNames[[1]][j] == 'adm') {
          admTypeType = 'adm'
          admType <- as.numeric(valueOfArgument(inputMacro2clean,'adm'))
        } else if (argNames[[1]][j] == 'type') {
          admTypeType = 'type'
          admType <- as.numeric(valueOfArgument(inputMacro2clean,'type'))
        } else {
          admTypeType <- 'undefined'
        }
        hitFlag = hitFlag + 1;
      }
    }
    
    inputNumber <<- inputNumber + 1;
    if ( admTypeType == 'adm' ) {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: ORAL administration',', adm=',admType,', target=',targetCompAmount, sep = '', collapse = "|")   
    } else if ( admTypeType == 'type') {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: ORAL administration',', type=',admType,', target=',targetCompAmount, sep = '', collapse = "|")  
    } else {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: ORAL administration, target=',targetCompAmount, sep = '', collapse = "|")  
    }
    
    # third loop for 'Tlag' needed for the information about the 'Input' 
    for (z in 1:length(argNames[[1]])) {
      if (argNames[[1]][z] == 'Tlag') {
        tlagValue = valueOfArgument(inputMacro2clean,'Tlag')
        Input[inputNumber] = paste(Input[inputNumber],'; Tlag=',tlagValue, sep = '', collapse = "|")
      }
    }
    
    # third loop for 'p' needed for the information about the 'Input' 
    for (z in 1:length(argNames[[1]])) {
      if (argNames[[1]][z] == 'p') {
        pValue = valueOfArgument(inputMacro2clean,'p')
        Input[inputNumber] = paste(Input[inputNumber],'; p=',pValue, sep = '', collapse = "|")
      }
    }
    Input[inputNumber] <<- Input[inputNumber]
  }
  
# IV
  if (macroName == 'iv') {
    for (i in 1:length(argNames[[1]])) {
      targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))
    }
    # second loop for 'adm' or 'type' -> output are 'admTypeType' and 'admType'
    hitFlag = 0;
    for (j in 1:length(argNames[[1]])) {
      while (hitFlag < 1) {
        if (argNames[[1]][j] == 'adm') {
          admTypeType = 'adm'
          admType <- as.numeric(valueOfArgument(inputMacro2clean,'adm'))
        } else if (argNames[[1]][j] == 'type') {
          admTypeType = 'type'
          admType <- as.numeric(valueOfArgument(inputMacro2clean,'type'))
        } else {
          admTypeType <- 'undefined'
        }
        hitFlag = hitFlag + 1;
      }
    }
    
    inputNumber <<- inputNumber + 1;
    if ( admTypeType == 'adm' ) {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: IV bolus administration',', adm=',admType,', target=',cmtAmount[targetCompNo],sep='')   
    } else if ( admTypeType == 'type') {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: IV bolus administration',', type=',admType,', target=',cmtAmount[targetCompNo],sep='')  
    } else {
      Input[inputNumber] <<- paste('Input[',inputNumber,']: IV bolus administration, target=',cmtAmount[targetCompNo],sep='')  
    }
  }

# TRANSFER
  if (macroName == 'transfer') {
    for (i in 1:length(argNames[[1]])) {
      toCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'to'))
      fromCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'from'))
      transfareRate <- valueOfArgument(inputMacro2clean,'kt')
      ODE[toCompNo] <<- paste(ODE[toCompNo],' + ',transfareRate,'*',cmtAmount[fromCompNo],sep='')
      ODE[fromCompNo] <<- paste(ODE[fromCompNo],' - ',transfareRate,'*',cmtAmount[fromCompNo],sep='')
    }
  }
  
#  ELIMINATION
  if (macroName == 'elimination') {
    if ((identifyArgument(inputMacro2clean,'k')==1) && (identifyArgument(inputMacro2clean,'CL')==0  && (identifyArgument(inputMacro2clean,'Km')==0))) {
      for (i in 1:length(argNames[[1]])) {
        if (argNames[[1]][i] == 'k') {                                  # linear elimination
          targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))
          Aname <- cmtAmount[targetCompNo]
          ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' - k*',Aname,sep='')
        }
      }
    } else if ((identifyArgument(inputMacro2clean,'k')==0) && (identifyArgument(inputMacro2clean,'CL')==0 && (identifyArgument(inputMacro2clean,'Km')==1))) {
      for (i in 1:length(argNames[[1]])) {
        if (argNames[[1]][i] == 'Km') {                                 # MM elimination
          targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))
          Aname <- cmtAmount[targetCompNo]
          ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' - Vm*',Aname,'/(Km + ',Aname,')',sep='')
        }
      }
    } else if ((identifyArgument(inputMacro2clean,'k')==0) && (identifyArgument(inputMacro2clean,'CL')==1 && (identifyArgument(inputMacro2clean,'Km')==0))) {
      for (i in 1:length(argNames[[1]])) {
        if (argNames[[1]][i] == 'CL') {                                 # linear elimination
          targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt'))
          Aname <- cmtAmount[targetCompNo]
          ODE[targetCompNo] <<- paste(ODE[targetCompNo], ' - CL/',cmtVolume[targetCompNo],'*',Aname,sep='')
        } 
      }
    }
  }

# EFFECT
  if (macroName == 'effect') {
    for (i in 1:length(argNames[[1]])) {
      if (argNames[[1]][i] == 'ke0') {                                  # linear effect link
        targetCompNo <- as.numeric(valueOfArgument(inputMacro2clean,'cmt')) # print(targetCompNo)
        Vname <- cmtVolume[targetCompNo]  # print(Vname)
        Aname <- cmtAmount[targetCompNo]  # print(Aname)
        Cname <- cmtConcentration[targetCompNo]  # print(Cname)
        cmtNumber <<- c(cmtNumber, length(cmtNumber)+1)                 # update 'cmtNumber' vector 
        cmtAmount <<- c(cmtAmount, 'noValue')                           # update 'cmtAmount' vector 
        cmtVolume <<- c(cmtVolume, 'noValue')                           # update 'cmtVolume' vector 
        cmtConcentration <<- c(cmtConcentration, valueOfArgument(inputMacro2clean,'concentration'))   # update 'cmtConcentration' vector   
        cmtConcentration <- c(cmtConcentration, valueOfArgument(inputMacro2clean,'concentration'))   # update 'cmtConcentration' vector   
        
        # create new effect compartment
        AENumber = AENumber + 1;
        AE[AENumber] <<- paste(Cname,'= ',Aname,'/',Vname,sep='')
        # create new effect compartment
        ODE[length(cmtNumber)+1] <<- paste('d',cmtConcentration[length(cmtConcentration)],'/dt= ke0*(',Cname,'- Ce)',sep='')
      }
    }
  }
  
  # paste return
  returnVector <- c(ODE,AE,AENumber,Input,inputNumber,cmtNumber,cmtAmount,cmtVolume,cmtConcentration)
  return(returnVector)
}
