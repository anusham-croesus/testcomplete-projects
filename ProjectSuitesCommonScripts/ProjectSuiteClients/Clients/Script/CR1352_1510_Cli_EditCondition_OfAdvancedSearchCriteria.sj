//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :Modification des champs autre que Nom pour un critère de recherche avancé
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1510
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1510_Cli_EditCondition_OfAdvancedSearchCriteria()
 {     
   var criterion="CR1352_1510";
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
   
   try{
       //Ajout de critère de recherche 
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(criterion);
       Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click();
       WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
       
       //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif   
       var nbOfcheckedElementsBefore = Get_MainWindow_StatusBar_NbOfcheckedElements().Text
       Log.Message(nbOfcheckedElementsBefore)
       
       //Cliquer sur le crayon de filtre appliqué
       var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
       Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-45, 13);
       WaitObject(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_INFORMATION", 2000);      
       Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView_ItemClientClassEqualsRealClient().Click();
       Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView_ItemClientClassEqualsRealClient().WaitProperty("IsMouseOver", true, 5000);
       Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator().Click();
       WaitObject(Get_CroesusApp(),"VisibleOnScreen", true, 1000)
       Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_CmbOperator_ItemIsNotEqualTo().Click();
       Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnEditACondition().Click();    
       Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click();
       
       WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
       //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
       var nbOfcheckedElementsAfter = Get_MainWindow_StatusBar_NbOfcheckedElements().Text
       Log.Message(nbOfcheckedElementsAfter)
       
       //Vérifier que le critère appliqué est modifié dans la grille Clients    
       if(nbOfcheckedElementsAfter == nbOfcheckedElementsBefore){
            
            Log.Error("le critère appliqué n'a pas été modifié")
       }
       else{
            Log.Checkpoint("le critère appliqué a été modifié")
       }
        
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
    finally{
       Delete_FilterCriterion(criterion,vServerClients)//Supprimer le criterion de BD               
    }
 }
 
