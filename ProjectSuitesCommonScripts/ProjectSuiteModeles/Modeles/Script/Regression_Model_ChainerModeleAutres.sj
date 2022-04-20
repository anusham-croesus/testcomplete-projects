//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2373

function Regression_Model_ChainerModeleAutres()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Transactions().Click();
  if(!Get_MenuBar_Modules_Transactions_DragSelection().Enabled)
    Log.Checkpoint("On ne peut pas mailler vers Transactions.");
  else
    Log.Error("On peut mailler vers Transactions.");
  
  Get_MenuBar_Modules_Securities().Click();
  if(!Get_MenuBar_Modules_Securities_DragSelection().Enabled)
    Log.Checkpoint("On ne peut pas mailler vers Titres.");
  else
    Log.Error("On peut mailler vers Titres.");
  
  Close_Croesus_MenuBar();
}