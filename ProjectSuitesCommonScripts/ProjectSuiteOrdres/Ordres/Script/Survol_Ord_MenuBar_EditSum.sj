//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Sommation des titres » en cliquant sur MenuBar - btnSum. 
 Vérifier la présence des contrôles et des étiquetés */

 function Survol_Ord_MenuBar_EditSum()
 {
    Login(vServerOrders, userName , psw ,language);
    Get_ModulesBar_BtnOrders().Click()
    
    Get_MenuBar_Edit().OpenMenu();
    Get_MenuBar_Edit_Sum().Click();
    
    //Les points de vérification en français 
     if(language=="french"){Check_Properties_French()} 
    //Les points de vérification en anglais 
    else {Check_Properties_English()} 
    
    Get_WinOrdersSum_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 
  //Fonctions  (les points de vérification pour les scripts qui testent Sum)
function Check_Properties_French()
{
  aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, "Sommation (ordres)");
  
  aqObject.CheckProperty(Get_WinOrdersSum_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
  aqObject.CheckProperty(Get_WinOrdersSum_BtnClose(), "IsEnabled", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_WinOrdersSum_ChNumberOfTransactions(), "Content", cmpEqual, "Nombre de transactions");
  aqObject.CheckProperty(Get_WinOrdersSum_ChFinancialInstrument(), "IsVisible", cmpEqual, true);
    
}

function Check_Properties_English()
{
 
  aqObject.CheckProperty(Get_WinOrdersSum(), "WPFControlText", cmpEqual, "Sum (Orders)");
  
  aqObject.CheckProperty(Get_WinOrdersSum_BtnClose().Content, "OleValue", cmpEqual, "_Close");
  aqObject.CheckProperty(Get_WinOrdersSum_BtnClose(), "IsEnabled", cmpEqual, true); 
  
  aqObject.CheckProperty(Get_WinOrdersSum_ChNumberOfTransactions(), "Content", cmpEqual, "Number of Transactions");
  aqObject.CheckProperty(Get_WinOrdersSum_ChFinancialInstrument(), "IsVisible", cmpEqual, true);
}