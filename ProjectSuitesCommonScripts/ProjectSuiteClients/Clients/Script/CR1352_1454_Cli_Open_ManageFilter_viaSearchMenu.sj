//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter

/* Description : Accéder a la fenêtre Gestion de Filtres via menu RECHERCHE
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1454
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1454_Cli_Open_ManageFilter_viaSearchMenu()
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
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
             
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();

 }