//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Identification du représentant de la famille dans la section détails
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2073

[Le script a été automatise partialement, les vérifications pour le 3-m étape n’ont pas été fates .La difficulté de récupère des données de la grille .Youlia]   
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ 
 
 function CR1352_2073_Cli_FamilyRepresentative_in_DetailSection()
 {    
//script spécifique a BNC
      var rootClient="800077";
            
      var address=GetData(filePath_Clients,"CR1352",204,language);
      var roots= GetData(filePath_Clients,"CR1352",202,language);   
      
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
      
       //sélectionner le client
      Search_Client(rootClient);
      
      if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataRecord.DataItem.ClientNumber==rootClient){     
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataContext.DataItem.Details, "IsFamilyContact", cmpEqual,false)
      }
      else{
          Log.Error("Le numéro du compte est erroné ")
      }
              
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",rootClient,10).Click();    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",rootClient,10).DblClick(); 
      aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains,rootClient);
      
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().set_IsChecked(true);
      Get_WinDetailedInfo_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(),"WindowMetricTag","CLIENT_NOTEBOOK");
      
       if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataRecord.DataItem.ClientNumber==rootClient){     
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataContext.DataItem.Details, "IsFamilyContact", cmpEqual,true)
      }
      else{
          Log.Error("Le numéro du compte est erroné")
      }
      
      //Remettre les données 
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",rootClient,10).Click();    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find("OriginalValue",rootClient,10).DblClick(); 
      aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains,rootClient);
      
      Get_WinDetailedInfo_TabInfo_GrpFollowUp_ChkFamilyRepresentativeForClient().set_IsChecked(false);
      Get_WinDetailedInfo_BtnOK().Click();
      WaitUntilObjectDisappears(Get_CroesusApp(),"WindowMetricTag","CLIENT_NOTEBOOK");
      
      if(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataRecord.DataItem.ClientNumber==rootClient){     
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",address,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).DataContext.DataItem.Details, "IsFamilyContact", cmpEqual,false)
      }
      else{
          Log.Error("Le numéro du compte est erroné")
      }
               
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();
   
 }


   