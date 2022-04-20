﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT DBA


function Help_Sleeve_Create_F1()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_user where STATION_ID = '" + userNameHelp + "'", vServerHelp, "config_txt");
  try {
    Activate_Inactivate_Pref(userNameHelp,"PREF_SLEEVE_ALLOW_CREATE","YES",vServerHelp);
    Activate_Inactivate_Pref(userNameHelp,"PREF_SLEEVE_ALLOW_VIEW","YES",vServerHelp);
    Activate_Inactivate_Pref(userNameHelp,"PREF_SLEEVE_ALLOW_SYNC","YES",vServerHelp);
    Activate_Inactivate_Pref(userNameHelp,"PREF_SLEEVE_ALLOW_DELETE","YES",vServerHelp);
    Activate_Inactivate_Pref(userNameHelp,"PREF_SLEEVE_ALLOW_TRADE","YES",vServerHelp);
    Activate_Inactivate_Pref(userNameHelp,"PREF_ENABLE_SLEEVES","YES",vServerHelp);
    RestartServices(vServerHelp);
    
    Login(vServerHelp, userNameHelp, pswHelp, language);
    Get_ModulesBar_BtnAccounts().Click();
    Get_MenuBar_Modules().Click();
    Get_MenuBar_Modules_Portfolio().Click();
    Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
    Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().Click();
    Get_Portfolio_AssetClassesGrid().keys("^a");
    Get_Portfolio_AssetClassesGrid().ClickR();
    Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
  
    Terminate_IEProcess();
    
    Log.Message("CROES-8591")
    Get_WinManagerSleeves_GrpSleeves_BtnAdd().Keys("[F1]");
  
    var columnID;
    if(language == "french") columnID = 1;
    else columnID = 2;
  
    aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                  "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 39, columnID));
  
    Get_WinManagerSleeves().Close();
    Terminate_IEProcess();
    Close_Croesus_MenuBar();
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    Execute_SQLQuery("update b_user set config_txt = '" + configTxt + "' from b_user where STATION_ID = '" + userNameHelp + "'", vServerHelp);
    RestartServices(vServerHelp);
  }
}
