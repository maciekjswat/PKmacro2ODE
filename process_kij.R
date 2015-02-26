#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# process_kij.R - function extracts 'k','i' and 'j'
# expressions from 'kij'
#*******************************************************************************

process_kij <- function( inputString ){    #  print('inside process_kij')
  
  hitOrNoHit1 = regexpr('k[0-9][0-9]$',inputString, perl=TRUE)              # k13
  hitOrNoHit2 = regexpr('k[0-9][0-9][0-9][0-9]$',inputString, perl=TRUE)    # k0103
  hitOrNoHit3 = regexpr('k_[0-9]_[0-9]$',inputString, perl=TRUE)            # k_1_3
  hitOrNoHit4 = regexpr('k_[0-9][0-9]_[0-9][0-9]$',inputString, perl=TRUE)  # k_01_03
  if (hitOrNoHit1[1]==1) {              # print('hit1')
    iIndex <- substr(inputString,2,2)
    jIndex <- substr(inputString,3,3)
  } else if (hitOrNoHit2[1]==1) {       # print('hit2')
    iIndex <- substr(inputString,2,3)
    jIndex <- substr(inputString,4,5)
  } else if (hitOrNoHit3[1]==1) {       # print('hit3')
    iIndex <- substr(inputString,3,3)
    jIndex <- substr(inputString,5,5)
  } else if (hitOrNoHit4[1]==1) {       # print('hit4')
    iIndex <- substr(inputString,3,4)
    jIndex <- substr(inputString,6,7)
  }
  
  bindResults <- c(as.numeric(iIndex[1]),as.numeric(jIndex[1]))
  return(bindResults)
}
