//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Filter_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
  Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
  
  Terminate_IEProcess();
  
  Get_WinCRUFilter_GrpDefinition_TxtName().keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne différente (erreur CROES-8490)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 14, columnID));
  
  Get_WinCRUFilter().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
