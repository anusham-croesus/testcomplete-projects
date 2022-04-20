//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Survol_Dash_MenuBar_FilePrint_MyOpenTasks
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » avec Alt + Shift + O. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Dash_Print_Alt_Shift_O()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
  
    Get_MainWindow().Keys("~O"); // Alt_Shift_O
  
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