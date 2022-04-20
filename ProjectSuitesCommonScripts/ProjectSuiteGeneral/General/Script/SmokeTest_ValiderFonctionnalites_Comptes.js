//USEUNIT SmokeTest_Common




/*
    Description : Valider les fonctionnalités du module Comptes
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Faire un "info" sur un compte déjà existant.
        2. Cliquer sur tous les onglets du compte (Notes, Objectif de placement, Rapports par défaut, Indices par défaut, Profil, Dates - et éventuellement Détenteurs, Comptes enregistrés, GP1859, Segments, Gestion de l'encaisse - suivi de OK.
        3. Mailler un compte dans le module Modèles/ Relation/clients/portefeuille et transactions.
    
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Comptes()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Comptes()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        
        var accountsCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (accountsCount < 1){
            Log.Error("There is no record in the grid.");
            return;
        }
        
        var arrayOfAccountsNames = new Array();
        var arrayOfAccountsNumbers = new Array();
        for (var i = 0; i < accountsCount; i++){
            arrayOfAccountsNumbers.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.accountNumber));
            arrayOfAccountsNames.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Name));
        }
        
        //Get a random Account
        var accountIndex = Math.round(Math.random()*(accountsCount - 1));
        var accountName = arrayOfAccountsNames[accountIndex];
        var accountNumber = arrayOfAccountsNumbers[accountIndex];
        Log.Message("Random Account : " + accountName + ", number : " + accountNumber);
        
        
        //1. Faire un "info" sur un compte déjà existant.
        Log.Message('1. Faire un "info" sur un compte déjà existant.', "", pmNormal, logAttributes);
        SearchAccount(accountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10).Click();
        Get_AccountsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtShortName().Text, "OleValue", cmpEqual, accountName, true);
        aqObject.CheckProperty(Get_WinAccountInfo_GrpAccount_TxtAccountNumber().Text, "OleValue", cmpEqual, accountNumber, true);
        
        
        //2. Cliquer sur tous les onglets du compte (Notes, Objectif de placement, Rapports par défaut, Indices par défaut, Profil, Dates - et éventuellement Détenteurs, Comptes enregistrés, GP1859, Segments, Gestion de l'encaisse - suivi de OK.
        Log.Message("2. Cliquer sur tous les onglets du compte (Notes, Objectif de placement, Rapports par défaut, Indices par défaut, Profil, Dates - et éventuellement Détenteurs, Comptes enregistrés, GP1859, Segments, Gestion de l'encaisse - suivi de OK.", "", pmNormal, logAttributes);
        
        Log.Message("Click on 'Notes' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabNotes().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabNotes(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Investment Objective' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabInvestmentObjective().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabInvestmentObjective(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Default Reports' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabDefaultReports().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultReports(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Default Indices' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabDefaultIndices() .Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabDefaultIndices(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Profile' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabProfile().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabProfile(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Dates' tab and check if the tab is selected.");
        Get_WinAccountInfo_TabDates().Click();
        aqObject.CheckProperty(Get_WinAccountInfo_TabDates(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Holders' tab and check if the tab is selected.");
        if (Get_WinAccountInfo_TabHolders().Exists){
            Get_WinAccountInfo_TabHolders().Click();
            aqObject.CheckProperty(Get_WinAccountInfo_TabHolders(), "IsSelected", cmpEqual, true, true);
        }
        else
            Log.Message("'Holders' tab does not exists.");
        
        Log.Message("Click on 'Registered Accounts' tab and check if the tab is selected.");
        if (Get_WinAccountInfo_TabRegisteredAccounts().Exists){
            Get_WinAccountInfo_TabRegisteredAccounts().Click();
            aqObject.CheckProperty(Get_WinAccountInfo_TabRegisteredAccounts(), "IsSelected", cmpEqual, true, true);
        }
        else
            Log.Message("'Registered Accounts' tab does not exists.");
        
        Log.Message("Click on 'PW1859' tab and check if the tab is selected.");
        if (Get_WinAccountInfo_TabPW1859().Exists){
            Get_WinAccountInfo_TabPW1859().Click();
            aqObject.CheckProperty(Get_WinAccountInfo_TabPW1859(), "IsSelected", cmpEqual, true, true);
        }
        else
            Log.Message("'PW1859' tab does not exists.");
        
        Log.Message("Click on 'Sleeves' tab and check if the tab is selected.");
        if (Get_WinAccountInfo_TabSleeves().Exists){
            Get_WinAccountInfo_TabSleeves().Click();
            aqObject.CheckProperty(Get_WinAccountInfo_TabSleeves(), "IsSelected", cmpEqual, true, true);
        }
        else
            Log.Message("'Sleeves' tab does not exists.");
        
        Log.Message("Click on 'Cash Management' tab and check if the tab is selected.");
        if (Get_WinAccountInfo_TabCashManagement().Exists){
            Get_WinAccountInfo_TabCashManagement().Click();
            aqObject.CheckProperty(Get_WinAccountInfo_TabCashManagement(), "IsSelected", cmpEqual, true, true);
        }
        else
            Log.Message("'Cash Management' tab does not exists.");
        
        Log.Message("Click on 'OK' button and check if the Account Info window has disappeared.");
        Get_WinAccountInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", GetData(filePath_Accounts, "AccountInfo", 2, language)], 30000);
        aqObject.CheckProperty(Get_WinAccountInfo(), "Exists", cmpEqual, false, true);
        
        
        //3. Mailler un compte dans le module Modèles/ Relation/clients/portefeuille et transactions.
        Log.Message('3. Mailler un compte dans le module Modèles/ Relation/clients/portefeuille et transactions.', "", pmNormal, logAttributes);
        CheckDragAccountToModules(accountNumber, "MENU BAR");
        CheckDragAccountToModules(accountNumber, "SHORT KEYS");
        CheckDragAccountToModules(accountNumber, "DRAG AND DROP");
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function CheckDragAccountToModules(accountNumber, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK ACCOUNT DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    
    SearchAccount(accountNumber);
    var accountNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10);
    
    accountNumberCell.Click();
    
    Log.Message("Use " + dragMethod + " to Drag account '" + accountNumber + "' to the Models module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(accountNumberCell);
    else {
        accountNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag account '" + accountNumber + "' to the Relationships module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(accountNumberCell);
    else {
        accountNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag account '" + accountNumber + "' to the Clients module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(accountNumberCell);
    else {
        accountNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag account '" + accountNumber + "' to the Portfolio module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(accountNumberCell);
    else {
        accountNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
    
    Log.Message("Use " + dragMethod + " to Drag account '" + accountNumber + "' to the Transactions module.");
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToTransactionsByDragAndDrop(accountNumberCell);
    else {
        accountNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToTransactionsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToTransactionsByMenuBar();
    }
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
}
