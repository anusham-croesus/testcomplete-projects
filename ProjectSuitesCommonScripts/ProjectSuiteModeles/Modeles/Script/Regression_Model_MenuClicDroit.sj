//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2325

function Regression_Model_MenuClicDroit()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().ClickR();
  Get_ModelsGrid_ContextualMenu_Info().Click();
  
  if(Get_WinModelInfo().Exists)
  {
    Log.Checkpoint("La fenêtre Info s'ouvre avec un clic droit.");
    Get_WinModelInfo().Close();
  }
  else
    Log.Error("La fenêtre Info ne s'ouvre pas avec un clic droit.");
  
  Get_ModelsGrid().Keys("^l");
  
  if(Get_WinModelInfo().Exists)
  {
    Log.Checkpoint("La fenêtre Info s'ouvre avec ctrl+L.");
    Get_WinModelInfo().Close();
  }
  else
    Log.Error("La fenêtre Info ne s'ouvre pas avec ctrl+L.");
  
  Close_Croesus_MenuBar();
}