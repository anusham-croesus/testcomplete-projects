//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_MenuBar_EditSearch

 /* Description :Aller au module "Transaction" en cliquant sur BarModules-btnTransaction.  
Afficher la fenêtre « Rechercher »  par clavier.. 
Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre par Esc*/

 function Survol_Tra_Search_KeybordSearch()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
   {
     WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
     WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
     Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
     
     Get_MainWindow().Keys("F");
   }
   else
   {
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
    
  //Les points de vérification 
  Check_Properties(language);
   
  Get_WinTransactionsQuickSearch_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();
 }