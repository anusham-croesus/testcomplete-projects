//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


 /* Description : A partir du module « Orders » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Ord_MenuBar_EditSearch()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
 
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Search().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else {Check_Properties_English()}
  
  Check_Existence_Of_Controls()
  
  Get_WinQuickSearch_BtnCancel().Click()
  
  Close_Croesus_MenuBar() 
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Search)
function Check_Properties_French()
{
   aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Rechercher");
   aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
   
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAccountNo(), "WPFControlText", cmpEqual, "AccountNumber - No de compte");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAlternativeOrderNo(), "WPFControlText", cmpEqual, "AlterOrderNumber - No ordre de rechange");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoIACode(), "WPFControlText", cmpEqual, "RepresentativeNumber - Code de CP");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoMarket(), "WPFControlText", cmpEqual, "ExchangeName - Marché");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSupplierNo(), "WPFControlText", cmpEqual, "WireNumber - No du fournisseur");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSymbol(), "WPFControlText", cmpEqual, "OrderSymbol - Symbole");
    
    //La présence des étiquettes
   aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Rechercher:");
   aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "Dans:");
}

function Check_Properties_English()
{
   aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Search");
   aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
   aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
   
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAccountNo(), "WPFControlText", cmpEqual, "AccountNumber - Account No.");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAlternativeOrderNo(), "WPFControlText", cmpEqual, "AlterOrderNumber - Alternative Order No.");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoIACode(), "WPFControlText", cmpEqual, "RepresentativeNumber - IA Code"); //EM : 90-07-23-RJ-CO : Avant RepresentativeId
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoMarket(), "WPFControlText", cmpEqual, "ExchangeName - Market");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSupplierNo(), "WPFControlText", cmpEqual, "WireNumber - Supplier No.");
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSymbol(), "WPFControlText", cmpEqual, "OrderSymbol - Symbol");
    
    //La présence des étiquettes
   aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Search for:"); //Search For:" 90.04.-5
   aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "In:");
}

function Check_Existence_Of_Controls()
{
   aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);

   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAccountNo(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoAlternativeOrderNo(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoMarket(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSupplierNo(), "IsEnabled", cmpEqual, true);
   aqObject.CheckProperty(Get_WinOrdersQuickSearch_RdoSymbol(), "IsEnabled", cmpEqual, true);
      
}