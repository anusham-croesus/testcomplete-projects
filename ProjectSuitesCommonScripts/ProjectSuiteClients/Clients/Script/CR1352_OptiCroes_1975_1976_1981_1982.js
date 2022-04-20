//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


/**
  Description : Gestion des criteres de recherches - Ajouter un critère de recherche par BtnAdd + L'editer par ClickR + Le Supprimer + Vérifier MenuContextuel
  
  Regrouper les scripts suivants:
  CR1352_1975_Cli_Add_SerachCriteria_btnAdd
  CR1352_1976_Cli_Edit_SerachCriteria_btnEdit
  CR1352_1981_Cli_Delete_SerachCriteria
  CR1352_1982_Cli_ContextualMenu
    
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-19-2020-09-45
*/


 function CR1352_OptiCroes_1975_1976_1981_1982()
 {  
    try{
      
      GP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
      pswGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
      
      Log.Message("Activer les Pref");
      Activate_Inactivate_Pref(GP1859,"PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
      Activate_Inactivate_Pref(GP1859,"PREF_DISPLAY_WHATS_NEW","NO",vServerClients);       
      if(client == "US" || client == "TD" || client == "CIBC"){
      Activate_Inactivate_Pref(GP1859,"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)     
      } 
      RestartServices(vServerClients); 
      
      var criterion="CR1352_1975_btnAdd";
      var access=GetData(filePath_Clients,"CR1352",270,language)
      
      Log.Message("se connercter avec GP1859");
      Login(vServerClients, GP1859 , pswGP1859 ,language);
      
     //********************************** Étape 1 : Ajouter un critère de recherche avec BtnAdd **********************************/
      Log.AppendFolder("Étape 1: Croes-1975 - Ajouter un critère de recherche avec BtnAdd");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1975", "Cas de test TestLink: Croes-1975");  
     //**********************************************************************************************************************************************************************/
    
      Log.Message("Choisir le module client"); 
      Get_ModulesBar_BtnClients().Click();
      Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);    
      Get_MainWindow().Maximize();
     
      Log.Message("cliquer sur Outils/configurations/Restrictions/Gérer les critères pour ouvrir la fenetre Gestionnaire de critères de recherche "); 
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();  
          
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();      
      aqObject.CheckProperty(Get_WinSearchCriteriaManager(), "VisibleOnScreen", cmpEqual, true);
      
      Log.Message("Ajouter le critère de recherche "+criterion+" en cliquant sur Ajouter");      
      Get_WinSearchCriteriaManager_BtnAdd().Click();
        
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSave().Click();

      var nbOfElementsBefore = 0;
      Log.Message("Vérifier que le critère est sur la liste");
      var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"PartyLevelName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"CreatedByName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"NbOfElements",cmpEqual,null);
          if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbOfElements != null)
            nbOfElementsBefore= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbOfElements
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
      
      Log.PopLogFolder();
      
     //********************************** Étape 2 : Modifier un critère de recherche avec ClickR **********************************/
      Log.AppendFolder("Étape 2: Croes-1976 - Modifier un critère de recherche avec ClickR");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1976", "Cas de test TestLink: Croes-1976");  
     //**********************************************************************************************************************************************************************/
          
      Log.Message("Modifier le critère");
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();      
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).ClickR();
      Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_EditForRestrictions().Click() 
      
      //Modifier le critère             
      if(Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Exists==true)
      {        
        Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClient().Click();
        if (client == "BNC"  )
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentativeItem().Click(); 
        else //RJ
          Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFictitiousClientItem().Click();         
      }
      else
      {
        Get_WinAddSearchCriterion_LvwDefinition_LlbClientsFamilyRepresentative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbClientsRealClientItem().Click();
      }
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 10000);
      
      Log.Message("Vérifier que le nombre d’enregistrement a été  modifié"); 
      aqObject.CompareProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbOfElements,cmpNotEqual,nbOfElementsBefore)
           
      
      Log.PopLogFolder();
       
      //********************************** Étape 3 : Tester le menu Contextuel **********************************/
      Log.AppendFolder("Étape 3: Croes-1982 - Tester le menu Contextuel");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1982", "Cas de test TestLink: Croes-1982");  
     //**********************************************************************************************************************************************************************/
      
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).ClickR();
          
      var count= Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().Items.Count
       for (var i=0; i<count-2; i++){
        if(i==3  || i==4 || i==5 || i==6 || i==7  ){
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().Items.Item(i+1),"WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",284+i,language))
          Log.Message(GetData(filePath_Clients,"CR1352",284+i,language)); 
        }
        else if( i==8 || i==9 ){
          Log.Message(GetData(filePath_Clients,"CR1352",284+i+1,language)); 
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().Items.Item(i+2),"WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",284+i+1,language))
        
        } 
        else
           aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().Items.Item(i),"WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",284+i,language))} 
      
      //Fermer la fenetre de Gestionnaire de critères de recherche
      Get_WinSearchCriteriaManager_BtnClose().Click();
      
      Log.PopLogFolder();
      
      //********************************** Étape 4 : Supprimer un critère de recherche et Gestion de restrictions**********************************/
      Log.AppendFolder("Étape 4: Croes-1981 - Supprimer un critère de recherche et Gestion de restrictions");
      //Afficher le lien de cas de test
      Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1981", "Cas de test TestLink: Croes-1981");  
     //**********************************************************************************************************************************************************************/
     
     var restriction="restriction_1981";
     var security ="AAER INC";
     Errormessage = GetData(filePath_Clients,"CR1352",280,language);
      
     Log.Message("Ajout d'une restriction ");
      Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();    
      aqObject.CheckProperty(Get_WinRestrictionsManagerForConfigurations(), "VisibleOnScreen", cmpEqual, true);
      
      Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd().Click();     
      Get_WinCRURestriction_TxtName().Keys(restriction);
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security)
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]")
      if(client == "CIBC")
          Aliases.CroesusApp.subMenus.FindChild("Value",security,10).DblClick();   //Ajouté par  Amine
      else
      {
         Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
         Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
      }
      if(Get_WinCRURestriction_BtnOK().WaitProperty("IsEnabled",true,5000))
        Get_WinCRURestriction_BtnOK().Click();
           
      Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();
      
      Log.Message("Assigner les restrictions ");
      Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick();      
      aqObject.CheckProperty(Get_WinAssignedRestrictionsManager(), "VisibleOnScreen", cmpEqual, true);      
      Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd().Click();      
      aqObject.CheckProperty(Get_WinAssignRestrictions(), "VisibleOnScreen", cmpEqual, true);
      
      Log.Message("Ajout d'une restriction");
      Get_WinAssignRestrictions_GrpRestrictions_BtnAdd().Click();    
      Get_WinRestrictionsManagerForConfigurations().Find("Value",restriction,10).Click();
      Get_WinRestrictionsManagerForConfigurations_BtnOK().Click();
      
      Log.Message("Vérifier que la restriction est sur la liste  ");   
      var count= Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Name()==restriction){
          findFilter=true;             
          break;             
       }             
      } 
      if (findFilter==true)
        Log.Checkpoint("Le critère est sur la liste ");
      else
        Log.Error("Le critère n'est pas sur la liste ");
                     
      Log.Message("Ajouter le critère pour "+criterion+" l'assigner à la restriction "+restriction);
      Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd().Click();
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnOK().Click();
      
      Log.Message("Vérifier que le critère est sur la liste ");     
      var count= Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinAssignRestrictions_GrpSearchCriteria_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
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
              
      //Fermer la fenêtre Associer des restrictions 
      Get_WinAssignRestrictions_BtnOK().Click();      
     
     //Fermer la fenêtre Gestionnaire des restrictions assignées 
      Get_WinAssignedRestrictionsManager_BtnClose().Click();
      
      Log.Message("Afficher la fenêtre Gestionnaire de critères de recherche"); 
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();      
      Get_WinSearchCriteriaManager().WaitProperty("VisibleOnScreen", true, 5000);
      
      Log.Message("Supprimer le critère "+criterion+" et vérifier qu'un message d'erreur s'affiche : "+Errormessage);
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click();      
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpMatches,GetData(filePath_Clients,"CR1352",279,language)) 
      //Cliquer sur supprimer pour confirmer
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      //Vérifier le message d'erreur
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,Errormessage); 
      //Cliquer sur OK  
      Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
      
      Get_WinSearchCriteriaManager_BtnClose().Click();
      
      Log.Message("Supprimer l'assignation de la restriction "+restriction+" au critère de recherche"+criterion);
      Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick();      
      Get_WinAssignedRestrictionsManager().WaitProperty("VisibleOnScreen", true, 5000); 
      Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().Find("Value",restriction,10).Click();     
      Get_WinAssignedRestrictionsManager_BarPadHeader_BtnDelete().Click();      
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      //Validation de la suppression de l'assignation de la restriction au critère
      if(Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().Find("Value",restriction,10).Exists)
        Log.Error("Problème de suppression: la restriction "+restriction+" est toujours assigné au critère de recherche "+criterion);
      else
        Log.Checkpoint("L'assignation de la restriction "+restriction+" au critère de recherche "+criterion+" a été supprimé avec succès.");        
      Get_WinAssignedRestrictionsManager_BtnClose().Click();
      
      Log.Message("Supprimer le critère "+criterion);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();      
      Get_WinSearchCriteriaManager().WaitProperty("VisibleOnScreen", true, 5000);
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click();
      //Validation de la suppression de critère
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      if(Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Exists)
        Log.Error("Problème de suppression: le critère de recherche "+criterion+" existe encore.");
      else
        Log.Checkpoint("Le critère de recherche "+criterion+" a été supprimé avec succès.");
        
      Get_WinSearchCriteriaManager_BtnClose().Click();
      
      Log.Message("Supprimer la restriction "+restriction);
      Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();    
      Get_WinRestrictionsManagerForConfigurations().WaitProperty("VisibleOnScreen", true, 5000); 
      Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().Find("Value",restriction,10).Click();     
      Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnDelete().Click(); 
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      //Validation de la suppression de la restriction
      if(Get_WinRestrictionsManagerForConfigurations_DgvRestrictions().Find("Value",restriction,10).Exists)
        Log.Error("Problème de suppression: la restriction "+restriction+" existe encore.");
      else
        Log.Checkpoint("La restriction "+restriction+" a été supprimé avec succès.");
      
      Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();               
      Get_WinConfigurations().Close();
           
      Log.PopLogFolder()
       
    }
    catch(e) 
    {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      
      //Fermer Croesus
      Log.Message("Fermer Croesus")
      Close_Croesus_X();
  	  
      Activate_Inactivate_Pref(GP1859,"PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
          if(client == "US" || client == "TD" ){
      Activate_Inactivate_Pref(GP1859,"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
      RestartServices(vServerClients);
      
      //Fermer le processus Croesus
      Terminate_CroesusProcess();         
      Runner.Stop(true)  
    } 
    }   
 }
 
 