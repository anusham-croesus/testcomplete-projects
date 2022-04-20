//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*         
         //lien pour TestLink
        Log.Link("https://jira.croesus.com/browse/QAS-892");  
        Résumé:Valider qu'il n'y a pas de crash et que l'option 'Copier l'informaiton du client' fonctionne bien. 
             
        Analyste d'automatisation : Youlia Raisper
		    Module:Client
		    la version du scriptage: Lu-27
		 
		 
 */
function CROES_11243_Copy_Note() {
    try {
		
          //lien pour TestLink
          Log.Link("https://jira.croesus.com/browse/QAS-892");
         
          var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");          
          var externalClient11243 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "externalClient11243", language+client);
          var fictitiousClient11243= ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "fictitiousClient11243", language+client);
          var clientTextAddNot11243=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "clientTextAddNot11243", language+client);
          // Se connecter avec Darwic
          Log.Message("Se connecter avec Darwic"); 
          Login(vServerClients, user, psw, language);         
          Get_MainWindow().Maximize();
          Get_ModulesBar_BtnClients().Click()
          
          //créer un client fictif saisir le nom
          Log.Message("créer un client fictif saisir le nom");
          CreateFictitiousClient(fictitiousClient11243);
        
          //créer un client externe saisir le nom
          Log.Message("créer un client externe saisir le nom");
          CreateExternalClient(externalClient11243);
          
          //Faire un info client externe et cliquer sur 
          Log.Message("Faire un info client externe");
          SearchClientByName(externalClient11243);
          Get_ClientsBar_BtnInfo().Click();
          
          //Ajouter une note dans la section en bas 
          Log.Message("Ajouter une note dans la section en bas ");
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")  
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().Keys(clientTextAddNot11243);
          Get_WinCRUANote_BtnSave().Click();
           
          Log.Message("Valider l'existence d'une note ");
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", clientTextAddNot11243, 10),"Exists", cmpEqual, true)        
          Get_WinDetailedInfo_BtnOK().Click();
           
          //Sélectionner le client externe auquel une note à été ajouté et.Faire un right click. Choisir l'option :Copier les informations du client...
          Log.Message("Sélectionner le client externe auquel une note à été ajouté et.Faire un right click. Choisir l'option :Copier les informations du client..."); 
          SearchClientByName(externalClient11243);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", externalClient11243, 10).ClickR();
          Get_ClientsGrid_ContextualMenu_CopyClientInformation().Click();

          
          /*Dans la section de droite de la fenêtre  Faire une recherche par Nom du client fictif crée à l'étape 1
          Le client fictif s'affiche dans la section de droite et cliquer .Cocher Notes dans la section en bas */
          Log.Message("Dans la section de droite de la fenêtre  Faire une recherche par Nom du client fictif crée à l'étape 1.Le client fictif s'affiche dans la section de droite et cliquer .Cocher Notes dans la section en bas.") 
          Get_WinCopyClientInfo_TxtQuickSearch().SetText(fictitiousClient11243);
          Get_WinCopyClientInfo_TxtQuickSearch().Keys("[Tab]");
          Get_WinCopyClientInfo_ChkBoxNote().set_IsChecked(true);
          Get_WinCopyClientInfo_BtnOK().Click();

          //Fair un info client sur le client fictif et valider que la note du client externe est copiée.
          Log.Message("Fair un info client sur le client fictif et valider que la note du client externe est copiée.") 
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictitiousClient11243, 10).Click()
          Get_ClientsBar_BtnInfo().Click();
          Log.Message("Valider l'existence d'une note");
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", clientTextAddNot11243, 10),"Exists", cmpEqual, true)   
          Get_WinDetailedInfo_BtnOK().Click();
          
        
          
    } catch (e) {

          //S'il y a exception, en afficher le message
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          Login(vServerClients, user, psw, language);         
          Get_MainWindow().Maximize();
          Get_ModulesBar_BtnClients().Click();
       

    } finally {

         //Supprimer les clients 
         Log.Message("Supprimer les clients")
         Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();                 
         SearchClientByName(fictitiousClient11243);
         Log.message(Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictitiousClient11243, 10).Exists)
         if(Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictitiousClient11243, 10).Exists){
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictitiousClient11243, 10).Click();
            Get_Toolbar_BtnDelete().Click();
            if(Get_DlgConfirmation().Exists){
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);                    
            } 
            Delay(1000);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", fictitiousClient11243, 10),"Exists", cmpEqual, false) 
         }
        
         SearchClientByName(externalClient11243);         
         if(Get_RelationshipsClientsAccountsGrid().FindChild("Value", externalClient11243, 10).Exists){
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", externalClient11243, 10).Click();
            Get_Toolbar_BtnDelete().Click();
            if(Get_DlgConfirmation().Exists){
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);      
            } 
            Delay(1000);
            aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().FindChild("Value", externalClient11243, 10),"Exists", cmpEqual, false)
         }    
         //Fermer le processus Croesus
         Terminate_CroesusProcess();
    }
}


