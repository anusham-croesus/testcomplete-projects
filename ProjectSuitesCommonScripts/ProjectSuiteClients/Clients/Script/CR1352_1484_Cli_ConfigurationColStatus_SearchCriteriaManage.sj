//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1153_Cli_Create_PerCurrencyFilter_Icon_Y
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter


/* Description :Configuration des colonnes. Sélectionner État de la colonne
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1484
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1484_Cli_ConfigurationColStatus_SearchCriteriaManage()
 { 
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click(); 
                        
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "IsFixed", cmpEqual,false);
    Check_Column_Property();

    Get_WinSearchCriteriaManager_chName().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheRight().Click();
    
    //Vérifier que l'État de la colonne : fixe à droite
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "IsFixed", cmpEqual,true);
    aqObject.CompareProperty(Get_WinSearchCriteriaManager_chName().Field.FixedLocation,cmpEqual,"FixedToFarEdge",true);
    
    Check_Column_Property();
   
    Get_WinSearchCriteriaManager_chName().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_FixToTheLeft().Click();
    
    //Vérifier que l'État de la colonne : fixe à gauche
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "IsFixed", cmpEqual,true);
    aqObject.CompareProperty(Get_WinSearchCriteriaManager_chName().Field.FixedLocation,cmpEqual,"FixedToNearEdge",true);
    
    Check_Column_Property();
        
    Get_WinSearchCriteriaManager_chName().ClickR();
    Get_GridHeader_ContextualMenu_ColumnStatus().Click();
    Get_GridHeader_ContextualMenu_ColumnStatus_Movable().Click();
    
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "IsFixed", cmpEqual,false);  
    Check_Column_Property()
    
    Get_WinSearchCriteriaManager_chName().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
           
    Get_WinSearchCriteriaManager_BtnClose().Click();
             
    Close_Croesus_MenuBar();
 }
 function Check_Column_Property()
 {    
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "IsFixed", cmpEqual, false);
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "IsFixed", cmpEqual, false);
    Log.Message("bug CROES-5123")
    aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "IsFixed", cmpEqual, false);
 }