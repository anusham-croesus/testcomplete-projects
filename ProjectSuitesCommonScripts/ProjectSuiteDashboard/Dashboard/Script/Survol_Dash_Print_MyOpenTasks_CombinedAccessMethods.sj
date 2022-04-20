//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Survol_Dash_MenuBar_FilePrint_MyOpenTasks
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord » :
    1- Afficher la fenêtre « Print » avec Alt + Shift + O.
    2- En cliquant sur le btnCancel, Vérifier le message «Impression annulée»
    3- Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches ouvertes.
    4- Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Mes tâches ouvertes.
*/

function Survol_Dash_Print_MyOpenTasks_CombinedAccessMethods()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
    
    // 1- Alt + Shift + O
    
    Log.Message("Afficher la fenêtre « Print » avec Alt + Shift + O.");
    Get_MainWindow().Keys("~O");
    
    // 2- Vérifications
    
    if (language=="french"){ //Les points de vérification en français 
        Check_Print_Properties_French() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_French() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyOpenTasks
    }
    else { //Les points de vérification en anglais 
        Check_Print_Properties_English() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_English() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyOpenTasks
    }
    Get_DlgInformation().Click(93, 66);
    
    // 3- Barre de menus > Imprimer > Mes tâches ouvertes
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches ouvertes.");
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_MyOpenTasks().ClickItem();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    // 4- Barre d'outils > Imprimer > Mes tâches ouvertes
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Mes tâches ouvertes.");
    Get_Toolbar_BtnPrintBoardsSelector().Click();
    Get_Toolbar_BtnPrintBoardsSelector_MyOpenTasks().Click();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_AltF4();
    //Sys.Browser("iexplore").Close()
}