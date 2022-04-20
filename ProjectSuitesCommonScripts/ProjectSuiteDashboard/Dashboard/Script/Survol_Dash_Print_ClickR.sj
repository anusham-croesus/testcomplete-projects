//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Dashboard_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » avec Clic droit. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Dash_ClickR()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
  
    Get_DashboardPlugin().ClickR();
    Get_Dashboard_ContextualMenu_Print().Click()
  
    //Les points de vérification en français 
    //if (language=="french"){Check_Print_Properties_French()} // la fonction est dans le script Common_functions
    //Les points de vérification en anglais 
    //else {Check_Print_Properties_English()} // la fonction est dans le script Common_functions
  
    //Get_DlgPrinting_BtnOK().Click(); //CP : Adaptation pour CO
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_X()
}
