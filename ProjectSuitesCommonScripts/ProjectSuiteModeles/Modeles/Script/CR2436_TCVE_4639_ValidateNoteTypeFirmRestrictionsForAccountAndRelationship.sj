//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT CR2436_Common_Functions
//USEUNIT PDFUtils


/**
    Description : CR-2436: Valider les restrictions firme type note pour compte et relation 
        
    https://jira.croesus.com/browse/TCVE-4639
    Analyste d'assurance qualité : Karima Mo
    Analyste d'automatisation : Abdel M
    
    Version de scriptage:	90.24,2021.04-54
    Date: 28-04-2021
*/

function CR2436_TCVE_4639_ValidateNoteTypeFirmRestrictionsForAccountAndRelationship()
{
    try {
            //Afficher le lien du cas de test
            Log.Link(" https://jira.croesus.com/browse/TCVE-4639","Cas de test JIRA : TCVE-4639");
            Log.Link(" https://jira.croesus.com/browse/TCVE-4810","Story JIRA : TCVE-4810");
                               
                   
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var relationNameTCVE4639 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationNameTCVE4639", language+client);
            var IACodeBD88 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "IACodeBD88", language+client);
             
            var account800238RE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "account800238RE", language+client);
            var account800238FS = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "account800238FS", language+client);

            var modeleNameTCVE4639 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "modeleNameTCVE4639", language+client);
            var modelTypeTCVE4639 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "modelTypeTCVE4617", language+client);
            var IACodeBD66 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "IACodeBD66", language+client);
            
            var relationshipCriteriaName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationshipCriteriaName", language+client);
            var relationshipCriteriaModule = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationshipCriteriaModule", language+client);
            var accountCriteriaName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accountCriteriaName", language+client);
            var accountCriteriaModule = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accountCriteriaModule", language+client);
            
            var relationshipRestrictionName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationshipRestrictionName", language+client);
            var relationshipRestrictionNote = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationshipRestrictionNote", language+client);
            var severityNoBloc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityNoBloc", language+client); 
            var accountRestrictionName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accountRestrictionName", language+client); 
            var accountRestrictionNote = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "accountRestrictionNote", language+client); 
            var severityBloc = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityBloc", language+client);
            var severitySoft = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severitySoft", language+client);
            var severityHard = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "severityHard", language+client);
            var restrictionTypeFirm = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "restrictionTypeFirm", language+client);
            var relationshipNumberTCVE4639 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "relationshipNumberTCVE4639", language+client);
            
            var reportName = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "reportName", language+client);
            var reportFileNameRelationship = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "reportFileNameRelationship", language+client);
            var reportFileNameAccount = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "reportFileNameAccount", language+client);
            var PDFFilePathRelationship = REPORTS_FILES_FOLDER_PATH + reportFileNameRelationship+".pdf"
            var PDFFilePathAccount = REPORTS_FILES_FOLDER_PATH + reportFileNameAccount+".pdf"
            var NoDataTodisplay = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR2436", "NoDataTodisplay", language+client);
            
            
            // Activer la pref
            Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_CRITERIA_RESTRICTIONS_ACCESS", "YES", vServerModeles);
            Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerModeles);
            
            //Redemarrer les service
            RestartServices(vServerModeles);
            
//******************** Étape1 *******************************************************
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec Keynej ");
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize(); 
            
//******************** Étape2 *******************************************************
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 2: Creation de relation et modele ");

            //Accéder au module Relation 
            Log.Message("Accéder au module Relation");         
            Get_ModulesBar_BtnRelationships().Click();
            Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
                       
            //Créer la relation 
            Log.Message("Créer la relation "+relationNameTCVE4639); 
            CreateRelationship(relationNameTCVE4639, IACodeBD88); 
            
            Log.Message("Associer les comptes " + account800238RE + " et "  + account800238FS + " à la relation " + relationNameTCVE4639);
            JoinAccountToRelationship(account800238RE, relationNameTCVE4639);
            JoinAccountToRelationship(account800238FS, relationNameTCVE4639);
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
          
            //Créer le modèle  
            Log.Message("Créer le modèle "+ modeleNameTCVE4639); 
            Create_Model(modeleNameTCVE4639,modelTypeTCVE4639, IACodeBD66);
            
            Log.Message(" Associer la relation "+relationNameTCVE4639+" au modèle "+modeleNameTCVE4639);
            AssociateRelationshipWithModel(modeleNameTCVE4639, relationNameTCVE4639);
             
//******************** Étape3 *******************************************************
            Log.PopLogFolder();
            logEtape3 = Log.AppendFolder("Étape 3: Ajouter un critère de recherche");
            
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();
            WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
            Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
            Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_efa9");

            Log.Message("Ajouter un critère relation");
            Get_WinSearchCriteriaManager_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5");
            
            Get_WinAddSearchCriterion_TxtName().Clear();
            Get_WinAddSearchCriterion_TxtName().Keys(relationshipCriteriaName);
            Get_WinAddSearchCriterion_CmbModule().Click();
            Get_SubMenus().Find("WPFControlText",relationshipCriteriaModule, 10).Click();
            
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemIACode().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(IACodeBD88);
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
            Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5");

            Log.Message("Ajouter un critère compte ");
            Get_WinSearchCriteriaManager_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5");
            
            Get_WinAddSearchCriterion_TxtName().Clear();
            Get_WinAddSearchCriterion_TxtName().Keys(accountCriteriaName);
            Get_WinAddSearchCriterion_CmbModule().Click();
            Get_SubMenus().Find("WPFControlText",accountCriteriaModule, 10).Click();
            
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemCurrency().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemCAD().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
            Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5");
            
            //Fermer la fenêtre Gestionnaire de critère de recherche
            Log.Message("Fermer la fenêtre Gestionnaire de critère de recherche");
            Get_WinSearchCriteriaManager_BtnClose().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_efa9");  
            
//******************** Étape4 *******************************************************
            Log.PopLogFolder();
            logEtape4 = Log.AppendFolder("Étape 4: Ajouter des restrictions firme type note");
            
            //Sélectionner Restrictions, Gérer les restrictions
            Log.Message("Sélectionner Restrictions, Gérer les restrictions");
            Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_8ed1");
            
            Log.Message("Ajouter une restriction pour Relation");
            Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");

            Get_WinCRURestriction_TxtName().Keys(relationshipRestrictionName);
            AddNoteRestriction(relationshipRestrictionNote, severityNoBloc);
            
            Log.Message("Ajouter une restriction pour Compte");
            Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");

            Get_WinCRURestriction_TxtName().Keys(accountRestrictionName);
            AddNoteRestriction(accountRestrictionNote, severityBloc);
            
            //Fermer la fenêtre Gestionnaire de restrictions
            Log.Message("Fermer la fenêtre Gestionnaire de restrictions");
            Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();
    
//******************** Étape5 *******************************************************
            Log.PopLogFolder();
            logEtape5 = Log.AppendFolder("Étape 5: Assigner la restriction de firme au critère");
            
            //Sélectionner Restrictions, Assigner les restrictions aux critères
            Log.Message("Sélectionner Restrictions, Assigner les restrictions aux critères");
            Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_ab9c");
            
            Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd().Click();
            Log.Message("Dans la partie Restrictions, cliquer sur Ajouter, sélectionner la 'Restriction Relations Code CP = BD88'");
            Get_WinAssignRestrictions_GrpRestrictions_BtnAdd().Click();
            Get_WinRestrictionsManagerForConfigurations().Find("Text", relationshipRestrictionName, 10).Click();
            Get_WinRestrictionsManagerForConfigurations_BtnOK().Click();
            
            Log.Message("Dans la partie Critère de recherche, cliquer sur Ajouter, sélectionner le 'Critère Relations Code CP = BD88'");
            Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd().Click();
            Get_WinSearchCriteriaManager().Find("Text", relationshipCriteriaName, 10).Click();
            Get_WinSearchCriteriaManager_BtnOK().Click();
            
            Get_WinAssignRestrictions_BtnOK().Click();
            
            Get_WinAssignedRestrictionsManager_BarPadHeader_BtnAdd().Click();
            Log.Message("Dans la partie Restriction, ajouter la 'Restriction compte CAD'");
            Get_WinAssignRestrictions_GrpRestrictions_BtnAdd().Click();
            Get_WinRestrictionsManagerForConfigurations().Find("Text", accountRestrictionName, 10).Click();
            Get_WinRestrictionsManagerForConfigurations_BtnOK().Click();
            
            Log.Message("Dans la partie Critère de recherche, cliquer sur Ajouter, sélectionner le 'Critère Comptes CAD'");
            Get_WinAssignRestrictions_GrpSearchCriteria_BtnAdd().Click();
            Get_WinSearchCriteriaManager().Find("Text", accountCriteriaName, 10).Click();
            Get_WinSearchCriteriaManager_BtnOK().Click();
            
            Get_WinAssignRestrictions_BtnOK().Click();

              //Validations
              Log.Message("Valider les informations des restrictions de firme type note dans la fenêtre Gestionnaire des restrictions assignées");
              var grid = Get_WinAssignedRestrictionsManager().WPFObject("_managerCtrl").WPFObject("ItemList").WPFObject("RecordListControl", "", 1)
              var count = grid.Items.Count;
              for (i=0;i<count;i++){
                  if (grid.Items.Item(i).DataItem.RestrictionName == relationshipRestrictionName){
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"RestrictionDescription",cmpEqual,relationshipRestrictionNote);
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"CriteriaDescription",cmpEqual,relationshipCriteriaName);
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Severity",cmpEqual,severitySoft);
                  }
                  if (grid.Items.Item(i).DataItem.RestrictionName == accountRestrictionName){
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"RestrictionDescription",cmpEqual,accountRestrictionNote);
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"CriteriaDescription",cmpEqual,accountCriteriaName);
                      aqObject.CheckProperty(grid.Items.Item(i).DataItem ,"Severity",cmpEqual,severityHard);
                  }
              }
            
            Get_WinAssignedRestrictionsManager_BtnClose().Click();
            Get_WinConfigurations().Close();
            
//******************** Étape6 *******************************************************
            Log.PopLogFolder();
            logEtape6 = Log.AppendFolder("Étape 6: Valider les restrictions firme type note dans le module Modèle");
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modeleNameTCVE4639);
            Get_ModelsGrid().Find("Value",modeleNameTCVE4639,10).Click();
            
            Log.Message("Dans onglet Portefeuilles associés, sélectionner la relation MIB-test1_R puis cliquer sur le bouton Restriction");
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationNameTCVE4639,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            
            //Valider les informations de la note pour la relation dans la fenêtre Gestionnaire de restrictions
            Log.Message("Valider les informations de la note pour la relation dans la fenêtre Gestionnaire de restrictions");
            var gridRelationshipRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridRelationshipRestiction, restrictionTypeFirm, severitySoft, relationshipRestrictionNote);
            Get_WinRestrictionsManager_BtnClose().Click();
            
            //Sélectionner le compte 800238-RE puis cliquer sur Restriction
            Log.Message("Sélectionner le compte 800238-RE puis cliquer sur Restriction");
            Get_Models_Details_DgvDetails().WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account800238RE,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionManagerWindow_325f");
            
            //Valider les informations de la note pour le compte dans la fenêtre Gestionnaire de restrictions
            Log.Message("Valider les informations de la note pour le compte dans la fenêtre Gestionnaire de restrictions");
            var gridAccountRestiction = Get_WinRestrictionsManager().WPFObject("_currentControl").WPFObject("_restrictionGrid").WPFObject("RecordListControl", "", 1); 
            ValidateRestrictionInformation(gridAccountRestiction, restrictionTypeFirm, severityHard, accountRestrictionNote);
            Get_WinRestrictionsManager_BtnClose().Click();         
            

//******************** Étape7 *******************************************************
            Log.PopLogFolder();
            logEtape7 = Log.AppendFolder("Étape 7: Valider les informations de la restriction firme type note à l'étape 4 du rééquilibrage");
            
            RebalancingModelToStepFour(modeleNameTCVE4639);
            
            //valider les informations des 2 notes type firme dans l'onglet Ordres proposés
            Log.Message("valider les informations des 2 notes type firme dans l'onglet Ordres proposés");
            CheckMessagesRestrictionsRebalancing(account800238RE, accountRestrictionNote, severityHard);
            CheckMessagesRestrictionsRebalancing(relationshipNumberTCVE4639, relationshipRestrictionNote, severitySoft);
            //Fermer le reéquilibrage
            Log.Message("Fermer le reéquilibrage");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();
            
            
//******************** Étape8 *******************************************************
            Log.PopLogFolder();
            logEtape8 = Log.AppendFolder("Étape 8: Modifier la restriction firme type note de la relation");
            
            Log.Message("Aller dans Outils/Configurations");
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();
            WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
                        
            Log.Message("Sélectionner Restrictions, Gérer les restrictions");
            Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click(); 
            Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_8ed1");
            
            Log.Message("Sélectionner la restriction avec le nom 'Restriction Relations Code CP = BD88' puis cliquer sur modifier");
            Get_WinRestrictionsManagerForConfigurations().Find("Text", relationshipRestrictionName, 10).Click();
            
            Get_WinRestrictionsManagerForConfigurations_BarPadHeader_BtnEdit().Click();
            WaitObject(Get_CroesusApp(), "Uid", "RestrictionWindow_1351");
            Get_WinCRURestriction_CmbSeverity().Click();
            Get_SubMenus().FindChild("Text",severityBloc,10).Click();
            Get_WinCRURestriction_BtnOK().Click();
            
            //Fermer la fenêtre Gestionnaire de restrictions
            Log.Message("Fermer la fenêtre Gestionnaire de restrictions");
            Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();          
            Get_WinConfigurations().Close();
            
//******************** Étape9 *******************************************************
            Log.PopLogFolder();
            logEtape9 = Log.AppendFolder("Étape 9: Vérifier les informations de la restriction modifée à l'étape 4 du rééquilibrage");
            
            RebalancingModelToStepFour(modeleNameTCVE4639);
            
            //valider les informations de la note pour relation après modification
            Log.Message("valider les informations de la note pour relation après modification");
            CheckMessagesRestrictionsRebalancing(relationshipNumberTCVE4639, relationshipRestrictionNote, severityHard);
            //Fermer le reéquilibrage
            Log.Message("Fermer le reéquilibrage");
            Get_WinRebalance_BtnClose().Click();
            Get_DlgConfirmation_BtnYes().Click();            

//******************************** Étape10 *************************************************************************88***************
            Log.PopLogFolder();
            logEtape10 = Log.AppendFolder("Étape 10: Rapport Restrictions");
            Log.Message("Aller dans le module Relations, sélectionner la relation MIB-test1_R");
            Get_ModulesBar_BtnRelationships().Click();
            SearchRelationshipByName(relationNameTCVE4639);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationNameTCVE4639, 10).Click();
            Log.Message("cliquer sur Rapports et graphiques");
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            Log.Message("Ajouter le rapport Restrictions parmi les rapports courants et générer le rapport");
            SelectReports(reportName);
            //Validate and save report
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameRelationship, REPORTS_FILES_BACKUP_FOLDER_PATH);
            
            //Extraire le texte du fichier PDF et le sauvegarder dans un fichier texte
            Log.Message("Extraire le texte du fichier PDF et le sauvegarder dans un fichier texte")
            var relationshipPathTextFile = GetPdfTextThroughCommandLine(PDFFilePathRelationship, 1, 1);           
            var sTempFolder = Sys.OSInfo.TempDirectory;
            var currentFile = aqFileSystem.FindFiles(sTempFolder,reportFileNameRelationship+"*.txt");
            while (currentFile.HasNext())
              {
               var aFile = currentFile.Next();
               Log.Message(aFile.Name);
              }
            var currentFileName = aFile.Name;
            Log.Message("Le dernier fichier téléchargé est: "+currentFileName); 
            var relationshipTextFile = sTempFolder+"\\"+currentFileName;
            Log.Message(relationshipTextFile)
            ReadFileLines(relationshipTextFile,relationshipRestrictionNote);  
            
            //Mailler la relation vers comptes, sélectionner le compte 800238-RE puis générer le rapports Restrictions
            Log.Message("Mailler la relation vers comptes, sélectionner le compte 800238-RE puis générer le rapports Restrictions");
            Log.Message("Mailler la relation vers comptes");
            Get_MenuBar_Modules().Click();
            Get_MenuBar_Modules_Accounts().Click();
            Get_MenuBar_Modules_Accounts_DragSelection().Click();
            Log.Message("Sélectionner le compte 800238-RE puis générer le rapports Restrictions");
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800238RE, 10).Click();
            Log.Message("cliquer sur Rapports et graphiques");
            Get_Toolbar_BtnReportsAndGraphs().Click();
            WaitReportsWindow();
            Log.Message("Ajouter le rapport Restrictions parmi les rapports courants et générer le rapport");
            SelectReports(reportName);
            //Validate and save report
            ValidateAndSaveReportAsPDF(REPORTS_FILES_FOLDER_PATH + reportFileNameAccount, REPORTS_FILES_BACKUP_FOLDER_PATH);
            
            //Extraire le texte du fichier PDF et le sauvegarder dans un fichier texte
            Log.Message("Extraire le texte du fichier PDF et le sauvegarder dans un fichier texte")
            var accountPathTextFile = GetPdfTextThroughCommandLine(PDFFilePathAccount, 1, 1);           
            var sTempFolder = Sys.OSInfo.TempDirectory;
            var currentFile = aqFileSystem.FindFiles(sTempFolder,reportFileNameAccount+"*.txt");
            while (currentFile.HasNext())
              {
               var aFile = currentFile.Next();
               Log.Message(aFile.Name);
              }
            var currentFileName = aFile.Name;
            Log.Message("Le dernier fichier téléchargé est: "+currentFileName); 
            var accountTextFile = sTempFolder+"\\"+currentFileName;
            Log.Message(accountTextFile)
            ReadFileLines(accountTextFile,accountRestrictionNote); 
        

//************** Étape11 *******************************************************
            Log.PopLogFolder();
            logEtape11 = Log.AppendFolder("Étape 11: Sur PuTTY, rouler le plugin cfLoader -DashboardRegenerator -firm=FIRM_1");
            ExecuteSSHCommandCFLoader("CR2436", vServerModeles, "cfLoader -DashboardRegenerator -firm=FIRM_1", "abdelm");
            
            
//************** Étape12 *******************************************************
            Log.PopLogFolder();
            logEtape12 = Log.AppendFolder("Étape 12: Valider que la restriction firme type note ne s'affiche pas dans le dashboard");
            
            Log.Message("Aller au module Dashboard");
            Get_ModulesBar_BtnDashboard().Click();
            Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 30000);
            Log.Message("Ajouter le dashboard Restrictions déclenchées");
            Clear_Dashboard();
            Add_TriggeredRestrictionsBoard();
            
            //Valider que les 2 restrictions firme type note pour la relation MIB-test1_R et le compte 800238-RE ne sont pas affichées
            Log.Message("Valider que les 2 restrictions firme type note pour la relation MIB-test1_R et le compte 800238-RE ne sont pas affichées")
            
            var grid = Get_DashboardPlugin().Dashboard.WPFObject("ScrollableContainer", "", 1).WPFObject("ScrollViewer").WPFObject("RestrictionsBoard", "", 1).WPFObject("_dashboardGrid").WPFObject("RecordListControl", "", 1);
            var count = grid.Items.Count;
            for (i=0; i<count; i++){
                if (grid.Items.Item(i).DataItem.RestrictionDomainDescription != relationshipRestrictionName || grid.Items.Item(i).DataItem.RestrictionDomainDescription != accountRestrictionName)
                    Log.Checkpoint("Les restriction ne sont pas affichées");
            }
    }
    catch(e) {
		        //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
		         
    }
    finally {
            Log.PopLogFolder();
            logEtape13 = Log.AppendFolder("Étape 13: C L E A N U P et déconnexion");
            Log.Message("C L E A N U P");
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000); 
            SearchModelByName(modeleNameTCVE4639);
        
            RemoveRelationshipClientAccountFromModel(modeleNameTCVE4639,relationNameTCVE4639);
            DeleteModelByName(modeleNameTCVE4639);
            DeleteRelationship(relationNameTCVE4639);
            
            //Supprimer les restrictions et les critères
            Log.Message("Supprimer les restrictions et les critères");
            Log.Message("Supprimer les restrictions assignées");
            Get_MenuBar_Tools().Click();
            Get_MenuBar_Tools_Configurations().Click();
            WaitObject(Get_CroesusApp(),"Uid","TreeView_f006");
            Get_WinConfigurations_TvwTreeview_LlbRestrictions().Click();
            Get_WinConfigurations_LvwListView_LlbAssignRestrictionsToCriteria().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_ab9c");
            DeleteAssignedRestrictions(relationshipRestrictionName);
            DeleteAssignedRestrictions(accountRestrictionName);
            Get_WinAssignedRestrictionsManager_BtnClose().Click();
            
            //Supprimer les restrictions 
            Log.Message("Supprimer les restrictions ");
            Get_WinConfigurations_LvwListView_LlbManageRestrictions().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_8ed1");
            DeleteRestrictionsForConfiguration(relationshipRestrictionName);
            DeleteRestrictionsForConfiguration(accountRestrictionName);
            Get_WinRestrictionsManagerForConfigurations_BtnClose().Click();
            
            //Supprimer les critères
            Log.Message("Supprimer les critères ");
            Get_WinConfigurations_LvwListView_LlbManageCriteria().DblClick();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_efa9");
            DeleteCreteriaForConfiguration(relationshipCriteriaName);
            DeleteCreteriaForConfiguration(accountCriteriaName);
            Get_WinSearchCriteriaManager_BtnClose().Click()
            Get_WinConfigurations().Close();
            
  		      //Fermer le processus Croesus
            Terminate_CroesusProcess();         
        
    }
}



