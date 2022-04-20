//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_MenuBar_FilePrint
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Print » avec ClickR. 
Cliquer sur le btnCancel, Vérifier le message «Impression annulée». Fermer la fenêtre du message par Esc   */
 
function Survol_Por_Print_ClickR()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  //Rechercher un client 800300
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
  
  //Afficher la fenêtre « Print » avec ClickR
  Get_PortfolioPlugin().ClickR()
  Get_PortfolioGrid_ContextualMenu_Print().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Properties_French()}// la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  else{Check_Print_Properties_English()} // la fonction est dans le script CommonCheckpoints
  
  //Get_DlgPrinting_BtnOK().Keys("[Esc]"); //EM: Modifié pour CO-90-07-22
  Get_DlgInformation().Keys("[Esc]");
  
  Close_Croesus_SysMenu();    
 }
 

