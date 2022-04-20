//USEUNIT CR1806_Helper




/**
    Description : Valider l'exportation de données à partir de la sélection du CP - Sans sélection d'enregistrement
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement()
{
    Log.Message("CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement()");
    CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_SansSelectionEnregistrement_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");

    Log.Message("JIRA CROES-10234 : Le champ NB_RECORDS et IA_CODES de la table B_data_hub est vide lorsqu'on exporte vers le presse-papiers sans sélectionner aucune donnée.");
    
    if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
        Log.Message("JIRA CROES-10233 : Lorsqu'on exporte vers excel via le blotter du module Ordres, la FUNCTION_ID = OrdreAccumulatorDataGrid au lieu de FUNCTION_ID = OrdreBlotterDataGrid qui est le comportement attendu.");
        Log.Message("JIRA CROES-10231 : Crash de l'application lorsqu'on fait une copie sur le datagrille vide du module Ordres.");
    }
    
    try {
        NameMapping.TimeOutWarning = false;
        
        var IACode = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithoutSelection_IACode", language + client);
        var fileNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithoutSelection_FileNamePrefix", language + client);
        var extractDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
        var vserverFolder = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "DataHubExtractor_VserverDefaultFolder", language + client);
        
        //Se connecter avec l'utilisateur GP1859
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Mettre à jour la Pref
        var prefValue = "YES";
        var prefLevel = "USER";
        UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, prefValue, prefLevel);
        
        //1. Se connecter avec GP1859
        Log.Message("1. Se connecter avec GP1859");
        Login(vServerDataHub, userNameGP1859, passwordGP1859, language);
        
        //2. Aller au menu principal/Utilisateurs/Sélection.../Codes de CP
        //3. Sélectionner le code BD88/Appliquer
        Log.Message("2, 3. Aller au menu principal/Utilisateurs/Sélection.../Codes de CP");
        SelectIACodes(IACode);
        
        var arrayOfModules = (executionModuleName == undefined)? [moduleName_Models, moduleName_Relationships, moduleName_Clients, moduleName_Accounts, moduleName_Portfolio, moduleName_Transactions, moduleName_Orders]: [executionModuleName];
        var exportMethod = exportMethod_MenuBar_CopyWithHeader;
        
        //Faire le test pour chaque module
        for (var i in arrayOfModules){
            var moduleName = arrayOfModules[i];
            
            //4. Aller au module
            Log.Message("4. Aller au module " + moduleName);
            
            if (moduleName == moduleName_Portfolio){
                if (!DragAccountsToPortfolio([]))
                    continue;
            }
            else
                GotoModule(moduleName);
            
            //Récupérer le Items count du grid
            var moduleGridCount = null;
            if (moduleName == moduleName_Models)
                moduleGridCount = VarToInt(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
            else if (moduleName == moduleName_Relationships)
                moduleGridCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
            else if (moduleName == moduleName_Clients)
                moduleGridCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
            else if (moduleName == moduleName_Accounts)
                moduleGridCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
            else if (moduleName == moduleName_Portfolio)
                moduleGridCount = VarToInt(Get_Portfolio_PositionsGrid().Items.Count);
            else if (moduleName == moduleName_Transactions)
                moduleGridCount = VarToInt(Get_Transactions_ListView().Items.Count);
            else if (moduleName == moduleName_Orders)
                moduleGridCount = VarToInt(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Count);
            
            
            //5. Aller ou menu edition/Copier avec en-tête
            Log.Message("5. Aller ou menu edition/Copier avec en-tête.");
            
            if (!ExportData(moduleName, exportMethod))
                Log.Error("There was a possible issue with the data export from module '" + moduleName + "' by : " + exportMethod);
            else {
                Log.Checkpoint("The data export from module '" + moduleName + "' by '" + exportMethod + "' was successfull");
                
                var actualValueInIACodefield = GetDataHubLastValue(DataHub_ColumnName_IA_CODES);
                if (moduleGridCount < 1)
                    Log.Message("The module " + moduleName + " grid was empty.", "", pmHigher, null, Sys.Desktop.Picture());
                else {
                    if (CompareProperty(actualValueInIACodefield, cmpContains, IACode, true, lmNone))
                        Log.Checkpoint("IA Code '" + IACode + "' is present in " + DataHub_ColumnName_IA_CODES + " field : " + actualValueInIACodefield);
                    else
                        Log.Error("IA Code '" + IACode + "' is not present in " + DataHub_ColumnName_IA_CODES + " field : " + actualValueInIACodefield);
                }
            }
            
            //6. Exécuter le plugin cfLoader -DataHubExtractor --FileName X--ExtractDate Y
            Log.Message("6. Exécuter le plugin cfLoader -DataHubExtractor --FileName X --ExtractDate Y");
            var fileName = fileNamePrefix + moduleName;
            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileName, extractDate, vserverFolder);

        }
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        if (userNameGP1859 != undefined) UpdateDataHubPrefAtSameLevelForUsers(userNameGP1859, null, prefLevel); //Mettre la Pref à sa valeur par défaut
		
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        NameMapping.TimeOutWarning = true;
    }
}
