//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2368

function Regression_Model_ChainerModeleCompte_DroitDacces()
{
  //Créer le modèle et associer des comptes
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username"),
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameModele = "Test-" + UniqueID;
  var nameAccountsBD88 = ["300006-OB", "300011-NA", "600002-NA"];
  //var nameAccountsBD66 = ["800065-FS", "800068-FS", "800079-GT"]; //EM: 90-06-Be-26 : Cangement dûe au changement de la BD -- le compte "800068-FS" est déja associé a un autre modele
  var nameAccountsBD66 = ["800065-FS", "800079-GT"];
  
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModele);
  Get_WinModelInfo_GrpModel_CmbIACode().Click();
  Get_WinModelInfo_GrpModel_CmbIACode().Keys("BD88");
  Log.Message("Il n'est pas possible d'entrer un code CP manuellement (CROES-8812)");
  Get_WinModelInfo_BtnOK().Click();
  
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
  var nameAccounts = nameAccountsBD88.concat(nameAccountsBD66);
  for(n = 0; n < nameAccounts.length; n++)
  {
    Get_WinPickerWindow_DgvElements().Keys(nameAccounts[n].charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(nameAccounts[n].slice(1));
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_DgvElements().FindChild("Value", nameAccounts[n], 10).Click(-1, -1, n == 0 ? skNoShift : skCtrl);
  }
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Close_Croesus_MenuBar();
  
  //Chainer le modèle et tester
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username"),
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_DragSelection().Click();
  
  var chaineCorrectement = true;
  for(n = 0; n < nameAccountsBD88.length; n++)
    if(!Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameAccountsBD88[n], 10).Exists)
    {
      chaineCorrectement = false;
      Log.Error("Le compte " + nameAccountsBD88[n] + " devrait être visible.");
    }
  for(n = 0; n < nameAccountsBD66.length; n++)
    if(Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameAccountsBD66[n], 10).Exists)
    {
      chaineCorrectement = false;
      Log.Error("Le compte " + nameAccountsBD66[n] + " ne devrait pas être visible.");
    }
  
  if(chaineCorrectement)
    Log.Checkpoint("Les comptes BD88 sont visibles et les comptes BD66 ne sont pas visibles.");
  Close_Croesus_MenuBar();
  
  //Supprimer le modèle
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username"),
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Keys("^a");
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Get_Toolbar_BtnDelete().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Close_Croesus_MenuBar();
}