//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables
//USEUNIT DBA

/* Description : :Modification du nom du critère avancé. Cliquer sur Yes dans un message apparait : Voulez vous créer un nouveau critère à partir de celui-ci? 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1509
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1509_Cli_EditName_OfAdvancedSearchCriteriaYes()
 {    
   var columnName=GetData(filePath_Clients,"CR1352",162,language)
   var criterion="CR1352_1509Yes";
   var modifiedCriterion="CR1352_1509YesModified";
   
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
   
   //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Get_WinSearchCriteriaManager_BtnAddAdvanced().Click();
   
   try{
       //Ajout de critère de recherche 
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().set_Text(criterion);
       Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click();
   
        //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, criterion)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif   
    
       //Cliquer sur le crayon de filtre appliqué
       var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
       Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-45, 13);
       
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Clear();
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().set_Text(modifiedCriterion);
       Get_WinCRUSearchCriterionAdvanced_BtnSaveAndRefresh().Click();
       
       //Validation du message
       if(language=="french"){
            aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, "Voulez-vous créer un nouveau critère de recherche à partir de celui-ci?  \r\nSi vous répondez Oui, le critère déjà existant et le nouveau critère modifié seront conservés. \r\nSi vous répondez Non, le dernier critère modifié écrasera l'autre.\r\n\r\n");   
       }    
       else{
            aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, "Do you want to create a new search from the existing saved search? \r\nIf you click Yes, the existing saved search and the modified search criteria will be kept. \r\nIf you click No, the existing saved search will be overwritten.\r\n\r\n\r\n");
       }  
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/4), Get_DlgConfirmation().get_ActualHeight()-45);
       
       //Vérifier que le critère de recherche il est appliqué dans la grille Clients
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, modifiedCriterion)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true)
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif
       
       //Vérifier que que le premier critère crée n'est pas sur la liste dans la gestionnaire de critères de recherches    
       Get_Toolbar_BtnManageSearchCriteria().Click();
       Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
       
       //Vérifier que les critères sont dans le gestionnaire de critères de recherches    
       Check_PresenceOfCriteria(criterion)      
       Check_PresenceOfCriteria(modifiedCriterion)
      
       Get_WinSearchCriteriaManager_BtnClose().Click();
        
       Get_MainWindow().SetFocus();
       Close_Croesus_SysMenu();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
    finally{
            Delete_FilterCriterion(modifiedCriterion,vServerClients)//Supprimer le criterion de BD
            Delete_FilterCriterion(criterion,vServerClients)//Supprimer le criterion de BD               
    }
 }
 
 function Check_PresenceOfCriteria(criterion)
 {
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
 }
 
