//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1352_1487_Cli_StateOfBtns_forSearchCriteriaManualList
//USEUNIT DBA

/* Description :Modifier une liste manuelle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1967
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1967_Edit_ManualList()
 {   
   var type= GetData(filePath_Clients,"CR1352",155,language)
   var criterion="CR13520_1967";
    
   Login(vServerClients, userName, psw, language);
   Get_ModulesBar_BtnClients().Click();
   
   Get_MainWindow().Maximize();
      
   //Création de critère de recherche qui sera remplacé par la suite.    
  //Afficher la fenêtre "Search Criteria"
   Get_Toolbar_BtnManageSearchCriteria().Click();  
   Get_WinSearchCriteriaManager_BtnAdd().Click();
   
   try{
       //creation de critère 
       Get_WinAddSearchCriterion_TxtName().Clear();
       Get_WinAddSearchCriterion_TxtName().Keys(criterion);
       Get_WinAddSearchCriterion_CmbAccess().Click();
       Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion().Click();  
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
       Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
       Get_WinAddSearchCriterion_BtnSave().Click();       
       Get_WinSearchCriteriaManager_BtnClose().Click();

       //Avec la barre d'espacement retirer ou ajouter les enregistrements
       for(i=0; i<=2; i++){
        Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Items.Item(i).set_IsSelected(true)
		WaitObject(Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl, "IsLoaded", true);
       }
       Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.CRMGrid.RecordListControl.Keys(" ");
      
       //Vérifier que le critère est appliqué est activé  
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "IsVisible", cmpEqual, true);
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1), "wState", cmpEqual, 0); // 0- Le filtre n'est pas actif ; 1- Le filtre est actif  
   
       //Cliquer sur le crayon 
       var width = Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth();
       Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(width-40, 13);
   
       //Vérifier que que seul le nom est éditable 
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpInformation_BtnProperties(), "IsEnabled", cmpEqual, true);
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnAdd(), "IsEnabled", cmpEqual, false);
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_BtnEdit(), "IsEnabled", cmpEqual, false);
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnAddACondition(), "IsEnabled", cmpEqual, false);
       aqObject.CheckProperty(Get_WinCRUSearchCriterionAdvanced_GrpDefinition_GrpCondition_BtnEditACondition(), "IsEnabled", cmpEqual, false);
   
       //Modifier le champ Nom
       Get_WinCRUSearchCriterionAdvanced_GrpInformation_TxtName().Keys(criterion)
       Get_WinCRUSearchCriterionAdvanced_BtnSave().Click();
        //WaitObject(Get_CroesusApp(),"WindowMetricTag","UNI_YESNO_API")

       //Vérifier le message
       if(language=="french"){
          aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual,"Le nom entré existe déjà. Voulez-vous écraser la définition de ce critère de recherche?");
       }
       else{
          aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual,"The name entered already exists. Do you want to overwrite this search criterion definition?");
       }
       Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
   
       
       aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "ActiveCriteriaDescription", cmpEqual, GetData(filePath_Clients,"CR1352",59,language));//le nom de critère 
       var ActiveCriteriaNbOfElementsBefore=Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteriaNbOfElements
       
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
 
 