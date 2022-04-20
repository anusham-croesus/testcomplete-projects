//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Performance_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
  
  Terminate_IEProcess();
  
  Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 19, columnID));
  
  Get_WinPerformance().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
