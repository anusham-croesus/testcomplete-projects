//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : À partir du module « Transactions » , afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication . 
 Vérifier la présence des contrôles et des étiquetés. Par la suite, cliquer sur le btn Quitter et vérifier que l’application a été fermée */
  
 function Survol_Tra_MenuBar_FileLock_BtnQuit()
 {
    Login(vServerTransactions, userName , psw ,language);
    Get_ModulesBar_BtnTransactions().Click();
    
	WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
	WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"]);
	Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
    
    //afficher la fenêtre « Gestion de portefeuilles » en cliquant sur MenuBar -File- BtnQLockTheApplication .
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_Lock().Click();
  
    //Les points de vérification
    Check_WinLockTheApplication_Properties(); //La fonction est dans CommonCheckpoints
   
    //Cliquer sur le btn Quitter 
    Get_WinLockTheApplication_BtnQuit().Click();
  
    Sys.Browser("iexplore").Close();
    delay(500);
  
    // Vérifier que l’application a été fermée
    if(Get_MainWindow().Exists){
      Log.Error("The application was not closed");
    } else {
      Log.Checkpoint("The application was closed");
    }
}