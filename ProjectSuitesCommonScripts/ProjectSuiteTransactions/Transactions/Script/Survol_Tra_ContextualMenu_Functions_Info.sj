//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_MenuBar_EditFunctions_Info

/* Description : A partir du module « Transactions » ,Rechercher un transfer et afficher la fenêtre « Info » par ContextualMenu_Functions_Info. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_ContextualMenu_Functions_Info()
{
   var type="transfer";// Le variable utilisée dans les points de vérifications 
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){  
       Delay(2000);
       if(client == "US" || client == "TD" || client == "CIBC"){
          Search_Transactions_Type("Transfer");
       } 
    
          // rechercher un transfer
         //Search_Transactions_Type("Transfer");
    
          //Rechercher un transfer et afficher la fenêtre « Info » par ContextualMenu_Functions_Info.
        //  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
        //  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
        //  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "56"], 10).WaitProperty("VisibleOnScreen", true, 30000);
       Get_MainWindow().Keys("[Apps]")

     //Get_Transactions_ContextualMenu_Functions().Click();
  
 var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
  Get_MainWindow().Keys("[Apps]")
   // Get_Transactions_ContextualMenu_Functions().Click();
    numberOftries++;
  } 
  Get_Transactions_ContextualMenu_Functions().Click();
  Get_Transactions_ContextualMenu_Functions_Info().Click()



        //Les points de vérification 
        Check_InfoTransactions_Properties(language,type)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
        Check_InfoTransactions_Properties_TabAmounts(language)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
        Check_InfoTransactions_Properties_TabGainsLosses(language)//la fonction est dans le scrip Survol_Tra_MenuBar_EditFunctions_Info
   }
   else {
       Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   //La fermeture de la fenêtre «Info»
   Get_WinTransactionsInfo_BtnCancel().Click();   
   Close_Croesus_AltF4();
}
