//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_ManageSearchCriteria_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnManageSearchCriteria().Click();
  
  Terminate_IEProcess();
  
  Get_WinSearchCriteriaManager_BtnAdd().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne incorrecte (erreur CROES-7956)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 13, columnID)); //EM : CO-90-07-23 : Avant 20
  
  Get_WinSearchCriteriaManager().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
