//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Account_Add_ClientList_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnAccounts().Click();
  Get_Toolbar_BtnAdd().Click();
  
  Terminate_IEProcess();
  
  Get_WinPickerWindow_DgvElements().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 27, columnID));
  
  Get_WinPickerWindow().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
