# PKmacro2ODE
## https://github.com/maciekjswat/PKmacro2ODE

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
shortcut for your OS. I.e. 'source the current document' under 
Windows & Linux: Ctrl+Shift+S, under Mac: Command+Shift+S.

More on:
https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts 

Example:
To run PK macro corresponding to ADVAN12 edit the line 15:
inputMacro <- readLines('macroSets/advan12.txt', n = -1).

The rulults are displayed as:

--------------------------------------------------------------- 
------------------------RESULTS-------------------------------- 
--------------------------------------------------------------- 
--- cmtNumber array --- 
1
2
3
4 
--- cmtAmount array  --- 
Ac
Ap1
Ap2
Ad4 
--- cmtVolume array  --- 
V
Vp1
Vp2
noValue 
--- cmtConcentration array  --- 
C
Cp1
Cp2
noValue 
------------------------ODE------------------------------------ 
dAc/dt= - k12*Ac + k21*Ap1 - k13*Ac + k31*Ap2 + ka*Ad4 - k*Ac
dAp1/dt= k12*Ac - k21*Ap1
dAp2/dt= k13*Ac - k31*Ap2
dAd4/dt= - ka*Ad4 
------------------------AE------------------------------------- 
 
------------------------Administrations------------------------ 
Input[1]: ORAL administration, adm=1, target=Ad4 

------------------------Input Check---------------------------- 
compartment(cmt=1, amount=Ac, volume=V, concentration=C)
peripheral(k12, k21, amount=Ap1, volume=Vp1, concentration=Cp1)
peripheral(k13, k31, amount=Ap2, volume=Vp2, concentration=Cp2)
oral(adm=1, cmt=1, ka)
elimination(cmt=1, k) 
