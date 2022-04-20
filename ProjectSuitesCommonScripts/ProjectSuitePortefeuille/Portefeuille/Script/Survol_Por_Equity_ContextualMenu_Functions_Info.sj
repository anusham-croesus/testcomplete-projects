//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_Bond_MenuBar_EditFunctions_Info

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Rechercher une position avec le symbol AGU (equity).
Afficher la fenêtre Info  par le Menu contextual. Fermer la fenêtre par X */
 
function Survol_Por_Equity_ContextualMenu_Functions_Info()
{
  var type="equity";
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
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
  
  Search_Position("AGU");
  
  Get_Portfolio_PositionsGrid().Keys("[Apps]");
  Get_PortfolioGrid_ContextualMenu_Functions().Click();
  Get_PortfolioGrid_ContextualMenu_Functions_Info().Click();
  
 //Les points de vérification 
  Check_Info_Properties(language, type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  Check_Details_Properties(language, type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  if(client == "US" ){
    Check_Lots_Properties(language, type);// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  } 
  Check_PositionInfo_Properties(language, type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  Check_Existence_Of_Controls_TabInfo(type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  Check_Existence_Of_Controls_TabDetails(type) // la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  if(client == "US" ){
    Check_Existence_Of_Controls_TabLots(type);
  }
  Check_Existence_Of_Controls_PositionInfo(type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  
  Get_WinPositionInfo().Close();
  
  Close_Croesus_X();    
 }