//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA



/* Description :Ajouter un critère de recherche
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1975
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1975_Cli_Add_SerachCriteria_btnAdd()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    Activate_Inactivate_Pref("GP1859","PREF_DISPLAY_WHATS_NEW","NO",vServerClients); 
    var criterion="CR1352_1975_btnAdd";
    var access=GetData(filePath_Clients,"CR1352",270,language)
    if(client == "US" || client == "TD" || client == "CIBC"){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)     
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
      
      //Ajouter un critère de recherche en cliquant sur Ajouter      
      Get_WinSearchCriteriaManager_BtnAdd().Click();
        
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSave().Click();

      
      //Vérifier que le critère est sur la liste     
      var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
      var findFilter=false;
      for (i=0; i<= count-1; i++){ 
       if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description()==criterion){
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"PartyLevelName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"CreatedByName",cmpEqual,access);
          aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"NbOfElements",cmpEqual,null);
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
      
      //Supprimer le critère
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager_BtnDelete().Click(); 
      
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      Get_WinSearchCriteriaManager_BtnClose().Click(); 
      Get_WinConfigurations().Close();
      
      Close_Croesus_AltF4();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
          if(client == "US" || client == "TD" ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }