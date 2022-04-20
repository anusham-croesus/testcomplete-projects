//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : :Valider les nouveaux champs dans info clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2074
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */
 
 function CR1352_2074_Cli_NewFields_InfoClient() //il faut finaliser le script 
 {    
// Script spécifique a BNC
      var rootClient="800075"
      var clientNo="800076"
      var roots= GetData(filePath_Clients,"CR1352",202,language) 
      var sameAddress= GetData(filePath_Clients,"CR1352",204,language)
    
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
        
      //sélectionner le client
      Search_Client(rootClient);
    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick();
    
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblBNForClient(), "IsVisible", cmpEqual,true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtBNForClient(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_LblProvincialBNForClient(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtProvincialBNForClient(), "IsVisible", cmpEqual, true);

      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblBalance(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtBalance(), "IsVisible",cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblTotalValue(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtTotalValue(), "IsVisible",cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_LblMarginOrExcessMargin(), "IsVisible", cmpEqual, true)  
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpAmounts_TxtMarginOrExcessMargin(), "IsVisible",cmpEqual, true);
    
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblSegmentation(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation(), "IsVisible", cmpEqual, true);    
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_LblCommunication(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbCommunication(), "IsVisible", cmpEqual, true);
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "IsVisible", cmpEqual, true);
   
      Get_WinDetailedInfo_BtnCancel().Click(); 
    
      //sélectionner le client
      Search_Client(rootClient);
    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",clientNo,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",clientNo,10).DblClick();
      aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient(), "Exists", cmpEqual, false);
    
    
      if(!Get_WinDetailedInfo_TabInfo().Exists){
        Log.Error("La section Montant est affichée")
      }
      else{
        Log.Message("La section Montant n'est pas affichée")
      }
    
      Get_WinDetailedInfo_BtnCancel().Click(); 
           
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
  
 }
 
