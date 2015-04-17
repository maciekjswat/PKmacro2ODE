#*******************************************************************************
# Copyright (C) 2015 EMBL-EBI - All rights reserved.
#*******************************************************************************
# xArgument.R - function returns 'argValue' or 'argName' - a bit repetitive 
# as similar to 'valueOfArgument' function but useful in some cases.
# 'valueOfArgument' is used when you definitely know that there is one.
#*******************************************************************************

xArgument <- function( inputMacro, argName ){

  if (valueOfArgument(inputMacro,argName)=='noValue') {
      xArgument=argName;
    } else {
      xArgument=valueOfArgument(inputMacro,argName);
    }

  return(xArgument)
}