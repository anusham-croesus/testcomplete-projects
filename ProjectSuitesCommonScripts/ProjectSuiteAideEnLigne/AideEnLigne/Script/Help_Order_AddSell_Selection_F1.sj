//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Order_AddSell_Selection_F1()
{
  Login(vServerHelp, userNameOrders, pswOrders, language);
  Get_ModulesBar_BtnOrders().Click();
  Get_Toolbar_BtnCreateASellOrder().Click();
  
  Terminate_IEProcess();
  
  Log.Warning("La fenêtre ne possède pas d'aide en ligne.");
  Log.Message("CROES-7956")
  Get_WinFinancialInstrumentSelector().Keys("[F1]");
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 41, columnID));
  
  Get_WinFinancialInstrumentSelector().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
