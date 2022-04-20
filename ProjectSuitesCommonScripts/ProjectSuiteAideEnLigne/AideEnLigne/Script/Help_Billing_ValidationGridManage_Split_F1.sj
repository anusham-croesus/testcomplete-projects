//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA


function Help_Billing_ValidationGridManage_Split_F1()
{
  Activate_Inactivate_PrefBranch("0","PREF_BILLING_GRID","YES",vServerHelp);
  RestartServices(vServerHelp);
  
  Login(vServerHelp, userNameBilling, pswHelp, language);
  Get_MenuBar_Tools().Click();
  Get_MenuBar_Tools_Configurations().Click();
  Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
  Get_WinConfigurations_LvwListView_LlbManageValidationGrid().DblClick();
  
  Terminate_IEProcess();
  
  Get_WinFeeMatrixConfiguration_DgvFeeMatrix().Keys("[Up]");
  Get_WinFeeMatrixConfiguration_BtnSplit().Click();
  Get_WinAddRange_BtnCancel().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 42, columnID));
  
  Terminate_IEProcess();
  Get_WinAddRange().Close();
  Get_WinFeeMatrixConfiguration().Close();
  Get_WinConfigurations().Close();
  Close_Croesus_MenuBar();
}
