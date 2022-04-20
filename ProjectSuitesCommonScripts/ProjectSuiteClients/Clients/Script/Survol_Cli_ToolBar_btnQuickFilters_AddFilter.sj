//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Clients » , afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Cli_ToolBar_btnQuickFilters_AddFilter()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click();
    
    //afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        
    //Les points de vérification 
    //Check_AddFilterForRelationshipsClientsAccounts_Properties(language);//la fonction est dans CommonCheckpoints
            
    Get_WinCRUFilter_BtnCancel().Click();
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
