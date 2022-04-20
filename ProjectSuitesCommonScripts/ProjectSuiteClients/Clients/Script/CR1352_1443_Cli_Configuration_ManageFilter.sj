//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter


/* Description :Configuration de la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1443
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1443_Cli_Configuration_ManageFilter()
 {
    
    Login(vServerClients, userName , psw ,language);
    Get_ModulesBar_BtnClients().Click()
    
    Get_MainWindow().Maximize();
       
    //afficher la fenêtre « Ajouter un filter » en cliquant sur MenuBar - SearchAddFilter. 
    Get_MenuBar_Search().OpenMenu();
    Get_MenuBar_Search_QuickFilters().OpenMenu();
    Get_MenuBar_Search_QuickFilters_Manage().Click();
    WaitObject(Get_CroesusApp(), "WindowMetricTag", "QuickFilterManager", 2000)
                
    //Vérifier que la fenêtre  Gestion des filtres s'affiche
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts(), "Title", cmpEqual, GetData(filePath_Clients,"CR1352",105,language)); 
         
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName(), "Exists", cmpEqual,true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChAccess(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreation(), "Exists", cmpEqual, true);

    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified().ClickR();
    Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();

    
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName(), "Exists", cmpEqual,true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChModified(), "Exists", cmpEqual, false);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreated(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChAccess(), "Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChCreation(), "Exists", cmpEqual, true);
    
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters_ChName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
       
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
             
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();
 }
 
 
 
