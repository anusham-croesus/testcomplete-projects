//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : Création de critère avancé
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1488
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1488_Cli_Create_AdvancedSearchCriteria()
 {     
   var columnName=GetData(filePath_Clients,"CR1352",162,language)
   var criterion="CR1352_1488"
    
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
       Log.Message("Jira: TCVE-2004 - un crash ")
       Get_WinCRUSearchCriterionAdvanced_BtnSave().Click();
       WaitUntilObjectDisappears(Get_CroesusApp(), "WindowMetricTag", "CRITERIA_INFORMATION")
       
       //Vérifier que le critère est sur la liste     
       var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
            var findFilter=false;
            for (i=0; i<= count-1; i++){ 
              if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
                 findFilter=true;             
                 break;             
              }             
            } 
            if (findFilter==true){
                Log.Checkpoint("Le critère est sur la liste ");
            }
            else{
                Log.Error("Le critère n'est pas sur la liste ");
            }    
   
       Check_columnAlphabeticalSort_CR1483(Get_WinSearchCriteriaManager_DgvCriteria(),columnName,"Description" )// dans Common_functions
     
       Get_WinSearchCriteriaManager_BtnClose().Click();
        
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
 
