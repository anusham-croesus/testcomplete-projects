//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Ajouter un critère de recherche
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1975
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1975_Cli_Add_SerachCriteria_ClickR()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="CR1352_1975_ClickR";
    var access=GetData(filePath_Clients,"CR1352",270,language)
     if(client == "US" || client == "TD" || client == "CIBC"){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients);  
    } 
    RestartServices(vServerClients); 
    try{
      Login(vServerClients, "GP1859" , psw ,language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
     
      Get_MenuBar_Tools().Click();
      Get_MenuBar_Tools_Configurations().Click();
      
      Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
      Get_WinConfigurations_LvwListView_LlbManageCriteria().WaitProperty("IsEnabled", true, 5000);
      Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();
      
      aqObject.CheckProperty(Get_WinSearchCriteriaManager(), "VisibleOnScreen", cmpEqual, true);
      
      //Ajouter un critère de recherche par click droit     
      Get_WinSearchCriteriaManager_DgvCriteria().ClickR();   
      Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_AddForRestrictions().Click()
       
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 10000);

      
      //Vérifier que le critère est sur la liste     
      var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"PartyLevelName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"CreatedByName",cmpEqual,access);
          var nbOfElements= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbOfElements
          aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate,"%#m/%d/%Y"),cmpEqual,aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CreatedDate,"%#m/%d/%Y"));
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
      
      //Cette partie couvre deux premiers étapes dans le cas Croes-1981:Supprimer un critère de recherche
      //Supprimer le critère
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click(); 
      
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      
      //Vérifier que le critère n'est pas sur la liste     
      var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"PartyLevelName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"CreatedByName",cmpEqual,access);
          var nbOfElements= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.NbOfElements
          aqObject.CompareProperty(aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate,"%#m/%d/%Y"),cmpEqual,aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CreatedDate,"%#m/%d/%Y"));
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
      Get_WinConfigurations().Close();
      
      
      //Vérifier nombres d’enregistrement 
      //Afficher la fenêtre "Search Criteria"
      Get_Toolbar_BtnManageSearchCriteria().Click();  
      Get_WinSearchCriteriaManager_BtnAdd().Click();
   
      //creation de cretere 
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().Keys(criterion);
      Get_WinAddSearchCriterion_CmbAccess().Click();
      Get_WinAddSearchCriterion_CmbAccess_ItemFirm().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();   
            
      aqObject.CheckProperty(Get_MainWindow_StatusBar_NbOfcheckedElements(),"Text",cmpEqual,nbOfElements);
         
      Close_Croesus_AltF4();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
      Delete_FilterCriterion(criterion,vServerClients) 
        if(client == "US" || client == "TD" ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }
 

