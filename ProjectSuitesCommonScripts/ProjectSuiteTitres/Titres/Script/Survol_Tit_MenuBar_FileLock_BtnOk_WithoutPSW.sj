//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Titre » , afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Ok sans donner un psw, vérifier la présence d’un message 
 // Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1803*/
  
 function Survol_Tit_MenuBar_FileLock_BtnOk_WithoutPSW()
 {
  Login(vServerTitre, userName, psw, language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
 
  //Cliquer sur le btn OK sans donner un psw
  Get_WinLockTheApplication_BtnOK().Click();
  
  Check_DlgUserNameOrPasswordIsNotValid_Properties(); //La fonction est dans CommonCheckpoints
  
  var width=Get_DlgInformation().get_ActualWidth()
  var height=Get_DlgInformation().get_ActualHeight()
  Get_DlgInformation().Close(); //Get_DlgUserNameOrPasswordIsNotValid_BtnOK().Click();
  WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1]);
  Get_WinLockTheApplication_BtnQuit().Click();
  WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "UnlockWindow_950d");
  Sys.Browser("iexplore").Close();
   
  // Vérifier que l’application a été fermée
  if(Get_MainWindow().Exists){
    Log.Error("The application was not closed");
  } else {
    Log.Checkpoint("The application was closed");
  }
}
