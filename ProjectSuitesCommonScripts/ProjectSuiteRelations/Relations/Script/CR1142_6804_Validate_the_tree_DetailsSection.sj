//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/*        
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6804");  
        Résumé: Validation de l'arborescence dans la section Détails pour les Relations Client / Relation client conjoint , modules: Relations et Clients
             
        Analyste d'automatisation : Youlia Raisper
		    Module: Relations		 
		 
 */
function CR1142_6804_Validate_the_tree_DetailsSection() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6804","Lien du Cas de test sur Testlink");
         
          var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var relationShipNo_6804 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "relationShipNo_6804", language+client);
          var detailsHolders= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "detailsHolders", language+client);
          var rootClients = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rootClients", language+client);           
          var rootRelationship =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rootRelationship", language+client);
          var rootAccount =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rootAccount", language+client);
          var clientBRODEURMARTIN =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientBRODEURMARTIN", language+client);
          var account800017 =ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "account800017", language+client);
          var accountFS=ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "account800017_0", language+client);  
          
           
          // Se connecter avec Keynej 
          Log.Message("Se connecter avec Keynej")
          Login(vServerRelations, userName, psw, language);         
          Get_MainWindow().Maximize();
        
          // Aller au Module Relations
          Log.Message("Aller au Module Relations")
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          
          //Sélectionner la Relation 0001C  Valider l'arborescence dans la section titulaire Détails.*/
          Log.Message("Aller au Module Relations")
          SearchRelationshipByNo(relationShipNo_6804);
          
          Log.Message("Dans la zone Holders il y a 2 items")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords, "Count", cmpEqual, 2);
          for (var i = 0; i < 2; i++){
              var clientName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientName_"+i, language+client);
              var clientId= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientId_"+i, language+client); 
              Log.Message("le client devrait être " + clientName+ " "+ clientId)          
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(i).DataItem, "ShortName", cmpEqual, clientName);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(i).DataItem, "LinkNumber", cmpEqual, clientId);
          }
                   
          Log.Message("Dans le premier item il y a 3 clients")
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords, "Count", cmpEqual, 3);
          for (var i = 0; i < 3; i++){
              var clientName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientName_0_"+i, language+client);
              var clientId= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientId_0_"+i, language+client);  
              Log.Message("le client devrait être " + clientName+ " "+ clientId)            
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(i).DataItem, "ClientNumber", cmpEqual, clientId);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(i).DataItem, "Name", cmpEqual, clientName);
          }
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(0).set_IsExpanded(false);
          
          Log.Message("Dans le deuxième item il y a 3 clients")
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(1).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords, "Count", cmpEqual, 3);
          for (var i = 0; i < 3; i++){
               var clientName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientName_1_"+i, language+client);
               var clientId= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "clientId_1_"+i, language+client);
               Log.Message("le client devrait être " + clientName+ " "+ clientId)              
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(i).DataItem, "ClientNumber", cmpEqual, clientId);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(i).DataItem, "Name", cmpEqual, clientName);
          }          
         Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",detailsHolders,10).DataContext.ChildRecords.Item(1).set_IsExpanded(false);
           
             
          //Sélectionner de nouveau la Relation 0001C Mailler vers le module Clients / Valider l'arborescence dans la section Détails du client 800017
          Log.Message("Sélectionner de nouveau la Relation 0001C Mailler vers le module Clients")
          SearchRelationshipByNo(relationShipNo_6804)
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Clients().OpenMenu();
          Get_MenuBar_Modules_Clients_DragSelection().Click();
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          Get_RelationshipsClientsAccountsPlugin().Find("Value",account800017,10).Click();
          
          //Les comptes et les clients de la Relation Client sont affichés correctement dans les zones de la section Détails
          Log.Message("dans la zone Comptes il y a 2 comptes")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootAccount,10).DataContext.ChildRecords, "Count", cmpEqual, 2);
          for (var i = 0; i < 2; i++){
               var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "account800017_"+i, language+client);
               Log.Message("le compt devrait être " + clientBRODEURMARTIN+ " "+ accountNo)              
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "DisplayAccountNumber", cmpEqual, accountNo);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "Name", cmpEqual, clientBRODEURMARTIN);
          }  
                   
          Log.Message("dans la zone Relations il y a 1 relation")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords, "Count", cmpEqual, 1);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          
          Log.Message("dans cette Relations dans la zone CLinets il y a 4 clients")
          aqObject.CheckProperty( Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords, "Count", cmpEqual, 4);
          
          Log.Message("Pour le client 800017 il y a 2 comptes")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).DataItem, "ClientNumber", cmpEqual, account800017);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).DataItem, "Name", cmpEqual, clientBRODEURMARTIN);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
         
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords, "Count", cmpEqual, 2);
           for (var i = 0; i < 2; i++){
               var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "account800017_"+i, language+client);
               Log.Message("le compt devrait être " + clientBRODEURMARTIN+ " "+ accountNo)              
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "DisplayAccountNumber", cmpEqual, accountNo);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "Name", cmpEqual, clientBRODEURMARTIN);
          } 
         
          //Sélectionner de nouveau la Relation 0001C Mailler vers le module COmptes / Valider l'arborescence dans la section Détails du compte 800017-FS
          Log.Message("Aller au Module Relations")
          Get_ModulesBar_BtnRelationships().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          SearchRelationshipByNo(relationShipNo_6804)
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Accounts().OpenMenu();
          Get_MenuBar_Modules_Accounts_DragSelection().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
 
          Get_RelationshipsClientsAccountsPlugin().Find("Value",accountFS,10).Click();
          //Les clients et les comptes de la Relation Client sont affichés correctement dans la section Détails
          Log.Message("Dans la zone Relation il y a une relation")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords, "Count", cmpEqual, 1);
          aqObject.CheckProperty( Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords.Item(0).DataItem, "LinkNumber", cmpEqual, relationShipNo_6804);
          aqObject.CheckProperty( Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords.Item(0).DataItem, "ShortName", cmpEqual, clientBRODEURMARTIN);
          
          Log.Message("Dans la zone Relation il y a une relation")
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          
          Log.Message("Pour cette relation dans la zone clients  il y a 4 clients")
          aqObject.CheckProperty( Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords, "Count", cmpEqual, 4);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).DataItem, "ClientNumber", cmpEqual, account800017);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).DataItem, "Name", cmpEqual, clientBRODEURMARTIN);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
         
          Log.Message("Pour le client 800017 il y a 2 comptes")
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords, "Count", cmpEqual, 2);
          for (var i = 0; i < 2; i++){
               var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "account800017_"+i, language+client);
               Log.Message("le compt devrait être " + clientBRODEURMARTIN+ " "+ accountNo)              
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "DisplayAccountNumber", cmpEqual, accountNo);
               aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",rootRelationship,10).Find("Description",rootClients,10).Find("Description",rootAccount,10).DataContext.ChildRecords.Item(i).DataItem, "Name", cmpEqual, clientBRODEURMARTIN);
          }          

    } catch (e) {

          //S'il y a exception, en afficher le message
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
  
    } finally {
           
          Terminate_CroesusProcess();
    }
}
