//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA


function Help_Billing_FeeSchedule_Add_ClickRight()
{
  Activate_Inactivate_PrefBranch("0","PREF_BILLING_FEESCHEDULE","YES",vServerHelp);
  RestartServices(vServerHelp);
  
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_MenuBar_Tools().Click();
  Get_MenuBar_Tools_Configurations().Click();
  Get_WinConfigurations_TvwTreeview_LlbBilling().Click();
  Get_WinConfigurations_LvwListView_LlbManageBilling().DblClick();
  Get_WinBillingConfiguration_TabFeeSchedule_BtnAdd().Click();
  
  Terminate_IEProcess();
  
  Log.Warning("La fenêtre ne possède pas d'aide en ligne.");
  Get_WinFeeTemplateEdit().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 42, columnID));
  
  Terminate_IEProcess();
  Get_WinFeeTemplateEdit().Close();
  Get_WinBillingConfiguration().Close();
  Get_WinConfigurations().Close();
  Close_Croesus_MenuBar();
}
