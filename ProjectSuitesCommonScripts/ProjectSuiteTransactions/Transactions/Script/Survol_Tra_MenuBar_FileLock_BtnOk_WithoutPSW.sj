//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Transactions_Get_functions
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Transactions » , afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Ok sans donner un psw, vérifier la présence d’un message */
  
 function Survol_Tra_MenuBar_FileLock_BtnOk_WithoutPSW()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
	WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");      
    WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
    Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
	
  
    //afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_Lock().Click();
  
    Check_WinLockTheApplication_Properties(); //La fonction est dans Common_functions
 
    //Cliquer sur le btn OK sans donner un psw
    Get_WinLockTheApplication_BtnOK().Click();
    
    //Les points de vérification
    Check_DlgUserNameOrPasswordIsNotValid_Properties(); //La fonction est dans CommonCheckpoints
    
    /*var width=Get_DlgCroesus().get_ActualWidth()
    var height=Get_DlgCroesus().get_ActualHeight()
    Get_DlgCroesus().Click(width/2,height-40);*/ //Get_DlgUserNameOrPasswordIsNotValid_BtnOK().Click();
    if(Get_DlgInformation().Exists) {    
    Get_DlgInformation().Close();
    }//EM: Modifié Depuis CO

    Delay(150);
    Get_WinLockTheApplication_BtnQuit().Click();
    Delay(150);
    Sys.Browser("iexplore").Close();
   
    // Vérifier que l’application a été fermée
    if(Get_MainWindow().Exists){
      Log.Error("The application was not closed");
    } else {
      Log.Checkpoint("The application was closed");
    }
}
