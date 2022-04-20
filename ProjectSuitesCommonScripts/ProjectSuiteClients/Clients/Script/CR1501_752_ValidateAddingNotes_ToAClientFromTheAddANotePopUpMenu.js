//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**

        Préconditions :Se connecter avec COPERN.

        
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-752
   
         1- Choisir le module client: Le module client s'ouvre correctement.      
         2-Sélectionner un client:Le client est bien sélectionné.
         3-Faire un click-right et choisir l'option 'Ajouter une note':L'option 'Ajouter une note' 
         est présente et la fenêtre d'ajout d'une note est affichée.
         4-Saisir une note et sauvegarder.:La note est ajoutée au client.
         
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-08-Dy-2--V9-Be_1-co6x
*/


function CR1501_752_ValidateAddingNotes_ToAClientFromTheAddANotePopUpMenu()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-752", "CR1501_752_ValidateAddingNotes_ToAClientFromTheAddANotePopUpMenu");
         
        userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");

        //Les variables
        var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
        var ClientTextAddNotTestCROES752=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "ClientTextAddNotTestCROES752", language+client);
        var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
        var createdByNoteCROES752=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "createdByNoteCROES752", language+client);
         
        Login(vServerClients, userNameCOPERN, passwordCOPERN, language);//debut
        //Choisir le module client
        Get_ModulesBar_BtnClients().Click();
        Search_Client(numberClient800300);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).ClickR();
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
        //Ajouter une note au client 800300
        var timeDisplayFormat = "%Y/%m/%d %#I:%M";
        var dateCreationCROES752 = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), timeDisplayFormat);
        Log.message(dateCreationCROES752);
        WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        Get_WinCRUANote_GrpNote_BtnDateTime().Click(); 
      
        Get_WinCRUANote_GrpNote_TxtNote().Click();
        Get_WinCRUANote_GrpNote_TxtNote().Keys(ClientTextAddNotTestCROES752);
         
        Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
        Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
        WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        var textAjoutNoteCROES752=Get_WinCRUANote_GrpNote_TxtNote().Text;
        Log.Message(textAjoutNoteCROES752);
         
        Get_WinCRUANote_BtnSave().Click();
        
        Search_Client(numberClient800300);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).DblClick();
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES752), 10).Click();
        
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNoteCROES752);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, ClientTextAddNotTestCROES752);
        var textNotCROES752= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNoteCROES752), 10);
        var x=textNotCROES752.Exists;
        Log.Message(x);
        if (textNotCROES752.Exists){
            var indexCROES752=textNotCROES752.Record.index;
            Log.Message(indexCROES752);
            
            var displayEffectiveDateCROES752=Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES752).DataItem.EffectiveDate;
            var displayCreationDateCROES752=aqConvert.DateTimeToFormatStr(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES752).DataItem.DateCreat, "%Y/%m/%d %#I:%M");
            var displayCreatedByCROES752=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES752).DataItem.FullName.OleValue);
            var displayNoteCROES752=VarToString(Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(indexCROES752).DataItem.Comment.OleValue);
              
            CheckEquals(displayEffectiveDateCROES752,null,"Date de référence est");

             var timeToleranceInMinutes = 3;
             Log.Message("Vérifier la Date de création est '" + dateCreationCROES752 + "' (avec une tolérance de " + timeToleranceInMinutes + " minutes).");
             var arrayOfExpected_dateCreationCROES752 = [dateCreationCROES752];
             for (var nbOfMinutes = 1; nbOfMinutes <= timeToleranceInMinutes; nbOfMinutes++)
                arrayOfExpected_dateCreationCROES752.push(aqConvert.DateTimeToFormatStr(aqDateTime.AddMinutes(StrToDateTime(dateCreationCROES752), nbOfMinutes), timeDisplayFormat));
             CheckEqualsToOneArrayItem(displayCreationDateCROES752, arrayOfExpected_dateCreationCROES752, "Date de création");
            
            CheckEquals(displayCreatedByCROES752,createdByNoteCROES752," Créée par est ");
            CheckEquals(displayNoteCROES752,textAjoutNoteCROES752,"La note est ");//La note est
            Log.Checkpoint("La note est copiée pour le client racine");
        }
        else {
            Log.Error("La note n'est pas copié pour le client racine");
        }
        
        Get_WinDetailedInfo_BtnCancel().Click();
    }   
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES752, vServerClients);
    }
    finally {
        Terminate_CroesusProcess();
        Delete_Note(ClientTextAddNotTestCROES752, vServerClients);
    }
}
