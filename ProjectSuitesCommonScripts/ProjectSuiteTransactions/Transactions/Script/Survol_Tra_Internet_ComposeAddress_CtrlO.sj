//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions

/* Description : A partir du module « Transactions ».
Afficher La fenêtre Composer par Ctrl+O. Vérifier la présence des contrôles dans le menu  */
 
 function Survol_Tra_Internet_ComposeAddress_CtrlO()
 {
   Login(vServerTransactions, userName , psw ,language);
   Get_ModulesBar_BtnTransactions().Click(); 
   Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);
   WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
   WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
   Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000); 
   
  //Afficher La fenêtre Composer
   Get_MainWindow().Keys("^o");
   
   //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
    
    //Les points de vérification en anglais 
  else {Check_Properties_English()}
     
  Check_Existence_Of_Controls(); 

    
  Get_WinComposeAddress_BtnCancelForTransactions().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_SysMenu();
 }
 
   //Fonctions  (les points de vérification pour les scripts qui testent Internet_ComposeAddress )
function Check_Properties_French()
{
  aqObject.CheckProperty(Get_WinComposeAddress(), "Title", cmpEqual, "Composer");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunchForTransactions().Content, "Text", cmpEqual, "_Lancer...");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancelForTransactions().Content, "Text", cmpEqual, "Annuler");
  aqObject.CheckProperty(Get_WinComposeAddress_LblAddressForTransactions().Text, "OleValue", cmpEqual, "Adresse:");
}

function Check_Properties_English()
{
  aqObject.CheckProperty(Get_WinComposeAddress(), "Title", cmpEqual, "Compose");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunchForTransactions().Content, "Text", cmpEqual, "_Launch...");
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancelForTransactions().Content, "Text", cmpEqual, "Cancel");
  aqObject.CheckProperty(Get_WinComposeAddress_LblAddressForTransactions().Text, "OleValue", cmpEqual, "Address:");
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunchForTransactions(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_BtnLaunchForTransactions(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancelForTransactions(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_BtnCancelForTransactions(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinComposeAddress_TxtAddressForTransactions(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComposeAddress_TxtAddressForTransactions(), "IsEnabled", cmpEqual, true);
}
 
