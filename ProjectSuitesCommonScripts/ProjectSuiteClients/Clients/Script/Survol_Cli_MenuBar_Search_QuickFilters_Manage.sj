//USEUNIT Common_functions
//USEUNIT Titres_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables

/* Description : A partir du module « Clients » , afficher la fenêtre « Gestionnaire de filtes rapides » en cliquant sur Menubar -Search - QuickFilters - Manage. 
 Vérifier la présence des contrôles et des étiquetés */
 
 //***********Il faut finaliser les scriptes de Quick_Filters car il y a une anomalie  ******
 
// function Survol_Cli_MenuBar_Search_QuickFilters_Manage()
// {
//    Login(vServerClients, userName , psw ,language);
//    Get_ModulesBar_BtnClients().Click()
//    
//    Get_MenuBar_Search().OpenMenu();
//    Get_MenuBar_Search_QuickFilters().OpenMenu();
//    Get_MenuBar_Search_QuickFilters_Manage().Click();
//    
//   //Les points de vérification 
//   Check_QuickFilters_Properties(language); 
//    
//    Get_WinQuickFiltersManager_BtnClose().Click()
//      
//    Get_MainWindow().SetFocus();
//    Close_Croesus_SysMenu();
// }
// 
//
// function  Check_QuickFilters_Properties(language)
// {
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(), "Title", cmpEqual, "Gestion des filtres");
//  
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "Content", cmpEqual, "_Appliquer");
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsEnabled", cmpEqual, true);
//  
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "Content", cmpEqual, "_Appliquer");
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsEnabled", cmpEqual, true);
//  
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar(), "Text", cmpEqual, "Filtres");
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "Content", cmpEqual, "Aj_outer");
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
//  aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
// } 