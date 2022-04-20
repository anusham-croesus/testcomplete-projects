//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord » :
    1- Afficher la fenêtre « Print » avec Alt + Shift + P.
    2- En cliquant sur le btnCancel, vérifier le message «Impression annulée».
    3- Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Tous les tableaux.
    4- Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Tous les tableaux.
*/

function Survol_Dash_Print_EveryBoard_CombinedAccessMethods()
{
    Login(vServerDashboard, userName, psw, language);
    
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
    
    // 1- Alt + Shift + P
    
    Log.Message("Afficher la fenêtre « Print » avec Alt + Shift + P.");
    Get_MainWindow().Keys("~P"); // Alt_Shift_P
    
    // 2- Vérifications
    
    //CP : Adaptation pour CO
    Check_Print_Properties();
    Get_DlgInformation().Click(93, 66);
    
    // 3- Barre de menus > Imprimer > Tous les tableaux
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Tous les tableaux.");
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_EveryBoard().ClickItem();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    // 4- Barre d'outils > Imprimer > Tous les tableaux
    
    Log.Message("Afficher la fenêtre « Print » en cliquant sur Barre d'outils > Imprimer > Tous les tableaux.");
    Get_Toolbar_BtnPrintBoardsSelector().Click();
    Get_Toolbar_BtnPrintBoardsSelector_EveryBoard().Click();
    Get_DlgPrint_BtnCancel().Click();
    Get_DlgInformation().Click(93, 66);
    
    Close_Croesus_AltF4();
}