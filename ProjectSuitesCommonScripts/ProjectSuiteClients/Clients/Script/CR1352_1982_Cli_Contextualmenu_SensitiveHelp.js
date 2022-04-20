//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Tester le menu Contextuel- SensitiveHelp
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1982
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1982_Cli_Contextualmenu_SensitiveHelp()
 {
    
    var criterion="CR1352_1982_SensitiveHelp";
    var access=GetData(filePath_Clients,"CR1352",270,language)
    if(client == "US" || client == "TD" ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients);  
    } 
    RestartServices(vServerClients);
    try{
      Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
      
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
      Get_WinFilterManager_DgvFilters_ContextualMenu_Help().Click()
      Get_WinFilterManager_DgvFilters_ContextualMenu_Help_ContextSensitiveHelp().Click()
    
      var length=aqString.GetLength(vServerClients)
      var subString= aqString.SubString(vServerClients, 7, length-7)
      if(client=="RJ"){
        aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#"+GetData(filePath_Clients,"CR1352",299,language)+"\\"+GetData(filePath_Clients,"CR1352",303,language)+".htm").Frame(0).Frame("topic").TextNode(1), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",304,language));
      }
      else{
        Log.Message("CROES-8440")
        Log.Message("EM: Le titre de la page n'est plus le même, il faut changer le datapool. Changement effectué pour l'url mais pas pour le titre")
        aqObject.CheckProperty(NameMapping.Sys.Browser("iexplore").Page("http://"+subString+"crweb/help/croesus/90/"+GetData(filePath_Clients,"CR1352",126,language)+"/Version9.htm#"+GetData(filePath_Clients,"CR1352",299,language)+"\\"+GetData(filePath_Clients,"CR1352",300,language)+".htm").Frame(0).Frame("topic").TextNode(1), "contentText", cmpEqual, GetData(filePath_Clients,"CR1352",301,language)); //EM: 90-06-Be-13 url a été modifié dans le datapool 
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
      	
    	if(client == "US" || client == "TD" ){
        Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
        RestartServices(vServerClients);  
        } 
    }   
 }