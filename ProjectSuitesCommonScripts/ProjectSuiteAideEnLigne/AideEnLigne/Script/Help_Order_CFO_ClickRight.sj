﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_CFO_ClickRight()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  
  var n = 0;
  while(!Get_OrdersBar_BtnCFO().Enabled && n++ < 30)
  {
    Get_OrderGrid().Keys("[Down]");
  }
  Get_OrdersBar_BtnCFO().Click();
  
  Terminate_IEProcess();
  
  Get_WinOrderDetail_LblSecurity().ClickR();
  Get_Win_ContextualMenu_Help2().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp2().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinOrderDetail().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
