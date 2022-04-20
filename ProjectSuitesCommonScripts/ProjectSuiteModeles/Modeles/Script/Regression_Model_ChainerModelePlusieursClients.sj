//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2361

function Regression_Model_ChainerModelePlusieursClients()
{
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnModels().Click();
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameModel = "TEST-" + UniqueID;
  var nameClients = ["800227", "800232", "800237", "800248"];
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModel);
  Get_WinModelInfo_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModel, 10).Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
  Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
  for(n = 0; n < nameClients.length; n++)
  {
    Get_WinPickerWindow_DgvElements().Keys(nameClients[n].charAt(0));
    Get_WinQuickSearch_TxtSearch().keys(nameClients[n].slice(1));
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinPickerWindow_DgvElements().FindChild("Value", nameClients[n], 10).Click(-1, -1, n == 0 ? skNoShift : skCtrl);
  }
  Get_WinPickerWindow_BtnOK().Click();
  Get_WinAssignToModel_BtnYes().Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Clients().Click();
  Get_MenuBar_Modules_Clients_DragSelection().Click();
  
  Get_Toolbar_BtnSum().Click();
   if(client=="BNC")
     var NumberOfClients = Get_WinClientsSum_TxtNumberOfClients().Text;
  else
    var NumberOfClients = Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD().Value; //EM : Modifié depuis 90-07-23-RJ
    
  if(NumberOfClients  == "" + nameClients.length)
    Log.Checkpoint("Tous les clients associés sont visibles."); else Log.Error("Les clients associés ne sont pas tous visibles.");
  Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
  Get_ModulesBar_BtnModels().Click();
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

function Test()
{
    var NumberOfClients = Get_WinClientsSumNoClientGrouping_TxtNumberOfClientsTotalCAD().Value;
    
    Log.Message("NumberOfClients = "+NumberOfClients);
}