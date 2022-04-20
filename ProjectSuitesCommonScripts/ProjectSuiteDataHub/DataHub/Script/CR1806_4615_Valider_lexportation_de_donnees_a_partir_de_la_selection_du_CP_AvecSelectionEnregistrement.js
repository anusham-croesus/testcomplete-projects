//USEUNIT CR1806_Helper



/**
    Description : Valider l'exportation de données à partir de la sélection du CP - Avec sélection d'enregistrement
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615
    Analyste d'assurance qualité : Jimena Bernal
    Analyste d'automatisation : Christophe Paring
    Version de scriptage :  ref90.06.Be-4
*/

function CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement()
{
    Log.Message("CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement()");
    CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement_PourLeModule(aqFileSystem.GetFileNameWithoutExtension(Project.FileName));
}



function CR1806_4615_Valider_lexportation_de_donnees_a_partir_de_la_selection_du_CP_AvecSelectionEnregistrement_PourLeModule(executionModuleName)
{
    if (executionModuleName != undefined) executionModuleName = aqString.ToUpper(Trim(executionModuleName));
    
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4615", "Pour ouvrir le cas de test, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        NameMapping.TimeOutWarning = false;
        
        var IACode = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithSelection_IACode", language + client);
        var fileNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithSelection_FileNamePrefix", language + client);
        var extractDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithSelection_ModelName", language + client);
        var nbOfTransactions = VarToInt(ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithSelection_NbOfTransactions", language + client));
        var filterIsGreaterThanValue = ReadDataFromExcelByRowIDColumnID(filePath_DataHub, "CR1806", "Croes_4615_WithSelection_FilterValue", language + client)
        var passwordGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        var userNameGP1859 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        
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
        
        
        
        //2 : Modèles
        //STEP 2 : Validation d'extrait avec la sélection multiple du même code de CP - Module Modèles
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Models){
            Log.Message("STEP 2 : Validation d'extrait avec la sélection multiple du même code de CP - Module Modèles.");
        
            //Aller au module Modèle et sélectionner le modèle
            var moduleName = moduleName_Models;
            var exportMethod = exportMethod_ClickR_CopyWithHeader;
            GotoModule(moduleName);
            SearchModelByName(modelName);
            var modelCell = Get_ModelsGrid().Find("Value", modelName, 10);
            if (!modelCell.Exists)
                Log.Error("The model name '" + modelName + "' was not found.");
            else {
                //Faire Clic droit puis Copier avec en-tête
                var formerNbOfRowsInDataHub = GetDataHubNbOfRecords();
                ExecuteActionAndExpectSubmenus(modelCell, "ClickR");
                Get_ModelsGrid_ContextualMenu_CopyWithHeader().Click();
            
                var nbOfExpectedNewRecords = 1;
                var isDataExportSuccessful = (nbOfExpectedNewRecords == GetNbOfNewRecordsInDataHub(formerNbOfRowsInDataHub, nbOfExpectedNewRecords));
                CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
            
                if (isDataExportSuccessful){
                    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                    CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
                }
            
                ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
            }
        }
        
        
        //3 : Transactions
        //STEP 3 : Validation d'extrait avec la sélection multiple du même code de CP - Module Transactions
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Transactions){
            Log.Message("STEP 3 : Validation d'extrait avec la sélection multiple du même code de CP - Module Transactions.");
        
            var moduleName = moduleName_Transactions;
            var exportMethod = exportMethod_MenuBar_CopyWithHeader;
            GotoModule(moduleName);
        
            //Sélectionner 10 transactions
            Get_Transactions_ListView().Click();
            Sys.Keys("[Home][Home]");
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).Click();
            for (var i = 2; i <= nbOfTransactions; i++)
                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", i], 10).Click(-1, -1, skCtrl);
            Get_MainWindow_StatusBar_NbOfSelectedElements().WaitProperty("Text.OleValue", nbOfTransactions, 10000);
            CheckEquals(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue, nbOfTransactions, "Number of selected transactions");
        
            var isDataExportSuccessful = ExportData(moduleName, exportMethod);
            CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
        
            if (isDataExportSuccessful){
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
            }

            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
        }
        
        
        //STEP 4 : Validation d'extrait avec la sélection multiple du même code de CP - Module clients, comptes et relations
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Relationships){
            Log.Message("STEP 4 : Validation d'extrait avec la sélection multiple du même code de CP - Module clients, comptes et relations.");
        
            //4 : Relations
            var moduleName = moduleName_Relationships;
            var exportMethod = exportMethod_ClickR_CopyWithHeader;
            GotoModule(moduleName);
            CreateTotalValueQuickFilterForRelationshipsClientsAccounts(filterIsGreaterThanValue);
            MenuBarEditSelectAll(); 
            var isDataExportSuccessful = ExportData(moduleName, exportMethod);
            CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
        
            if (isDataExportSuccessful){
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
            }

            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
        }
        
        //4 : Clients
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Clients){
            var moduleName = moduleName_Clients;
            var exportMethod = exportMethod_ClickR_CopyWithHeader;
            GotoModule(moduleName);
            CreateTotalValueQuickFilterForRelationshipsClientsAccounts(filterIsGreaterThanValue);
            MenuBarEditSelectAll(); 
            var isDataExportSuccessful = ExportData(moduleName, exportMethod);
            CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
        
            if (isDataExportSuccessful){
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
            }

            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
        }
        
        //4 : Comptes
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Accounts){
            var moduleName = moduleName_Accounts;
            var exportMethod = exportMethod_ClickR_CopyWithHeader;
            GotoModule(moduleName);
            CreateTotalValueQuickFilterForRelationshipsClientsAccounts(filterIsGreaterThanValue);
            MenuBarEditSelectAll(); 
            var isDataExportSuccessful = ExportData(moduleName, exportMethod);
            CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
        
            if (isDataExportSuccessful){
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
            }

            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
        }
        
        //5 : Ordres
        
        //STEP 5 : Validation d'extrait avec la sélection multiple du même code de CP - Module Ordres
        if (executionModuleName == undefined || executionModuleName == projectName_DataHub || executionModuleName == moduleName_Orders){
            Log.Message("STEP 5 : Validation d'extrait avec la sélection multiple du même code de CP - Module Ordres.");
            var moduleName = moduleName_Orders;
            var exportMethod = exportMethod_ClickR_CopyWithHeader;
            GotoModule(moduleName);
            MenuBarEditSelectAll(); 
            var isDataExportSuccessful = ExportData(moduleName, exportMethod);
            CheckEquals(isDataExportSuccessful, true, "The data export result from module '" + moduleName + "' by " + exportMethod);
            
            if (isDataExportSuccessful){
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_FUNCTION_NAME), GetExpectedFunctionName(exportMethod, moduleName), DataHub_ColumnName_FUNCTION_NAME);
                CheckEquals(GetDataHubLastValue(DataHub_ColumnName_IA_CODES), IACode, DataHub_ColumnName_IA_CODES);
            }
            
            ExecuteCfLoaderDataHubExtractorAndCheckIfExpectedFileIsGenerated(vServerDataHub, fileNamePrefix + "_" + moduleName + "_" + exportMethod, extractDate, vserverDefaultFolder);
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
        Terminate_CroesusProcess(); //Fermer le processus Croesus
        NameMapping.TimeOutWarning = true;
    }
}



function CreateTotalValueQuickFilterForRelationshipsClientsAccounts(filterIsGreaterThanValue)
{
    ExecuteActionAndExpectSubmenus(Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts(), "Click");
    Get_Toolbar_BtnQuickFilters_ContextMenu_TotalValue().Click();
    Get_WinCreateFilter_CmbOperator().set_IsDropDownOpen(true);
    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
    Get_WinCreateFilter_TxtValueDouble().set_Text(filterIsGreaterThanValue);
    Get_WinCreateFilter_BtnApply().Click();
}



function MenuBarEditSelectAll()
{
    //Aller ou menu edition/Sélectionner tout/Copier avec en-tête
    Log.Message("Aller ou menu edition/Sélectionner tout/Copier avec en-tête.");
    ExecuteActionAndExpectSubmenus(Get_MenuBar_Edit(), "Click");
    Get_MenuBar_Edit_SelectAll().Click();
    Delay(1000); //Wait for the status bar to be updated
    var nbOfSelectedElements = (Get_MainWindow_StatusBar_NbOfSelectedElements().Text == null)? 0: VarToInt(Get_MainWindow_StatusBar_NbOfSelectedElements().Text.OleValue);
    if (nbOfSelectedElements == 0)
        Log.Warning("Upon Select All, no row was selected in the module " + moduleName + " grid.", "", pmHigher, pmNormal, Sys.Desktop.Picture());
}
