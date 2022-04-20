//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_Fills_F1()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  
  var n = 0;
  while(!Get_OrdersBar_BtnFills().Enabled && n++ < 30)
  {
    Get_OrderGrid().Keys("[Down]");
  }
  Get_OrdersBar_BtnFills().Click();
  
  Terminate_IEProcess();
  
  Get_WinOrderFills_GrpFills_CmbDate().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("CROES-7953")
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinOrderFills().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
