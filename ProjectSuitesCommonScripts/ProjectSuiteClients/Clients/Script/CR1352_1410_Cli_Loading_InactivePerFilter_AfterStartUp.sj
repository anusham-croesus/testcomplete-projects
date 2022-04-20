//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

/* Description :Chargement des filtres permanents inactifs au démarrage de croesus
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1410
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1410_Cli_Loading_InactivePerFilter_AfterStartUp()
 {
    var filter=GetData(filePath_Clients,"CR1352",92,language);
    
    Login(vServerClients,userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
       
    //Afficher la fenêtre ManageFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filter,10).Click();
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
    
    //désactiver le filtre 
    Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(); 
           
    //vérification 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
                           
    Get_MainWindow().SetFocus();
    Close_Croesus_X();
    
    Login(vServerClients,userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    //vérification 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filter)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    Log.Message("CROES-5204, Lorsque des filtres sauvegardés sont désactivés, ils ne gardent pas leur état. Ils sont toujours actifs a la réouverture de Croesus.")  
     
    // Cliquer sur le x
    Get_RelationshipsClientsAccountsGrid_BtnFilter_BtnRemove(1).Click();
        
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();            
 }
 
