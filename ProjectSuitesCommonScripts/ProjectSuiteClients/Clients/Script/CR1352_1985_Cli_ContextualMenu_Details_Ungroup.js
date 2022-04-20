//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions

/* Description :Fonction dissocier du menu contextuel dans Détail (client réel)
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1985
 
Analyste d'assurance qualité: Karima Mehiguene
Analyste d'automatisation: Youlia Raisper */ //il faut finaliser le script 
 
 function CR1352_1985_Cli_ContextualMenu_Details_Ungroup()
 {             
// script spécifique pour BNC
      var rootClient="800272"
      var secondaryClient1="800273"    
      var secondaryClient2="800274"  
      var secondaryClient2_1="800273-DQ" 
    
      var roots= GetData(filePath_Clients,"CR1352",202,language)  
      var accounts= GetData(filePath_Clients,"CR1352",206,language) 
    
      Login(vServerClients,userName, psw, language);
      Get_ModulesBar_BtnClients().Click();
      
      Get_MainWindow().Maximize();
    
      //chercher un client 
      Search_Client(rootClient);
    
      //Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("ClrClassName","RecordListControl",10).Items.Count
      var count= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Uid","DataGrid_abbc",10).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).Items.Count
      
      if(count == 3){
        Log.Checkpoint("Il a y trois comptes dans le bloc Racines.")
      }
      else{
        Log.Error("On devrait avoir trois clients dans le bloc Racines")
      }

      //Vérification pour le client  secondaryClient1
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",secondaryClient1,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",secondaryClient1,10).ClickR();
    
      //Vérifier que la fonction Dissocier est grisée
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(),"IsEnabled",cmpEqual,false);    
    
      //Vérification pour le client  secondaryClient2
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",secondaryClient2,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",roots,10).Find("OriginalValue",secondaryClient2,10).ClickR();
    
      //Vérifier que la fonction Dissocier est grisée
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(),"IsEnabled",cmpEqual,false);
    
    
      var width= Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualWidth();
      var height=Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).get_ActualHeight();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).Click((width+5)-width, (height/2));
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).set_IsExpanded(true);
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find(["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","2"],10).WaitProperty("IsExpanded", true, 1000)
    
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",accounts,10).Find("OriginalValue",secondaryClient2_1,10).Click();
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",roots,10).Find("Description",accounts,10).Find("OriginalValue",secondaryClient2_1,10).ClickR();
      //Vérifier que la fonction Dissocier est grisée
      aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_ContextualMenu_Ungroup(),"IsEnabled",cmpEqual,false);
        
      Get_MainWindow().SetFocus();
      Close_Croesus_MenuBar();    
 }
 

