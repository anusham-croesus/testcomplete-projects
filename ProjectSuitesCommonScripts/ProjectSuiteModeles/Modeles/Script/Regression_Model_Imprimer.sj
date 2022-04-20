//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2329

function Regression_Model_Imprimer()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_ModelsGrid().ClickR();
  Get_ModelsGrid_ContextualMenu_Print().Click();
  if(Get_DlgPrint().Exists)
  {
    Log.Checkpoint("Dialogue d'impression est présent.");
    Get_DlgPrint().Close();
    //Get_DlgPrinting_BtnOK().Click(); //EM: Modifié pour CO-90-07-22
    Get_DlgInformation().Close();
  }
  else
    Log.Error("Dialogue d'impression est absent.");
  
  Close_Croesus_MenuBar();
}