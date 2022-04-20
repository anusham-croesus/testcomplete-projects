//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT SmokeTest_Common


/**
    Jira Xray                 : https://jira.croesus.com/browse/TCVE-6451
    Description               : Flaguer les portefeuilles hors tolérence dans les modules clients et relations selon la logique CIBC
                                " Je veux automatiser le nouveau development RQS dans la mainline 90.27
                                  pour que ces nouveaux développements soient ouverts pas nos suites de tests automatisés RQS de CIBC
    Version de scriptage      : ref90-27-66 CIBC
    Date:                     : 02 septembre 2021

    Analyste d'automatisation : Abdel.m
    Analyste QA               : Karima.Mo
**/

function TCVE_6451_FlagOutOfTolerancePortfoliosInClientAndRelationshipModulesAccordingToCIBCLogic()
{
    var logEtape1, logEtape2,logEtape3,logEtape4, logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-6451","Lien du cas de test dans Jira");
        Log.Link("https://jira.croesus.com/browse/TCVE-7172","Lien de la story dans Jira");
        
        var userNameKEYNEJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var cfLoaderPlugin_generateRQSPortfolio = "cfLoader -DashboardRegenerator \"GenerateAccountPortfolio=False GenerateRQSPortfolio=CLIENT,LINK\" -firm=FIRM_1"
        var SSHUser   = "aminea";
        var SSHFolder = "CR1958.2.6644";
        var ManagementLevelLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "ManagementLevelLabel", language + client);
        var OffsideLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "OffsideLabel", language + client);
        var nbrRelations = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "nbrRelations", language + client);
        var nbrClientsOffside = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "nbrClientsOffside", language + client);
        var nbrClientsIndividual = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "nbrClientsIndividual", language + client);
        var client800036 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "client800036", language + client);
        var clientProfile = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "clientProfile", language + client);
        var individual = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "individual", language + client);
        var relationship0002A = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "relationship0002A", language + client);
        var client800003 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "client800003", language + client);
        var client800006 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "client800006", language + client);
        var BigCharSize = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "BigCharSize", language + client);
        var SmallCharSize = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "SmallCharSize", language + client);
        var RQSManagementLevelLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "TCVE", "RQSManagementLevelLabel", language + client);
        

        //******************************************* Étape 1***************************************************
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Loader la bd dans la description: CIBC_RQS_90.26-63_2021-06-29_REF"+
                                    "( Laisser la config FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS = valeur de la firme X=10, Y=20, V=10, Z=5, W=95).");
        Log.Message("On va voir après si cette BD s'applique aussi à RQS ou je dois la préparer au début de script");
        
                                    
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Rouler le plugin: cfLoader -DashboardRegenerator \"GenerateAccountPortfolio=False GenerateRQSPortfolio=CLIENT,LINK\" -firm=FIRM_1.");
        
        //Executer la commande cfLoader:  cfLoader  -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
        Log.Message("Execution de la commande cfLoader");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, SSHUser);
        
        //******************************************* Étape 3***************************************************

        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Se connecter avec Keynej.");
        
        Log.Message("Se connecter à croesus");
        Login(vServerRQS, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("Aller dans le module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Ajouter les colonnes  Niveau de gestion et Hors tolérence ");
        Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(), OffsideLabel);
        Add_ColumnByLabel(Get_RelationshipsGrid_ChTotalValue(), ManagementLevelLabel);
        
        Log.Message("Appliquer le filtre rapide 'Hors tolérence=Oui'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_Offside().Click();
        Get_WinCreateFilter_FieldYes().DblClick();
        
        Log.Message("Appliquer le filtre rapide 'Niveau de gestion=Profil client'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManagementLevel().Click();
        Get_WinCreateFilter_FieldClientProfile().DblClick();
        
        Log.Message("Valider le nombre de relations retournées");
        var gridRel = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridRel.Items.Count;
        if (count == nbrRelations) 
            Log.Checkpoint("Le nombre de relations affichées est comme attendu "+nbrRelations);
        else  
            Log.Error("Le nombre de relations affichées est différent de l'attendu "+nbrRelations);
            
        Log.Message("Valider la colonne Hors tolérance ");
        for (i=0; i<count; i++){
           if (gridRel.Items.Item(i).DataItem.IsOffsideForRCM == true)
              Log.Checkpoint("La ligne "+i+" de la colonne Hors tolérance est cochée");
           else
              Log.Error("La ligne "+i+" de la colonne Hors tolérance n'est pas cochée");  
        }
        
        //******************************************* Étape 4***************************************************

        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Valider la colonne offside dans le module Clients.");
        
        Log.Message("Aller dans le module Clients");
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Ajouter les colonnes  Niveau de gestion et Hors tolérence ");
        Add_ColumnByLabel(Get_ClientsGrid_ChIACode(), OffsideLabel);
        Add_ColumnByLabel(Get_ClientsGrid_ChIACode(), ManagementLevelLabel);
        
        Log.Message("Appliquer le filtre rapide 'Hors tolérence=Oui'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_Offside().Click();
        Get_WinCreateFilter_FieldYes().DblClick();
        
        Log.Message("Valider le nombre de Clients retournées");
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        var find = false;
        if (count == nbrClientsOffside) 
            Log.Checkpoint("Le nombre de clients affichés est comme attendu "+nbrClientsOffside);
        else
            Log.Error("Le nombre de clients affichés est différent de l'attendu "+nbrClientsOffside);
            
        Log.Message("Valider la colonne Hors tolérance");
        for (i=0; i<count; i++){
           if (gridCli.Items.Item(i).DataItem.IsOffsideForRCM == true)
              Log.Checkpoint("La ligne "+i+" de la colonne Hors tolérance est cochée");
           else
              Log.Error("La ligne "+i+" de la colonne Hors tolérance n'est pas cochée");
           if (gridRel.Items.Item(i).DataItem.ClientNumber == client800036)
              find = true; 
        }
        Log.Message("Valider que le client "+client800036+" existe dans la liste")
        if (find)
              Log.Checkpoint("Le client "+client800036+" existe dans la liste");
           else   
              Log.error("Le client "+client800036+" n'existe pas dans la liste");
        
        
        //******************************************* Étape 5***************************************************

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Appliquer le 2èm filtre rapide 'Niveau de gestion=Individuel' et Valider le nombre de clients affichés.");
        
        Log.Message("Appliquer le filtre rapide 'Niveau de gestion=Individuel'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManagementLevel().Click();
        Get_WinCreateFilter_FieldIndividual().DblClick();
        
        Log.Message("Valider le nombre de Clients retournées");
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        if (count == nbrClientsIndividual) 
            Log.Checkpoint("Le nombre de clients affichés est comme attendu "+nbrClientsIndividual);
        else
            Log.Error("Le nombre de clients affichés est différent de l'attendu "+nbrClientsIndividual);
            
        //******************************************* Étape 6***************************************************

        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Valider le nombre de clients et relations offside dans le rapports des portefeuilles offside.");
        
        Log.Message("Cliquer sur l'oeil dans la barre de menu pour ouvrir le gestionnaire du risque et de la conformité, onglet Rapports")
        Get_Toolbar_BtnRQS().Click();
        WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621");
        Get_WinRQS_TabReports().Click();
        Log.Message("Select Offside Accounts on the drawdown list Report Type");
        Get_WinRQS_TabReports_CmbReportType().Click();
        Get_WinRQS_TabReports_CmbReportType().ClickItem(3);
        Log.Message("Click sur le bouton Display Report");
        Get_WinRQS_TabReports_BtnDisplayReport().Click();
        
        Log.Message("Ajouter la colonne  Niveau de gestion ");
        Add_ColumnByLabel(Get_WinRQS_TabReports_DgvOffsideAccounts_ChClientName(), RQSManagementLevelLabel);
        
        var count = Get_WinRQS_TabReports_DgvOffsideAccounts().Items.Count;
        var counterClientProfile = 0;
        var counterIndividual = 0;
        for (i=0; i<count; i++){
            if (Get_WinRQS_TabReports_DgvOffsideAccounts().Items.Item(i).DataItem.ManagementLevelDescription == clientProfile)
                counterClientProfile++;
            if (Get_WinRQS_TabReports_DgvOffsideAccounts().Items.Item(i).DataItem.ManagementLevelDescription == individual)
                counterIndividual++;
        }
        Log.Message(counterClientProfile)
        Log.Message(counterIndividual)
        Log.Message("Valider le nombre de relations Profil client");
        if (counterClientProfile == nbrRelations) 
            Log.Checkpoint("Le nombre de relations Profil client affichées est comme attendu "+nbrRelations);
        else  
            Log.Error("Le nombre de relations Profil client affichées est différent de l'attendu "+nbrRelations);
            
        
        Log.Message("Valider Le nombre de clients Individuel");
         if (counterIndividual == nbrClientsIndividual) 
            Log.Checkpoint("Le nombre de clients individuels affichés est comme attendu "+nbrClientsIndividual);
        else  
            Log.Error("Le nombre de clients individuels affichés est différent de l'attendu "+nbrClientsIndividual);
            
         //Fermer RQS  
         Get_WinRQS().Close(); 
         
         //******************************************* Étape 7***************************************************

        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Valider qu'une relation individuel est offside si elle contient au moins un client offside.");
        
        Log.Message("Aller dans le module Clients et rafraichir la grille pour enlever les filtres");
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Aller dans le module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("sélectionner le numéro de relation 0002A puis valider qu'elle est offside et elle a le niveau de gestion Individuel");
        SearchRelationshipByNo(relationship0002A);
        var gridRel = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridRel.Items.Count;
        for (i=0; i<count; i++){
           if (gridRel.Items.Item(i).DataItem.LinkNumber == relationship0002A){
              aqObject.CheckProperty(gridRel.Items.Item(i).DataItem, "ManagementLevelDescription", cmpEqual, individual);
              aqObject.CheckProperty(gridRel.Items.Item(i).DataItem, "IsOffsideForRCM", cmpEqual, true);
           }   
        }
        
        Log.Message("Mailler la relation dans le module Clients");
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Clients().Click();
        Get_MenuBar_Modules_Clients_DragSelection().Click();
        
        Log.Message("Valider que le client 80003 est offside et que le client 80006 n'est pas offside")
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        for (i=0; i<count; i++){
           if (gridCli.Items.Item(i).DataItem.ClientNumber == client800003){
              aqObject.CheckProperty(gridRel.Items.Item(i).DataItem, "IsOffsideForRCM", cmpEqual, true);
              Log.Checkpoint("le client "+client800003+" est offside");
           }   
           if (gridCli.Items.Item(i).DataItem.ClientNumber == client800006){
              aqObject.CheckProperty(gridRel.Items.Item(i).DataItem, "IsOffsideForRCM", cmpEqual, false);
              Log.Checkpoint("le client "+client800006+" n'est pas offside");
           }
        }
        
        //******************************************* Étape 8***************************************************

        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Valider que les clients associé à une relation profil client offside sont aussi offside.");
        
        Log.Message("Aller dans le module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Appliquer le filtre rapide 'Hors tolérence=Oui'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_Offside().Click();
        Get_WinCreateFilter_FieldYes().DblClick();
        
        Log.Message("Appliquer le filtre rapide 'Niveau de gestion=Profil client'");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManagementLevel().Click();
        Get_WinCreateFilter_FieldClientProfile().DblClick();
        
        Log.Message("faire Ctrl+A, sélectionner les 11 relations affiché puis mailler dans le module Clients");
        Sys.Keys("^a");
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Clients().Click();
        Get_MenuBar_Modules_Clients_DragSelection().Click();
        
        Log.Message("Valider que tous les clients appartenant aux relations sont offside");
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        for (i=0; i<count; i++){
            aqObject.CheckProperty(gridRel.Items.Item(i).DataItem, "IsOffsideForRCM", cmpEqual, true);
        }
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        //******************************************* Étape 9***************************************************

        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Modifier la config FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS (X, Y, V) pour rendre un client (initialement offside) non offside.");
        
//        Activate_Inactivate_PrefFirm("FIRM_1", "FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS", "X=30, Y=30 V=30 Z=5 W=95", vServerRQS); 
//        RestartServices(vServerRQS);
        var sqlString = "Insert into b_config (Cle,User_NuM, CLEGROUPE,RANG,CLELONG_L1,CLELONG_L2,FPICTURE,FVALID,AVANCE,NOTE,FIRM_ID,CUSTODIAN_ID) values"
        sqlString+= "('FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS',0,'FEED',1,'Offside client config',"
        sqlString+="'Offside client config','','','',"
        sqlString+="'V=30"
        sqlString+="W=95"
        sqlString+="X=30"
        sqlString+="Y=30"
        sqlString+="Z=5',1,1)"
        Execute_SQLQuery(sqlString, vServerRQS);
//        RestartServices(vServerRQS);
        
        //******************************************* Étape 10***************************************************

        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 10: Rouler le plugin DashboardRegenerator.");
        
        Log.Message("Rouler le plugin: cfLoader -DashboardRegenerator \"GenerateAccountPortfolio=False GenerateRQSPortfolio=CLIENT,LINK\" -firm=FIRM_1.");
        
        //Executer la commande cfLoader:  cfLoader  -DashboardRegenerator "generateRQSPortfolio=CLIENT,LINK" -firm=FIRM_1
        Log.Message("Execution de la commande cfLoader");
        ExecuteSSHCommandCFLoader(SSHFolder, vServerRQS, cfLoaderPlugin_generateRQSPortfolio, SSHUser);
        
        Log.Message("Réouvrir l'application, aller dans le module Clients");
        Log.Message("Se connecter à croesus");
        Login(vServerRQS, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("Aller dans le module Clients");
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Search_Client(client800036);
        
        Log.Message("Valider que le client 800036 est non offside");
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        for (i=0; i<count; i++){
           if (gridCli.Items.Item(i).DataItem.ClientNumber == client800036){
              aqObject.CheckProperty(gridCli.Items.Item(i).DataItem, "IsOffsideForRCM", cmpEqual, true);
           }   
        }
        
        
        
        //******************************************* Étape 11***************************************************

        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Étape 11: Remettre la config FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS (X, Y, V) à son état initial.");
        
        Execute_SQLQuery("delete  from b_config where cle='FD_COMPLIANCE_TEST_OFFSIDE_ACCOUNTS' and firm_id=1", vServerRQS);
        
        //******************************************* Étape 12***************************************************

        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: Valider la logique générique pour les critères de recherche dans les modules CRM (ORC-2756).");
        
        Log.Message("ajouter le critère de recherche ' Liste des clients ayant hors tolérence égal à Oui et ayant niveau de gestion égal à Individuel'");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemOffside().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();      
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemManagementLevel().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIndividual().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click(); 
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ToggleButton_5139");
        
        Log.Message("Valider le résultat retourné par le critère");
        var gridCli = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridCli.Items.Count;
        if (count == nbrClientsIndividual) 
            Log.Checkpoint("Le nombre de clients affichés est comme attendu "+nbrClientsIndividual);
        else
            Log.Error("Le nombre de clients affichés est différent de l'attendu "+nbrClientsIndividual);
            
        
        Log.Message("Aller dans le module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("ajouter le critère 'Liste des relations ayant hors tolérence égal à Oui et ayant niveau de gestion égal à Profil client'");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemOffside().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();      
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemManagementLevel().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemClientProfile().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click(); 
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ToggleButton_5139");
        
        Log.Message("Valider le résultat retourné par le critère");
        var gridRel = Get_RelationshipsClientsAccountsGrid().RecordListControl;
        var count = gridRel.Items.Count;
        if (count == nbrRelations) 
            Log.Checkpoint("Le nombre de clients affichés est comme attendu "+nbrRelations);
        else
            Log.Error("Le nombre de clients affichés est différent de l'attendu "+nbrRelations);
        
        
        //******************************************* Étape 13***************************************************

        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 13: Valider que les options hors tolérence et niveau de gestion ne sont pas affichés dans le module comptes.");
        
        Log.Message("Aller dans le module Comptes");
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("clic droit sur l'entête d'une colonne, puis ajouter une colonne et Valider que les options hors tolérence et niveau de gestion ne sont pas affichés");
        Get_AccountsGrid_ChAccountNo().ClickR();
        Get_AccountsGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        var found = false;
        var SubMenu = Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1);
        var count = SubMenu.DataContext.Items.Item(0).Items.Count;
        for (i=0; i<count; i++){
           var item = SubMenu.DataContext.Items.Item(0).Items.Item(i);
           if (item.Label == ManagementLevelLabel){
              Log.Error("la colonne Niveau de gestion ne doit pas être affichée");
              found = true;
            }
            if (item.Label == OffsideLabel){
              Log.Error("la colonne Hors tolérance ne doit pas être affichée");
              found = true;
            }
        }
        if (!found) Log.Checkpoint("Les deux colonnes 'Hors tolérance' et 'Niveau de gestion' ne sont pas affichées");
        
        Log.Message("Valider que les options Hors tolérence et niveau de gestion ne figure pas dans le filtre rapide");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        var found = false;
        var grid = Get_SubMenus().WPFObject("ContextMenu", "", 1);
        var count = grid.ChildCount;
        for (i=0; i<count; i++){
             if (grid.Items.Item(i).WPFControlText == ManagementLevelLabel){
              Log.Error("la colonne Niveau de gestion ne doit pas être affichée");
              found = true;
            }
            if (grid.Items.Item(i).WPFControlText == OffsideLabel){
              Log.Error("la colonne Hors tolérance ne doit pas être affichée");
              found = true;
            }
        }
        if (!found) Log.Checkpoint("Les deux colonnes 'Hors tolérance' et 'Niveau de gestion' ne sont pas affichées");
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
            
        
        //******************************************* Étape 14***************************************************

        Log.PopLogFolder();
        logEtape14 = Log.AppendFolder("Étape 14:  Modifier la PREF_ENABLE_CLIENT_RELATIONSHIPS=Non.");
        
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CLIENT_RELATIONSHIPS", "NO", vServerRQS);
//        RestartServices(vServerRQS);
        
        //******************************************* Étape 15***************************************************

        Log.PopLogFolder();
        logEtape15 = Log.AppendFolder("Étape 15:  Reouvrir l'application, module Relations.");
        
        Log.Message("Réouvrir l'application, aller dans le module Clients");
        Log.Message("Se connecter à croesus");
        Login(vServerRQS, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("Aller dans le module Relations");
        Get_ModulesBar_BtnRelationships().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Log.Message("Valider que les colonnes hors tolérence et niveau de gestion sont affichées");
        if (Get_RelationshipsGrid_ChManagementLevel().Exists)
            Log.Checkpoint("la colonne 'Niveau de gestion' est affichée");
        if (Get_RelationshipsGrid_ChOffside().Exists)
            Log.Checkpoint("la colonne 'Niveau de gestion' est affichée");
        
        Log.Message("Valider que les options Hors tolérence et niveau de gestion figure dans le filtre rapide");
        ClickAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts());
        var found = false;
        var grid = Get_SubMenus().WPFObject("ContextMenu", "", 1);
        var count = grid.ChildCount;
        for (i=0; i<count; i++){
             if (grid.Items.Item(i).WPFControlText == ManagementLevelLabel){
              Log.Checkpoint("la colonne Niveau de gestion est affichée dans le filtre rapide");
              found = true;
            }
            if (grid.Items.Item(i).WPFControlText == OffsideLabel){
              Log.Checkpoint("la colonne Hors tolérance est affichée dans le filtre rapide");
              found = true;
            }
        }
        if (!found) Log.Error("Au moins une colonne des deux colonnes 'Hors tolérance' et 'Niveau de gestion' n'est pas affichée dans le filtre rapide");
        
        
        
        //******************************************* Étape 16***************************************************

        Log.PopLogFolder();
        logEtape16 = Log.AppendFolder("Étape 16: Valider ORC-2330: Maximiser le font size de l'application et valider que la fenêtre RQS est aussi maximisée.");
        Log.Message("Cliquer 4 fois sur le grand A pour agrandir le caractere");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_WinMain_Btn_BigChar().Click();
        Get_WinMain_Btn_BigChar().Click();
        Get_WinMain_Btn_BigChar().Click();
        Get_WinMain_Btn_BigChar().Click();
        Log.Message("Valider la taille de caractere");
        aqObject.CheckProperty(Get_RelationshipsDetails_TabDocuments(), "Height", cmpEqual, BigCharSize) 
        
        Log.Message("Cliquer sur l'oeil dans la barre de menu pour ouvrir le gestionnaire du risque et de la conformité")
        Get_Toolbar_BtnRQS().Click();
        WaitObject(Get_CroesusApp(), "Uid", "AlertsManagementWindow_0621");
        
        Log.Message("Valider que la taille de carctere est grande aussi dans la fenêtre RQS");
        aqObject.CheckProperty(Get_WinRQS_TabReports(), "Height", cmpEqual, BigCharSize)
        //Fermer RQS  
        Get_WinRQS().Close(); 
        
        Log.Message("Cliquer 4 fois sur le petit A pour retourner 'a la taille normale du caractere");
        Get_WinMain_Btn_SmallChar().Click();
        Get_WinMain_Btn_SmallChar().Click();
        Get_WinMain_Btn_SmallChar().Click();
        Get_WinMain_Btn_SmallChar().Click();
        Log.Message("Valider que la taille de carctere est à l'état initial");
        aqObject.CheckProperty(Get_RelationshipsDetails_TabDocuments(), "Height", cmpEqual, SmallCharSize)
        
    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
  
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Log.Message("Remettre la pref à yes");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CLIENT_RELATIONSHIPS", "YES", vServerRQS);
       
    }
}
