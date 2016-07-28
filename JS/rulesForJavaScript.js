function processMainMacros(macroInput)
{
  var mainMacros = new Array(); 
  var macros = splitIntoMacros(macroInput)
  
  for (i = 0; i != macros.length; i++)
  {
    if (macros[i].name == "m1")
      mainMacros[mainMacros.Length] = macros[i];
  }
}

function processOtherMacros(macroInput)
{
  return "other stuff";
}

function translate(myInput)
{
  mainMacros = processMainMacros(myInput);
  otherMacros = processOtherMacros(myInput);
  
  return myInput;
}

function myfunc()
{
  document.getElementById("translation").innerHTML = translate(document.getElementById("userInput").value);
}

/*####################*/
function extractMain( inputString, mainMacros )
{
  var ms = new Array()
  for (i = 0; i != macros.length; i++)
  {
    ms[i] = string.replace(/ /g,'');
    m_name = extractNamems[i]

  }
}

function extractName( inputString )
{
	L0 = split(inputString,"(")
	macroName = L0[0]
	
	return macroName
}



/*function extractMainMacros(macroInput)
{
  var mainMacros = new Array(); 
  var macros = splitIntoMacros(macroInput)
  
  for (i = 0; i != macros.length; i++)
  {
    if (macros[i].name == "m1")
      mainMacros[mainMacros.Length] = macros[i];
  }
}

function processOthers(macroInput)
{
  return "other stuff";
}

function translate(myInput)
{
  mainMacros = extractMainMacros(myInput);
  otherMacros = extractOtherMacros(myInput);
  
  return myInput;
}

function myfunc()
{
  document.getElementById("translation").innerHTML = translate(document.getElementById("userInput").value);
}*/
