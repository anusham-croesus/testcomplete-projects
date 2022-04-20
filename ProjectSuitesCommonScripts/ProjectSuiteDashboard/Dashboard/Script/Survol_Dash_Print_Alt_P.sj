//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » avec Alt + P. 
 En cliquant sur le btnCancel, vérifier le message «Impression annulée» */

function Survol_Dash_Print_Alt_P()
{
    Login(vServerDashboard, userName, psw, language);

    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();

    Get_MainWindow().Keys("~p"); // Alt_P
  
    //Les points de vérification en français 
    //if (language=="french"){Check_Print_Properties_French()} // la fonction est dans le script Common_functions
    //Les points de vérification en anglais 
    //else {Check_Print_Properties_English()} // la fonction est dans le script Common_functions
  
    //Get_DlgPrinting_BtnOK().Click(); //CP : Adaptation pour CO
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_MenuBar();
}

