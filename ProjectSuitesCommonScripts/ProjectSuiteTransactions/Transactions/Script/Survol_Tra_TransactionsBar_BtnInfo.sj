//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT Survol_Tra_MenuBar_EditFunctions_Info

/* Description : A partir du module « Transactions » , afficher la fenêtre « Info » en cliquant sur TransactionsBar_BtnInfo. 
 Vérifier la présence des contrôles et des étiquetés */

function Survol_Tra_TransactionsBar_BtnInfo()
{
   var type="transfer";
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000)){
      Delay(2000);
     if(client == "US" || client == "TD" || client == "CIBC"){
       Search_Transactions_Type("transfer");
     } 
      // rechercher un buy
     //Search_Transactions_Type("transfer");
   
      //afficher la fenêtre « Info » en cliquant sur TransactionsBar_BtnInfo.
      Get_TransactionsBar_BtnInfo().Click();
     
      var numberOftries=0;  
  while ( numberOftries < 5 && !Get_WinTransactionsInfo().Exists){
     Get_TransactionsBar_BtnInfo().Click();
    numberOftries++;
       } 
     //Get_MenuBar_Edit_FunctionsForTransactions_Info().Click();
      
      
     // Get_TransactionsBar_BtnInfo().Click();
      ///Delay(3000);
      
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
