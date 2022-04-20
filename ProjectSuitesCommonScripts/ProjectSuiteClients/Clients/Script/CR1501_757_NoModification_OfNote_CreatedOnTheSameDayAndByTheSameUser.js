//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :
        La preference PREF_EDIT_NOTE=NO.
        Se connecter avec 'COPERN'
        
        https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-757
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-Sélectionner un client.:Le client est bien sélectionné.
         3-Ajouter une note a ce client  avec l'option click-right.:La note est ajoutée.
         4-Cliquer sur le bouton 'Info':La fenêtre info du client sélectionné est ouverte.
         5-Sélectionner la note crée précédemment.:On peut pas modifier la note et le libellé de la bouton 'Modifier '
          a changé. Le libellé est devenue 'Consulter'.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-8--V9-Be_1-co6x
*/


function CR1501_757_NoModification_OfNote_CreatedOnTheSameDayAndByTheSameUser()
{
    try {
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-757");
         
         userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
         passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
         //Mettre la PREF_ADDRESS_GROUPING a la valeur 2
         Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","NO",vServerClients);
         RestartServices(vServerClients);
         //Les variables
         
         var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
         var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
         var ClientTextAddNotTestCROES757=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES757", language+client);
         
         Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
         //Choisir le module client
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         //Ajouter une note avec le click right
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
         Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
         //Ajouter une note au client 800300
       
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
         Get_WinCRUANote_GrpNote_TxtNote().Click()
         Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES757);
         
         Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
         Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
         WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
         var textAjoutNoteCROES757=Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
         Log.Message(textAjoutNoteCROES757)
         
         Get_WinCRUANote_BtnSave().Click();
         Get_ModulesBar_BtnClients().Click();
         Search_Client(numberClient800300);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click()
         Get_ClientsBar_BtnInfo().Click();
         //Les points de vérificationss
         Get_WinInfo_Notes_TabGrid().Click();
         //Vérifier qu'on peut pas modifier la note
         WaitObject(Get_WinDetailedInfo(),["UID", "IsSelected"], ["TabItem_fc72", true]);
         Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Value",textAjoutNoteCROES757,10).Click();
         
         //Les points de vérification
         if(Get_WinInfo_Notes_TabGrid_BtnEdit().Exists && Get_WinInfo_Notes_TabGrid_BtnEdit().VisibleOnScreen )
         {
           Log.Error("Le bouton modifier existe et visble sur l'écran");
         }
         else
         { 
            if(Get_WinInfo_Notes_TabGrid_BtnDisplay().Exists && Get_WinInfo_Notes_TabGrid_BtnDisplay().VisibleOnScreen )
            {
              aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
              Log.Checkpoint("Le bouton consulter existe et visible sur l'écran") 
            }
         }
          

          
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
        RestartServices(vServerClients);
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES757, vServerClients)
       
        
        
    }
    finally {
   
        Terminate_CroesusProcess();
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_NOTE","YES",vServerClients);
        RestartServices(vServerClients);
        Delete_Note(ClientTextAddNotTestCROES757, vServerClients)
      
        
    }
}