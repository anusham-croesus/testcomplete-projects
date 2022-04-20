//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/*
  Description : recherche avec les filtres
  
  Regrouper les scripts suivants:
  CR1501_790_Cli_SearchWithFilterCreatedByAndOperatorIsExcluding
  CR1501_777_Cli_FilterSearchByDateModifiedAndOperatorIsIsEarlierThan
  CR1501_779_Cli_FilterSearchByDateModifiedAndOperatorIsBetween
  CROES_11141_Cli_WhenAddingFilterByCreationDateTheCrashApplication
   
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation : Emna IHM  
  Version de scriptage:		ref90-19-2020-09-33
*/


function CR1501_Opti_777_779_790_JiraCroes11141()
{
   try {
          userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
          passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
          var numberClient800300=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "numberClient800300", language+client);
          var PortTextAddNotTestCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "PortTextAddNotTestCROES790", language+client);
          var textphrasePredefiniCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textphrasePredefiniCROES790", language+client);
          var userCreerFiltreCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "userCreerFiltreCROES790", language+client);
          var NameFiltrExpluaNicolaCopernic=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "NameFiltrExpluaNicolaCopernic", language+client);
          var textNoteCompletCROES790=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "textNoteCompletCROES790", language+client);
          
          var DisplayFilterDescription777=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "DisplayFilterDescriptionCROES777", language+client); //Date de modification // Modification Date 
          
          var DisplayFilterDescription779_1=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "DisplayFilterDescriptionCROES779_1", language+client); //Date de modification entre // Modification Date between
          var DisplayFilterDescription779_2=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1501", "DisplayFilterDescriptionCROES779_2", language+client);
          
          var descriptionFiltreCreatioDateCROES11141=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Anomalies", "descriptionFiltreCreatioDateCROES11141", language+client);
          
          
          Log.Message("se connercter avec Copern");
          Login(vServerClients, userNameCOPERN, passwordCOPERN, language);
          
          /********************************** Étape 1 : Préparation : Ajout d'une note au client 800300 **********************************/
          Log.AppendFolder("Étape 1: Préparation: Ajout d'une note au client 800300");
                    
          Log.Message("Choisir le module client et Sélectionner le client "+numberClient800300);
          Get_ModulesBar_BtnClients().Click();
          Search_Client(numberClient800300)         
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          
          Log.Message("Ajouter une note au client "+ numberClient800300);
          Get_ClientsBar_BtnInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Get_WinInfo_Notes_TabGrid_BtnAdd().Click();           
          Get_WinCRUANote_GrpNote_TxtNote().Click()
          Get_WinCRUANote_GrpNote_TxtNote().set_Text(PortTextAddNotTestCROES790);
          Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES790, 10).Click();
          Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
          WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74")
          
          Log.Message("Sauvegarder et fermer la fenetre info");
          Get_WinCRUANote_BtnSave().Click();      
          Get_WinDetailedInfo_BtnCancel().Click()
          
          Log.Message("Sélectionner le client "+numberClient800300+" et reouvrir la fenêtre info"); 
          Search_Client(numberClient800300)
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", numberClient800300, 10).Click();
          Get_ClientsBar_BtnInfo().Click();
          Get_WinInfo_Notes_TabGrid().Click();
          Log.Message("Valider l'ajout de la note"); 
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textNoteCompletCROES790);
          
          Log.PopLogFolder();
          
          /********************************** Étape 2: couverture de Croes-790 ***********************************/          
          Log.AppendFolder("Étape 2: couverture de Croes-790. La recherche avec le filtre par 'Créée par' et Opérateur est 'excluant'");
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-790","Cas de test TestLink : Croes-790") 
          
          Log.Message("Cliquer sur filtre et choisir le filtre par 'Créée par' et Opérateur est 'excluant'"); 
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
          Log.Message("Valider que les notes correspondant au filtre sont affichées.") 
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, NameFiltrExpluaNicolaCopernic);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
          var existenceNoteCreeParNicolasCopern= Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", userCreerFiltreCROES790, 10).Exists;
          if(existenceNoteCreeParNicolasCopern)
            Log.Error("Les notes crées par Nicolas Copernic sont affichées même si on a appliué le filtre.")
          else 
            Log.Checkpoint("Les notes crées par Nicolas Copernic ne sont pas affichées.") 
                      
          //Fermer le filtre
          Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).Click(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).get_ActualWidth() - 17, 13)  
          
          Log.PopLogFolder();
          
          /********************************** Étape 3: couverture de Croes-777 ***********************************/          
          Log.AppendFolder("Étape 3: couverture de Croes-777. La recherche avec le filtre par  'Date de modification et Opérateur est 'est antérieure au'");
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-777","Cas de test TestLink : Croes-777") 
          
          Log.Message("Cliquer sur filtre et choisir le filtre par 'Date de modification et Opérateur est 'est antérieure au'"); 
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_ModificationDate().Click();
          
          Get_WinCreateFilter_CmbOperator().Click();
          
          Get_WinCRUFilter_CmbOperator_ItemIsPriorTo().Click();
          if(language == "french")  var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%Y/%m/%d")
          if(language == "english") var ToDay=aqConvert.DateTimeToFormatStr(aqDateTime.Today(), "%m/%d/%Y")
          Get_WinCreateFilter_DtpValue().set_StringValue(ToDay);
          Get_WinCreateFilter_BtnApply().Click();
       
          //Les points de vérification
          Log.Message("Ajouter la coulonne date de modification si elle n'existe pas.") 
          if(!Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().Exists){
            Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().Click();
            Get_CroesusApp().WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click(); 
          } 
          Log.Message("Valider que les notes correspondant au filtre sont affichées.") 
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, DisplayFilterDescription777+" < "+ToDay);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
          
          var existenceNoteAfterToday = false;
          for(i=0; i<Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Count; i++){
            var DisplayDateMAJ =Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.DateMaj;
            if (aqDateTime.Compare(DisplayDateMAJ, aqDateTime.Today()) == 1 || aqDateTime.Compare(DisplayDateMAJ, aqDateTime.Today()) == 0){
              existenceNoteAfterToday = true;
              break;
            }            
          }
          if(existenceNoteAfterToday)
            Log.Error("Les notes crées après la date de "+ToDay+" sont affichées même si on a appliué le filtre.")
          else 
            Log.Checkpoint("Les notes crées après la date de "+ToDay+" ne sont pas affichées.")
          
          //Fermer le filtre
          Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).Click(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).get_ActualWidth() - 17, 13)  
          
          Log.PopLogFolder();
          
          /********************************** Étape 4: couverture de Croes-779 ***********************************/          
          Log.AppendFolder("Étape 4: couverture de Croes-779. La recherche avec le filtre par  'Date de modification et Opérateur est 'entre'");
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-779","Cas de test TestLink : Croes-779") 
          
          Log.Message("Cliquer sur filtre et choisir le filtre par 'Date de modification' et Opérateur est 'entre'"); 
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinInfo_Notes_TabGrid_DgvNotes_ContextMenu_ModificationDate().Click();
          
          Get_WinCreateFilter_CmbOperator().Click();
          Get_WinCRUFilter_CmbOperator_ItemBetween().Click();
          
          var PeriodEndDate = aqDateTime.Today(); 
          var PeriodStartDate = aqDateTime.AddDays(PeriodEndDate, -7); 
          if(language == "french")  var PeriodStartDateStr=aqConvert.DateTimeToFormatStr(PeriodStartDate, "%Y/%m/%d")
          if(language == "english") var PeriodStartDateStr=aqConvert.DateTimeToFormatStr(PeriodStartDate, "%m/%d/%Y")
          
          Get_WinCreateFilter_DtpValue().set_StringValue(PeriodStartDateStr);
          Get_WinCreateFilter_DtpAnd().set_StringValue(ToDay);
          Get_WinCreateFilter_BtnApply().Click();
       
          //Les points de vérification
          Log.Message("Valider que les notes correspondant au filtre sont affichées.") 
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, DisplayFilterDescription779_1 +" "+ PeriodStartDateStr +" "+DisplayFilterDescription779_2 +" "+ ToDay);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  
          
          var existenceNoteOutOfPeriod = false;
          for(i=0; i<Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Count; i++){
            var DisplayDateMAJ = Get_WinInfo_Notes_TabGrid_DgvNotes().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.DateMaj;
            if ((aqDateTime.Compare(DisplayDateMAJ, PeriodStartDate) == -1 || aqDateTime.Compare(DisplayDateMAJ, PeriodStartDate) == 0) || (aqDateTime.Compare(DisplayDateMAJ, PeriodEndDate) == 1 || aqDateTime.Compare(DisplayDateMAJ, PeriodEndDate) == 0)){
              existenceNoteOutOfPeriod = true;
              break;
            }            
          }          
          if(existenceNoteOutOfPeriod)
            Log.Error("Les notes qui ne sont pas entre "+PeriodStartDateStr+" et "+ToDay+" sont affichées même si on a appliué le filtre.")
          else 
            Log.Checkpoint("Les notes qui ne sont pas entre "+PeriodStartDateStr+" et "+ToDay+" ne sont pas affichées.")
   
           //Fermer le filtre
          Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).Click(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).get_ActualWidth() - 17, 13)  
          
          Log.PopLogFolder(); 
          
          /********************************** Étape 5: couverture de Jira Croes-11141 ***********************************/          
          Log.AppendFolder("Étape 5: couverture de Jira Croes-11141. Lorsqu'on ajoute un filte par date de creation l'application crash");
          //Afficher le lien de cas de test
          Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-11141","Cas de test TestLink : Croes-11141") 
          
          Log.Message("Cliquer sur filtre et choisir le filtre par 'Date de creation' et Opérateur est 'n'égale(e) pas'"); 
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinInfo_Notes_TabGrid_DgvNotes().Click(10,10)
          Get_WinPositionInfo_TabNotes_TabGrid_BtnQuickFilters_ContextMenu_CreationDate().Click();
          Get_WinCreateFilter_CmbOperator().Click()
          Get_WinCRUFilter_CmbOperator_ItemIsNotEqualTo().Click();
          Get_WinCreateFilter_DtpValue().set_StringValue(ToDay);
          Get_WinCreateFilter_BtnApply().Click();
          
          Log.Message("Vérifier si l'application crash");
          if(Get_DlgError().Exists)
            Log.Error("L'application Crash : Jira CROES-11141")
          else
            Log.Checkpoint("Aucun Crash n'a été detecté")
            
          //Les points de vérification 
          var displayFiltrecreation=aqString.Concat(descriptionFiltreCreatioDateCROES11141, ToDay)
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1).DataContext, "FilterDescription", cmpEqual, displayFiltrecreation);
          aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_DgvNotes_BtnFilter(1), "wState", cmpEqual, 1); // 0 - Le filtre n'est pas actif 1- Le filtre est actif  */
		      Log.Message("Vérifier que les notes dont la date de création est aujourd'hui ne sont pas affichées");
          var ExistenceResultatFiltreOnGrill=Get_WinInfo_Notes_TabGrid_DgvNotes().Find("Text",ToDay,10)
           if(ExistenceResultatFiltreOnGrill.Exists)
              Log.Error("les notes dont la date de création est "+ToDay+" sont affichées")
           else
              Log.Checkpoint("les notes dont la date de création est "+ToDay+" ne sont pas affichées") 
          
          Log.PopLogFolder();
          
          //--- Réinitialiser      
          Log.Message("Enlever la colonne Date de modification et fermer la fenetre info");
          Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().Click();
          Get_WinInfo_Notes_TabGrid_DgvNotes_ChModificationDate().ClickR();
          Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();      
          Get_WinDetailedInfo_BtnCancel().Click()
    }
    catch(e) 
    {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
          Delete_Note(textNoteCompletCROES790, vServerClients);
          //Fermer Croesus
          Log.Message("Fermer Croesus")
          Close_Croesus_X();
    		  //Fermer le processus Croesus
          Terminate_CroesusProcess();         
          Runner.Stop(true)
    }
    finally 
    {
        Delete_Note(textNoteCompletCROES790, vServerClients);
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
  		  //Fermer le processus Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)
    }
}