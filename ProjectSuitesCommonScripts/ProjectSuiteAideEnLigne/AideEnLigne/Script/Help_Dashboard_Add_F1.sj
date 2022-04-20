//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Dashboard_Add_F1()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_Toolbar_BtnAdd().Click();
  
  Terminate_IEProcess();
  
  Get_DlgAddBoard_BtnCancel().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("CROES-8580")
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 31, columnID));
  
  Get_DlgAddBoard().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
