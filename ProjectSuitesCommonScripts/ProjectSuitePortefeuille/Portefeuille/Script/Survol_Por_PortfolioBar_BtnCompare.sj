//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Contexte de compaison » 
en cliquant sur PortfolioBar -btnComparel. Fermer la fenêtre par Esc */
 
// function Survol_Por_PortfolioBar_BtnCompare()
// {
//  Login(vServerPortefeuille, userName , psw ,language);
//  Get_ModulesBar_BtnClients().Click()
//  
//  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
//  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

//Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()
//
//  Get_MenuBar_Modules().OpenMenu()
//  Get_MenuBar_Modules_Portfolio().OpenMenu()
//  Get_MenuBar_Modules_Portfolio_DragSelection().Click()
//  
//  Get_PortfolioBar_BtnCompare().Click()
//  
//  //Les points de vérification en français 
//  if(language=="french"){Check_Properties_French()}
//  //Les points de vérification en anglais 
//  else{Check_Properties_English()} 
//  
//  Check_Existence_Of_Controls()
//  
//  Get_WinComparisonContextChooser_BtnCancel().Keys("[Esc]");
//  
//  Close_Croesus_X()
//  //Sys.Browser("iexplore").Close()
//    
// }
// 
 //Fonctions  (les points de vérification pour les scripts qui testent Print)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinComparisonContextChooser().Title, "OleValue", cmpEqual, "Contexte de comparaison");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions().Header, "OleValue", cmpEqual, "Choix d'historique:");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoLastQuarter().Content, "OleValue", cmpEqual, "Dernier trimestre");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoYearToDate().Content, "OleValue", cmpEqual, "Cumul annuel");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoSinceInception().Content, "OleValue", cmpEqual, "Depuis le début");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoCustom().Content, "OleValue", cmpEqual, "Choix de date:");
    //btns
    aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");    
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinComparisonContextChooser().Title, "OleValue", cmpEqual, "Comparison Context");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions().Header, "OleValue", cmpEqual, "Historical Options:");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoLastQuarter().Content, "OleValue", cmpEqual, "Last Quarter");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoYearToDate().Content, "OleValue", cmpEqual, "Year to Date");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoSinceInception().Content, "OleValue", cmpEqual, "Since Inception");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_RdoCustom().Content, "OleValue", cmpEqual, "Custom:");
    //btns
    aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");    
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinComparisonContextChooser_GrpHistoricalOptions_TxtCustomDate(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnOK(),"IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinComparisonContextChooser_BtnCancel(),"IsVisible", cmpEqual, true);
}

