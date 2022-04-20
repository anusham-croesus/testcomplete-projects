//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Cancel*/

function Survol_Por_MenuBar_EditSearch()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  //Rechercher un client 800300. 
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();

 //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //Afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search.
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Search().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else {Check_Properties_English()}
  
  Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Por_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Click();
  
  Close_Croesus_MenuBar();
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Search)
function Check_Properties_French()
{
     aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Rechercher");

     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Titre");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbole");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Nom");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo().DataContext.Label, "OleValue", cmpEqual, "No compte");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "Code de CP");
     
     //btns
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
     
     aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Rechercher:");
     aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "Dans:");     
}

function Check_Properties_English()
{
     aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Search");
     
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription().DataContext.Label, "OleValue", cmpEqual, "Description");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity().DataContext.Label, "OleValue", cmpEqual, "Security");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol().DataContext.Label, "OleValue", cmpEqual, "Symbol");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Name");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType().DataContext.Label, "OleValue", cmpEqual, "Type");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo().DataContext.Label, "OleValue", cmpEqual, "Account No.");
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "IA Code");
     
     //btns
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
     
     aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Search for:");
     aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "In:");
}

function Check_Existence_Of_Controls()
{
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
     
     aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
     aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsReadOnly", cmpEqual, false);
     
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoDescription(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSecurity(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoSymbol(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoName(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoType(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoAccountNo(), "IsEnabled", cmpEqual, true);
     aqObject.CheckProperty(Get_WinPortfolioQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
}
