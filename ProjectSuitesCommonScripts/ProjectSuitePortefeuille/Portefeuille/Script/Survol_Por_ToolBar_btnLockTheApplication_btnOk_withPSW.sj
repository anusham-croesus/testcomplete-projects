//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
Afficher la fenêtre « Gestion de portefeuilles » en cliquant sur Toolbar - BtnQLockTheApplication . 
Vérifier la présence des contrôles et des étiquetés. Par la suite, remplie un bonne psw cliquer sur le btn Ok, vérifier que l’application n’a pas été fermée.*/

 function Survol_Por_ToolBar_BtnLockTheApplication_BtnOk_WithPSW()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_MainWindow().Maximize();
  //Rechercher un client 800300.
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){
    Search_Client("800300");
  } else {
    Log.Error("The BtnSearch didn't become enabled within 15 seconds.");
  }

  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();
  
   //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000); 
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  Get_Toolbar_BtnLockTheApplication().Click();
  
  Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
  
  //Saisir un bon mot de passe et cliquer sur le bouton OK
  Get_WinLockTheApplication_TxtPassword().Keys(psw);
  Get_WinLockTheApplication_BtnOK().Click();
  
  //Vérifier que l’application n'a pas été fermée
  if(Get_MainWindow().Exists){
    Log.Checkpoint("The application was not closed");
  } else {
    Log.Error("The application was closed");
  }
  
  Get_MainWindow().Restore();
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}
