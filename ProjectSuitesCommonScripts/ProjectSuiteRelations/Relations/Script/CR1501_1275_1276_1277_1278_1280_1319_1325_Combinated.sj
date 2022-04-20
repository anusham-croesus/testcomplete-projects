//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

/**
Ce script regroupe les 6 scripts:

         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1275
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1276
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1277
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1278
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1280
         https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1325
    
    regroupé par: A.A   
    Version de scriptage:	ref90-20-12
*/

function CR1501_1275_1276_1277_1278_1280_1319_1325_Combinated()
{
    try {
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1278");
    
            userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
            passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          
            userNameDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "username");
            passwordDALTOJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DALTOJ", "psw");
         
            var IACodeCROES1275        = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "IACodeCROES1275", language+client);
            //Variables pour note
            var noteText_CR1501        = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_NoteText", language+client);
            var relationshipName       = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_RelationshipName", language+client);
            var frequencyRelationship  = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_Frequency", language+client);
            var notePredefinedSentence = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_NotePredefinedSentence", language+client);
            //Variables pour phrase prédéfinie
            var newPredefinedSentence  = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_NewPredefinedSentence", language+client);
            var PredefinedSentenceName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_PredefinedSentenceName", language+client);
            var createdBy              = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "CR1501_CreatedBy", language+client);

                       
//            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_NOTE_DELETE", "YES",vServerRelations);
//            Activate_Inactivate_Pref(userNameDALTOJ, "PREF_EDIT_FIRM_FUNCTIONS", "NO", vServerRelations);

            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Connexion avec Copern et création de la relation");
            Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
            
            //Choisir le module relation
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
           
            CreateRelationship(relationshipName, IACodeCROES1275);
                        
            
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Valider l'ajout et la suppression d'une phrase prédéfinie script 1322");           
            //Ajouter une phrase Predéfinie avec click-droit
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();

            WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
            Get_WinCRUANote_BtnAddPredefinedSentences().Click();
            Get_WinAddNewSentence_TxtName().Click()
            Get_WinAddNewSentence_TxtName().set_Text(PredefinedSentenceName);
            Get_WinAddNewSentence_TxtSentence().Click()
            Get_WinAddNewSentence_TxtSentence().set_Text(newPredefinedSentence);
            Get_WinAddNewSentence_BtnSave().Click();
           
            //Valider que la phase est ajoutée           
            Log.Message("Valider que la phase est ajoutée");  
            var displaySenPredefCROES1322 = Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",PredefinedSentenceName, 10)//.WPFControlText
            if(displaySenPredefCROES1322.Exists){
                var textDisplaySenPredefCROES1322 = displaySenPredefCROES1322.WPFControlText;
                var index = displaySenPredefCROES1322.Record.index;
                var displayCreatedByCROES1322 = Get_WinCRUANote_TabGrid_DgvPredefinedSentences().WPFObject("RecordListControl", "", 1).Items.Item(index).DataItem.FullName.OleValue;
                CheckEquals(textDisplaySenPredefCROES1322, PredefinedSentenceName,"Le nom de la phrase prédéfinie ");
                CheckEquals(displayCreatedByCROES1322, createdBy, "Créée par est ")
            }
            else
                Log.Error("La phrase prédéfinie ajoutée précédemment n'existe pas parmi la liste des phrases prédéfinies")
                
            //Supprimer la phrase prédéfinie  
            Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",PredefinedSentenceName, 10).Click()
            Get_WinCRUANote_BtnDeletePredefinedSentences().Click() 
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
            
            //Valider qe la phrase est supprimée
            if(Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",PredefinedSentenceName, 10).Exists)
                Log.Error("La phrase prédéfinie ajoutée précédemment n'est pas supprimée")
            else
                Log.Checkpoint("La phrase prédéfinie ajoutée est bien supprimée");
                          
            Get_WinCRUANote_BtnCancel1().Click();
                        
            
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Ajouter une phrase prédéfinie script 1319 et 1325");           
            //Ajouter une phrase Predéfinie avec click-droit
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR();
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();

            WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        
            Get_WinCRUANote_BtnAddPredefinedSentences().Click();
            Get_WinAddNewSentence_TxtName().Click()
            Get_WinAddNewSentence_TxtName().set_Text(PredefinedSentenceName);
            Get_WinAddNewSentence_TxtSentence().Click()
            Get_WinAddNewSentence_TxtSentence().set_Text(newPredefinedSentence);
            Get_WinAddNewSentence_BtnSave().Click();
            Get_WinCRUANote_BtnCancel1().Click();
            
            //Ajouter une note
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 4: Ajouter une note");
            var textAjoutNote = AddNoteToRelationship(relationshipName , noteText_CR1501, notePredefinedSentence);
            
            //Modifier la date de création de la note pour la date d'hier
            var CurrentDate = aqDateTime.Today();
            var YesterdayDate = aqDateTime.AddDays(CurrentDate, -1);
            var FormatDateYesterday = aqConvert.DateTimeToFormatStr(YesterdayDate, "%b %d %Y %#I:%M %p")
            UpdateDateCreation_Note(noteText_CR1501, FormatDateYesterday, vServerRelations);

            //Cliquer sur le bouton 'Info'
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click(); 
            Get_RelationshipsBar_BtnInfo().Click()
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
           
            //Les points de vérification: on ne peut pas supprimer la note
            if(Get_WinInfo_Notes_TabGrid_BtnDelete().Exists && Get_WinInfo_Notes_TabGrid_BtnDelete().VisibleOnScreen ){
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, false);          
            }
            else{ 
                Log.Error("Le bouton supprimer est activé");
            }
            Get_WinDetailedInfo_BtnOK().Click();
         
            //Modifier la date de création de la note à aujourdhui
            var CurrentDate = aqDateTime.Today();
            //        var YesterdayDate = aqDateTime.AddDays(CurrentDate, -1);
            var FormatDateToday = aqConvert.DateTimeToFormatStr(CurrentDate, "%b %d %Y %#I:%M %p")
            UpdateDateCreation_Note(noteText_CR1501, FormatDateToday, vServerRelations);
        
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click(); 
            Get_RelationshipsBar_BtnInfo().Click()
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
            
            //Validation: on peut supprimer la note
            if(Get_WinInfo_Notes_TabGrid_BtnDelete().Exists && Get_WinInfo_Notes_TabGrid_BtnDelete().VisibleOnScreen ){
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, true);          
            }
            else{ 
                Log.Error("Le bouton supprimer est désactivé");
            }
            Get_WinDetailedInfo_BtnOK().Click();

            Close_Croesus_X();
        
            //Se connecter a  l'application avec DALTOJ
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 4: Connexion avec Daltoj et validation");
            
            Login(vServerRelations, userNameDALTOJ, passwordDALTOJ, language);
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);

            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click(); 
            Get_RelationshipsBar_BtnInfo().Click()
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10).Click();
          
            //Les points de vérification: la note existe et visible mais on ne peux pas la supprimer ou la modifier
            if(Get_WinInfo_Notes_TabGrid_BtnEdit().Exists && Get_WinInfo_Notes_TabGrid_BtnEdit().VisibleOnScreen ){
                Log.Error("Le bouton modifier est activé");
            }
            else{ 
                if(Get_WinInfo_Notes_TabGrid_BtnDisplay().Exists && Get_WinInfo_Notes_TabGrid_BtnDisplay().VisibleOnScreen ){
                    aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDisplay(), "Enabled", cmpEqual, true);
                    Log.Checkpoint("Le bouton consulter existe et visible sur l'écran") 
                }
            } 
            if(Get_WinInfo_Notes_TabGrid_BtnDelete().Exists && Get_WinInfo_Notes_TabGrid_BtnDelete().VisibleOnScreen ){
                aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_BtnDelete(), "Enabled", cmpEqual, false);
            }
            else{ 
                Log.Error("Le bouton supprimer est activé");
            }
            
            //Valider que la phrase prédéfinie ajoutée par Copern est visible et pas supprimable
            Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
            var objectSentence = Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value",PredefinedSentenceName, 10);
            if(objectSentence.Exists && objectSentence.VisibleOnScreen)
                Log.Checkpoint("La phase prédéfinie ajoutée par Copern est visible")
            else
                Log.error("La phase prédéfinie ajoutée par Copern n'existe pas ou pas visible")
            
            objectSentence.Click()
            aqObject.CheckProperty(Get_WinCRUANote_BtnDeletePredefinedSentences(), "Enabled", cmpEqual, false);

            Get_WinCRUANote_BtnCancel1().Click();
            Get_WinDetailedInfo_BtnOK().Click();
            
            //Supprimer la relation
            //var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", RelationshipName, 10);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
            Get_Toolbar_BtnDelete().Click();
            Delay(100);          
            Get_DlgConfirmation().WaitProperty("VisibleOnScreen",true,5000);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-47);
            
            //Fermer 
            Close_Croesus_X();
    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));   
    }
    finally {
            Terminate_CroesusProcess();  
    }   
}

function AddNoteToRelationship(relationshipName , noteText, predefinedSentence, rightClick){
        
        if(rightClick){
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).ClickR(); 
            Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
        }
        else{
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click(); 
            Get_RelationshipsBar_BtnInfo().Click()
            Get_WinDetailedInfo_TabInfo().Click();
            Get_WinInfo_Notes_TabGrid().Click();
            Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
        }
        Get_WinCRUANote_GrpNote_TxtNote().Click();
        Get_WinCRUANote_GrpNote_TxtNote().set_Text(noteText);
        Get_WinCRUANote_GrpNote_BtnDateTime().Click();
        Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", predefinedSentence, 10).Click();
        Get_WinCRUANote_GrpNote_BtnAddSentence().Click();      
        WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
        var textAjoutNote = Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
        Log.Message(textAjoutNote);
        Get_WinCRUANote_BtnSave().Click();
        
        if(!rightClick)
            Get_WinDetailedInfo_BtnOK().Click();
        return textAjoutNote
}