//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_ArchivDocuments_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnArchiveMyDocuments().Click();
  
  Terminate_IEProcess();
  
  Get_PersonalDocuments_Toolbar_TxtSearch().keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 15, columnID));
  
  Get_WinPersonalDocuments().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
