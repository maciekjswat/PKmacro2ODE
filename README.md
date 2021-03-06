# PKmacro2ODE

Set of R scripts for the conversion of PK macros to 
* plain text ordinary differential equations (ODE) and algebraic equations (AE)
* information about Administration/Input not captured by equations

### Warnings/Limitations
* PKmacro2ODE handles well-defined macros only
* No validation is build in yet
* Macros are assumed to be formulated without defaults

### Quick Intro
* The strating point is the 'testRun.R' file.
* Select the appropriate model located in the 'macroSets' subfolder
by editing the lines 12-21 - all of the examples are described in the 
PDF document.
E.g. to run any of the ADVAN1-4 & 10-12 edit the line 15, e.g.
`inputMacro <- readLines('macroSets/advan11.txt', n = -1)`
* If you use RStudio just click the Run icon or use the appropriate 
shortcut for your OS. To 'source the current document' under 
Windows & Linux use `Ctrl+Shift+S`, under Mac `Command+Shift+S`.
(https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts)

### Example:
The set of PK macros corresponding to ADVAN12 reads
```
compartment(cmt=1, amount=Ac, volume=V, concentration=C)
peripheral(k12, k21, amount=Ap1, volume=Vp1, concentration=Cp1)
peripheral(k13, k31, amount=Ap2, volume=Vp2, concentration=Cp2)
oral(adm=1, cmt=1, ka)
elimination(cmt=1, k) 
```
The translation results into ODEs and information about 
the input and dataset connectivity will be will be displayed as:
```
----------------------- processing macro 1 -------------------- 
compartment(cmt=1,amount=Ac,volume=V,concentration=C) 
 
----------------------- processing macro 2 -------------------- 
peripheral(k12,k21,amount=Ap1,volume=Vp1,concentration=Cp1) 
 
----------------------- processing macro 3 -------------------- 
peripheral(k13,k31,amount=Ap2,volume=Vp2,concentration=Cp2) 
 
----------------------- processing macro 4 -------------------- 
oral(adm=1,cmt=1,ka) 
 
----------------------- processing macro 5 -------------------- 
elimination(cmt=1,k) 
 
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
...
```