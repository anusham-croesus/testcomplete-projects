//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Survol_Dash_MenuBar_FilePrint_MyOpenTasks
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Mes tâches ouvertes. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Dash_ToolBar_BtnPrint_MyOpenTasks()
{
    Login(vServerDashboard, userName, psw, language);
    
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
    
    Get_Toolbar_BtnPrintBoardsSelector().Click();
    Get_Toolbar_BtnPrintBoardsSelector_MyOpenTasks().Click();
    
    /*if (language=="french"){ //Les points de vérification en français 
        Check_Print_Properties_French() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_French() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyOpenTasks
    } else { //Les points de vérification en anglais 
        Check_Print_Properties_English() // la fonction est dans le script Common_functions
        Check_MyTasksProperties_English() // la fonction est dans Survol_Dash_MenuBar_FilePrint_MyOpenTasks
    }*/
    
    //Get_DlgPrinting_BtnOK().Click(); //CP : Adaptation pour CO
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_AltF4();
    //Sys.Browser("iexplore").Close()
}