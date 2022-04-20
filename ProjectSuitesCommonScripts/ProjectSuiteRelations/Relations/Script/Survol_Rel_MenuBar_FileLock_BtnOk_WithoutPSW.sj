//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Relations » , afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Ok sans donner un psw, vérifier la présence d’un message */
  
 function Survol_Rel_MenuBar_FileLock_BtnOk_WithoutPSW()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_MenuBar_File().OpenMenu();
  Get_MenuBar_File_Lock().Click();
  
  Check_WinLockTheApplication_Properties(); //La fonction est dans Common_functions
 
  //Cliquer sur le btn OK sans donner un psw
  Get_WinLockTheApplication_BtnOK().Click();
  
  Check_DlgUserNameOrPasswordIsNotValid_Properties(); // la fonction est dans Common_functions
  
  /*var width=Get_DlgCroesus().get_ActualWidth()
  var height=Get_DlgCroesus().get_ActualHeight()
  Get_DlgCroesus().Click(width/2,height-40);*/ //Get_DlgUserNameOrPasswordIsNotValid_BtnOK().Click();
  if(Get_DlgInformation().Exists) {    
    Get_DlgInformation().Close();
  }//EM: Modifié Depuis CO
  
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
