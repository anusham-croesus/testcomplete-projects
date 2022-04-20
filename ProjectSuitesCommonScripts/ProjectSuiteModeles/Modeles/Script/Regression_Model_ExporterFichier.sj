//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2322

function Regression_Model_ExporterFichier()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var fileFullPath = Project.Path + "test_2322.txt";
  if (aqFile.Exists(fileFullPath))
      aqFileSystem.DeleteFile(fileFullPath);
  
  Get_ModelsGrid().ClickR();
  Get_ModelsGrid_ContextualMenu_ExportToFile().Click();
  Get_DlgSelectTheFileName_CmbFileName_TxtFileName().Keys("\"" + fileFullPath + "\"");
  Get_DlgSelectTheFileName_BtnSave().Click();
  
  var grid = Get_Grid_ContentArrayWithHeader(Get_ModelsGrid(), Get_ModelsGrid_ChModelNo());
  
  var fileText = aqFile.ReadWholeTextFile(fileFullPath, aqFile.ctANSI);
  
  fileText = aqString.Replace(fileText, "\r\n", "\n", true);
  fileText = fileText.split("\n");
  if(fileText[fileText.length - 1].length == 0)
    fileText.pop();
  for(n = 0; n < fileText.length; n++)
    fileText[n] = fileText[n].split("\t");
  
  if(fileText.length != grid.length || fileText[0].length != grid[0].length)
    Log.Error("Tailles différentes entre le fichier et la grille", "Application: " + grid[0].length + "x" + grid.length + 
                                                                   "\r\nFichier texte: " + fileText[0].length + "x" + fileText.length);
  
  for(n = 0; n < fileText.length; n++)
    for(m = 0; m < fileText[n].length; m++)
    {
      fileText[n][m] = aqString.Unquote(fileText[n][m]);
      if(aqString.Compare(fileText[n][m], grid[n][m], true) == 0 || ((fileText[n][m] == "Yes" || fileText[n][m] == "Oui") && grid[n][m] == "True") ||
                                                                    ((fileText[n][m] == "No" || fileText[n][m] == "Non") && grid[n][m] == "False"))
        Log.Checkpoint("identique - " + grid[n][m]);
      else
        Log.Error("non identique - " + grid[n][m], "Application: " + grid[n][m] + "\r\nFichier texte: " + fileText[n][m]);
    }
  
  Close_Croesus_MenuBar();
  aqFileSystem.DeleteFile(fileFullPath);
}
