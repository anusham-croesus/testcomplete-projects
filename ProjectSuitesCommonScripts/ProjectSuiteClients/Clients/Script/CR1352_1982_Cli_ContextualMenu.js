//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Tester le menu Contextuel
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1982
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1982_Cli_ContextualMenu()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="CR1352_1982";
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
      
     //Ajouter un critère de recherche en cliquant sur Ajouter      
      Get_WinSearchCriteriaManager_BtnAdd().Click();
       
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion);
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
      Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 10000);
      
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
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
        else{
       // Log.Message(Aliases.CroesusApp.subMenus.WPFObject("ContextMenu", "", 1).Items.Item(i))
        aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu().Items.Item(i),"WPFControlText", cmpEqual,GetData(filePath_Clients,"CR1352",284+i,language))} 
      }
      
     //Supprimer le critère
     Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
     Get_WinSearchCriteriaManager_BtnDelete().Click();
    
     //Cliquer sur supprimer 
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
          
	
	if(client == "US" || client == "TD" || client == "CIBC"){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }
 
 