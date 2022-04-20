//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description : Disponibilité des boutons pour les critères de type Gabarit
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1486
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1486_Cli_StateOfBtns_forSearchCriteriaTemplate()
 { 
   var type= GetData(filePath_Clients,"CR1352",154,language)
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   
    //Choisir un filtre  de type Gabarie
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).ClickR();
    
    //Vérifier que Les boutons disponibles sont : Ajouter , Ajouter avancé, Créer à partir de , Fermer.  .Les boutons grisés sont : Supprimer, Copier, Charger , Actualiser.
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAdd(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnAddAdvanced(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCreateFromTemplate(), "IsEnabled", cmpEqual, true)
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnClose(), "IsEnabled", cmpEqual, true);
   
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnCopy(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnRefresh(), "IsEnabled", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnLoad(), "IsEnabled", cmpEqual, false);  
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_BtnDelete(), "IsEnabled", cmpEqual, false);
    
    Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",type,100).ClickR();   
    //Les fonctions disponibles sont : Ajouter, Ajouter avancé, Créer à partir de, Fermer. Supprimer, Copier, Charger et Actualiser sont grisés.
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Add(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddAdvanced(), "IsEnabled", cmpEqual, true); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_CreateFromTemplate(), "IsEnabled", cmpEqual, true)
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Close(), "IsEnabled", cmpEqual, true);
  
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Delete(), "IsEnabled", cmpEqual, false); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Copy(), "IsEnabled", cmpEqual, false); 
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Refresh(), "IsEnabled", cmpEqual, false)
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_Load(), "IsEnabled", cmpEqual, false);
     
    Get_WinSearchCriteriaManager_BtnClose().Click();
        
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
 }
 
