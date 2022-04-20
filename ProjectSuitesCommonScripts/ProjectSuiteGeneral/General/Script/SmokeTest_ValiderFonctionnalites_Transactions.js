//USEUNIT SmokeTest_Common




/*
    Description : Valider les fonctionnalités du module Transactions
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Avoir mailler un compte dans le module Transactions
        2. Faire "info" sur une transaction. Cliquer sur l'onglet "Gains/Pertes" et faire OK.
        3. Mailler une transaction dans le module Modèles/ Relation/clients/comptes /portefeuille et Titres.
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Transactions()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Transactions()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var winInfoTransactionTitle = GetData(filePath_Transactions, "Info", 2, language);
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        var accountsCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (accountsCount < 1){
            Log.Error("There is no record in the grid.");
            return;
        }
        
        var arrayOfAccountsNumbers = new Array();
        for (var i = 0; i < accountsCount; i++)
            arrayOfAccountsNumbers.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.accountNumber));
        
        var maxNbOfTries = 50;
        for (var i = 1; i <= maxNbOfTries; i++){
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            
            //Get a random Account
            var accountIndex = Math.round(Math.random()*(accountsCount));
            var accountNumber = arrayOfAccountsNumbers[accountIndex];
            Log.Message("Random Account number : " + accountNumber);
        
            //1. Avoir maillé un compte dans le module Transactions
            Log.Message("1. Mailler le compte '" + accountNumber + "' dans le module Transactions.", "", pmNormal, logAttributes);
            SearchAccount(accountNumber);
            Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10).Click();
            DragToTransactionsByMenuBar();
            Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
            aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
            
            var transactionsCount = VarToInt(Get_Transactions_ListView().Items.Count);
            if (transactionsCount > 0)
                break;
        }
        
        if (transactionsCount < 1)
            return Log.Error("No account with transactions found after " + maxNbOfTries + " tries.");
        
        //Get a random Transaction
        var isTransactionFound = false;
        for (var j = 1; j <= maxNbOfTries; j++){
            var transactionIndex = Math.round(Math.random()*(transactionsCount));
            
            if (!Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", transactionIndex], 10).Exists)
                continue;
            
            var transactionCell = Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", transactionIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["BrowserCellTemplateSimple", 1], 10);
            var isTransactionFound = (transactionCell.Exists && transactionCell.VisibleOnScreen);
            if (isTransactionFound)
                break;
        }
        
        if (!isTransactionFound)
            return Log.Error("No transaction found after " + maxNbOfTries + " tries.");
        
        
        //2. Faire "info" sur une transaction. Cliquer sur l'onglet "Gains/Pertes" et faire OK.
        Log.Message("2. Faire 'info' sur une transaction. Cliquer sur l'onglet 'Gains/Pertes' et faire OK.", "", pmNormal, logAttributes);
        transactionCell.Click();
        
        Log.Message("Cliquer sur 'Info' et vérifier si la fenêtre 'Info Transactions' est affichée.");
        Get_TransactionsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinTransactionsInfo(), "VisibleOnScreen", cmpEqual, true, true);
        aqObject.CheckProperty(Get_WinTransactionsInfo().Title, "OleValue", cmpEqual, winInfoTransactionTitle, true);
        
        Log.Message("Cliquer sur l'onglet 'Gains/Pertes' et vérifier qu'il est sélectionné.");
        Get_WinTransactionsInfo_TabGainsLosses().Click();
        aqObject.CheckProperty(Get_WinTransactionsInfo_TabGainsLosses(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'OK' button and check if the 'Transactions Info' window has disappeared.");
        Get_WinTransactionsInfo_BtnOK().Click();
        SetAutoTimeOut();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", winInfoTransactionTitle], 30000);
        aqObject.CheckProperty(Get_WinTransactionsInfo(), "Exists", cmpEqual, false, true);
        RestoreAutoTimeOut();
        
        
        //3. Mailler une transaction dans le module Modèles/ Relation/clients/comptes /portefeuille et Titres.
        Log.Message('3. Mailler un compte dans le module Modèles/ Relation/clients/portefeuille et transactions.', "", pmNormal, logAttributes);
        CheckDragTransactionToModules(transactionCell, "MENU BAR");
        CheckDragTransactionToModules(transactionCell, "SHORT KEYS");
        CheckDragTransactionToModules(transactionCell, "DRAG AND DROP");
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function CheckDragTransactionToModules(transactionCell, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK TRANSACTION DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Models module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Relationships module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Clients module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Accounts module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToAccountsByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToAccountsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToAccountsByMenuBar();
    }
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Portfolio module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
    
    Log.Message("Use " + dragMethod + " to Drag Transaction to the Securities module.");
    Get_ModulesBar_BtnTransactions().Click();
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToSecuritiesByDragAndDrop(transactionCell);
    else {
        transactionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToSecuritiesByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToSecuritiesByMenuBar();
    }
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnSecurities().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
}
