//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList

/* Description : Sauvegarde des critères par défaut au démarrage de croesus
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1527
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1527_Cli_Save_DefaultClientsListCriteria_AfterStartup()
 { 
    var type= GetData(filePath_Clients,"CR1352",155,language)  
    var criterion= GetData(filePath_Clients,"CR1352",59,language)
    
    try{
        Login(vServerClients, userName, psw, language);
        Get_ModulesBar_BtnClients().Click();
        
        Get_MainWindow().Maximize();
   
        Create_DefaultClientsList();
    
        Get_Toolbar_BtnManageSearchCriteria().Click(); 
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
    
        if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.Description==GetData(filePath_Clients,"CR1352",59,language)){
           Log.Checkpoint("Liste de clients par défautest est dans le Gestionnaire de critères de recherches en haut de la liste")
           Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",GetData(filePath_Clients,"CR1352",59,language),100).Click();
           Get_WinSearchCriteriaManager_BtnLoad().Click();
      
           //Vérifier que le critère est appliqué  
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif  
     
           Get_MainWindow().SetFocus();
           Close_Croesus_SysMenu();
      
           Login(vServerClients, userName, psw, language);
           Get_ModulesBar_BtnClients().Click();
      
           //Vérifier que le critère est appliqué  
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif 
            
           //Supprimer le critère par default
           Delete_DefaultClientsList(type)
         
        }
        else{
           Log.Error("Liste de clients par défaut n'est pas dans le Gestionnaire de critères de recherches en haut de la liste")
           Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click();
           Get_WinSearchCriteriaManager_BtnClose().Click();
        }
     
        Get_MainWindow().SetFocus();
        Close_Croesus_SysMenu();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
   
        Delete_FilterCriterion(criterion,vServerClients)//Supprimer le filtre de BD   
    }

 }
 

