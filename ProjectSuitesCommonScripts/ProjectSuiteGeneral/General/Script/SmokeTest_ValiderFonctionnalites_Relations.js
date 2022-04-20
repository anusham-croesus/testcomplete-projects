//USEUNIT SmokeTest_Common




/*
    Description : Valider les fonctionnalités du module Relations
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Faire un "info" sur une relation déjà existante.
        2. Cliquer sur tous les onglets de la relation (Info, Adresses, Produits et Services, Profil, Comptes sous-jacents et Documents) suivi de OK.
        3. Mailler une relation dans le module Modèles/clients/comptes/portefeuille et transactions.
    
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Relations()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Relations()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
        
        var relationshipsCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (relationshipsCount < 1){
            Log.Error("There is no record in the grid.");
            return;
        }
        
        var arrayOfRelationshipsNames = new Array();
        var arrayOfRelationshipsNumbers = new Array();
        for (var i = 0; i < relationshipsCount; i++){
            arrayOfRelationshipsNumbers.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.LinkNumber.OleValue));
            arrayOfRelationshipsNames.push(VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ShortName.OleValue));
        }
        
        //Get a random Relationship
        var relationshipIndex = Math.round(Math.random()*(relationshipsCount - 1));
        var relationshipName = arrayOfRelationshipsNames[relationshipIndex];
        var relationshipNumber = arrayOfRelationshipsNumbers[relationshipIndex];
        Log.Message("Random Relationship : " + relationshipName + ", number : " + relationshipNumber);

        
        //1. Faire un "info" sur une relation déjà existante.
        Log.Message('1. Faire un "info" sur une relation déjà existante.', "", pmNormal, logAttributes);
        SearchRelationshipByName(relationshipName);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10).Click();
        Get_RelationshipsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains, relationshipName, true);
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Title", cmpContains, relationshipNumber, true);
        
        
        //2. Cliquer sur tous les onglets de la relation (Info, Adresses, Produits et Services, Profil, Comptes sous-jacents et Documents) suivi de OK.
        Log.Message('2. Cliquer sur tous les onglets de la relation (Info, Adresses, Produits et Services, Profil, Comptes sous-jacents et Documents) suivi de OK.', "", pmNormal, logAttributes);
        
        Log.Message("Click on 'Info' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabInfo().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabInfo(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Addresses' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabAddresses().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabAddresses(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Products & Services' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabProductsAndServices() .Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Profile' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabProfile().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabProfile(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Underlying Accounts' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabUnderlyingAccountsForRelationship(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'Documents' tab and check if the tab is selected.");
        Get_WinDetailedInfo_TabDocuments().Click();
        aqObject.CheckProperty(Get_WinDetailedInfo_TabDocuments(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on 'OK' button and check if the Relationship Info window has disappeared.");
        Get_WinDetailedInfo_BtnOK().Click();
        SetAutoTimeOut();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "Title"], ["UniDialog", "*" + relationshipName + "*" + relationshipNumber + "*"], 30000);
        aqObject.CheckProperty(Get_WinDetailedInfo(), "Exists", cmpEqual, false, true);
        RestoreAutoTimeOut();
        
        
        //3. Mailler une relation dans le module Modèles/clients/comptes/portefeuille et transactions.
        Log.Message('3. Mailler une relation dans le module Modèles/clients/comptes/portefeuille et transactions.', "", pmNormal, logAttributes);
        CheckDragRelationshipToModules(relationshipName, "MENU BAR");
        CheckDragRelationshipToModules(relationshipName, "SHORT KEYS");
        CheckDragRelationshipToModules(relationshipName, "DRAG AND DROP");
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function CheckDragRelationshipToModules(relationshipName, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK RELATIONSHIP DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    
    SearchRelationshipByName(relationshipName);
    var relationshipCell = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
    
    relationshipCell.Click();
    Get_RelationshipsClientsAccountsDetails().set_IsExpanded(true);
    var RelationDetailAccount = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1793", "RelationDetailAccount", language + client);
    var accountHierarchyObject = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel().Find("Description", RelationDetailAccount, 10);
    var doesRelationshipContainNoAccount = !(accountHierarchyObject.Exists && accountHierarchyObject.VisibleOnScreen);
    
    Log.Message("Use " + dragMethod + " to Drag relationship '" + relationshipName + "' to the Models module.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(relationshipCell);
    else {
        relationshipCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    
    Log.Message("Use " + dragMethod + " to Drag relationship '" + relationshipName + "' to the Clients module.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(relationshipCell);
    else {
        relationshipCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag relationship '" + relationshipName + "' to the Accounts module.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToAccountsByDragAndDrop(relationshipCell);
    else {
        relationshipCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToAccountsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToAccountsByMenuBar();
    }
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag relationship '" + relationshipName + "' to the Portfolio module.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(relationshipCell);
    else {
        relationshipCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    
    if (!doesRelationshipContainNoAccount){
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
        aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
    }
    else {
        Log.Message("Relationship '" + relationshipName + "' contains no account, Information dialog box should be displayed, and we should remain in the Relationships module.");
        if (aqObject.CheckProperty(Get_DlgInformation(), "Exists", cmpEqual, true, true))
            Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    }
    
    Log.Message("Use " + dragMethod + " to Drag relationship '" + relationshipName + "' to the Transactions module.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToTransactionsByDragAndDrop(relationshipCell);
    else {
        relationshipCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToTransactionsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToTransactionsByMenuBar();
    }
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
}
