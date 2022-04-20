//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1169_Cli_Create_UserAccessFilter

/* Description :États des boutons dans la fenêtre Gestion des filtres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1441
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1441_Cli_StateOfBtns_forUserAccessFilter()
 {
    try{ 

        var filtre="Filtre_Utilisateur"
             
        Login(vServerClients, userName,psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
             
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Create_UserAccessFilter(filtre);   
                  
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,10).Click()
        
        //vérification 
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnDelete(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnEdit(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply(), "IsEnabled", cmpEqual, true);
        
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose(), "IsEnabled", cmpEqual, true);
               
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                               
        Get_MainWindow().SetFocus();
        Close_Croesus_X();                  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(filtre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 