function extractMainMacros(macroInput)
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
}
