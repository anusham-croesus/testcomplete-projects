//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
       Se connecter avec COPERN.

        
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-777
   
         1- Choisir le module client:Le module client s'ouvre correctement    
         2-Sélectionner un client qui contient des notes.:Le client est bien sélectionné.
         3-Cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         4-Cliquer sur filtre et choisir le filtre 'date de modification:La liste des filtres s'ouvre
          correctement et la fenêtre 'Créer un filtre'  de 'Date de modification' est ouverte.
         5-Choisir 'est antérieure au' pour le champ 'Opérateur',saisir une valeur ensuite cliquer sur le bouton 'Appliquer':
         Les notes correspondant au filtre sont affichées.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:		ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_777_Cli_FilterSearchByDateModifiedAndOperatorIsIsEarlierThan()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-777");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
          

         //Les variables
         
       /*  var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var ClientTextAddNotTestCROES777=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES777", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
       
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au client 800300
       
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES777);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES777=Get_WinCRUANote_GrpNote_TxtNote().Text;
         Log.Message(textAjoutNoteCROES777)
         
         Get_WinCRUANote_BtnSave().Click();
         
         
          Search_Client(numberClient800300);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).DblClick();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES777), 10).Click();
          
         
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES777);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES777);
          
            
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
          
            
          //Les points de vérifications
          
            var textNotCROES777= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES777), 10)
            var x=textNotCROES777.Exists;
            Log.Message(x);
          if(textNotCROES777.Exists)
            {
             Log.Error("La note n'est pas supprimée")
            }
            else{
              Log.Checkpoint("La note est supprimée")
            }
             Get_WinDetailedInfo_BtnCancel().Click();*/
             Log.Warning("Je peux pas automatiser ce cas de test suite a l'anomalie: CROES-10858	")
            

          
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        //Delete_Note(ClientTextAddNotTestCROES777, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        //Delete_Note(ClientTextAddNotTestCROES777, vServerClients)
      
        
    }
}
