//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2362

function Regression_Model_ChainerModeleCompte()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModele = "CH AMERICAN EQUI";
  var nameAccount = "800300-NA";
  
  if (client == "CIBC") nameModele = "*FALL BACK";
  
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
  Get_WinPickerWindow_DgvElements().Keys(nameAccount.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(nameAccount.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_DragSelection().Click();
  
  if(Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameAccount, 10).Exists)
    Log.Checkpoint("Le compte est bien chainé.");
  else
    Log.Error("Le compte n'est pas chainé.");
  
  Get_ModulesBar_BtnModels().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameAccount, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Close_Croesus_MenuBar();
}