//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module « Dashboard », afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquettes. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée */
  
function Survol_Dash_MenuBar_FileLock_BtnQuit()
{
    Login(vServerDashboard, userName, psw, language);
    Get_ModulesBar_BtnDashboard().Click();
    
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_Lock().Click();
    
    //Check_WinLockTheApplication_Properties(); //La fonction est dans Common_functions
    
    //cliquer sur le btn Quitter
    Get_WinLockTheApplication_BtnQuit().Click();
    
    // Vérifier que l’application a été fermée
    //if (WaitUntilObjectDisappears(Sys, "Uid", "WPFWindowContainer_7458"))
    //    Log.Checkpoint("The application was closed");
    //else {
    //    Log.Error("The application was not closed");
    //    Get_MainWindow().SetFocus();
    //    Close_Croesus_MenuBar();
    //    Terminate_CroesusProcess();
    //}
}
