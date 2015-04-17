# PKmacro2ODE
# https://github.com/maciekjswat/PKmacro2ODE

Set of R scripts for the conversion of PK macros to 
* plain text ODEs
* information about Administration/Input not captured by equations

Warnings/Limitations
* PKmacro2ODE handles well-defined macros only
* No validation is build in yet
* Macros are assumed to be formulated without defaults

Quick Intro
* The strating point is the 'testRun.R' file.
* Select the appropriate model located in the 'macroSets' subfolder
by editing the lines 12-21.
E.g. to run any of the ADVAN1-4 & 10-12 editi the line
inputMacro <- readLines('macroSets/advan11.txt', n = -1)
* If you use RStudio just click the Run icon OR use the appropriate 
shortcut for your OS. 

I.e. 'source the current document' with  
-- Windows & Linux: Ctrl+Shift+S	
-- Mac: Command+Shift+S

More on:
https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts 
