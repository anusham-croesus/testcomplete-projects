//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-790
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-  Sélectionner un client: Le client est bien sélectionné.
         3-Cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         4-Cliquer sur filtre et choisir le filtre 'Créée par':La liste des filtres s'ouvre correctement et la fenêtre 'Créer un filtre'  de 'Créée par' est ouverte.
         5-Choisir 'excluant' pour le champ 'Opérateur' ,choisir une valeur ensuite cliquer sur le bouton 'Appliquer':Les notes correspondant au filtre sont affichées.
   
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_790_Cli_SearchWithFilterCreatedByAndOperatorIsExcluding()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-790");
         
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         
         //Les variables
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var PortTextAddNotTestCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES790", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var userCreerFiltreCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "userCreerFiltreCROES790", language+client);
         var NameFiltrExpluaNicolaCopernic=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "NameFiltrExpluaNicolaCopernic", language+client);
         var textNoteCompletCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textNoteCompletCROES790", language+client);
      
         
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
          Get_ModulesBar_BtnClients().Click();
          //Sélectionner le client 800300
         
         Search_Client(numberClient800300)
         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          //Ajouter une note au client 800300
            Get_ClientsBar_BtnInfo().Click();
           
                    

           Get_WinInfo_Notes_TabGrid().Click();
         
           Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES790);
          
          var textAjoutNoteCROES790=Get_WinCRUANote_GrpNote_TxtNote().Text;
          Log.Message(textAjoutNoteCROES790)
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          Get_WinCRUANote_BtnSave().Click();
      
          Get_WinDetailedInfo_BtnCancel().Click()
          //Cliquer sur le bouton Info 
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          //Ajouter une note au client 800300
           Get_ClientsBar_BtnInfo().Click();
           Get_WinInfo_Notes_TabGrid().Click();
           
           Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
           Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
           Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_CreatedBy().Click();
           Get_WinCreateFilter_CmbOperator().Click();
           Get_WinCRUFilter_CmbOperator_ItemExcluding().Click();
           Get_WinCreateFilter_DgvValue().Keys("[End]")
           Get_WinCreateFilter_DgvValue().Keys("[End]")
           Get_WinCreateFilter_DgvValue().FindChild("Value", userCreerFiltreCROES790, 10).Click();
           Get_WinCreateFilter_BtnApply().Click();
       
           //Les points de vérification 
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, NameFiltrExpluaNicolaCopernic);
           aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
           var existenceNoteCreeParNicolasCopern= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", userCreerFiltreCROES790, 10).Exists;
           if(existenceNoteCreeParNicolasCopern == true)
             {
                Log.Error("Les note créées par Nicolas Copernic sont affichées affichées même si on a appliué le filtre")
             }
           else {
           Log.Checkpoint("Les note créées par Nicolas Copernic ne sont pas affichées affichées") 
            } 
         
        Get_WinDetailedInfo_BtnCancel().Click()
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        Terminate_CroesusProcess();
        Delete_Note(textNoteCompletCROES790, vServerClients)
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Delete_Note(textNoteCompletCROES790, vServerClients)
       
        
    }
}
