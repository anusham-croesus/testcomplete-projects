//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Modification permise dans info clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2075
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_2075_Cli_Edit_SecondaryRootClient()
 {    
// Script spécifique pour BNC
   
      var rootClient="800075"
      var secondaryClient="800076"     
      var roots= GetData(filePath_Clients,"CR1352",202,language)   
    
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
      //sélectionner le client
      Search_Client(rootClient);                   
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",secondaryClient,10).Click();    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",secondaryClient,10).DblClick();  
      
      //Delay(2000);
      
      //Valider qu'on ne peut pas modifier la section suivi 
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentationForSecondaryRoot(), "IsEnabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbContactPersonForSecondaryRoot(), "IsEnabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbAccountManagerForSecondaryRoot(), "IsEnabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunicationForSecondaryRoot(), "IsEnabled", cmpEqual, false);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbReportVisualSupportForClientForSecondaryRoot(), "IsEnabled", cmpEqual, false);
  
      Get_WinDetailedInfo_BtnOK().Click();
      
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();

 }
 
