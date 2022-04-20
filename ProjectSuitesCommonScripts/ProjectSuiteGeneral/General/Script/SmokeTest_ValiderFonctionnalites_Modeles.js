//USEUNIT SmokeTest_Common



/*
    Description : Valider les fonctionnalités du module Modèles
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Faire un "info" sur un modèle déjà existant suivi de Fermer.
        2. Cliquer dans les onglets de la partie Détails du modèle (onglets : Portefeuilles associés, Positions, Sommaire et Critères de rééquilibrage).
        3. Mailler un modèle dans le module Relation/Clients/Comptes/Portefeuille
    
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Modeles()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Modeles()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        
        var modelsCount = VarToInt(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (modelsCount < 1){
            Log.Error("There is no record in the grid.");
            return;
        }
        
        var arrayOfModelsNumbers = new Array();
        var arrayOfModelsNames = new Array();
        for (var i = 0; i < modelsCount; i++){
            arrayOfModelsNumbers.push(VarToStr(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber));
            arrayOfModelsNames.push(VarToStr(Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Name.OleValue));
        }
        
        //Get a random Model
        var modelIndex = Math.round(Math.random()*(modelsCount - 1));
        var modelName = arrayOfModelsNames[modelIndex];
        var modelNumber = arrayOfModelsNumbers[modelIndex];
        Log.Message("Random Model : " + modelName + ", number : " + modelNumber);

        
        //1. Faire un "info" sur un modèle déjà existant suivi de Fermer.
        Log.Message('1. Faire un "info" sur un modèle déjà existant suivi de Fermer ou OK.', "", pmNormal, logAttributes);
        SearchModelByName(modelName);
        Get_ModelsGrid().FindChild("Value", modelName, 10).Click();
        Get_ModelsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinModelInfo(), "Title", cmpContains, modelName, true);
        aqObject.CheckProperty(Get_WinModelInfo(), "Title", cmpContains, modelNumber, true);
        
        if (Get_WinModelInfo_GrpModel_ChkActive().IsEnabled){
            Log.Message("La case à cocher Actif de la fenêtre 'Info Modèle' est active, cliquer sur le bouton 'OK'.");
            Get_WinModelInfo_BtnOK().Click();
        }
        else {
            Log.Message("La case à cocher Actif de la fenêtre 'Info Modèle' n'est pas active, cliquer sur le bouton 'Fermer'.");
            Get_WinModelInfo_BtnClose().Click();
        }
        
        SetAutoTimeOut();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "InfoModelWindow_b101", 30000);
        aqObject.CheckProperty(Get_WinModelInfo(), "Exists", cmpEqual, false, true);
        RestoreAutoTimeOut();
        
        
        //2. Cliquer dans les onglets de la partie Détails du modèle (onglets : Portefeuilles associés, Positions, Sommaire et Critères de rééquilibrage).
        Log.Message('2. Cliquer dans les onglets de la partie Détails du modèle (onglets : Portefeuilles associés, Positions, Sommaire et Critères de rééquilibrage).', "", pmNormal, logAttributes);
        Get_Models_Details().set_IsExpanded(true);
        
        Log.Message("Click on Assigned Portfolios tab and check if the tab is selected.");
        Get_Models_Details_TabAssignedPortfolios().Click();
        aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on Positions tab and check if the tab is selected.");
        Get_Models_Details_TabPositions().Click();
        aqObject.CheckProperty(Get_Models_Details_TabPositions(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on Summary tab and check if the tab is selected.");
        Get_Models_Details_TabSummary() .Click();
        aqObject.CheckProperty(Get_Models_Details_TabSummary(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Click on Rebalancing Criteria tab and check if the tab is selected.");
        Get_Models_Details_TabRebalancingCriteria().Click();
        aqObject.CheckProperty(Get_Models_Details_TabRebalancingCriteria(), "IsSelected", cmpEqual, true, true);
        
        
        //3. Mailler un modèle dans le module Relation/Clients/Comptes/Portefeuille et Transactions
        Log.Message('3. Mailler un modèle dans le module Relation/Clients/Comptes/Portefeuille et Transactions.', "", pmNormal, logAttributes);
        CheckDragModelToModules(modelName, "MENU BAR");
        CheckDragModelToModules(modelName, "SHORT KEYS");
        CheckDragModelToModules(modelName, "DRAG AND DROP");
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
    
}



function CheckDragModelToModules(modelName, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK MODEL DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    
    SearchModelByName(modelName);
    var modelCell = Get_ModelsGrid().FindChild("Value", modelName, 10);
    
    Log.Message("Use " + dragMethod + " to Drag model '" + modelName + "' to the Relationships module.");
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(modelCell);
    else {
        modelCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    
    Log.Message("Use " + dragMethod + " to Drag model '" + modelName + "' to the Clients module.");
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(modelCell);
    else {
        modelCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag model '" + modelName + "' to the Accounts module.");
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToAccountsByDragAndDrop(modelCell);
    else {
        modelCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToAccountsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToAccountsByMenuBar();
    }
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag model '" + modelName + "' to the Portfolio module.");
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(modelCell);
    else {
        modelCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
}
