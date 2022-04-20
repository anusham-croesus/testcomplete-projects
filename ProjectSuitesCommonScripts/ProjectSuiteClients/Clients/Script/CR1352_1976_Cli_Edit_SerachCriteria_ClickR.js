//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Modifier le critère de recherche
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1976
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1976_Cli_Edit_SerachCriteria_ClickR()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="CR1352_1976_ClickR";
    var access=GetData(filePath_Clients,"CR1352",270,language)
    if(client == "US" || client == "TD" || client == "CIBC" ){
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
      
      for(var i=1;i<=2; i++){
          //Ajouter un critère de recherche en cliquant sur Ajouter      
          Get_WinSearchCriteriaManager_BtnAdd().Click();
        
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().set_Text(criterion+"_"+i);
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSave().Click();
      }
      
      //Modifier le critère
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion+"_1",10).Click();
      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion+"_1",10).ClickR();
      Get_WinSearchCriteriaManager_DgvCriteria_ContextualMenu_EditForRestrictions().Click()
       
      Get_WinAddSearchCriterion().WaitProperty("IsVisible",true,2000);          
      Get_WinAddSearchCriterion_TxtName().Clear();
      Get_WinAddSearchCriterion_TxtName().set_Text(criterion+"_2");
      Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
      
     // if(client == "CIBC")
              aqObject.CheckProperty(Get_DlgConfirmation_LblMessageCF(), "Text", cmpEqual, GetData(filePath_Clients, "CR1352", 273, language));
      //else
            //  aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "Text", cmpEqual, GetData(filePath_Clients, "CR1352", 273, language));
              
      aqObject.CheckProperty(Get_DlgConfirmation_RdoCreateANewCriterion(), "WPFControlText", cmpEqual, GetData(filePath_Clients, "CR1352", 274, language));
      aqObject.CheckProperty(Get_DlgConfirmation_RdoChangeTheCurrentCriterion(), "WPFControlText", cmpEqual, GetData(filePath_Clients, "CR1352", 275, language));
      
      Get_DlgConfirmation_RdoChangeTheCurrentCriterion().set_IsChecked(true);
      
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      
      //Vérifier le message
      //aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, GetData(filePath_Clients,"CR1352",276,language)); //Dans ce cas le fichier Excel n’a pas fonctionné
      Log.Message("Croes-4495")
      if(language=="french"){
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches, "Un critère de recherche a déjà été enregistré sous ce nom. \r\nVeuillez vérifier le nom du critère dans les deux langues."); //EM : Modifié selon le Jira Croes-4495'
      }  
      else{
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches, "A search criterion has already been saved under this name.\r\nVerify the criterion name in both languages.");
      }   
      
      //Cliquer sur OK  
      Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
      
      Get_WinAddSearchCriterion_BtnCancel().Click();
           
      //Supprimer les critères
      for(var i=1;i<=2; i++){
        Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion+"_"+i,10).Click();
        Get_WinSearchCriteriaManager_BtnDelete().Click(); 
      
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);           
      }
      
      Get_WinSearchCriteriaManager_BtnClose().Click(); 
      Get_WinConfigurations().Close(); 
      
      //Fermer l'application  
      Close_Croesus_AltF4();
       
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally{
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","NO",vServerClients)
      	
	if(client == "US" || client == "TD" || client == "CIBC"  ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }