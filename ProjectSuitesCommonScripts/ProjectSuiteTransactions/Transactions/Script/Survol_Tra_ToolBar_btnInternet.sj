//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Transaction ». Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu */

 //******************************* une anomalie JIRA:BNC-276 *****************************************
 
 function Survol_Tra_ToolBar_btnInternet() // Le texte du bouton est différant pour le module Transaction : à la place du Access your browser home page... Access the H_ome Page of Your Browser...
 {  
   var module="transaction"
   
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click();
   
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
   {
       WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
       WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
       Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
       //Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu
       Get_Toolbar_BtnInternet().Click();
   }
   else
   {
       Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
   
   if(client == "BNC" ){
       //Les points de vérification en français 
      if(language=="french"){Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_French(module)}// la fonction est dans CommonCheckpoints
    
        //Les points de vérification en anglais 
      else {Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_English(module)}// la fonction est dans CommonCheckpoints    
      Check_ToolBar_InternetForPortfolioTransactionsSecurity_Existence_Of_Controls(module) // la fonction est dans CommonCheckpoints 
   }
   else{//RJ
     aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions(), "IsVisible", cmpEqual, true);
     
       if(language=="french"){
           aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions().Header, "OleValue", cmpEqual, "_Aller à la page d'accueil de votre navigateur...");
           aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions().Header, "OleValue", cmpEqual, "_Composer une adresse...");
       }
       else{
          aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_AccessYourBrowserHomePageForTransactions().Header, "OleValue", cmpEqual, "Access the H_ome Page of Your Browser...");
          aqObject.CheckProperty(Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddressForTransactions().Header, "OleValue", cmpEqual, "_Compose Address...");
       }
   }
  Get_MainWindow().SetFocus();
  Close_Croesus_X();

 }
