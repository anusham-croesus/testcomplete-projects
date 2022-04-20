//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions

/* Description : A partir du module « Transactions » , afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */

 function Survol_Tra_MenuBar_EditSum()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
    //afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum.
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Sum().Click();
    
    //Les points de vérification 
    Check_Properties(language)
    
    Get_WinTransactionsSum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 
  //Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties(language)
{
   if (client == "BNC" ){
      aqObject.CheckProperty(Get_WinTransactionsSum(), "Title", cmpEqual,  GetData(filePath_Transactions,"Sum",2,language));    
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Sum",3,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose(), "IsEnabled", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsCAD(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",4,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADBuy(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADSell(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADDeposit(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADWithdrawal(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADCommission(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactions(), "IsVisible", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsUSD(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",5,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDBuy(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDSell(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDDeposit(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDWithdrawal(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDCommission(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactions(), "IsVisible", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsEUR(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",6,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURBuy(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURSell(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURDeposit(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURWithdrawal(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURCommission(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsEURNumberOfTransactions(), "IsVisible", cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTotal(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",7,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalBuy(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalSell(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalDeposit(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalWithdrawal(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalCommission(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalNumberOfTransactions(), "IsVisible", cmpEqual, true);
    
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblBuy(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",8,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblSell(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",9,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblDeposit(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",10,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblWithdrawal(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",11,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblCommission(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",12,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblNumberOfTransactions(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",13,language));
    }
    else{
      aqObject.CheckProperty(Get_WinTransactionsSum(), "Title", cmpEqual,  GetData(filePath_Transactions,"Sum",2,language));    
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose().Content, "Text", cmpEqual, GetData(filePath_Transactions,"Sum",3,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_BtnClose(), "IsEnabled", cmpEqual, true);
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsCADRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",14,language));}
    else{
    aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsCADRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",4,language));}
      
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADBuyRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADSellRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADDepositRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADWithdrawalRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADCommissionRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsCADNumberOfTransactionsRJ(), "IsVisible", cmpEqual, true);
    if(client == "US" ){
    aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsUSDRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",15,language));}
    else{
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTransactionsUSDRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",5,language));} 
      
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDBuyRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDSellRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDDepositRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDWithdrawalRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDCommissionRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTransactionsUSDNumberOfTransactionsRJ(), "IsVisible", cmpEqual, true);
    if(client == "US" ){ aqObject.CheckProperty(Get_WinTransactionsSum_LblTotalRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",16,language));}
    else{
      aqObject.CheckProperty(Get_WinTransactionsSum_LblTotalRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",7,language));
    } 
      
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalBuyRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalSellRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalDepositRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalWithdrawalRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalCommissionRJ(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinTransactionsSum_TxtTotalNumberOfTransactionsRJ(), "IsVisible", cmpEqual, true);
    
    
      aqObject.CheckProperty(Get_WinTransactionsSum_LblBuyRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",8,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblSellRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",9,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblDepositRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",10,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblWithdrawalRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",11,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblCommissionRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",12,language));
      aqObject.CheckProperty(Get_WinTransactionsSum_LblNumberOfTransactionsRJ(), "Text", cmpEqual, GetData(filePath_Transactions,"Sum",13,language));
    
    }
  
}

