//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Relations
    Jira                 :  TCVE-1868
    Description          :  DValider la case à cocher "include underlying items" pour les Relations_Client
    Préconditions        : 
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.17.2020.7-61/ CIBC
    date                 :  29-07-2020 
  
    
*/

function TCVE_1868_ValidateTheIncludeUnderlyingItemsCheckboxForCustomerRelationships()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1858","Lien de la story dans Jira");
           Log.Link("https://jira.croesus.com/browse/TCVE-1868","Lien de cas de test dans Jira");
           
    
           //Declaration des Variables
           
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
           
           var relationship80028 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationship80028",language+client);
           var phoneCallType     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "phoneCallType",language+client);//"Phone Call"// "Appel tél."
           var RelTextAddNotTCVE1868_1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RelTextAddNotTCVE1868_1",language+client);//"Note TCVE1868_1"
           var client800219 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800219",language+client);//"800219"
           var client800281 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800281",language+client);
           var client800283 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800283",language+client);
           var client800284 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800284",language+client);
           var conversionType = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "conversionType",language+client);
           var account800219FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "account800219FS",language+client);
           var account800284NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "account800284NA",language+client);
           var RelTextAddNotTCVE1868_2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "RelTextAddNotTCVE1868_2",language+client);
           var document1 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "document1",language+client);
           var document2 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "document2",language+client);
           var appointmentType = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "appointmentType",language+client);
           var time = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "time",language+client);
           var descriptionTCVE1868 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "descriptionTCVE1868",language+client);
           var allDescriptionTCVE1868 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "allDescriptionTCVE1868",language+client);
           var relationship0001C = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "relationship0001C",language+client);
           var noteRelation0001C = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "noteRelation0001C",language+client);
           var client800027 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800027",language+client);
           var account800027NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "account800027NA",language+client);
           var client800024 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "client800024",language+client);
           var noteClient800024 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "noteClient800024",language+client);
           var account800024GT = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "account800024GT",language+client);
           var noteAccount800024GT = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "Anomalies", "noteAccount800024GT",language+client);
           
           
/************************************Étape 1************************************************************************/     
          //Se connecter à croesus avec Keynej
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ");
          Log.Message("Se connecter à croesus avec KEYNEJ")
          Login(vServerRelations, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
      
//************************************Étape 2************************************************************************/     
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Select Relation 'Client relationship' 80028 – Info – Agenda / Add note Phone Call /Save" );

           //Accéder au module Relations
           Log.Message("Acceder au module Relations");
           Get_ModulesBar_BtnRelationships().Click();
           
           //Sélectionner la Relation 'Client relationship' 80028
           Log.Message("Sélectionner la Relation 'Client relationship' 80028");
           SearchRelationshipByNo(relationship80028);
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship80028,10).Click();
           
           //Accéder à la fenêtre Info
           Log.Message("Accéder à la fenêtre Info/Agenda");
           Get_RelationshipsBar_BtnInfo().Click();
           Get_WinDetailedInfo_TabAgendaForClient().Click();
           
           //Ajouter un phone call dans onglet Agenda
           Log.Message("Ajouter un phone call");
           Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
           Get_WinAddEditAnEvent_CmbType().Click();
           Get_SubMenus().Find("WPFControlText", phoneCallType, 10).Click();
           Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
           
           //Ajouter un fichier dans onglet documents
           Log.Message("Ajouter un fichier dans onglet documents");
           Get_WinDetailedInfo_TabDocuments().Click();
           Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
           Delay(100);
           Get_WinAddAFile_GrpFile_BtnBrowse().Click();
           Delay(100);
           Get_DlgOpen_CmbFileName().Keys(folderPath_Data+document1);
           Get_DlgOpen_BtnOpen().Click();
           Delay(100);
           Get_WinAddAFile_BtnOK().Click();
           
           //Ajouter une note
           Log.Message("Ajouter une note dans Info/Note");
           Get_WinDetailedInfo_TabInfo().Click();
           AddNote(RelTextAddNotTCVE1868_1);
           
           
           
          
///************************************Étape 3 ************************************************************************/     
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3: Mailler la relation 80028 vers Client");
                      
           //Mailler la relation 80028 vers Client

           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship80028,10).Click();
           Get_MenuBar_Modules().OpenMenu();
           Get_MenuBar_Modules_Clients().OpenMenu();
           Get_MenuBar_Modules_Clients_DragSelection().Click();
           Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000);
           
           // Select 800219 – Info – Agenda – Add type= Conversion / Ok
           Log.Message("Select 800219 – Info – Agenda – Add type= Conversion ");
           Get_RelationshipsClientsAccountsGrid().Find("Value",client800219,10).DblClick();
           
           //Accéder à la fenêtre Info
           Log.Message("Accéder à la fenêtre Info/Agenda");
//           Get_RelationshipsBar_BtnInfo().Click();
           Get_WinDetailedInfo_TabAgendaForClient().Click();
           
           //Ajouter une conversation dans onglet Agenda
           Log.Message("Ajouter une conversation dans onglet Agenda");
           Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
           Get_WinAddEditAnEvent_CmbType().Click();
           Get_SubMenus().Find("WPFControlText", conversionType, 10).Click();
           Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           
           //Détails / Select account: 800291-FS / Add Notes / Save
           Log.Message("Détails / Select account: 800291-FS / Add Notes / Save");
           Get_RelationshipsClientsAccountsDetails().Find("Text",account800219FS,100).DblClick();
           AddNote(RelTextAddNotTCVE1868_1);
           
           
///************************************Étape 4 ************************************************************************/     
           Log.PopLogFolder();
           logEtape4 = Log.AppendFolder("Étape 4: Select client 800281 et 800283 – Info – Documents – Click add a file – choisir le document a a jouter – OK");
                      
           //Selectionner le client 800281 et ajouter une note
           Log.Message("Ajouter une note au client "+client800281);
           Get_RelationshipsClientsAccountsGrid().Find("Text",client800281,10).DblClick();
           Get_WinDetailedInfo_TabInfo().Click();
           AddNote(RelTextAddNotTCVE1868_2);
           
           //Selectionner le client 800283 et ajouter un document
           Log.Message("Ajouter un document au client "+client800283);
           AddDocumentToClient(client800283,folderPath_Data+document2);
           
///************************************Étape 5 ************************************************************************/     
           Log.PopLogFolder();
           logEtape5 = Log.AppendFolder("Étape 5: Select client 800284 – Info – Agenda Add type= Appointment , time=14:00, Account no = 800284-NA , Description = RDV Client – Ok");
                      
           //Selectionner le client 800284 et ajouter type= Appointment
           Log.Message("Ajouter dans Agenda  un type= Appointment au client "+client800284);
           Get_RelationshipsClientsAccountsGrid().Find("Text",client800284,10).DblClick(); 
           Get_WinDetailedInfo_TabAgendaForClient().Click();
           Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
           Get_WinAddEditAnEvent_CmbType().Click();
           Get_SubMenus().Find("WPFControlText", appointmentType, 10).Click();
           //Saisir la date et l'heure (ici on met la date de demain pour ne pas tomber sur une date passée si on exécute le script après 14h)
           TodayValue = aqDateTime.Today();
           if (language == "french")
              Tomorrow = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(TodayValue,1), "%Y/%m/%d");
           else 
              Tomorrow = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(TodayValue,1), "%m/%d/%Y");
           Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Click();
           Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Keys(Tomorrow);
           Get_WinAddEditAnEvent_CmbTime().Keys(time);
           //Associer le comptes 800284-NA
           Get_WinAddEditAnEvent_BtnAccountNo().Click();
           WaitObject(Get_CroesusApp(),"Text",account800284NA);
           Get_WinAccount().Find("Text",account800284NA,10).Click();
           Get_WinAccount_BtnOK().Click();
           //Saisir la description
           Get_WinAddEditAnEvent_TxtDescription().Keys(descriptionTCVE1868);
           //Clic OK         
           Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           
///************************************Étape 6 ************************************************************************/     
           Log.PopLogFolder();
           logEtape6 = Log.AppendFolder("Étape 6: Retourner dans Relations/ select client Relationship 80028 / Click Activities La case 'Inlude underlying items' est cochée");
                     
           Log.Message("Aller dans module Relations et selectionner la relation client");
           Get_ModulesBar_BtnRelationships().Click();
           
           //Sélectionner la Relation 'Client relationship' 80028
           Log.Message("Sélectionner la Relation 'Client relationship' 80028");
           SearchRelationshipByNo(relationship80028);
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship80028,10).Click();
           
           Log.Message("Cliquer sur le bouton 'Activités'");
           Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
           // Validations
           Log.Message("Valider l'affichage des activités créés dans les étapes précédentes");
           aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsChecked", cmpEqual, true);
           CheckActivityInGrid(allDescriptionTCVE1868);
           CheckActivityInGrid(document1);
           CheckActivityInGrid(document2);
           CheckActivityInGrid(RelTextAddNotTCVE1868_1);
           CheckActivityInGrid(RelTextAddNotTCVE1868_2);
           CheckActivityInGrid(phoneCallType);
           CheckActivityInGrid(conversionType);
          
///************************************Étape 7 ************************************************************************/     
           Log.PopLogFolder();
           logEtape7 = Log.AppendFolder("Étape 7: Décocher la case 'Inlude underlying items'");
           
           Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().Set_IsChecked(false);
           Log.Message("Valider que seules les activités de la relation sont affichées");
           aqObject.CheckProperty(Get_WinActivities().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items, "Count", cmpEqual, 2);
           CheckActivityInGrid(RelTextAddNotTCVE1868_1);
           CheckActivityInGrid(document1);
           Log.Message("Fermer la fenêtre Activités");
           Get_WinActivities_BtnClose().Click();
           
           
/************************************Étape 8 ************************************************************************/     
           Log.PopLogFolder();
           logEtape8 = Log.AppendFolder("Étape 8: Select Relation 0001C - INFO-Agenda – add type = appel téléphonique, heure :14 00 /Ok Add Notes / Client interested in security: / Save");
           Log.Message("Aller dans module Relations et selectionner la relation 0001C");
           Get_ModulesBar_BtnRelationships().Click();
           
           //Sélectionner la Relation  0001C
           Log.Message("Sélectionner la Relation 0001C");
           SearchRelationshipByNo(relationship0001C);
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship0001C,10).Click();  
           
           //Accéder à la fenêtre Info
           Log.Message("Accéder à la fenêtre Info/Agenda");
           Get_RelationshipsBar_BtnInfo().Click();
           Get_WinDetailedInfo_TabAgendaForClient().Click();
           
           //Ajouter un phone call dans onglet Agenda à 14h
           Log.Message("Ajouter un phone call");
           Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
           Get_WinAddEditAnEvent_CmbType().Click();
           Get_SubMenus().Find("WPFControlText", phoneCallType, 10).Click();
           //Saisir la date et l'heure (ici on met la date de demain pour ne pas tomber sur une date passée si on exécute le script après 14h)
           TodayValue = aqDateTime.Today();
           if (language == "french")
              Tomorrow = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(TodayValue,1), "%Y/%m/%d");
           else 
              Tomorrow = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(TodayValue,1), "%m/%d/%Y");
           Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Click();
           Get_WinAddEditAnEvent_GrpAddEditAnEvent_DtpDateForSchedule().Keys(Tomorrow);
           Get_WinAddEditAnEvent_CmbTime().Keys(time);
           
           Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
           
           //Ajouter une note
           Log.Message("Ajouter une note dans Info/Note");
           Get_WinDetailedInfo_TabInfo().Click();
           AddNote(noteRelation0001C);
           
/************************************Étape 9 ************************************************************************/     
           Log.PopLogFolder();
           logEtape9 = Log.AppendFolder("Étape 9: Select Relation 0001C - Dans la section Détails – Double click sur Client 800027 ");
           //Détails – Double click sur Client 800027 /Onglet Agenda Add type = Appointment , compte 800027-NA – Ok
           Log.Message("Détails – Double click sur Client 800027 /Onglet Agenda Add type = Appointment , compte 800027-NA – Ok");
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship0001C,10).Click();
           Delay(10000)
           Get_RelationshipsClientsAccountsDetails().Find("Text",client800027,100).Click();
           Get_RelationshipsClientsAccountsDetails().Find(["ClrClassName","Text"],["XamTextEditor",client800027],100).DblClick();
           Get_WinDetailedInfo_TabAgendaForClient().Click();
           Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnAdd().Click();
           Get_WinAddEditAnEvent_CmbType().Click();
           Get_SubMenus().Find("WPFControlText", appointmentType, 10).Click();
           //Associer le comptes 800027-NA
           Get_WinAddEditAnEvent_BtnAccountNo().Click();
           WaitObject(Get_CroesusApp(),"Text",account800027NA);
           Get_WinAccount().Find("Text",account800027NA,10).Click();
           Get_WinAccount_BtnOK().Click();
           //Clic OK         
           Get_WinAddEditAnEvent_BtnOKForSchedule().Click();
           Get_WinDetailedInfo_BtnOK().Click();
           
           //Double click dans détails Client =800024 – Info – Add note – No answer! – Ok
           Log.Message("Double click dans détails Client =800024 – Info – Add note – No answer! – Ok");
           Get_RelationshipsClientsAccountsDetails().Find("Text",client800024,100).DblClick();
           AddNote(noteClient800024);
           
           //Client 800024 / Compte 800024-GT /Add note – Left message on answering machine./OK
           Log.Message("Client 800024 / Compte 800024-GT /Add note – Left message on answering machine./OK");
           Get_RelationshipsClientsAccountsDetails().Click(40,100);
           Get_RelationshipsClientsAccountsDetails().Find("Text",account800024GT,100).Click();
           Get_RelationshipsClientsAccountsDetails().Find("Text",account800024GT,100).DblClick();
           AddNote(noteAccount800024GT);
           
           //Sélectionner la Relation 0001C
           Log.Message("Sélectionner la Relation 0001C");
           SearchRelationshipByNo(relationship0001C);
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship0001C,10).Click();
           
           Log.Message("Cliquer sur le bouton 'Activités'");
           Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
           // Validations
           Log.Message("Valider l'affichage des activités créés dans les étapes précédentes");
           aqObject.CheckProperty(Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems(), "IsChecked", cmpEqual, true);
           CheckActivityInGrid(phoneCallType);           
           CheckActivityInGrid(noteAccount800024GT);
           CheckActivityInGrid(noteClient800024);
           CheckActivityInGrid(noteRelation0001C);
           CheckActivityInGrid(appointmentType);
           Log.Message("Fermer la fenêtre Activités");
           Get_WinActivities_BtnClose().Click();
           
/************************************Étape 10 ************************************************************************/     
           Log.PopLogFolder();
           logEtape10 = Log.AppendFolder("Étape 10: Select les 2 relations client 0001C + 80028-- Activities'");
           
           //Sélectionner les deux relations 0001C + 80028
           Log.Message("Sélectionner les deux relations 0001C + 80028");
           Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
           SearchRelationshipByNo(relationship0001C)
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship0001C,10).Click(-1, -1, skCtrl);
           Get_RelationshipsClientsAccountsGrid().Find("Text",relationship80028,10).Click(-1, -1, skCtrl);
           Log.Message("Cliquer sur le bouton 'Activités'");
           Get_RelationshipsClientsAccountsBar_BtnActivities().Click();
           
           //Valider que si la case "underlying items" n'est pas cochée les activités de toutes les relations sont affichées 
           Log.Message("Valider que si la case 'underlying items' n'est pas cochée les activités de toutes les relations sont affichées");
           Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().Set_IsChecked(false);
           aqObject.CheckProperty(Get_WinActivities().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items, "Count", cmpEqual, 3);
           CheckActivityInGrid(noteRelation0001C);
           CheckActivityInGrid(document1);
           CheckActivityInGrid(RelTextAddNotTCVE1868_1);
           
/************************************Étape 11 ************************************************************************/     
           Log.PopLogFolder();
           logEtape11 = Log.AppendFolder("Étape 11: Valider que si la case 'underlying items' est cochée les activités de toutes les relations sont affichées :");
           Get_WinActivities_GrpActivities_GrpCurrentContext_ChkIncludeUnderlyingItems().Set_IsChecked(true); 
           //Validations
           Log.Message("Valider les activités affichées");
           CheckActivityInGrid(allDescriptionTCVE1868);
           CheckActivityInGrid(document1);
           CheckActivityInGrid(document2);
           CheckActivityInGrid(RelTextAddNotTCVE1868_1);
           CheckActivityInGrid(RelTextAddNotTCVE1868_2);
           CheckActivityInGrid(phoneCallType);
           CheckActivityInGrid(conversionType);
           CheckActivityInGrid(phoneCallType);           
           CheckActivityInGrid(noteAccount800024GT);
           CheckActivityInGrid(noteClient800024);
           CheckActivityInGrid(noteRelation0001C);
           CheckActivityInGrid(appointmentType);
           Log.Message("Fermer la fenêtre Activités");
           Get_WinActivities_BtnClose().Click();
           
           
           
           
           
          
          


    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
      
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: ------------- C L E A N U P -----------------------------");
//      supprimer les événements créés
        Log.Message("------------- C L E A N U P -----------------------------");
        Log.Message(" supprimer les événements créés"); 
        // Accéder au module Relations
        Log.Message("Aller au module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        SearchRelationshipByNo(relationship80028);
        Get_RelationshipsClientsAccountsGrid().Find("Text",relationship80028,10).Click();
           
        //Accéder à la fenêtre Info
        Log.Message("Accéder à la fenêtre Info");
        Get_RelationshipsBar_BtnInfo().Click();
        if (Get_WinDetailedInfo().Find("Text",RelTextAddNotTCVE1868_1,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",RelTextAddNotTCVE1868_1,10).Click();
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        
        Get_WinDetailedInfo_TabAgendaForClient().Click();
        if (Get_WinDetailedInfo().Find("Text",conversionType,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",conversionType,10).Click();
          Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().click();
          Get_DlgConfirmation_BtnYes().click();  
        }
        if(Get_WinDetailedInfo().Find("Text",phoneCallType,10).Exists) 
        {
          Get_WinDetailedInfo().Find("Text",phoneCallType,10).Click();
          Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().click();
          Get_DlgConfirmation_BtnYes().click();
        }   
        
        Get_WinDetailedInfo_TabDocuments().Click();
        if (Get_PersonalDocuments_Toolbar_BtnRemove().Enabled)
        {
          Get_PersonalDocuments_Toolbar_BtnRemove().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
        //Supprimer les événements de la relation 0001C
        Log.Message("Supprimer les événements de la relation 0001C");
        SearchRelationshipByNo(relationship0001C);
        Get_RelationshipsClientsAccountsGrid().Find("Text",relationship0001C,10).Click();
           
        //Accéder à la fenêtre Info
        Log.Message("Accéder à la fenêtre Info");
        Get_RelationshipsBar_BtnInfo().Click();
        
        if (Get_WinDetailedInfo().Find("Text",noteRelation0001C,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",noteRelation0001C,10).Click();
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_TabAgendaForClient().Click();
        if(Get_WinDetailedInfo().Find("Text",phoneCallType,10).Exists) 
        {
          Get_WinDetailedInfo().Find("Text",phoneCallType,10).Click();
          Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().click();
          Get_DlgConfirmation_BtnYes().click();
        }   
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
        //Supprimer les événements des clients
        Log.Message("Supprimer les événements des clients");
        
        deleteClientNote(client800219,RelTextAddNotTCVE1868_1);
        deleteClientNote(client800281,RelTextAddNotTCVE1868_2);
        
        Search_Client(client800283);
        Get_RelationshipsClientsAccountsGrid().Find("Text",client800283,10).DblClick();
        Get_WinDetailedInfo_TabDocuments().Click();
        if (Get_PersonalDocuments_Toolbar_BtnRemove().Enabled)
        {
          Get_PersonalDocuments_Toolbar_BtnRemove().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
        deleteClientActivity(client800284,appointmentType);
        deleteClientNote(client800024,noteClient800024);
        deleteClientNote(client800027,noteClient800024);
        deleteClientActivity(client800027,appointmentType);
        
        //Aller au module comptes
        Log.Message("Aller au module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Search_Account(account800024GT);
        Get_RelationshipsClientsAccountsGrid().Find("Text",account800024GT,10).DblClick();
        if (Get_WinDetailedInfo().Find("Text",noteAccount800024GT,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",noteAccount800024GT,10).Click();
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
        
        
        
//        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }
 
 function deleteClientNote(clientNumber,activity){
        Log.Message("Aller au module Clients");
        Get_ModulesBar_BtnClients().Click();
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().Find("Text",clientNumber,10).DblClick();
        if (Get_WinDetailedInfo().Find("Text",activity,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",activity,10).Click();
          Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
 }
 
 function deleteClientActivity(clientNumber,activity){
        Log.Message("Aller au module Clients");
        Get_ModulesBar_BtnClients().Click();
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().Find("Text",clientNumber,10).DblClick();
        Get_WinDetailedInfo_TabAgendaForClient().Click();
        if (Get_WinDetailedInfo().Find("Text",activity,10).Exists)
        {
          Get_WinDetailedInfo().Find("Text",activity,10).Click();
          Get_WinDetailedInfo_TabAgendaForClient_GrpInformation_BtnDelete().Click();
          Get_DlgConfirmation_BtnYes().click();
        }
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniButton", "1"]);
 }
 
 
 function Get_WinAddEditAnEvent_CmbType(){
   return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["UniComboBroker","1"],10);
 }
 
 function Get_WinAddEditAnEvent_CmbTime(){
   return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["UniComboBroker","4"],10);
 }
 
 function Get_WinAddEditAnEvent_BtnAccountNo(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["Button","4"],10);}
 function Get_WinAddEditAnEvent_TxtDescription(){return Get_WinAddEditAnEvent().FindChild(["ClrClassName","WPFControlOrdinalNo"],["TextBox","1"],10);}
 
 function Get_WinAccount(){
      if (language == "french") return Get_CroesusApp().FindChild(["ClrClassName","WndCaption"],["HwndSource","Comptes"],10)
      else return Get_CroesusApp().FindChild(["ClrClassName","WndCaption"],["HwndSource","Accounts"],10)}
      
 function Get_WinAccount_BtnOK(){return Get_WinAccount().FindChild(["ClrClassName","WPFControlText"],["UniButton","OK"],10)}
 
 function AddNote(note){
   //Ajouter une note
   Get_WinInfo_Notes_TabGrid().Click();
   Get_WinInfo_Notes_TabGrid_BtnAdd().Click();
   Get_WinCRUANote().WaitProperty("Enabled", true, 30000);    
   Get_WinCRUANote_GrpNote_BtnDateTime().WaitProperty("Enabled", true, 30000);
   Get_WinCRUANote_GrpNote_TxtNote().Click()
   Get_WinCRUANote_GrpNote_TxtNote().set_Text(note);
//   Get_WinCRUANote_BtnSave().WaitProperty("Enabled", true, 30000);
   Get_WinCRUANote_BtnSave().Click();
   Get_WinCRUANote_BtnSave().Click();
   Get_WinDetailedInfo_BtnOK().Click();
 }
 
 
 function CheckActivityInGrid(activity){
     var grid = Get_WinActivities().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10);
     var count = grid.Items.Count;
     var found = false;
     for (i=0;i<count;i++){
        if (grid.Items.Item(i).DataItem.Description == activity){
              Log.Checkpoint("l'activité "+activity+" existe dans la grille");
              found = true;
        }
     }
     if (!found)
        Log.Error("l'activité "+activity+" n'existe pas dans la grille");
 }
  
   function test(){
     Get_WinAddEditAnEvent_CmbType().Click();
   }