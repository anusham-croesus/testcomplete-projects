//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300.  
 Afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée. */

function Survol_Cli_MenuBar_FileLock_BtnQuit()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  // Afficher la fenêtre « Gestion de portefeuilles »
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  //Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
   
  //cliquer sur le btn Quitter
  Get_WinLockTheApplication_BtnQuit().Click();
  
  
  // Vérifier que l’application a été fermée
  //if(Get_MainWindow().Exists){
  //  Log.Error("The application was not closed");
  //} else {
  //  Log.Checkpoint("The application was closed");
  //}
}