//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/*        
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6902");  
        Résumé: Valider que tous les clients/comptes doivent apparaître dans le module Client/Comptes lorsqu'on maille la relation groupée, ayant associées des différentes type des relations (des Relations Client  et des relations ordinaire) (voir Jira:PF-2930)
           
        Analyste d'automatisation : Youlia Raisper
        version du scriptage: ref90-15-2020-3-367
		    Module: Relations
			 
 */
function CR1142_6902_PF2930() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6902","Lien du Cas de test sur Testlink");
          Log.Message("Résumé: Valider que tous les clients/comptes doivent apparaître dans le module Client/Comptes lorsqu'on maille la relation groupée, ayant associées des différentes type des relations (des Relations Client  et des relations ordinaire) (voir Jira:PF-2930)");
          var logEtape1, logEtape2, logEtape3, logEtape4;
          
          var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var groupedRelationshipName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "groupedRelationshipName", language+client);
     
          var rel80004                = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rel80004", language+client);
          var rel80021                = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "rel80021", language+client);
          var client30001             = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "client30001", language+client);
          var Account300001NA         = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "Account300001NA", language+client);
          var Account300001RE         = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "Account300001RE", language+client);
          var DesRelationships        = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "DesRelationships", language+client);
          var DesClients              = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1142", "DesClients", language+client);
          
          
          // ********************************************************Étape 1*******************************************
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1:Créer une relation groupée (ex:Test_Rel_GR), puis associer les Relations Client (ex: 80004 et 80021)  ");
                      
          Log.Message("Se connecter avec Keynej ") 
          Login(vServerRelations, user, psw, language);         
          Get_MainWindow().Maximize();
                 
          Log.Message("Aller au Module Relations") 
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                    
          Log.Message("Créer une relation groupée (ex:Test_Rel_GR), puis associer les Relations Client (ex: 80004 et 80021)");  
          CreateGroupedRelationship(groupedRelationshipName, "BD88");
		  Log.Message ("Jira: PF-3737 Le champ 'Associer à une relation groupée' ne devrait pas être grisé");
          JoinToAGroupedRelationship(rel80004, groupedRelationshipName);
          JoinToAGroupedRelationship(rel80021, groupedRelationshipName);
          
          Log.Message("Get relationship nomber from BD")
          var relTEST_REL_GR_NO = Execute_SQLQuery_GetField("select NO_LINK from dbo.b_link where FULLNAME = 'TEST_REL_GR'", vServerRelations, "NO_LINK");
          Log.Message(relTEST_REL_GR_NO);
          
          Log.Message("Valider que les relations sont associées a la realtion groupée");
          Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10).Click();
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).Find("OriginalValue",rel80004,10), "Exists", cmpEqual,true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).Find("OriginalValue",rel80021,10), "Exists", cmpEqual,true);
           
          Log.Message("Valider que le client 300001 ne presente pas dans le details de realtion groupée ");
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description","Relationships",10).Find("Description","Clients",10).Find("OriginalValue",client30001,10), "Exists", cmpEqual,false);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(0).set_IsExpanded(false);
          
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(1).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).Find("Description",DesClients,10).Find("OriginalValue",client30001,10), "Exists", cmpEqual,false);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(1).set_IsExpanded(false);
          
          Log.Message("Mailler la relation 80004 vers le module client et valider que le client 30001 n'est pas la")
          SearchRelationshipByNo(groupedRelationshipName);
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10), Get_ModulesBar_BtnClients());
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains,relTEST_REL_GR_NO );
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",client30001,10), "Exists", cmpEqual,false);
         
          // ********************************************************Étape 2*******************************************
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Ajout de client et exécution de Loader ");
                 
          Log.Message("update b_client set no_links ='G0080004P0' where no_client ='300001'");
          Execute_SQLQuery("update b_client set no_links ='G0080004P0' where no_client ='300001'",vServerRelations);
         
          Log.Message("/*cd  /home/marinag/CR1142 le plugin:  cfLoader -ClientLink --cpmafile='CR1142_FULL_CPMA.txt' -FIRM=FIRM_1");
          ExecuteSSHCommandCFLoader("CR1142", vServerRelations, "cfLoader -ClientLink --cpmafile=\"CR1142_FULL_CPMA.txt\" -FIRM=FIRM_1", "marinag");
         
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByNo(groupedRelationshipName);
          Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10).Click();
         
          Log.Message("Dans Croesus -Deatils, valider que le client: 30001, dois être associé a la Relation Client: 80004");
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description","Relationships",10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description","Relationships",10).Find("Description","Clients",10).Find("OriginalValue",client30001,10), "Exists", cmpEqual,true);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description","Relationships",10).DataContext.ChildRecords.Item(0).set_IsExpanded(false);
         
          // ********************************************************Étape 3*******************************************
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Validations d'affichage du client");
          
          Log.Message("Selectionner la relation groupée (Test_Rel_GR) puis mailler vers le module Clients");
          SearchRelationshipByNo(groupedRelationshipName);
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10), Get_ModulesBar_BtnClients());
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains,relTEST_REL_GR_NO );
         
          Log.Message("Valider que le  client 30001 affiché dans la grille du module Clients") 
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",client30001,10), "Exists", cmpEqual,true);
         
          Log.Message("Selectionner la relation groupée (Test_Rel_GR) puis mailler vers le module Comptes");
          Get_ModulesBar_BtnRelationships().Click();
          SearchRelationshipByNo(groupedRelationshipName);
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10), Get_ModulesBar_BtnAccounts());
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains,relTEST_REL_GR_NO );
         
          Log.Message("Valider que le client 30001 affiché dans la grille du module Comptes");
          Scroll();       
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300001RE,10), "Exists", cmpEqual,true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",Account300001NA,10), "Exists", cmpEqual,true);

          Log.Message("Mailler la Relation 80004 vers le module Clients est valider que tous les clients doivent être affichés");
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SearchRelationshipByNo(groupedRelationshipName);
          Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).Find("OriginalValue",rel80004,10), Get_ModulesBar_BtnClients());
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains,rel80004 );
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).Find("OriginalValue",rel80004,10);
         
          Log.Message("Valider que le  client 30001 est affiché dans la grille du module Client") 
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",client30001,10), "Exists", cmpEqual,true);
         
          // ********************************************************Étape 4*******************************************
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Valider la suppression du client. JIRA PF-3120");
        
          Log.Message("Supprimer le Client 300001 de la Relation Client 80004")
          Execute_SQLQuery("update b_client set no_links = null, no_link = null where NO_CLIENT = '300001'",vServerRelations);
          Log.Message("/*cd  /home/marinag/CR1142 le plugin:  cfLoader -ClientLink --cpmafile='CR1142_FULL_CPMA.txt' -FIRM=FIRM_1");
          ExecuteSSHCommandCFLoader("CR1142", vServerRelations, "cfLoader -ClientLink --cpmafile=\"CR1142_FULL_CPMA.txt\" -FIRM=FIRM_1", "marinag");
                
          Log.Message("Valider que le client 300001 ne presente pas dans le details de la realtion groupée ");
          Get_ModulesBar_BtnRelationships().Click();
          Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
          SearchRelationshipByNo(groupedRelationshipName);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(0).set_IsExpanded(true);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description","Relationships",10).Find("Description","Clients",10).Find("OriginalValue",client30001,10), "Exists", cmpEqual,false);
          Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description",DesRelationships,10).DataContext.ChildRecords.Item(0).set_IsExpanded(false);
         
          Log.Message("Selectionner la relation groupée (Test_Rel_GR) puis mailler vers le module Clients");        
          Drag(Get_RelationshipsClientsAccountsPlugin().Find("Value",groupedRelationshipName,10), Get_ModulesBar_BtnClients());
          Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains,relTEST_REL_GR_NO );
         
          Log.Message("Valider que le  client 30001 n'est pas affiché dans la grille du module Client") 
          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().Find("Value",client30001,10), "Exists", cmpEqual,false);
                  

    } catch (e) {
       //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
 
    } finally {
         //Remettre les colonnes par défaut 
         // ********************************************************CLEAN-UP*******************************************
         Log.PopLogFolder();
         logEtape4 = Log.AppendFolder("CLEAN-UP");
         Log.Message("Se connecter avec Keynej ") 
         Login(vServerRelations, user, psw, language);         
         Get_MainWindow().Maximize();
         Get_ModulesBar_BtnRelationships().Click();
         Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
         DeleteRelationship(groupedRelationshipName)       
         //Fermer le processus Croesus
         Terminate_CroesusProcess();
    }
}

function Scroll(){
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_RelationshipsClientsAccountsGrid().get_ActualWidth()
    var ControlHeight=Get_RelationshipsClientsAccountsGrid().get_ActualHeight()
    for (i=1; i<=2; i++) { Get_RelationshipsClientsAccountsGrid().Click(ControlWidth-3, ControlHeight-40)}
}