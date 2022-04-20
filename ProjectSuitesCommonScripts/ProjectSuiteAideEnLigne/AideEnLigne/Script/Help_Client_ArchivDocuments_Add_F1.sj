//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_ArchivDocuments_Add_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnArchiveMyDocuments().Click();
  
  Terminate_IEProcess();
  
  Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
  Get_WinAddAFile_GrpFile_TxtFilePath().keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne incorrecte (erreur CROES-7956)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 16, columnID));
  
  Get_WinAddAFile().Close();
  Get_WinPersonalDocuments().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
