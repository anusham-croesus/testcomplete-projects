//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Relation » , afficher la fenêtre « Ajouter un filter » en cliquant sur Menubar - SearchAddFilters. 
 Vérifier la présence des contrôles et des étiquetés */
 
 function Survol_Rel_MenuBar_SearchAddFilter()
 {
    Login(vServerRelations, userName, psw, language);
    Get_ModulesBar_BtnRelationships().Click();
    
    //afficher la fenêtre « Ajouter un filter »
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
        
    //Les points de vérification 
    Check_AddFilterForRelationshipsClientsAccounts_Properties(language)//la fonction est dans CommonCheckpoints
    
    //Fermeture de la fenêtre « Ajouter un filter »        
    Get_WinCRUFilter_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 