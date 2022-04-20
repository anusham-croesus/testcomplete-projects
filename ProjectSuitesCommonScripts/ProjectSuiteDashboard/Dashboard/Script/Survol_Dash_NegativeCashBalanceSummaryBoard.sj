//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Sommaire de l'encaisse négative" et vérifier les entêtes de colonne. */

function Survol_Dash_NegativeCashBalanceSummaryBoard()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
  //Vider le tableau de bord et ajouter le tableau "Sommaire de l'encaisse négative"
  Clear_Dashboard();
  Get_Toolbar_BtnAdd().Click();
  Get_DlgAddBoard_TvwSelectABoard_NegativeCashBalanceSummary().Click();
  Get_DlgAddBoard_BtnOK().Click();
  WaitObject(Get_CroesusApp(), ["BoardTitle","VisibleOnScreen"], [GetData(filePath_Dashboard, "Add_Board", 13, language), true]);

//  Delay(2000);
  //Ajouter toutes les entêtes de colonne
  Get_Dashboard_NegativeCashBalanceSummaryBoard_ChBalance().ClickR();
  while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
  {
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click();
    Get_Dashboard_NegativeCashBalanceSummaryBoard_ChBalance().ClickR();
  }  
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 2, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChCheckBoxOnOff(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 3, language)); //Checkbox (entête vide)
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChBalance(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 4, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 5, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChName(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 6, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChIACode(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 7, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 8, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChCurrency(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 9, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAssignedTo(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 10, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChDateOfBirth(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 11, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChAge(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 12, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChLastContact(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 13, language));
  aqObject.CheckProperty(Get_Dashboard_NegativeCashBalanceSummaryBoard_ChFullName(), "Content", cmpEqual, GetData(filePath_Dashboard, "NegativeCashBalanceSummaryBoard", 14, language));
  
  //Fermer Croesus
  Get_MainWindow().Keys("[Esc]");
  Close_Croesus_X();
}
