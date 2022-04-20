//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2348

function Regression_Model_DeplacerColonnes()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
  //Devise
  var listCol = Get_ModelsGrid_ColumnList();
  var previousConfig = "";
  for(var n = 0; n < 30 && listCol[n] != null; n++)
    previousConfig += listCol[n].WPFControlText;
  
  var distanceMove = listCol[3].ScreenLeft - Get_ModelsGrid_ChCurrency().ScreenLeft - 10;
  Get_ModelsGrid_ChCurrency().Drag(10, 10, distanceMove, 0);
  
  listCol = Get_ModelsGrid_ColumnList();
  var newConfig = "";
  for(var n = 0; n < 30 && listCol[n] != null; n++)
    newConfig += listCol[n].WPFControlText;
  
  if(previousConfig != newConfig)
    Log.Checkpoint("Colonne Devise déplacée.");
  else
    Log.Error("Colonne Devise non déplacée.");
  
  //Nom
  listCol = Get_ModelsGrid_ColumnList();
  previousConfig = "";
  for(var n = 0; n < 30 && listCol[n] != null; n++)
    previousConfig += listCol[n].WPFControlText;
  
  distanceMove = listCol[9].ScreenLeft - Get_ModelsGrid_ChName().ScreenLeft - 10;
  Get_ModelsGrid_ChName().Drag(10, 10, distanceMove, 0);
  
  listCol = Get_ModelsGrid_ColumnList();
  newConfig = "";
  for(var n = 0; n < 30 && listCol[n] != null; n++)
    newConfig += listCol[n].WPFControlText;
  
  if(previousConfig != newConfig)
    Log.Checkpoint("Colonne Nom déplacée.");
  else
    Log.Error("Colonne Nom non déplacée.");
  
  Get_ModelsGrid_ChName().ClickR();
  Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  Close_Croesus_MenuBar();
}