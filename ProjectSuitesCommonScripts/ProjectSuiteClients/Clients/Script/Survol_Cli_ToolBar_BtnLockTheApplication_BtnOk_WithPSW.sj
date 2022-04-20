﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Afficher la fenêtre « Gestion de portefeuilles » en cliquant sur Toolbar - BtnQLockTheApplication . 
Vérifier la présence des contrôles et des étiquetés. Par la suite, remplie un bonne psw cliquer sur le btn Ok, vérifier que l’application n’a pas été fermée.*/

 function Survol_Cli_ToolBar_BtnLockTheApplication_BtnOk_WithPSW()
{
  Login(vServerClients, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  Get_MainWindow().Maximize();
  //Afficher la fenêtre « Gestion de portefeuilles »
  Get_Toolbar_BtnLockTheApplication().Click();
  
  //Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
  
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