//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA


function Help_Billing_BillingParameters_F1()
{
  Login(vServerHelp, userNameBilling, pswHelp, language);
  Get_MenuBar_Tools().Click();
  Get_MenuBar_Tools_Billing().Click();
  
  Terminate_IEProcess();
  
  Get_WinBillingParameters_RdoInArrears().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 42, columnID));
  
  Terminate_IEProcess();
  Get_WinBillingParameters().Close();
  Close_Croesus_MenuBar();
}
