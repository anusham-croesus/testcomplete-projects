//USEUNIT SmokeTest_Common




/*
    Description : Valider les fonctionnalités du module Clients
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Faire un "info" sur un client déjà existant.
        2. Cliquer sur tous les onglets du client (Info, Adresses, Agenda, Produits et Services, Profil, Documents, Réseau d'influence et Campagnes) suivi de OK.
        3. Mailler un client dans le module Modèles/Relation/comptes/portefeuille et transactions.
    
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Clients()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Clients()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
        
        var clientsCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (clientsCount < 1){
            Log.Error("There is no record in the grid.");
            return;
        }
        
        var arrayOfClientsNames = new Array();
        var arrayOfClientsNumbers = new Array();
        for (var i = 0; i < clientsCount; i++){
            arrayOfClientsNumbers.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber));
            arrayOfClientsNames.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Name));
        }
        
        //Get a random Client
        var clientIndex = Math.round(Math.random()*(clientsCount - 1));
        var clientName = arrayOfClientsNames[clientIndex];
        var clientNumber = arrayOfClientsNumbers[clientIndex];
        Log.Message("Random Client : " + clientName + ", number : " + clientNumber);
        
        
        //1. Faire un "info" sur un client déjà existant.
        Log.Message('1. Faire un "info" sur un client déjà existant.', "", pmNormal, logAttributes);
        Search_Client(clientNumber);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
        Get_ClientsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains, clientName, true);
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains, clientNumber, true);
        
        
        //2. Cliquer sur tous les onglets du client (Info, Adresses, Agenda, Produits et Services, Profil, Documents, Réseau d'influence et Campagnes) suivi de OK.
        Log.Message("2. Cliquer sur tous les onglets du client (Info, Adresses, Agenda, Produits et Services, Profil, Documents, Réseau d'influence et Campagnes) suivi de OK.", "", pmNormal, logAttributes);
        
        Log.Message("Click on 'Info' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabInfo().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Addresses' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabAddresses().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Agenda' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabAgendaForClient().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAgendaForClient(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Products & Services' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabProductsAndServices() .Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Profile' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabProfile().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabProfile(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Documents' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabDocuments().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Client Network' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabClientNetworkForClient().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabClientNetworkForClient(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Campaigns' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabCampaignsForClient().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabCampaignsForClient(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'OK' button and check if the Client Info window has disappeared.");
        Get_WinDetailedInfo_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "*" + clientName + "*" + clientNumber + "*"], 30000);
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Exists", cmpEqual, false, true);
        
        
        //3. Mailler un client dans le module Modèles/Relation/comptes/portefeuille et transactions.
        Log.Message('3. Mailler un client dans le module Modèles/Relation/comptes/portefeuille et transactions.', "", pmNormal, logAttributes);
        CheckDragClientToModules(clientNumber, "MENU BAR");
        CheckDragClientToModules(clientNumber, "SHORT KEYS");
        CheckDragClientToModules(clientNumber, "DRAG AND DROP");
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function CheckDragClientToModules(clientNumber, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK CLIENT DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    
    Search_Client(clientNumber);
    var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10);
    
    clientNumberCell.Click();
    
    //Check if the client has some accounts
    Log.Message("Check if the client has some accounts.")
    Get_RelationshipsClientsAccountsDetails().set_IsExpanded(true);

    var AccountText = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR1793", "AccountText", language + client);
    
    var arrayOfDataRecordPresenterHierarchyObjects = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindAllChildren(["ClrClassName", "IsVisible"], ["DataRecordPresenter", "*"], 100).toArray();
    for (var i in arrayOfDataRecordPresenterHierarchyObjects)
        arrayOfDataRecordPresenterHierarchyObjects[i].set_IsExpanded(true);
        
    var arrayOfExpandableFieldRecordPresenterHierarchyObjects = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().FindAllChildren(["ClrClassName", "IsVisible"], ["ExpandableFieldRecordPresenter", "*"], 100).toArray();
    for (var i in arrayOfExpandableFieldRecordPresenterHierarchyObjects)
        arrayOfExpandableFieldRecordPresenterHierarchyObjects[i].set_IsExpanded(true);
    
    var accountDataRecordPresenterHierarchyObject = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find(["ClrClassName", "VisibleOnScreen", "Description"], ["DataRecordPresenter", true, AccountText], 100);
    var accountExpandableFieldRecordPresenterHierarchyObject = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find(["ClrClassName", "VisibleOnScreen", "Description"], ["ExpandableFieldRecordPresenter", true, AccountText], 100);
    var doesClientContainNoAccount = (!accountDataRecordPresenterHierarchyObject.Exists && !accountExpandableFieldRecordPresenterHierarchyObject.Exists);

    
    Log.Message("Use " + dragMethod + " to Drag client '" + clientNumber + "' to the Models module.");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(clientNumberCell);
    else {
        clientNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag client '" + clientNumber + "' to the Relationships module.");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(clientNumberCell);
    else {
        clientNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag client '" + clientNumber + "' to the Accounts module.");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToAccountsByDragAndDrop(clientNumberCell);
    else {
        clientNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToAccountsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToAccountsByMenuBar();
    }
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag client '" + clientNumber + "' to the Portfolio module.");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(clientNumberCell);
    else {
        clientNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    
    if (Get_DlgInformation().Exists){
        if (!doesClientContainNoAccount)
            Log.Error("Client '" + clientNumber + "' contains some account, Information dialog box should not be displayed, that is not the case.")

        Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    }
    else {
        if (doesClientContainNoAccount)
            Log.Error("Client '" + clientNumber + "' contains no account, Information dialog box should be displayed, that is not the case.")
        
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
    }
    
    
    Log.Message("Use " + dragMethod + " to Drag client '" + clientNumber + "' to the Transactions module.");
    Get_ModulesBar_BtnClients().Click();
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToTransactionsByDragAndDrop(clientNumberCell);
    else {
        clientNumberCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToTransactionsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToTransactionsByMenuBar();
    }
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
}
