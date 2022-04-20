//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Tableau de bord », afficher la fenêtre « Print » en cliquant sur Barre de menus > Imprimer > Tous les tableaux. 
 En cliquant sur le btnCancel, Vérifier le message «Impression annulée» */

function Survol_Dash_MenuBar_FilePrint_EveryBoard()
{
    Login(vServerDashboard, userName, psw, language);
  
    Get_ModulesBar_BtnDashboard().Click();
    Add_PositiveCashBalanceSummaryBoard();
  
    Get_MenuBar_File().OpenMenu();
    Get_MenuBar_File_PrintForDashboard().Click();
    Get_MenuBar_File_PrintForDashboard_EveryBoard().ClickItem();
  
    /*
    //Commenté pour Adaptation pour CO
    //Les points de vérification en français 
    if (language=="french"){Check_Print_Properties_ForPrintEveryBoard_French()}// la fonction est dans le script Common_functions
    //Les points de vérification en anglais 
    else {Check_Print_Properties_ForPrintEveryBoard_English()}// la fonction est dans le script Common_functions
  
    Get_DlgPrinting().Click(90, 90);
    */
  
    //CP : Adaptation pour CO
    Check_Print_Properties();
    Get_DlgInformation().Click(93, 66);
  
  
    Close_Croesus_AltF4();
    //Sys.Browser("iexplore").Close()
}