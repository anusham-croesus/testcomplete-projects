//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/* Description :Tester le menu Contextuel- CopyWithHeader
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1982
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */

 function CR1352_1982_Cli_ContextualMenu_CopyWithHeader()
 {
 
    Activate_Inactivate_Pref("GP1859","PREF_CRITERIA_RESTRICTIONS_ACCESS","YES",vServerClients)
    var criterion="CR1352_1982_CopyWithHeader";
    var access=GetData(filePath_Clients,"CR1352",270,language)
    if(client == "US" || client == "TD"  || client == "CIBC" ){
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

      Sys.Clipboard="" //vider le presse-papiers
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).Click();
      Get_WinSearchCriteriaManager().Find("Value",criterion,10).ClickR();                
      Get_WinFilterManager_DgvFilters_ContextualMenu_CopyWithHeader().Click()
      
      Aliases.CroesusApp.WPFObject("HwndSource: CriteriaManagerWindow").Maximize();

     var copiedText = Sys.Clipboard
     Log.Message(copiedText)
     // Split at each space character.
     var textArr = copiedText.split("\r\n"); //Création de tableau pour chaque ligne   
     var firstLine= textArr[0].split("	")  //Création de tableau pour le 1 ligne    
     var secondLine= textArr[1].split("	")  //Création de tableau pour le 2 ligne   

     //Vérification des entêtes et les donnes du filtre    
     var count= Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
     for(i=0;i<=count-1;i++){
         if(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description==criterion){
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chName(), "WPFControlText", cmpEqual,firstLine[0]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chAccess(), "WPFControlText", cmpEqual, firstLine[1]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chType(), "WPFControlText", cmpEqual, firstLine[2]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreation(), "WPFControlText", cmpEqual, firstLine[3]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModule(), "WPFControlText", cmpEqual, firstLine[4]);        
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chModified(), "WPFControlText", cmpEqual, firstLine[5]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chGenerated(), "WPFControlText", cmpEqual, firstLine[6]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chNoOfRecords(), "WPFControlText", cmpEqual, firstLine[7]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_chCreated(), "WPFControlText", cmpEqual, firstLine[8]);
            
           
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Description", cmpEqual, secondLine[0]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "PartyLevelName", cmpEqual, secondLine[1]);
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "TypeDisplayName", cmpEqual, secondLine[2])           
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "CreatedByName", cmpEqual, secondLine[3]);           
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "Module", cmpEqual, secondLine[4]);       
            var lastUpdate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastUpdate,"%#m/%d/%Y")
            aqObject.CompareProperty(lastUpdate, cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[5], "%#m/%d/%Y"));
            var lastGenerationDate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LastGenerationDate,"%#m/%d/%Y")
            aqObject.CompareProperty(lastGenerationDate, cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[6], "%#m/%d/%Y") );
            aqObject.CheckProperty(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "NbOfElements", cmpEqual, secondLine[7]);  
            var createdDate=aqConvert.DateTimeToFormatStr(Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.CreatedDate,"%#m/%d/%Y")
            aqObject.CompareProperty(createdDate, cmpEqual,aqConvert.DateTimeToFormatStr(secondLine[8], "%#m/%d/%Y") );
         }
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
      	if(client == "US" || client == "TD" || client == "CIBC"  ){
    Activate_Inactivate_Pref("GP1859","PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients)
    RestartServices(vServerClients);  
    } 
    }   
 }
 