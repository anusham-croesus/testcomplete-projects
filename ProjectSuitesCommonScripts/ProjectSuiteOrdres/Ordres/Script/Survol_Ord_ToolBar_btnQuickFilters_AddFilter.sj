//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Ord_ToolBar_btnQuickFilters_AddFilter()
 {
    Login(vServerOrders, userName , psw ,language);
    Get_ModulesBar_BtnOrders().Click()
    
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click()
    Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_AddAFilter().Click()
      
    //Les points de vérification en français 
     if(language=="french"){ Check_AddFilter_Properties_French()} // la fonction est dans Common_functions
    
    //Les points de vérification en anglais 
    else {Check_AddFilter_Properties_English()}  // la fonction est dans Common_functions
    
    //Les points de vérification: La présence des contrôles
    Check_AddFilter_Existence_Of_Controls() // la fonction est dans Common_functions
 
    Get_WinAddFilter_BtnCancel().Click();
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 