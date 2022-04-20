//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT  Survol_Por_PortfolioBar_BtnCompare

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Contexte de compaison » 
en cliquant sur PortfolioBar -btnCompare. Fermer la fenêtre en cliquant sur le btn Cancel */
 
// function Survol_Por_MenuBar_EditFunctions_Compare()
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
//  Get_MenuBar_Edit().OpenMenu()
//  Get_MenuBar_Edit_FunctionsForPortfolio().OpenMenu()
//  Get_MenuBar_Edit_FunctionsForPortfolio_Compare().Click()
//  
//  //Les points de vérification en français 
//  if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_BtnCompare
//  //Les points de vérification en anglais 
//  else{Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_BtnCompare
//  
//  Check_Existence_Of_Controls()
//  
//  Get_WinComparisonContextChooser_BtnCancel().Click()
//  
//  Close_Croesus_AltF4()
//  //Sys.Browser("iexplore").Close()
//    
// }