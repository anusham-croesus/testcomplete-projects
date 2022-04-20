//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT Global_variables
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT DBA
//USEUNIT CR1352_1167_Cli_Create_BranchAccessFilter

/* Description :Déactiver un filtre permanent
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1176
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1176_Cli_DeactivatePerFilter()
 {
    try{ 

        var filtre="Filtre_Succursale"
             
        Login(vServerClients,"COPERN",psw,language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
        
        //Enlever des filtres s'ils existent
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click(); 
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsChecked", true, 1000);
        
        aqObject.CheckProperty(Get_MainWindow(), "WndCaption", cmpEqual, "Croesus - Nicolas Copernic (COPERN)");
       
        //Afficher la fenêtre « Ajouter un filter » en cliquant sur Toolbar - BtnQuickFilters
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
        
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_PadHeaderBar_BtnAdd().Click(); 
               
        Create_BranchFilter(filtre)  
        
        //Appliquer le filtre
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Value",filtre,10).Click()    
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
        //vérification 
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, filtre)   
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
        
        //Les points de vérification : Vérifier que le nombre de résultats dans le grid 
        if (client == "BNC" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 45)
        }
        if(client == "US" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 22)
        } 
        if(client == "TD"){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 48)
        } 
        if(client=="RJ" || client == "CIBC"){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 48)
        }
          
        //Désactiver le filtre       
        Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click()
        //Les points de vérification : Vérifier que le nombre de résultats dans le grid
        if (client == "BNC"){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 55)
        }
        else if (client == "TD" ){
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 60)
        }
        else if( client == "US" ){aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 57)}
        else{  // CIBC
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items, "Count", cmpEqual, 55)
        }
                
        Get_MainWindow().SetFocus();
        Close_Croesus_X();
    }
    
    catch(e){
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
                       
    finally{
   
        Delete_FilterCriterion(filtre,vServerClients)//Supprimer le filtre de BD   
    }
 }
 
 

