//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

/* Description :Chargement du filtre permanent au démarrage de croesus
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1177
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1177_Cli_LoadingSeveral_PerFilter_AfterStartUp()
 {
        
    var filter1=GetData(filePath_Clients,"CR1352",92,language);
    var filter2=GetData(filePath_Clients,"CR1352",93,language);
    
    Login(vServerClients,userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre ManageFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filter1,10).Click()
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
    
    //Afficher la fenêtre ManageFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filter2,10).Click()
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
    
    Get_DlgWarning().Close();
    
           
    //vérifier que les filtres sont actifs
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter1)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpEqual, filter2)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
     //Vérifier le nombre de filtres affichés  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 2);
                      
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
    
    //Redémarrer l’application 
    Login(vServerClients,userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
     //vérification 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter1)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpEqual, filter2)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
     //Vérifier le nombre de filtres affichés  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 2);
    
    // Cliquer sur le x
    Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(2).Click();
    Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
       
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();            
 }
 