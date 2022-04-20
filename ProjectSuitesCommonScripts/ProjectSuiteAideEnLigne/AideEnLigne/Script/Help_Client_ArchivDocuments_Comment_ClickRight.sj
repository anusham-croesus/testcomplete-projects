//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_ArchivDocuments_Comment_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_Toolbar_BtnArchiveMyDocuments().Click();
  
  Terminate_IEProcess();
  
  Get_PersonalDocuments_GrpComments().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("Fenêtre possède une aide en ligne différente en anglais (erreur CROES-7990)");
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 17, columnID));
  
  Get_WinPersonalDocuments().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
