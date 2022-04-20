//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tra_MenuBar_FilePrint

/* Description : A partir du module « Transactions » , afficher la fenêtre « Print » avec ClickR.  
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

 function Survol_Tra_Print_ClickR()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 3000)
  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);

  //afficher la fenêtre « Print » avec ClickR
  Get_MainWindow().ClickR(); 
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MainWindow().ClickR();
    numberOftries++;
  } 
   
  Get_Transactions_ContextualMenu_Print().Click();
  Get_DlgDefinePrintingType_RdoDynamicManageableColumns().Click();
  
  //Les points de vérification
  Check_Properties(language); 
  
  Get_DlgDefinePrintingType_BtnOK().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Tra_Properties_French()}
  //Les points de vérification en anglais 
  else{Check_Print_Tra_Properties_English()}
  
  //Get_DlgPrinting_BtnOKForTransactionsAndAgenda().Click();
      if(Get_DlgInformation().Exists){
      var width = Get_DlgInformation().Get_Width();
      Get_DlgInformation().Click((width*(1/2)),73);         
      }
  Close_Croesus_X();
 }