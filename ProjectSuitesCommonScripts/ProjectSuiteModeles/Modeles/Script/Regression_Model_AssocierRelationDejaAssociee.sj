//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2343

function Regression_Model_AssocierRelationDejaAssociee()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModele = "CH AMERICAN EQUI";
  var nameRelation = "#3 TEST";
  
  if (client == "CIBC") nameModele = "*FALL BACK";
  
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
  Get_WinPickerWindow_DgvElements().FindChild("Value", nameRelation, 10).Click();
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  
  var relationAssocie = Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().FindChild("Value", nameRelation, 10);
  if(relationAssocie.Exists)
  {
    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Relationships().Click();
    Get_WinPickerWindow_DgvElements().FindChild("Value", nameRelation, 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    if(!Get_WinAssignToModel_BtnYes().Visible)
      Log.Checkpoint("Relation déjà associée ne peut être associée.");
    else
      Log.Error("Relation déjà associée peut être associée.");
    Get_WinAssignToModel_BtnClose().Click();
    relationAssocie.Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
  }
  else
    Log.Error("Relation non associée.");
  
  Close_Croesus_MenuBar();
}