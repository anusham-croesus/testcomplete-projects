//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Clients » , afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Cli_MenuBar_SearchAddFilter()
 {
    Login(vServerClients, userName, psw, language);
    Get_ModulesBar_BtnClients().Click()
    
    //afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter. 
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
        
    //Les points de vérification 
    Check_AddFilterForRelationshipsClientsAccounts_Properties(language);//la fonction est dans CommonCheckpoints
            
    Get_WinCRUFilter_BtnCancel().Click();
      
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
