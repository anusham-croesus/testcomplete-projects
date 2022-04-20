//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). 
Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu  */
 
function Survol_Por_ToolBar_btnInternet()
{
  var module="portfolio"
  
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click()
  
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
  
  Get_Toolbar_BtnInternetAddresses().Click()
   
   //Les points de vérification en français 
  if(language=="french"){Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_French(module)}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
  else {Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_English(module)}// la fonction est dans CommonCheckpoints
     
  Check_ToolBar_InternetForPortfolioTransactionsSecurity_Existence_Of_Controls(module) // la fonction est dans CommonCheckpoints 
 
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
 }
 
