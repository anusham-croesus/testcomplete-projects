//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
Afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda. 
Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements .Fermer la fenêtre en cliquant sur le btn Cancel*/

 function Survol_Por_MenuBar_ToolsAgenda()
{
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()
  
  //maillage  vers le module portefeuille  
  Get_MenuBar_Modules().OpenMenu()
  Get_MenuBar_Modules_Portfolio().OpenMenu()
  Get_MenuBar_Modules_Portfolio_DragSelection().Click()
  
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  //Afficher la fenêtre « Agenda » en cliquant sur MenuBar -Tools- btnAgenda.
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_Agenda().Click()
  
  //Les points de vérification en utilisant le fichier Excel
  Check_WinAgenda_Properties(language)
  
  Get_WinAgenda_BtnCancel().Click() 
  
  Close_Croesus_X()
}

 