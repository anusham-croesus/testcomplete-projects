//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2372

function Regression_Model_ChainerModelePortefeuille()
{
  Login(vServerModeles, userName ,psw ,language);
  
  Get_ModulesBar_BtnModels().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Models().Click();
  Get_MenuBar_Modules_Models_DragSelection().Click();
  
  Get_ModelsGrid_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  var ColumnName = Get_ColumnIndex(Get_ModelsGrid_ChName());
  var ColumnNo = Get_ColumnIndex(Get_ModelsGrid_ChModelNo());
  var line = Get_Grid_ContentArray(Get_ModelsGrid(), Get_ModelsGrid_ChModelNo())[0];
  
  var modelName = line[ColumnName];
  var modelNo = line[ColumnNo];
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  var expected = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "NomOngletModelePortefeuille", language);
  expected = aqString.Replace(expected, "*nom*", modelName);
  expected = aqString.Replace(expected, "*numero*", modelNo);
  var detected = Get_Portfolio_Tab(1).WPFControlText;
  
  if(expected == detected)
    Log.Checkpoint("Le nom d'onglet est correct.");
  else
    Log.Error("Le nom d'onglet est incorrect.", "Expected: " + expected + "\r\nDetected: " + detected);
  
  expected = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "ModelePortefeuille", language);
  detected = Get_PortfolioGrid_LblBlinkingText().WPFControlText;
  
  if(expected == detected)
    Log.Checkpoint("Le texte clignotant est correct.");
  else
    Log.Error("Le texte clignotant est incorrect.", "Expected: " + expected + "\r\nDetected: " + detected);
  
  var pic = Get_PortfolioGrid_LblBlinkingText().Picture();
  
  var blinked = false;
  for(n = 0; n < 20 && !blinked; n++)
     blinked = !pic.Compare(Get_PortfolioGrid_LblBlinkingText().Picture());
  
  if(blinked)
    Log.Checkpoint("Le texte clignotant clignote.");
  else
    Log.Error("Le texte clignotant ne clignote pas.");
  
  Close_Croesus_MenuBar();
}