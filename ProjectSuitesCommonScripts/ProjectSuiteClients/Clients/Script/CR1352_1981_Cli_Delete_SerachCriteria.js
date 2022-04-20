//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA



/* Description : Supprimer un critère de recherche
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1981
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1981_Cli_Delete_SerachCriteria()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="criterion_1981";
    var access=GetData(filePath_Clients,"CR1352",270,language)
    var restriction="restriction_1981";
    var security ="AAER INC";
    if(client == "US" || client == "TD"  || client == "CIBC"){
      Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients);  
    } 
    RestartServices(vServerClients);
    try{
      Login(vServerClients, "GP1859" , psw ,language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
     
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
      
      //Ajout d'un critère
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();      
      aqObject.CheckProperty(Get_WinSearchCriteriaManager(), "VisibleOnScreen", cmpEqual, true);
  
      Get_WinSearchCriteriaManager_BtnAdd().Click();       
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      Sys.Refresh();
      Get_WinSearchCriteriaManager_BtnClose().Click();
      
      //Ajout d'une restriction 
      Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();    
      aqObject.CheckProperty(Get_WinRestrictionsManagerForConfigurations(), "VisibleOnScreen", cmpEqual, true);
      
      Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd().Click();     
      Get_WinCRURestriction_TxtName().Keys(restriction);
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(security)
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]")
      if(client == "CIBC")
      {
       Aliases.CroesusApp.subMenus.FindChild("Value",security,10).DblClick();   //Ajouté par  Amine
       }
      else
      {
       Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
       Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
      }
      if(Get_WinCRURestriction_BtnOK().WaitProperty("IsEnabled",true,5000)){
        Get_WinCRURestriction_BtnOK().Click();
      }      
      Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();
      
      //Assigner les restrictions 
      Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick();      
      aqObject.CheckProperty(Get_WinAssignedRestrictionsManager(), "VisibleOnScreen", cmpEqual, true);      
      Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd().Click();      
      aqObject.CheckProperty(Get_WinAssignRestrictions(), "VisibleOnScreen", cmpEqual, true);
      
      //Ajout d'une restriction
      Get_WinAssignRestrictions_GrpRestrictions_BtnAdd().Click();    
      Get_WinRestrictionsManagerForConfigurations().Find("Value",restriction,10).Click();
      Get_WinRestrictionsManagerForConfigurations_BtnOK().Click();
      
      //Vérifier que le critère est sur la liste     
      var count= Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinAssignRestrictions_GrpRestrictions_DgvRestrictions().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Name()==restriction){
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
                
      //Ajout d'un critèr
      Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd().Click();
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnOK().Click();
      
        //Vérifier que le critère est sur la liste     
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
      
      //Afficher la fenêtre Gestionnaire de critères de recherche 
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();
      
      aqObject.CheckProperty(Get_WinSearchCriteriaManager(), "VisibleOnScreen", cmpEqual, true);
      //Supprimer le critère de recherche
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click();
      
      aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpMatches,GetData(filePath_Clients,"CR1352",279,language)) 
      //Cliquer sur supprimer 
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);  
      
      aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,GetData(filePath_Clients,"CR1352",280,language)) 
      //Cliquer sur OK  
      Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
      
      Get_WinSearchCriteriaManager_BtnClose().Click();
      Get_WinConfigurations().Close();
      
      Close_Croesus_AltF4();
             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      //Remettre les données a l’état initial           
      Login(vServerClients, "GP1859" , psw ,language);
      Get_ModulesBar_BtnClients().Click();
     
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick(); 
      
      Get_WinAssignedRestrictionsManager_DgvAssignedRestrictions().Find("Value",restriction,10).Click();
      Get_WinAssignedRestrictionsManager_BarPadHeader_BtnDelete().Click();
      //Cliquer sur supprimer 
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
      Get_WinAssignedRestrictionsManager_BtnClose().Click();
      
      //Supprimer la restriction 
      Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick(); 
      Get_WinRestrictionsManagerForConfigurations().Find("Value",restriction,10).Click();
      Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnDelete().Click();
      //Cliquer sur supprimer 
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
      Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();     
      
      //Supprimer le critère de recherche
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick(); 
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click();
      //Cliquer sur supprimer 
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
      Get_WinSearchCriteriaManager_BtnClose().Click();
      Get_WinConfigurations().Close();
      Close_Croesus_AltF4();
      
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
      	if(client == "US" || client == "TD"  || client == "CIBC" ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }
 function test()
 {
    Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("AAER INC")
      Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]")
   Aliases.CroesusApp.subMenus.FindChild("Value","AAER INC",10).DblClick();
 }
