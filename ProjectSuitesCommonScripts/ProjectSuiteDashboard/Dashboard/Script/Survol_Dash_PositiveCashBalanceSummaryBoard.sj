//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Dans le module « Tableau de bord », ajouter le tableau "Sommaire de l'encaisse positive" et vérifier les entêtes de colonne. */

function Survol_Dash_PositiveCashBalanceSummaryBoard()
{
  Login(vServerDashboard, userName, psw, language);
  Get_ModulesBar_BtnDashboard().Click();
  
   if (Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 2000)){
   
       //Vider le tableau de bord et ajouter le tableau "Sommaire de l'encaisse positive"
      Clear_Dashboard();
      Get_Toolbar_BtnAdd().Click();
      Get_DlgAddBoard_TvwSelectABoard_PositiveCashBalanceSummary().Click();
      Get_DlgAddBoard_BtnOK().Click();
   }
   else{
      Log.Error("The BtnDashboard didn't become Checked within 2 seconds.");
   };
   WaitObject(Get_CroesusApp(), ["BoardTitle","VisibleOnScreen"], [GetData(filePath_Dashboard, "Add_Board", 9, language), true]);

//   Delay(2000); 
  //Ajouter tous les entêtes de colonne
  Get_Dashboard_PositiveCashBalanceSummaryBoard_ChBalance().ClickR();
  while (Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true)
  {
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click();
    Get_Dashboard_PositiveCashBalanceSummaryBoard_ChBalance().ClickR();
  }  
  
  //Les points de vérification
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard(), "BoardTitle", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 2, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCheckBoxOnOff(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 3, language)); //Checkbox (entête vide)
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChBalance(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 4, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 5, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChName(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 6, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChIACode(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 7, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChTelephone1(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 8, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChCurrency(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 9, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAssignedTo(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 10, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChDateOfBirth(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 11, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChAge(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 12, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChLastContact(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 13, language));
  aqObject.CheckProperty(Get_Dashboard_PositiveCashBalanceSummaryBoard_ChFullName(), "Content", cmpEqual, GetData(filePath_Dashboard, "PositiveCashBalanceSummaryBoard", 14, language));
  
  //Fermer Croesus
  Get_MainWindow().Keys("[Esc]");
  Close_Croesus_X();
}
