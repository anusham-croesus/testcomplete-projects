//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers) afficher la fenêtre « Documents personnels » 
avec Ctrl+Maj+A.Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Por_ArchiveDoc_Ctrl_Maj_A()
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
  
   //afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A
  Get_MainWindow().Keys("^A");
  
  //Les points de vérification en utilisant le fichier Excel
  Check_WinPersonalDocuments_Properties(language)
          
  Get_WinPersonalDocuments().Close()
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
 }