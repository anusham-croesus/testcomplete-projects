//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2320

function Regression_Model_MenuContext_Copier()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().ClickR(Get_ModelsGrid().width / 2, Get_ModelsGrid_ChModelNo().height + 5);
  Get_ModelsGrid_ContextualMenu_Copy().Click();
  
  var grid = Get_Grid_ContentArray(Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  
  var copyText = Sys.Clipboard;
  copyText = copyText.split("\t");
  
  if(copyText.length != grid[0].length)
    Log.Error("Tailles différentes entre le fichier et la grille", "Application: " + grid[0].length + 
                                                                   "\r\nFichier texte: " + copyText.length);
  
  for(n = 0; n < copyText.length; n++)
  {
    if(aqString.Compare(copyText[n], grid[0][n], true) == 0 || ((copyText[n] == "Oui" || copyText[n] == "Yes") && grid[0][n] == "True") ||
                                                               ((copyText[n] == "Non" || copyText[n] == "No") && grid[0][n] == "False"))
      Log.Checkpoint("identique - " + grid[0][n]);
    else
      Log.Error("non identique - " + grid[0][n], "Application: " + grid[0][n] + "\r\nTexte Copié: " + copyText[n]);
  }
  
  Close_Croesus_MenuBar();
}
