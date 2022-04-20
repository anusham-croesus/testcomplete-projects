//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

/* Description :Tri des colonnes dans la fenêtre Gestions des filtres. Vérification du tri a été faite pour 5 entêtes de colonnes 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1442
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1483_Cli_ColumnSorting_inSearchCriteriaManage()
 {        
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre "Search Criteria"
    Get_Toolbar_BtnManageSearchCriteria().Click();        
        
    Get_WinSearchCriteriaManager_chName().Click() ;      
    Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients,"CR1352",162,language),"Description")
        
    Get_WinSearchCriteriaManager_chAccess().Click() ;
    Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients,"CR1352",163,language),"PartyLevelName")
         
    Get_WinSearchCriteriaManager_chType().Click(); 
    Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients,"CR1352",164,language),"TypeDisplayName")
          
    Get_WinSearchCriteriaManager_chCreation().Click();
    Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients,"CR1352",165,language),"CreatedByName")
           
    Get_WinSearchCriteriaManager_chModule().Click(); 
    Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),GetData(filePath_Clients,"CR1352",166,language),"Module")
       
    Get_WinSearchCriteriaManager_BtnClose().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
        
 }