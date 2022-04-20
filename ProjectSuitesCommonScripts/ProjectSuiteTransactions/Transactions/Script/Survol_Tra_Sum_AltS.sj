//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_MenuBar_EditSum

/* Description : A partir du module « Transactions » , afficher la fenêtre « Sommation des titres » avec AltS . 
 Vérifier la présence des contrôles et des étiquetés */

 function Survol_Tra_Sum_AltS()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
    //afficher la fenêtre « Sommation des titres » avec AltS 
    //Get_MainWindow().Keys("~s") 
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_WinTransactionsSum().Exists){
      Get_MainWindow().Keys("~s") ;
      numberOftries++;
    }
        
    //Les points de vérification 
    Check_Properties(language)
    
    Get_WinTransactionsSum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
 }