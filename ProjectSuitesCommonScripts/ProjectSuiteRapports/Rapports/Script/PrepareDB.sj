//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT Clients_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions



function PrepareDB()
{
    //language = "french";
    
    vServerAccounts = "http://qa-tests-auto35.croesus.local/";
    
    Login(vServerAccounts, "GP1859", psw, language);
    
    PrepareAccounts();
    
    PrepareClients();
    
    PrepareRelationships();
}



function RestoreDB()
{
    //language = "french";
    
    vServerAccounts = "http://qa-tests-auto35.croesus.local/";
    
    Login(vServerAccounts, "GP1859", psw, language);
    
    RestoreAccounts();
    
    RestoreClients();
    
    RestoreRelationships();
}



function PrepareAccounts()
{
    //Préparation des comptes
    Get_ModulesBar_BtnAccounts().Click();
    
    PrepareAccount("300001-NA", null, null, null, null);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (période)", "Portfolio Performance (Period)");
    PrepareAccount("800015-NA", "20080315", null, null, arrayOfReportsNamesFrEn);
    
    PrepareAccount("800015-OB", "20071231", null, null, null);
    
    PrepareAccount("800015-RE", "20090115", null, null, null);
    
    PrepareAccount("800015-SF", "20070630", null, Array("EAFE", "S&P60", "TSE60"), null);
    
    PrepareAccount("800030-GT", null, "Basic_Global_Balanced", null, null);
    
    PrepareAccount("800030-JW", null, "Firm_Global_Growth", null, null);
    
    arrayOfReportsNamesFrEn = Array(Array("Performance du portefeuille", "Performance du portefeuille (simple)"), Array("Portfolio Performance", "Portfolio Performance (Simple)"));
    PrepareAccount("800030-NA", null, "Firm_Global_Balanced", null, arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (historique)", "Portfolio Performance (History)");
    PrepareAccount("800032-NA", null, null, null, arrayOfReportsNamesFrEn);
    
    PrepareAccount("800032-GT", null, null, null, null);
    
    PrepareAccount("800046-FS", "20090331", null, Array("EAFE", "S&P60", "TSE60"), null);
    
    PrepareAccount("800046-OB", "20090331", null, Array("NASDAQ100", "S&P500", "TSE100"), null);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (graphique)", "Portfolio Performance (Graph)");
    PrepareAccount("800046-NA", "20070101", null, Array("NASDAQ100", "S&P500", "TSE100"), arrayOfReportsNamesFrEn);
    
    PrepareAccount("800046-RE", "19990501", null, Array("EAFE", "S&P60", "TSE60"), null);
    
    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (sans référence)", "Portfolio Summary (without References)");
    PrepareAccount("800224-JW", null, null, null, arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (avec références)", "Portfolio Summary (with References)");
    PrepareAccount("800262-JW", null, null, null, arrayOfReportsNamesFrEn);
}



function PrepareClients()
{
    //Préparation des clients
    Get_ModulesBar_BtnClients().Click();
    
    PrepareClient("300001", null, null, null);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (période)", "Portfolio Performance (Period)");
    PrepareClient("800015", null, Array("EAFE", "S&P60", "TSE60"), arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array(Array("Performance du portefeuille", "Performance du portefeuille (simple)"), Array("Portfolio Performance", "Portfolio Performance (Simple)"));
    PrepareClient("800030", "Basic_Global_Balanced", null, arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (historique)", "Portfolio Performance (History)");
    PrepareClient("800032", null, null, arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (graphique)", "Portfolio Performance (Graph)");
    PrepareClient("800046", "Firm_Global_Growth", Array("NASDAQ100", "S&P500", "TSE100"), arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (sans référence)", "Portfolio Summary (without References)");
    PrepareClient("800224", null, null, arrayOfReportsNamesFrEn);
    
    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (avec références)", "Portfolio Summary (with References)");
    PrepareClient("800262", null, null, arrayOfReportsNamesFrEn);
}



function PrepareRelationships()
{
    //Préparation des relations
    Get_ModulesBar_BtnRelationships().Click();

    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (sans référence)", "Portfolio Summary (without References)");
    PrepareRelationship("PERF_PORTEF01", false, "AC42", "CAD", "FR", null, null, arrayOfReportsNamesFrEn);
    JoinClientToRelationship("800224", "PERF_PORTEF01");
    
    arrayOfReportsNamesFrEn = Array("Sommaire du portefeuille (avec références)", "Portfolio Summary (with References)");
    PrepareRelationship("PERF_PORTEF02", false, "BD66", "USD", "EN", null, null, arrayOfReportsNamesFrEn);
    JoinClientToRelationship("800262", "PERF_PORTEF02");
    
    PrepareRelationship("PERF_PORTEF03", false, "BD88", "CAD", "FR", null, null, null);
    JoinClientToRelationship("300001", "PERF_PORTEF03");
    
    PrepareRelationship("PERF_PORTEF04", false, "AC55", "CAD", "FR", null, null, null);
    JoinAccountToRelationship("800030-NA", "PERF_PORTEF04");
    
    PrepareRelationship("PERF_PORTEF05", false, "AC55", "CAD", "FR", "Basic_Global_Balanced", null, null);
    JoinAccountToRelationship("800030-JW", "PERF_PORTEF05");
    JoinAccountToRelationship("800030-GT", "PERF_PORTEF05");
    
    arrayOfReportsNamesFrEn = Array(Array("Performance du portefeuille", "Performance du portefeuille (simple)"), Array("Portfolio Performance", "Portfolio Performance (Simple)"));
    PrepareRelationship("PERF_PORTEF06", false, "AC55", "CAD", "FR", "Firm_Global_Growth", null, arrayOfReportsNamesFrEn);
    JoinClientToRelationship("800030", "PERF_PORTEF06");
    
    PrepareRelationship("PERF_PORTEF07", false, "AC55", "CAD", "FR", null, null, null);
    JoinAccountToRelationship("800046-NA", "PERF_PORTEF07");
    JoinAccountToRelationship("800046-RE", "PERF_PORTEF07");
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (période)", "Portfolio Performance (Period)");
    PrepareRelationship("PERF_PORTEF08", false, "AC44", "CAD", "EN", null, Array("EAFE", "S&P60", "TSE60"), arrayOfReportsNamesFrEn);
    JoinClientToRelationship("800015", "PERF_PORTEF08");
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (historique)", "Portfolio Performance (History)");
    PrepareRelationship("PERF_PORTEF09", false, "AC55", "CAD", "EN", null, null, arrayOfReportsNamesFrEn);
    JoinAccountToRelationship("800032-GT", "PERF_PORTEF09");
    JoinAccountToRelationship("800032-NA", "PERF_PORTEF09");
    
    arrayOfReportsNamesFrEn = Array("Performance du portefeuille (graphique)", "Portfolio Performance (Graph)");
    PrepareRelationship("PERF_PORTEF10", false, "AC55", "USD", "FR", null, Array("NASDAQ100", "S&P500", "TSE100"), arrayOfReportsNamesFrEn);
    JoinClientToRelationship("800046", "PERF_PORTEF10");
    
    PrepareRelationship("PERF_PORTEF11", true, "AC55", "CAD", "FR", null, null, null);
    JoinToAGroupedRelationship("PERF_PORTEF06", "PERF_PORTEF11");
    JoinToAGroupedRelationship("PERF_PORTEF08", "PERF_PORTEF11");
    JoinToAGroupedRelationship("PERF_PORTEF10", "PERF_PORTEF11");
}



function RestoreAccounts()
{
    //Restauration des comptes
    Get_ModulesBar_BtnAccounts().Click();

    RestoreAccount("300001-NA");
    RestoreAccount("800015-NA");
    RestoreAccount("800015-OB");
    RestoreAccount("800015-RE");
    RestoreAccount("800015-SF");
    RestoreAccount("800030-GT");
    RestoreAccount("800030-JW");
    RestoreAccount("800030-NA");
    RestoreAccount("800032-NA");
    RestoreAccount("800032-GT");
    RestoreAccount("800046-FS");
    RestoreAccount("800046-OB");
    RestoreAccount("800046-NA");
    RestoreAccount("800046-RE");
    RestoreAccount("800224-JW");
    RestoreAccount("800262-JW");
}



function RestoreClients()
{
    //Restauration des clients
    Get_ModulesBar_BtnClients().Click();

    RestoreClient("300001");
    RestoreClient("800015");
    RestoreClient("800030");
    RestoreClient("800032");
    RestoreClient("800046");
    RestoreClient("800224");
    RestoreClient("800262");
}



function RestoreRelationships()
{
    //Restauration des clients
    Get_ModulesBar_BtnRelationships().Click();

    DeleteRelationship("PERF_PORTEF01");
    DeleteRelationship("PERF_PORTEF02");
    DeleteRelationship("PERF_PORTEF03");
    DeleteRelationship("PERF_PORTEF04");
    DeleteRelationship("PERF_PORTEF05");
    DeleteRelationship("PERF_PORTEF06");
    DeleteRelationship("PERF_PORTEF07");
    DeleteRelationship("PERF_PORTEF08");
    DeleteRelationship("PERF_PORTEF09");
    DeleteRelationship("PERF_PORTEF10");
    DeleteRelationship("PERF_PORTEF11");
}



function PrepareAccount(accountNumber, managementStartDate, investmentObjective, arrayOfIndicesSymbols, arrayOfReportsNamesFrEn)
{
    //Ouvrir la fenêtre Info du compte
    Log.Message("Prepare account N° " + accountNumber);
    Search_Account(accountNumber);
    Get_AccountsBar_BtnInfo().Click();
    Delay(1000);
    
    //Renseigner la date de début de gestion
    if (Trim(VarToStr(managementStartDate)) != ""){
        yearNumber = aqString.SubString(managementStartDate, 0, 4);
        monthNumber = aqString.SubString(managementStartDate, 4, 2);
        dayNumber = StrToInt(aqString.SubString(managementStartDate, 6, 2));
        Get_WinAccountInfo_TabDates().Click();
        Delay(2000);
        Get_WinAccountInfo_TabDates_DtpManagementStartDate().Click(Get_WinAccountInfo_TabDates_DtpManagementStartDate().get_ActualWidth()-10, Get_WinAccountInfo_TabDates_DtpManagementStartDate().get_ActualHeight()/2);
        Delay(200);
        
        if (StrToInt(yearNumber) < 2004) //Faire apparaître l'année
            Get_Calendar_LstYears().Click(Get_Calendar_LstYears().get_ActualWidth()-10, 50);
        
        Get_Calendar_LstYears_Item(yearNumber).Click();
        Delay(200);
        Get_Calendar_LstMonths_Item(monthNumber).Click();
        Delay(200);
        Get_Calendar_LstDays_Item(dayNumber).Click();
        Get_Calendar_BtnOK().Click();
    }
    
    //Renseigner l'objectif de placement
    if (Trim(VarToStr(investmentObjective)) != ""){
        Get_WinAccountInfo_TabInvestmentObjective().Click();
        Delay(1000);

        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
    }
    
    //Renseigner les indices par défaut 
    if (Trim(VarToStr(arrayOfIndicesSymbols)) != ""){
    
        if ((GetVarType(arrayOfIndicesSymbols) != varArray) && (GetVarType(arrayOfIndicesSymbols) != varDispatch))
            arrayOfIndicesSymbols = new Array(arrayOfIndicesSymbols);
        
        Get_WinAccountInfo_TabDefaultIndices().Click();
        Delay(1000);
        
        SelectIndices(arrayOfIndicesSymbols);
    }
    
    //Renseigner les rapports par défaut
    if (Trim(VarToStr(arrayOfReportsNamesFrEn)) != ""){
    
        if ((GetVarType(arrayOfReportsNamesFrEn) != varArray) && (GetVarType(arrayOfReportsNamesFrEn) != varDispatch))
            Log.Error("Array expected!");
        
        arrayOfReportsNames = (language == "french")? arrayOfReportsNamesFrEn[0] : arrayOfReportsNamesFrEn[1];

        if ((GetVarType(arrayOfReportsNames) != varArray) && (GetVarType(arrayOfReportsNames) != varDispatch))
            arrayOfReportsNames = new Array(arrayOfReportsNames);
        
        
        Get_WinAccountInfo_TabDefaultReports().Click();
        Delay(1000);
        
        SelectReports(arrayOfReportsNames);
    }
    
    //Valider les modifications
    Delay(1000);
    Get_WinAccountInfo_BtnOK().Click();
}



function RestoreAccount(accountNumber)
{
    //Ouvrir la fenêtre Info du compte
    Log.Message("Restore account N° " + accountNumber);
    Search_Account(accountNumber);
    Get_AccountsBar_BtnInfo().Click();
    Delay(1000);
    
    //Effacer la date de début de gestion
    Get_WinAccountInfo_TabDates().Click();
    Delay(1000);
    Get_WinAccountInfo_TabDates_DtpManagementStartDate().Click();
    Get_WinAccountInfo_TabDates_DtpManagementStartDate().Keys("[End][BS][BS][BS][BS][BS][BS][BS][BS]");
    
    //Effacer l'objectif de placement
    Get_WinAccountInfo_TabInvestmentObjective().Click();
    Delay(1000);
    Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().set_IsChecked(false);
    
    //Effacer les indices par défaut
    Get_WinAccountInfo_TabDefaultIndices().Click();
    Delay(1000);
    var isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    while (isBtnRemoveIndicesEnabled){
        Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().Click();
        Delay(200);
        isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    }
    
    //Effacer les rapports par défaut
    Get_WinAccountInfo_TabDefaultReports().Click();
    Delay(1000);
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    //Valider les modifications
    Get_WinAccountInfo_BtnOK().Click();
}



function RestoreClient(clientNumber)
{
    //Ouvrir la fenêtre Info du compte
    Log.Message("Restore client N° " + clientNumber);
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    Delay(1000);
    
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Delay(1000);
    
    //Effacer l'objectif de placement
    Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
    Delay(1000);
    Get_WinInfo_TabInvestmentObjective_ChkInvestmentObjectiveForClientAndAccount().set_IsChecked(false);
    
    //Effacer les indices par défaut
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().Click();
    Delay(1000);
    var isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    while (isBtnRemoveIndicesEnabled){
        Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().Click();
        Delay(200);
        isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    }
    
    //Effacer les rapports par défaut
    Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
    Delay(1000);
    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    //Valider les modifications
    Delay(1000);
    Get_WinDetailedInfo_BtnOK().Click();
}





function PrepareClient(clientNumber, investmentObjective, arrayOfIndicesSymbols, arrayOfReportsNamesFrEn)
{
    //Ouvrir la fenêtre Info du client
    Log.Message("Prepare client N° " + clientNumber);
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    Delay(1000);
    
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Delay(1000);
    
    //Renseigner l'objectif de placement
    if (Trim(VarToStr(investmentObjective)) != ""){
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Delay(1000);

        SelectInvestmentObjectiveForClientAndAccount(investmentObjective);
    }
    
    //Renseigner les indices par défaut 
    if (Trim(VarToStr(arrayOfIndicesSymbols)) != ""){
    
        if ((GetVarType(arrayOfIndicesSymbols) != varArray) && (GetVarType(arrayOfIndicesSymbols) != varDispatch))
            arrayOfIndicesSymbols = new Array(arrayOfIndicesSymbols);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().Click();
        Delay(1000);
        
        SelectIndices(arrayOfIndicesSymbols);
    }
    
    //Renseigner les rapports par défaut
    if (Trim(VarToStr(arrayOfReportsNamesFrEn)) != ""){
    
        if ((GetVarType(arrayOfReportsNamesFrEn) != varArray) && (GetVarType(arrayOfReportsNamesFrEn) != varDispatch))
            Log.Error("Array expected!");
        
        arrayOfReportsNames = (language == "french")? arrayOfReportsNamesFrEn[0] : arrayOfReportsNamesFrEn[1];

        if ((GetVarType(arrayOfReportsNames) != varArray) && (GetVarType(arrayOfReportsNames) != varDispatch))
            arrayOfReportsNames = new Array(arrayOfReportsNames);
        
        
        Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
        Delay(1000);
        
        SelectReports(arrayOfReportsNames);
    }
    
    //Valider les modifications
    Delay(1000);
    Get_WinDetailedInfo_BtnOK().Click();
}


function PrepareRelationship(relationshipName, isGroupedRelation, relationshipIACode, relationshipCurrency, relationshipLanguage, investmentObjective, arrayOfIndicesSymbols, arrayOfReportsNamesFrEn)
{
    CreateRelationship(relationshipName, isGroupedRelation, relationshipIACode, relationshipCurrency, relationshipLanguage);
    
    //Ouvrir la fenêtre Info de la relation
    Log.Message("Prepare relationship " + relationshipName);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(1000);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
    Get_RelationshipsBar_BtnInfo().Click();
    Delay(1000);
    
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Delay(1000);
    
    //Renseigner l'objectif de placement
    if (Trim(VarToStr(investmentObjective)) != ""){
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective().Click();
        Delay(1000);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabInvestmentObjective_BtnInvestmentObjectiveForRelationship().Click();

        switch (investmentObjective){
            case "Basic_Global_Balanced":
                Get_LstInvestmentObjectivesForRelationship_ItemBasic_Balanced().Click();
                break;
                
            case "Firm_Global_Balanced":
                Get_LstInvestmentObjectivesForRelationship_ItemFirm_Balanced().Click();
                break;
            
            case "Firm_Global_Growth":
                Get_LstInvestmentObjectivesForRelationship_ItemFirm_Growth().Click();
                break;
            
            default:
                Log.Error(investmentObjective + " investment objective not covered !");
        }
    }
    
    //Renseigner les indices par défaut 
    if (Trim(VarToStr(arrayOfIndicesSymbols)) != ""){
    
        if ((GetVarType(arrayOfIndicesSymbols) != varArray) && (GetVarType(arrayOfIndicesSymbols) != varDispatch))
            arrayOfIndicesSymbols = new Array(arrayOfIndicesSymbols);
        
        Get_WinDetailedInfo_TabProductsAndServices_TabDefaultIndices().Click();
        Delay(1000);
        
        SelectIndices(arrayOfIndicesSymbols);
    }
    
    //Renseigner les rapports par défaut
    if (Trim(VarToStr(arrayOfReportsNamesFrEn)) != ""){
    
        if ((GetVarType(arrayOfReportsNamesFrEn) != varArray) && (GetVarType(arrayOfReportsNamesFrEn) != varDispatch))
            Log.Error("Array expected!");
        
        arrayOfReportsNames = (language == "french")? arrayOfReportsNamesFrEn[0] : arrayOfReportsNamesFrEn[1];

        if ((GetVarType(arrayOfReportsNames) != varArray) && (GetVarType(arrayOfReportsNames) != varDispatch))
            arrayOfReportsNames = new Array(arrayOfReportsNames);
        
        
        Get_WinDetailedInfo_TabProductsAndServices_TabDefaultReports().Click();
        Delay(1000);
        
        SelectReports(arrayOfReportsNames);
    }
    
    //Valider les modifications
    Delay(1000);
    Get_WinDetailedInfo_BtnOK().Click();
}




function SelectInvestmentObjectiveForClientAndAccount(investmentObjective)
{
    Get_WinInfo_TabInvestmentObjective_BtnSelectAnObjectiveForClientAndAccount().Click();
        
    switch (investmentObjective){
        case "Basic_Global_Balanced":
            Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemBasic_ItemGlobal_Balanced().Click();
            break;
                
        case "Firm_Global_Balanced":
            Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemFirm_ItemGlobal_Balanced().Click();
            break;
            
        case "Firm_Global_Growth":
            Get_WinSelectAnObjective_TvwObjectives_ItemGlobalAssetAllocations_ItemFirm_ItemGlobal_Growth().Click();
            break;
            
        default:
            Log.Error(investmentObjective + " investment objective not covered !");
    }
        
    Delay(1000);
    Get_WinSelectAnObjective_BtnOK().Click();
}



function SelectIndices(arrayOfIndicesSymbols)
{
    var isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    while (isBtnRemoveIndicesEnabled){
        Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().Click();
        Delay(200);
        isBtnRemoveIndicesEnabled = Get_WinInfo_TabDefaultIndices_BtnRemoveIndices().IsEnabled;
    }

    var availableIndicesCount = Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (var i = 0; i < availableIndicesCount; i++){
        var currentAvailableIndiceSymbol = Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Symbol();
        var isFound = false;
        for (j = 0; j < arrayOfIndicesSymbols.length; j++){
            if (VarToStr(currentAvailableIndiceSymbol) == arrayOfIndicesSymbols[j]){
                isFound = true;
                break;
            }
        }
            
        Get_WinInfo_TabDefaultIndices_GrpAvailableIndices_DgvAvailableIndices().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(isFound);
    }
        
    if (Get_WinInfo_TabDefaultIndices_BtnAddIndices().IsEnabled)
        Get_WinInfo_TabDefaultIndices_BtnAddIndices().Click(); 
}



function SelectReports(arrayOfReportsNames)
{
    if (GetVarType(arrayOfReportsNames) != varArray && GetVarType(arrayOfReportsNames) != varDispatch)
        arrayOfReportsNames = new Array(arrayOfReportsNames);

    if (Get_Reports_GrpReports_BtnRemoveAllReports().IsEnabled)
        Get_Reports_GrpReports_BtnRemoveAllReports().Click();

    var reportsCount = Get_Reports_GrpReports_TabReports_LvwReports().Items.get_Count();
    var nbOfSelectedReports = 0;
    Get_Reports_GrpReports_TabReports_LvwReports().Keys("[Home]");
    for (var i = 1; i < reportsCount; i++){
        var currentReportName = VarToStr(Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).WPFControlText);
        var isFound = false;
        for (j = 0; j < arrayOfReportsNames.length; j++){
            if (currentReportName == arrayOfReportsNames[j]){
                isFound = true;
                nbOfSelectedReports ++;
                break;
            }
        }
            
        if (isFound)
            Get_Reports_GrpReports_BtnAddAReport().Click();
        
        if (nbOfSelectedReports == arrayOfReportsNames.length)
            break;
        
        Get_Reports_GrpReports_TabReports_LvwReports().WPFObject("ListBoxItem", "", i).Keys("[Down]");
    }
}




function CreateRelationship(relationshipName, isGroupedRelation, relationshipIACode, relationshipCurrency, relationshipLanguage)
{
    Log.Message("Create the relationship \"" + relationshipName + "\".");
    
    Get_ModulesBar_BtnRelationships().Click();
    Delay(100);
    
    var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    if (searchResult.Exists){
        Log.Message("The relationship " + relationshipName + " already exists.");
    }
    else {
        ClickOnToolbarAddButton();
        Delay(100);
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        Delay(1000);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(relationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACode().set_Text(relationshipIACode);
        
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguageForRelationshipWhenIACodeIsTextbox().set_IsDropDownOpen(true);
        if (relationshipLanguage == "french" || relationshipLanguage == "FR")
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage_ItemFrench().Click();
        else
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbLanguage_ItemEnglish().Click();
            
        Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrencyForRelationshipWhenIACodeIsTextbox().set_IsDropDownOpen(true);
        switch (relationshipCurrency){
            case "CAD" :
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemCAD().Click();
                break;
                
            case "EUR" :
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemEUR().Click();
                break;
                
            case "NOK" :
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemNOK().Click();
                break;
                
            case "SEK" :
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemSEK().Click();
                break;
                
            case "USD" :
                Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbCurrency_ItemUSD().Click();
                break;
                
            default:
                Log.Error(relationshipCurrency + " currency not covered !");
        }
        
        if (isGroupedRelation){
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationshipWhenIACodeIsTextbox().set_IsDropDownOpen(true);
            Get_WinDetailedInfo_TabInfo_GrpGeneral_CmbTypeForRelationship_ItemGroupedRelation().Click();
        }
        
        Delay(1000);
        Get_WinDetailedInfo_BtnOK().Click();
    }
}