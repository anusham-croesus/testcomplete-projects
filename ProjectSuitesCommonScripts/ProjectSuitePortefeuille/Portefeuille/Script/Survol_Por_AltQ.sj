//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Survol_Por_AltF4

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Vérifier l’affichage de la fenêtre 'Croesus - Nicolas Copernic (COPERN)' 
contenant les boutons "Info", "Solde date trans.","Proj. Liquidités","Tous", "Simulation", "Comparaison" et vérifier la présence des contrôles dans TOOLBARTRAY.
 Fermer l’application avec AltQ */ 

function Survol_Por_AltQ()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()

  //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
   //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //Les points de vérification en français 
   if(language=="french"){ Check_Properties_French()} // la fonction est dans le script Survol_Por_AltF4 
  //Les points de vérification en anglais 
   else {Check_Properties_English()} // la fonction est dans le script Survol_Por_AltF4 
   
  //Les points de vérification: La présence des contrôles
  Check_Existence_Of_Controls()
  
  Close_Croesus_AltQ()
}

