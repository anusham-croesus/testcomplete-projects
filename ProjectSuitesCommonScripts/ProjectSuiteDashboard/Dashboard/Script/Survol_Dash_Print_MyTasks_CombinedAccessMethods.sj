//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Dash_MenuBar_FilePrint_MyTasks


/* Description : A partir du module « Tableau de bord » :
    1- Afficher la fenêtre « Print » avec Alt + Shift + T.
    2- En cliquant sur le btnCancel, Vérifier le message «Impression annulée».
    3- Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches.
    4- Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Mes tâches.
*/

function Survol_Dash_Print_MyTasks_CombinedAccessMethods()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
    
    // 1- Alt + Shift+ T
    
    Log.Message("Afficher la fenêtre « Print » avec Alt + Shift + T.");
    Get_MainWindow().Keys("~T");
    
    // 2- Vérifications
    
    WaitObject(Get_CroesusApp(), ["WndCaption", "WndClass", "VisibleOnScreen"], ["Print", "#32770", true]);
    if (language=="french"){ //Les points de vérification en français 
        Check_Print_Properties_French() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_French() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyTasks
    } else { //Les points de vérification en anglais 
        Check_Print_Properties_English() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_English() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyTasks
    }
    Get_DlgInformation().Click(93, 66);
    
    // 3- Barre de menus > Imprimer > Mes tâches
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Mes tâches.");
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_MyTasks().ClickItem();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    // 4- Barre d'outils > Imprimer > Mes tâches
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Mes tâches.");
    Get_Toolbar_BtnPrintBoardsSelector().Click();
    Get_Toolbar_BtnPrintBoardsSelector_MyTasks().Click();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_MenuBar();
}