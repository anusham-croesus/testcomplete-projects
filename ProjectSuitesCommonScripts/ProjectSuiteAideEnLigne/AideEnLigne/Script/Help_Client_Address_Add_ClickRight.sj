//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions


function Help_Client_Address_Add_ClickRight()
{
  Login(vServerHelp, userNameHelp, pswHelp, language);
  Get_ModulesBar_BtnClients().Click();
  Get_ClientsBar_BtnInfo().Click();
  
  Terminate_IEProcess();
  
  Get_WinDetailedInfo_TabAddresses().Click();
  Delay(500);
  Get_WinDetailedInfo_TabAddresses_GrpAddresses_BtnAdd().Click();
  
  Get_WinCRUAddress_LblType().ClickR();
  Get_Win_ContextualMenu_Help().HoverMouse();
  Get_Win_ContextualMenu_Help_ContextSensitiveHelp().Click();
  
  var columnID;
  if(language == "french") columnID = 1;
  else columnID = 2;
  
  Log.Message("CROES-8582")
  aqObject.CheckProperty(Get_HelpWindow_Title(vServerHelp),
                                "contentText", cmpEqual, ReadDataFromExcelByRowIDColumnID(filePath_Help, "Feuil1", 8, columnID));

  Log.Message("Il manque le bout .Frame(Fenêtre_principale) du fonction  get: Get_HelpWindow_Title entre Frame(topic) et TextNode(1) pour plus de détail voir le commentaire mise au niveau de la fonction get")                           
  
  
  Get_WinCRUAddress().Close();
  Get_WinDetailedInfo().Close();
  Terminate_IEProcess();
  Close_Croesus_MenuBar();
}
