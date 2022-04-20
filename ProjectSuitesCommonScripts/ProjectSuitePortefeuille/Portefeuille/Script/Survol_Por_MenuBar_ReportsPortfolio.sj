//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
afficher la fenêtre « Rapports portefeuille » en cliquant sur MenuBar-ReportsSecurities . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons .Fermer la fenêtre en cliquant sur le btn Fermer*/

function Survol_Por_MenuBar_ReportsPortfolio()
{
  var module="portfolio";
  var btn="reports";
  
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  //Rechercher un client 800300.
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800276")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();

  //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //afficher la fenêtre « Rapports portefeuille » en cliquant sur MenuBar-ReportsSecurities 
  Get_MenuBar_Reports().OpenMenu()
  Get_MenuBar_Reports_Portfolio().Click()
    
  //Les points de vérification
  Check_Properties_Reports(language,module,btn)
  
  Get_WinReports_BtnClose().Click()
  
  Close_Croesus_MenuBar()
}

 