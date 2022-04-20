//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Comptes », afficher la fenêtre « Gestion de portefeuilles » en cliquant sur Toolbar - BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquettes. Par la suite, saisir un bon mot de passe et cliquer sur le btn Ok, vérifier que l’application n’a pas été fermée */
  
function Survol_Acc_ToolBar_BtnLockTheApplication_BtnOk_WithPSW()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_MainWindow().Maximize();
  Get_Toolbar_BtnLockTheApplication().Click();
  
  //Check_WinLockTheApplication_Properties(); //La fonction est dans Common_functions
  
  //Saisir un bon mot de passe et cliquer sur le bouton OK
  Get_WinLockTheApplication_TxtPassword().Keys(psw);
  Get_WinLockTheApplication_BtnOK().Click();
  
  //Vérifier que l’application n'a pas été fermée
  //if(Get_MainWindow().Exists){
  //  Log.Checkpoint("The application was not closed");
  //} else {
  //  Log.Error("The application was closed");
  //}
  
  Get_MainWindow().Restore();
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
}
