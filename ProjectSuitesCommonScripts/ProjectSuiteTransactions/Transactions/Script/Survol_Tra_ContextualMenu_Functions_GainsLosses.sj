//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_MenuBar_EditFunctions_Info

/* Description : A partir du module « Transactions » , Rechercher un transfer, afficher la fenêtre « Info » en cliquant sur MenuBar - fonctions-GainsLosses. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_ContextualMenu_Functions_GainsLosses()
{
   // Le variable utilisée dans les points de vérifications
   var type="transfer";
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){  
    
     WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
     WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
     Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
     
     if(client == "US" || client == "TD" || client == "CIBC"){
       // rechercher un transfer   
     Search_Transactions_Type(type);
     } 
      // rechercher un transfer   
     //Search_Transactions_Type(type);
     
      //afficher la fenêtre « Info » en cliquant sur MenuBar - fonctions-GainsLosses
      
     Get_MainWindow().Keys("[Apps]")
     WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniActionPopupMenu", "1"]);
     // Get_Transactions_ContextualMenu_Functions().Click();
    //  Delay(2000);
     
      var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MainWindow().Keys("[Apps]")
     WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniActionPopupMenu", "1"]);
      Get_Transactions_ContextualMenu_Functions().Click();

     
    //Get_RelationshipsClientsAccountsGrid()
    numberOftries++;
  } 
  
     Get_Transactions_ContextualMenu_Functions().Click();

     Get_Transactions_ContextualMenu_Functions_GainsLosses().Click();
     WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"]); 
     
      //Les points de vérification 
      Check_InfoTransactions_Properties(language,type)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
      Check_InfoTransactions_Properties_TabAmounts(language)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
      Check_InfoTransactions_Properties_TabGainsLosses(language,type)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
   }
   else {
       Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   //La fermeture de la fenêtre «Info»
   Get_WinTransactionsInfo_BtnCancel().Click();
   
   Close_Croesus_AltF4();
}
