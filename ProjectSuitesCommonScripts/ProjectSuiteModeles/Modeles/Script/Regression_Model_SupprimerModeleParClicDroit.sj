//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2313

function Regression_Model_SupprimerModeleParClicDroit()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameUsed = "Test-" + UniqueID;
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameUsed);
  Get_WinModelInfo_BtnOK().Click();
  
  Get_ModelsGrid().FindChild("Value", nameUsed, 10).ClickR();
  Get_ModelsGrid_ContextualMenu_Delete().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  if(!Get_ModelsGrid().FindChild("Value", nameUsed, 10).Exists)
    Log.Checkpoint("Modèle supprimé.");
  else
    Log.Error("Le modèle n'a pas été supprimé.");
  
  
  Close_Croesus_MenuBar();
}