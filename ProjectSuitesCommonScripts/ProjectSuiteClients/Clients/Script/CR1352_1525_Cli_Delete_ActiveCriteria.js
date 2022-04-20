//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Supprimer un critère actif
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1525
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1525_Cli_Delete_ActiveCriteria()
 {     
   var criterion="CR1352_1525"
    
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
       
       //Vérifier que le critère est appliqué  
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif
   
       Get_Toolbar_BtnManageSearchCriteria().Click(); 
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
 
       //Choisir un filtre 
       Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,100).Click(); 
       Get_WinSearchCriteriaManager_BtnDelete().Click();
       
       //Validation du message
       aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",173,language));   
      
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       
       aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",174,language)); 
       
       var width = Get_DlgWarning_LblMessage().Get_Width();
       Get_DlgWarning().Close()
       
       //Vérifier que le critère n'est pas sur la liste     
       var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
       var findFilter=false;
            for (i=0; i<= count-1; i++){ 
              if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
                 findFilter=true;             
                 break;             
              }             
            } 
            if (findFilter==true){
                Log.Error("Le critère est sur la liste ");
            }
            else{
                Log.Checkpoint("Le critère n'est pas sur la liste ");
            }
            
       Get_WinSearchCriteriaManager_BtnClose().Click();
       
       //Vérifier que le critère est retiré  
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "Exists", cmpEqual, false);
            
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
 
