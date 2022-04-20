//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT Survol_Tra_Internet_ComposeAddress_CtrlO

/* Description : A partir du module « Transaction ».
Afficher La fenêtre Composer en cliquant sur MenuBar_Tools_Internet_ComposeAddress. Vérifier la présence des contrôles dans le menu  */
 
 function Survol_Tra_MenuBar_Tools_Internet_ComposeAddress()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click(); 
  
  Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
  WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
  WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
  Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);  
  
  //Afficher La fenêtre Composer
  Get_MenuBar_Tools().click();
    
  /*var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MenuBar_Tools().OpenMenu();  
    numberOftries++;
  } */
  Get_MenuBar_Tools_Internet().OpenMenu();
  
  if(language=="french"){
    WaitObject(Get_SubMenus(),["ClrClassName", "WPFControlText"], ["MenuItem", "_Composer une adresse..."],1000);}
  else{
    WaitObject(Get_SubMenus(),["ClrClassName", "WPFControlText"], ["MenuItem", "_Compose Address..."],1000);}
  
  Get_MenuBar_Tools_Internet_ComposeAddressForTransactions().Click();
   
   //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}// la fonction est dans Survol_Tra_Internet_ComposeAddress_CtrlO
    
    //Les points de vérification en anglais 
  else {Check_Properties_English()}// la fonction est dans Survol_Tra_Internet_ComposeAddress_CtrlO
     
  Check_Existence_Of_Controls(); // la fonction est dans Survol_Tra_Internet_ComposeAddress_CtrlO 
  
  Get_WinComposeAddress_BtnCancelForTransactions().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X(); 
 }
