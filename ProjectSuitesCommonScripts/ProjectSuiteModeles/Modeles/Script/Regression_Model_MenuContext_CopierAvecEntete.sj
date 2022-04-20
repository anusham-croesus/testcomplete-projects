//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2321

function Regression_Model_MenuContext_CopierAvecEntete()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().ClickR(Get_ModelsGrid().width / 2, Get_ModelsGrid_ChModelNo().height + 5);
  Get_ModelsGrid_ContextualMenu_CopyWithHeader().Click();
  
  var grid = Get_Grid_ContentArrayWithHeader(Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  
  var copyText = Sys.Clipboard;
  copyText = aqString.Replace(copyText, "\r\n", "\n", true);
  copyText = copyText.split("\n");
  if(copyText[copyText.length - 1].length == 0)
    copyText.pop();
  for(n = 0; n < copyText.length; n++)
    copyText[n] = copyText[n].split("\t");
  
  if(copyText[0].length != grid[0].length)
    Log.Error("Tailles différentes entre le fichier et la grille", "Application: " + grid[0].length + 
                                                                   "\r\nFichier texte: " + copyText[0].length);
  
    
  for(n = 0; n < copyText.length; n++)
    for(m = 0; m < copyText[n].length; m++)
    {
      if(aqString.Compare(copyText[n][m], grid[n][m], true) == 0 || ((copyText[n][m] == "Oui" || copyText[n][m] == "Yes") && grid[n][m] == "True") ||
                                                                    ((copyText[n][m] == "Non" || copyText[n][m] == "No") && grid[n][m] == "False"))
        Log.Checkpoint("identique - " + grid[n][m]);
      else
        Log.Error("non identique - " + grid[n][m], "Application: " + grid[n][m] + "\r\nTexte Copié: " + copyText[n][m]);
    }
  
  Close_Croesus_MenuBar();
}
