//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Titre » , afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1804*/
  
 function Survol_Tit_MenuBar_FileLock_BtnQuit()
 {
  Login(vServerTitre, userName, psw, language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
   
  //Cliquer sur le btn Quitter 
  Get_WinLockTheApplication_BtnQuit().Click();
  
  Sys.Browser("iexplore").Close();

  
  // Vérifier que l’application a été fermée
  if(Get_MainWindow().Exists){
    Log.Error("The application was not closed");
  } else {
    Log.Checkpoint("The application was closed");
  }
}
