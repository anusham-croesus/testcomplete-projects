//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Transactions_Get_functions

 /* Description :Aller au module "Transaction" en cliquant sur BarModules-btnTransaction.  
Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Cancel*/

 function Survol_Tra_MenuBar_EditSearch()
 {
  Login(vServerTransactions, userName , psw ,language);
  Get_ModulesBar_BtnTransactions().Click();
  
   if (Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 2000))
   {
     WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
     WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
     Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
     
     
       //Afficher la fenêtre « Rechercher » en cliquant sur le bouton recherche. 
     Get_Toolbar_BtnSearch().Click();
     
      //Les points de vérification 
      Check_Properties(language)
      
      //fermerla fenetre
      Get_WinTransactionsQuickSearch_BtnCancel().Click();
   
     //Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
     Get_MenuBar_Edit().OpenMenu();
     Get_MenuBar_Edit_Search().Click();
   }
   else
   {
     Log.Error("The BtnTransactions didn't become Checked within 2 seconds.");
   }
    
  //Les points de vérification 
  Check_Properties(language)
   
  Get_WinTransactionsQuickSearch_BtnCancel().Click();
  
  Close_Croesus_MenuBar();
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Search)
 function Check_Properties(language)
{
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_BtnOK().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",2,language));
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",3,language));
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch().Title, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",4,language));
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_LblSearch().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",5,language));
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_LblIn().Text, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",6,language));
  
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoAccountNo().Content, "OleValue", cmpEqual,GetData(filePath_Transactions,"Search",7,language));
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoAccountNo(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoAccountNo(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoType().Content, "OleValue", cmpEqual, GetData(filePath_Transactions,"Search",8,language)); 
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoType(), "IsVisible", cmpEqual, true); 
  aqObject.CheckProperty(Get_WinTransactionsQuickSearch_RdoType(), "IsEnabled", cmpEqual, true); 
}