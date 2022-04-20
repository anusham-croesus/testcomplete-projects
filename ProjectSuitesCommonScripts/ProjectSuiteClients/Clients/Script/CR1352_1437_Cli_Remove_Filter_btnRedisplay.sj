//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters


/* Description :Retirer les filtres appliqués avec le bouton réafficher tout
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1437
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1437_Cli_Remove_Filter_btnRedisplay()
 {
    var perFilter1=GetData(filePath_Clients,"CR1352",92,language);
    var perFilter2=GetData(filePath_Clients,"CR1352",93,language);
    var temFilterName1=GetData(filePath_Clients,"CR1352",96,language);
    
    Login(vServerClients,userName,psw,language);
    Get_ModulesBar_BtnClients().Click();
    
    Get_MainWindow().Maximize();
     
    
    //Création et application du filtre temporaire  
    //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_Currency().Click();
    Get_WinCreateFilter_CmbOperator().DropDown();
    Get_WinCRUFilter_CmbOperator_ItemAmong().Click();
    //Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Items.Item(Get_IndexForCurrencyCAD()).set_IsSelected(true);
    Get_WinCreateFilter_DgvValue().WPFObject("RecordListControl", "", 1).Find("Value","CAD",10).Click();  
    Get_WinCreateFilter_BtnApply().Click();  
   
    //Les points de vérification
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, temFilterName1);
                  
    //Afficher la fenêtre ManageFilters pour appliquer le perFilter1
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",perFilter1,10).Click()
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
    
    //Afficher la fenêtre ManageFilters pour appliquer le perFilter2
    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                      
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",perFilter2,10).Click()
    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
    
    Get_DlgWarning().Close();//Fermeture du message 
               
    //vérifier que les filtres sont actifs
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, temFilterName1)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2).DataContext, "FilterDescription", cmpEqual, perFilter1)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(2), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3), "IsEnabled", cmpEqual, true);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3).DataContext, "FilterDescription", cmpEqual, perFilter2)   
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(3), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
    
     //Vérifier le nombre de filtres affichés  
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 3);
                      
    
    // Cliquer sur le Redisplay
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
     //Vérifier le nombre de filtres affichés  (Tous le filtres appliqués sont retirés de la grille )
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.WPFObject("ItemsControl", "", 1).Items, "Count", cmpEqual, 0);
             
    Get_MainWindow().SetFocus();
    Close_Croesus_MenuBar();            
 }
 
