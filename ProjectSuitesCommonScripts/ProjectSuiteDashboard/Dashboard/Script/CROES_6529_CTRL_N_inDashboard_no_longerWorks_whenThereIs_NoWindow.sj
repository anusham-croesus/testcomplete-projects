//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Dashboard_Get_functions



/**
    Description : Dans le Dashboard, lorsqu'il n'y a pas de fenêtre ouverte, le CTRL + N ne fonctionne pas. Fonctionnait dans les anciennes versions.
                  1. Module Dashboard
                  2. Cliquer sur le X pour fermer toutes les fenêtres
                  3. Faire CTRL + N
                  Aucune fenêtre ne s'ouvre.
    Auteur : Emna Ihm
    Anomalie: CROES-6529
    Version de scriptage:	90.10.Fm-19
*/
function CROES_6529_CTRL_N_inDashboard_no_longerWorks_whenThereIs_NoWindow()
{
    try {
      
        Log.Link("https://jira.croesus.com/browse/CROES-6529", "Cas de tests JIRA CROES-6529");
        
        Log.Message("*** Login ***")
        Login(vServerDashboard, userName, psw, language);
        Get_ModulesBar_BtnDashboard().Click();
        Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
        Get_MainWindow().Maximize();
        
        //Cliquer sur le X pour fermer toutes les fenêtres
        Log.Message("** D'abord vider le dashboard");
        Clear_Dashboard();
        
        //Faire CTRL + N
        Log.Message("** Faire CTRL + N");
        Get_MainWindow().Keys("^n"); //Ouvrir la boîte de dialogue "Ajouter un tableau"        
        WaitObject(Get_CroesusApp(), "Uid", "AddBoardDialog_c7f4"); 
        
        Log.Message("** Valider la boîte de dialogue <<Ajouter un tableau>> est ouvert.")
        if(!Get_DlgAddBoard().Exists && !Get_DlgAddBoard().VisibleOnScreen)
          Log.Error("Aucune fenêtre ne s'ouvre.")
        else
        {
          Log.Checkpoint("La boîte de dialogue <<"+Get_DlgAddBoard().Title+">> est ouvert.")
          aqObject.CheckProperty(Get_DlgAddBoard(), "Exists", cmpEqual, true);
          aqObject.CheckProperty(Get_DlgAddBoard(), "VisibleOnScreen", cmpEqual, true);
          aqObject.CheckProperty(Get_DlgAddBoard(), "Title", cmpEqual, GetData(filePath_Dashboard, "Add_Board", 2, language));          
          
          Log.Message("** Fermer la boîte de dialogue <<Ajouter un tableau>>");
          Get_DlgAddBoard_TvwSelectABoard().Keys("[Esc]"); 
        }
        
        Close_Croesus_X();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}