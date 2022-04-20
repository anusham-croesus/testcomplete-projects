//USEUNIT CR1485_Common_functions




/**
    Ref : P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.4. Comptes\Répartition et Objectif\
    
    Configuration du CR1905 pour les rapports suivants :
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\3. Évaluation du portefeuille (simple)\3.4. Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\5. PERFORMANCE DU PORTEFEUILLE\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\9. Sommaire du portefeuille\2.2 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\12. Répartition d'actifs (graphique par catégorie)\2.2 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\20. Évaluation du portefeuille (avancé)\3.3 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\27. Répartition d'actifs (détaillée)\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\48. Analyse de revenu des titres\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\55. ACTIFS SOUS GESTION\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\61. Évaluation du portefeuille (intermédiaire)\3.2 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\74. PERFORMANCE DU PORTEFEUILLE (HISTORIQUE)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\77. PERFORMANCE DU PORTEFEUILLE (SIMPLE)\3.1 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\97. ÉVALUATION DU PORTEFEUILLE (VALEUR ACCUMULÉE)\3.3 Comptes
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\102. PERFORMANCE DU PORTEFEUILLE (SOMMAIRE DES COMPTES)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\108. SOMMAIRE DU PORTEFEUILLE (DÉTAILLÉ)\2.1 Clients
    P:\aq\Projets\GEN\CR1485\Rapports de référence\BNC\124. Performance du portefeuille (intermédiaire)\3.1 Comptes
*/
function CR1485_PreparationBD_CR1905()
{
    Log.Message("CR1485_PreparationBD_CR1905()");
    Log.Link("P:\\aq\\Projets\\GEN\\CR1485\\Rapports de référence\\BNC\\3. Évaluation du portefeuille (simple)\\3.4. Comptes\\Répartition et Objectif\\Configuration Rép et Obj.txt", "Pour ouvrir le Document de la Configuration à faire relative au CR1905, cliquer sur le lien dans la colonne 'Link'.");
    
    try {
        //Récupérer les données du fichier Excel
        var inner_DataSeparatorChar = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "Inner_DataSeparatorChar", language);
        var outer_DataSeparatorChar = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "Outer_DataSeparatorChar", language);
        var arrayOfUsers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "CR1905_Users", language).split(inner_DataSeparatorChar);
        var arrayOfInvestmentObjective_ClientsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_ClientsNumbers", language).split(outer_DataSeparatorChar);
        var arrayOfInvestmentObjective_AccountsNumbers = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_AccountsNumbers", language).split(outer_DataSeparatorChar);
        var myAssetAllocationsItem_englishDescription = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", "english");
        var myAssetAllocationsItem_frenchDescription = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", "french");
        var myAssetAllocationsItemName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "MyAssetAllocation_Description", language);
        var investmentObjective_Description = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_Description", language);
        var investmentObjective_AutomaticMinMaxAdjustment = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjective_AutomaticMinMaxAdjustment", language);
    
        //Récupérer les noms des objectifs de placement ainsi que leur pourcentage
        var offset_InvestmentObjectiveIDs = FindExcelRow(filePath_ReportsCR1485, "PreparationBD_CR1905", "InvestmentObjectives_List");
        var Excel = Sys.OleObject("Excel.Application");
        Sys.WaitProcess("excel", 10000);
        Excel.Workbooks.Open(filePath_ReportsCR1485).Sheets.Item("PreparationBD_CR1905").Activate();
        var excelRowCount = Excel.ActiveSheet.UsedRange.Rows.Count;
        Excel.Quit();
        TerminateProcess("excel");
        
        var arrayOfArrayOfInvestmentObjectiveNamesAndValues = [];
        if (offset_InvestmentObjectiveIDs !== null){
            var investmentObjectiveID_MaxNum = excelRowCount - offset_InvestmentObjectiveIDs;
            for (var i = 1; i <= investmentObjectiveID_MaxNum; i++){
                var investmentObjectiveID = "InvestmentObjective_" + IntToStr(i);
                var investmentObjectiveName = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", investmentObjectiveID, language);
                var recommendedPercentage = ReadDataFromExcelByRowIDColumnID(filePath_ReportsCR1485, "PreparationBD_CR1905", investmentObjectiveID, "InvestmentObjective_Percent");
                arrayOfArrayOfInvestmentObjectiveNamesAndValues.push([investmentObjectiveName, recommendedPercentage]);
            }
        }
        
        //Faire la préparation pour chacun des utilisateurs mentionnés par arrayOfUsers 
        for (var u in arrayOfUsers){
            if (Trim(arrayOfUsers[u]) == ""){
                Log.Warning("The user name ID is empty.");
                continue;
            }
            
            try {
                //Login
                var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", arrayOfUsers[u], "username");
                var testUserPswd = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", arrayOfUsers[u], "psw");
                var arrayOfCurrentUserClientsNumbers = arrayOfInvestmentObjective_ClientsNumbers[u].split(inner_DataSeparatorChar);
                var arrayOfCurrentUserAccountsNumbers = arrayOfInvestmentObjective_AccountsNumbers[u].split(inner_DataSeparatorChar);
                Log.Message("CR1905_PreparationBD() for user " + testUserName);
                Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerReportsCR1485);
                Login(vServerReportsCR1485, testUserName, testUserPswd, language);              
                
                //Ouvrir la fenêtre de Configurations
                var numTry = 0;
                do {
                    Delay(5000);
                    Get_MenuBar_Tools().Click();
                } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
                Get_MenuBar_Tools_Configurations().Click();
                Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
                Get_WinConfigurations().Parent.Maximize();
                
                //CRÉATION D'UNE RÉPARTITION D'ACTIFS NOMBREUSE ET CRÉATION DES OBJECTIFS DE PLACEMENT POUR LA RÉPARTITION D'ACTIFS
                if (CreateMyAssetAllocationBasedOnSubcategories(myAssetAllocationsItem_englishDescription, myAssetAllocationsItem_frenchDescription))
                    SetInvestmentObjectiveNamesValues(myAssetAllocationsItemName, arrayOfArrayOfInvestmentObjectiveNamesAndValues, investmentObjective_Description, investmentObjective_AutomaticMinMaxAdjustment);
            
                //Fermer la fenêtre de Configurations et Croesus
                Get_WinConfigurations().Close();
            
                //Configurer l'objectif de placement pour les clients relatifs à l'utilisateur       
                for (var c in arrayOfCurrentUserClientsNumbers){
                    var clientNumber = arrayOfCurrentUserClientsNumbers[c];
                    if (Trim(clientNumber) == "")
                        continue;
                    
                    Log.Message("Add My Asset Allocation '" + myAssetAllocationsItemName + "' > '"+ investmentObjective_Description + "' investment objective to client '" + clientNumber + "'");
                    SelectClients(clientNumber);
                    Get_ClientsBar_BtnInfo().Click();
                    Get_WinDetailedInfo_TabProductsAndServices().Click();
                    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", true, 60000);
                    Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
                    Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
                    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
                    Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, investmentObjective_Description).Click();
                    if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
                        Get_WinSelectAnObjective_BtnOK().Click();
                    else {
                        Log.Error("Investment objective selection cancelled.");
                        Get_WinSelectAnObjective_BtnCancel().Click();
                    }
                    Get_WinDetailedInfo_BtnOK().Click();
                }

                //Configurer l'objectif de placement pour les comptes relatifs à l'utilisateur
                for (var a in arrayOfCurrentUserAccountsNumbers){
                    var accountNumber = arrayOfCurrentUserAccountsNumbers[a];
                    if (Trim(accountNumber) == "")
                        continue;
                
                    Log.Message("Add My Asset Allocation '" + myAssetAllocationsItemName + "' > '"+ investmentObjective_Description + "' investment objective to account '" + accountNumber + "'");
                    SelectAccounts(accountNumber);
                    Get_AccountsBar_BtnInfo().Click();
                    Get_WinAccountInfo_TabInvestmentObjective().Click();
                    Get_WinAccountInfo_TabInvestmentObjective().WaitProperty("IsSelected", true, 60000);
                    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
                    Get_WinSelectAnObjective_TvwObjectives_TvwMyAssetAllocations_TvwMyAssetAllocationsItem_TvwMyObjectives_TvwMyObjectivesItem(myAssetAllocationsItemName, investmentObjective_Description).Click();
                    if (Get_WinSelectAnObjective_BtnOK().WaitProperty("Enabled", true, 5000))
                        Get_WinSelectAnObjective_BtnOK().Click();
                    else {
                        Log.Error("Investment objective selection cancelled.");
                        Get_WinSelectAnObjective_BtnCancel().Click();
                    }
                    
                    Get_WinAccountInfo_BtnOK().Click();
                    
                    //S'il y a une éventuelle boîte de dialogue de confirmation
                    var previousAutoTimeout = Options.Run.Timeout;
                    SetAutoTimeOut();
                    if (Get_DlgConfirmation().Exists){
                        Log.Warning("There was an unexpected Confirmation Dialog Box. Click on Yes.", VarToStr(Get_DlgConfirmation_LblMessage().Message), pmNormal, null, Sys.Desktop.Picture());
                        Get_DlgConfirmation_BtnYes().Click();
                    }
                    SetAutoTimeOut(previousAutoTimeout);
                }
            
                //Fermer Croesus
                CloseCroesus();
            }
            catch(exception_CR1485_PreparationBD_CR1905){
                Log.Error("CR1485_PreparationBD_CR1905(), Exception for user " + testUserName + ": " + exception_CR1485_PreparationBD_CR1905.message, VarToStr(exception_CR1485_PreparationBD_CR1905.stack));
                exception_CR1485_PreparationBD_CR1905 = null;
            }
            finally {
                Terminate_CroesusProcess();
            }
        }
    }
    catch(outer_exception_CR1485_PreparationBD_CR1905){
        Log.Error("Exception in CR1485_PreparationBD_CR1905(): " + outer_exception_CR1485_PreparationBD_CR1905.message, VarToStr(outer_exception_CR1485_PreparationBD_CR1905.stack));
        outer_exception_CR1485_PreparationBD_CR1905 = null;
    }
    finally {
        Terminate_CroesusProcess();
    }
}



function CreateMyAssetAllocationBasedOnSubcategories(myAssetAllocationsItem_englishDescription, myAssetAllocationsItem_frenchDescription)
{
    var myAssetAllocationsItemName = (language == "french")? myAssetAllocationsItem_frenchDescription: myAssetAllocationsItem_englishDescription;
    
    for (var nbTry = 1; nbTry <= 3; nbTry++){
        Delay(3000);
        Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
        Delay(3000);
        Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
        Delay(3000);
        if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists)
            break;
    }
    
    if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists){
        Log.Warning("Il y a une répartition existante de même nom '" + myAssetAllocationsItemName + "'.", "", pmHigher, null, Sys.Desktop.Picture());
        return null;
    }
    else {
        Delay(3000);
        if (!Get_WinConfigurations_ToolBar_BtnAddAssetAllocation().WaitProperty("IsEnabled", true, 60000)){
            Delay(3000);
            Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
            Delay(3000);
            Get_WinConfigurations_ToolBar_BtnAddAssetAllocation().WaitProperty("IsEnabled", true, 60000)
        }
        Get_WinConfigurations_ToolBar_BtnAddAssetAllocation().Click();
        Get_WinAssetAllocation_BtnLanguages().Click();
        Get_WinDescription_TxtEnglishCanada().Keys(myAssetAllocationsItem_englishDescription);
        Get_WinDescription_TxtFrancaisCanada().Keys(myAssetAllocationsItem_frenchDescription);
        Get_WinDescription_BtnOK().Click();
        Get_WinAssetAllocation_BtnOK().Click();
        
        for (var nbTry = 1; nbTry <= 3; nbTry++){
            Delay(3000);
            Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
            Delay(3000);
            
            if (Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().Exists)
                Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
            
            Delay(3000);
            if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists)
                break;
        }
        
        Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).DblClick();
        Get_WinConfigurations_LvwListView_LlbBasedOn().Parent.Parent.set_IsSelected(true);
        Get_WinConfigurations_ToolBar_BtnMapClassification().Click();
        Get_WinMapAClassification_LvwAccessLevel_LlbGlobalClassifications().Click();
        Get_WinMapAClassification_LvwAvailableClassifications_LlbSubcategories().Click();
        Get_WinMapAClassification_BtnOK().Click();
    }
    
    for (var nbTry = 1; nbTry <= 3; nbTry++){
        Delay(5000);
        Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().HoverMouse();
        Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
        Delay(5000);
        if (Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().Exists)
            Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
        Delay(5000);
        if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists)
            break;
    }
    
    return Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists;
}



function SetInvestmentObjectiveNamesValues(myAssetAllocationsItemName, arrayOfArrayOfInvestmentObjectiveNamesAndValues, investmentObjective_Description, investmentObjective_AutomaticMinMaxAdjustment)
{    
    for (var nbTry = 1; nbTry <= 3; nbTry++){
        Delay(3000);
        Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
        Delay(3000);
        Get_WinConfigurations_LvwListView_LlbMyAssetAllocations().DblClick();
        Delay(3000);
        if (Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).Exists)
            break;
    }
    
    Get_WinConfigurations_LvwListView_LlbItem(myAssetAllocationsItemName).DblClick();
    Get_WinConfigurations_LvwListView_LlbMyObjectives().Parent.Parent.set_IsSelected(true);
    Get_WinConfigurations_ToolBar_BtnAddInvestmentObjective().Click();
    Get_WinInvestmentObjective_GrpInformation_TxtDescription().Clear();
    Get_WinInvestmentObjective_GrpInformation_TxtDescription().Keys(investmentObjective_Description);
    Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment().Clear();
    Get_WinInvestmentObjective_GrpInformation_TxtAutomaticMinMaxAdjustment().Keys(investmentObjective_AutomaticMinMaxAdjustment);
    
    for (var i in arrayOfArrayOfInvestmentObjectiveNamesAndValues){
        var investmentObjectiveName = arrayOfArrayOfInvestmentObjectiveNamesAndValues[i][0];
        var recommendedPercentage = arrayOfArrayOfInvestmentObjectiveNamesAndValues[i][1];
        
        if (recommendedPercentage == 0)
            continue; //OK pour la phase de création
        
        if (aqString.StrMatches("[^0-9]", recommendedPercentage)){
            Log.Error("The Recommended value '" + recommendedPercentage + "' is not an Integer (for Item '" + investmentObjectiveName + "' setting.)");
            continue;   
        }
        
        if (!Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(investmentObjectiveName).Exists){
            Log.Error("Item '" + investmentObjectiveName + "' was not found in the grid");
            continue;   
        }
        
        var isSuccessfull = false;
        var numTry = 0;
        do {
            numTry++;
            Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_DgvInvestmentObjective_Item(investmentObjectiveName).set_IsActive(true);
            Delay(numTry * 3000);
            Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended().Keys("[Del]" + recommendedPercentage + "[Tab]");
            isSuccessfull = Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended().WaitProperty("Text.OleValue", StrToInt(recommendedPercentage), numTry * 10000);
        } while (!isSuccessfull && numTry < 4)
        
        Delay(3000);
        if (StrToInt(recommendedPercentage) != Get_WinInvestmentObjective_GrpCompositionOfTheAssetClass_GrpPercentages_TxtRecommended().Text.OleValue)
            Log.Error("The Recommended value " + recommendedPercentage + " setting was not successful for item : " + investmentObjectiveName);
    }
    
    var winInvestmentObjectiveUid = VarToStr(Get_WinInvestmentObjective().Uid);
    Get_WinInvestmentObjective_BtnOK().Click();
    SetAutoTimeOut();
    if (Get_DlgInformation().Exists){
        Log.Error("There was an issue while setting Investment Objective values ; cancel it.");
        Get_DlgInformation_BtnOK().Click();
        Get_WinInvestmentObjective_BtnCancel().Click();
    }
    RestoreAutoTimeOut();
    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", winInvestmentObjectiveUid);
}
