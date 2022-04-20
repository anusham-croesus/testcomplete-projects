//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT CR1352_1037_Cli_Create_TempCPFilter_ToolBar_btnQuickFilters
//USEUNIT CR1352_1039_Cli_Edit_TempFilter_ByPermanentFilter
//USEUNIT CR1352_1038_Cli_Edit_TempFilter
//USEUNIT Global_variables

/* Description :Unicité du nom du critère de recherche par niveau de d'accés
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1506
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_1506_Cli_UniqueName_OfSearchCriteria_SameLevelAccess()
 {   
   Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","YES",vServerClients)
   RestartServices(vServerClients);
   
   if (client == "BNC")
      var criterion="same adress"
   
   if (client == "TD" )
      var criterion="COPERN VT <> 0"
   
   if(client == "US" || client == "CIBC" )
      var criterion="Same name search criteria"
      
   if(client != "US" && client != "BNC" && client != "TD" && client != "CIBC"){//RJ 
     if(language=="french"){
        var criterion="Clients dont l'anniversaire est au mois de..."
      }
      else{
        var criterion="Clients born in the month of..."
      }
   }

   var message=GetData(filePath_Clients,"CR1352",169,language)
   
 try{  
     Login(vServerClients, userName, psw, language);
     Get_ModulesBar_BtnClients().Click();
     
     Get_MainWindow().Maximize();
     if(client == "US" || client == "CIBC")// ajout d'un filtre de type d'accés user
     {
     Get_Toolbar_BtnManageSearchCriteria().Click(); 
     Get_WinSearchCriteriaManager_BtnAdd().Click();
   
     Get_WinAddSearchCriterion_TxtName().Clear();
     Get_WinAddSearchCriterion_TxtName().Keys(criterion);
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
     Get_WinAddSearchCriterion_CmbAccess().Click();
     Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion().Click(); 
     Get_WinAddSearchCriterion_BtnSave().Click(); 
     Get_WinSearchCriteriaManager_BtnClose().Click();
       
     } 
   
     //Afficher la fenêtre "Search Criteria"
     Get_Toolbar_BtnManageSearchCriteria().Click(); 
     Get_WinSearchCriteriaManager_BtnAdd().Click();
     Get_WinSearchCriteriaManager_BtnAdd().WaitProperty("IsChecked", true, 10000);
     
     Get_WinAddSearchCriterion_TxtName().Clear();
     Get_WinAddSearchCriterion_TxtName().Keys(criterion);
      
     //creation de cretere 
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
     Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemDot().Click();
     
     if(client=="RJ" || client == "US" || client == "TD" || client == "CIBC" ){
        Get_WinAddSearchCriterion_CmbAccess().Click();  
        if( client == "RJ" ){
              Get_WinAddSearchCriterion_CmbAccess_ItemFirm().Click();
        } 
        else
            //if(client == "US" || client == "TD" || client == "CIBC"){
        Get_WinAddSearchCriterion_CmbAccess_ItemMyCriterion().Click(); 
        if(client == "CIBC"){
             Log.Message("On a une différence dans le texte du niveau d'accés sur la fenêtre d'un ajout de critére de recherche")
       }       
     } 
     Get_WinAddSearchCriterion_BtnSave().WaitProperty("VisibleOnScreen", true, 30000);     
     Get_WinAddSearchCriterion_BtnSave().Click();
     
     var numberOftries=0;  
     while ( numberOftries < 5 && Get_WinSearchCriteriaManager().Exists && !Get_DlgInformation().Exists){
        Get_WinAddSearchCriterion_BtnSave().Click();
        numberOftries++;
     }  
  
     Log.Message("CROES-4495")
     //aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,message); //Dans ce cas le fichier Excel n’a pas fonctionné
    if(language=="french")
        aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,"Un critère de recherche a déjà été enregistré sous ce nom. \r\nVeuillez vérifier le nom du critère dans les deux langues."); 
    else
       aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpMatches,"A search criterion has already been saved under this name.\r\nVerify the criterion name in both languages.");
  
     Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
     Get_WinAddSearchCriterion_BtnCancel().Click();
   
     Get_WinSearchCriteriaManager_BtnClose().Click();// suppression du critére 
     if(client == "US" || client == "CIBC"){
//      Get_Toolbar_BtnManageSearchCriteria().Click();
//      Get_WinSearchCriteriaManager_DgvCriteria().Find("Value",criterion,10).Click() 
//      Get_WinSearchCriteriaManager_BtnDelete().Click();
//      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
//      Get_WinSearchCriteriaManager_BtnClose().Click()
        Delete_FilterCriterion(criterion,vServerClients)
     } 
          
     Get_MainWindow().SetFocus();
     Close_Croesus_SysMenu();
   }
   catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
   }
   finally{
       Activate_Inactivate_Pref('COPERN',"PREF_EDIT_FIRM_FUNCTIONS","NO",vServerClients) 
       RestartServices(vServerClients);
     }
 }