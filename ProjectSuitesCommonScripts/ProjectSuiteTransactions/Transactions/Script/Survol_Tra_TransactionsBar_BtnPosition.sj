//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Tra_MenuBar_EditFunctions_Info

/* Description : A partir du module « Transactions » ,Rechercher un deposit et afficher la fenêtre en cliquant sur le bouton TransactionsBar_BtnPosition. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_TransactionsBar_BtnPosition()
{  
   var type="";  // Le variable utilisée dans les points de vérifications 
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 3000)){  
      WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
      WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("IsVisible", true, 30000); 
      
      //rechercher un deposit
      if (language=="french"){    
        Search_Transactions_Type("Dépôt")}
      else {
        Search_Transactions_Type("Deposit")}
      
      //afficher la fenêtre en cliquant sur le bouton TransactionsBar_BtnPosition
      Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "10"], 10).WaitProperty("IsVisible", true, 30000);
      Get_TransactionsBar_BtnPosition().Click();
    
      //Les points de vérification en français 
      if(language=="french"){Check_Properties_Info_Cash_French()}// la fonction est dans CommonCheckpoints
      //Les points de vérification en anglais 
      else{Check_Properties_Info_Cash_English()} // la fonction est dans CommonCheckpoints
      //Les points de vérification
      Check_Existence_Of_Controls_Info_Cash(type) // la fonction est dans CommonCheckpoints
   }
   else {
       Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   //La fermeture de la fenêtre 
   Get_WinPositionInfoBalance_BtnCancel().Click();
   
   Close_Croesus_X();
}