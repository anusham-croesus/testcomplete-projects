//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description : Modification permise dans info clients
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2075
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_2075_Cli_Edit_SegmentationInfoClient()
 {    
// script spécifique pour BNC
   
      var rootClient="800075"
      var roots= GetData(filePath_Clients,"CR1352",202,language)
    
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
        
      //sélectionner le client
      Search_Client(rootClient);             
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick();     

      var segmentationBefore=Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().Text
      
      //Modifier le champ segmentation
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().Click();
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().set_Text("A");   
      Get_WinDetailedInfo_BtnApply().Click();
      Get_WinDetailedInfo_BtnOK().Click();
      
      //sélectionner le client
      Search_Client(rootClient);             
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("OriginalValue",rootClient,10).DblClick();
            
      //Valider la modification
      var segmentationAfter=Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().Text

      
      aqObject.CompareProperty(segmentationBefore,cmpNotEqual,segmentationAfter)
      
      //Remettre les données 
      //Modifier le champ segmentation
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().Click();
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_CmbSegmentation().set_Text("");    
      Get_WinDetailedInfo_BtnApply().Click();
      Get_WinDetailedInfo_BtnOK().Click();
                
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();

 }
