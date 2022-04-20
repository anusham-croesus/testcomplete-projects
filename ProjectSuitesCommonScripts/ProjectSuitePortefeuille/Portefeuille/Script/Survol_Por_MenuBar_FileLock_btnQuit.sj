//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
 Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).  
 Afficher la fenêtre « Gestion de portefeuilles »en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée. */

function Survol_Por_MenuBar_FileLock_BtnQuit()
{
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
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
//  Delay(200);
     Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000); 
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
   
  //cliquer sur le btn Quitter
  Get_WinLockTheApplication_BtnQuit().Click();
  
  
if (WaitUntilObjectDisappears(Get_CroesusApp(), ["Uid", "Title"], ["UnlockWindow_950d", GetData(filePath_Common, "Lock_Application", 2, language)])){
     Sys.Browser("iexplore").Close();
  }
  else {
     Log.Error("La fenêtre Client Info n'était pas fermée.");
     Terminate_CroesusProcess();
  }
 
  
  // Vérifier que l’application a été fermée
  if(Get_MainWindow().Exists){
    Log.Error("The application was not closed");
  } else {
    Log.Checkpoint("The application was closed");
  }
}
