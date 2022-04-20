//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord » :
    1- Afficher la fenêtre « Print » avec Alt + P.
    2- En cliquant sur le btnCancel, vérifier le message «Impression annulée».
    3- Afficher la fenêtre « Print » avec Clic droit.
*/

function Survol_Dash_Print_SelectedBoard_CombinedAccessMethods()
{
    Login(vServerDashboard, userName, psw, language);

    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
    
    // 1- Alt + P
    
    Log.Message("Afficher la fenêtre « Print » avec Alt + P.");
    Get_MainWindow().Keys("~p");
    
    // 2- Vérifications
    
    if (language=="french"){   //Les points de vérification en français 
        Check_Print_Properties_French()
    } // la fonction est dans le script Common_functions
    else {   //Les points de vérification en anglais 
        Check_Print_Properties_English()
    } // la fonction est dans le script Common_functions
    Get_DlgInformation().Click(93, 66);
    
    // 3- Clic droit
    
    Log.Message("Afficher la fenêtre « Print » avec Clic droit.");
    Get_DashboardPlugin().ClickR();
    Get_Dashboard_ContextualMenu_Print().Click()
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_X();
}