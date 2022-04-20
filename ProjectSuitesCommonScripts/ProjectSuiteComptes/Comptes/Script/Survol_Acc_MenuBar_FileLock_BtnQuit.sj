//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Comptes », afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquettes. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée */
  
function Survol_Acc_MenuBar_FileLock_BtnQuit()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  //Check_WinLockTheApplication_Properties(); //La fonction est dans Common_functions
  
  //cliquer sur le btn Quitter
  Get_WinLockTheApplication_BtnQuit().Click();
  WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "UnlockWindow_950d");
  
  Sys.Browser("iexplore").Close();
  
  // Vérifier que l’application a été fermée
  //if(Get_MainWindow().Exists){
  //  Log.Error("The application was not closed");
  //} else {
  //  Log.Checkpoint("The application was closed");
  //}
}
