//USEUNIT SmokeTest_Common




/*
    Description : Valider les fonctionnalités du module Portefeuille
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Avoir mailler un compte dans le module Portefeuilles
        2. Faire "info" sur une position(différent de Encaisse). Cliquer sur l'onglet "Détails" et faire OK.
        3. Mailler une position dans le module Modèles/ Relation/clients/portefeuille/transactions et Titres.
        4. Sélectionner plusieurs positions/Add note, Résultat attendu: Date de réference == date de création
        5. Modifier une position qui a une note. Résultat attendu: Date de référence ne doit pas être vide et l'utilisateur peut le modifier
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Portefeuille()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Portefeuille()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var arrayOfPreviousPositionsHavingNote = Execute_SQLQuery_GetFieldAllValues("select POSITION_ID from B_PORTEF where HAS_NOTE = 'Y'", vServerGeneral, "POSITION_ID");
        var noteText = "Add Note for SmokeTest_ValiderFonctionnalites_Portefeuille - " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
        var noteTextUpdate = "Update Note for SmokeTest_ValiderFonctionnalites_Portefeuille - " + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d_%H%M%S");
        var dateStrFormat = (language == "french")? "%Y/%m/%d": "%m/%d/%Y";
        var maxNbOfPositionsForNoteCheck = 3;
        var cashSubcategory = GetData(filePath_Portefeuille, "Info", 154, language);
        var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SmokeTest_ValiderFonctionnalites_Portefeuille_NumeroCompte", language + client);
        var noteEffectiveDateEmpty = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "SmokeTest_ValiderFonctionnalites_Portefeuille_NoteDateReferenceVide", language + client);
        
        //1. Avoir maillé un compte dans le module Portefeuille.
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        Log.Message("1. Mailler le compte '" + accountNumber + "' dans le module Portefeuille.", "", pmNormal, logAttributes);
        DragAccountNumberToPortFolio(accountNumber);
        
        //2. Faire "info" sur une position (différent de Encaisse). Cliquer sur l'onglet "Détails" et faire OK.
        Log.Message("2. Faire 'info' sur une position (différent de Encaisse). Cliquer sur l'onglet 'Détails' et faire OK.", "", pmNormal, logAttributes);

        //Add Subcategory column
        Get_Portfolio_PositionsGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        Get_Portfolio_PositionsGrid_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().Click();
        Get_GridHeader_ContextualMenu_AddColumn_Subcategory().Click();
        
        //Get a Position different from Cash
        Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "IsActive"], ["DataRecordPresenter", false, true], 10).Click();
        var portfolioCount = VarToInt(Get_Portfolio_PositionsGrid().Items.Count);
        var subcategoryColumnIndex = Get_Portfolio_PositionsGrid_ChSubcategory().WPFControlOrdinalNo;
        var accountNoColumnIndex = Get_Portfolio_PositionsGrid_ChAccountNo().WPFControlOrdinalNo;
        var isPositionFound = false;
        for (var j = 1; j <= portfolioCount; j++){
            var positionRow = null;
            positionRow = Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "IsSelected"], ["DataRecordPresenter", false, true], 10);
            if (positionRow == null || !positionRow.Exists)
                continue;
            
            var positionCell = positionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountNoColumnIndex], 10);
            var subcategoryValue = positionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", subcategoryColumnIndex], 10).WPFControlText;
            var isPositionFound = (positionCell.Exists && positionCell.VisibleOnScreen && subcategoryValue != cashSubcategory);
            if (isPositionFound)
                break;
            
            Get_Portfolio_PositionsGrid().Keys("[Down]");
            WaitObject(positionRow, "IsSelected", false);
        }
        
        if (!isPositionFound)
            return Log.Error("No position different from Cash found.");
        
        positionCell.Click();
        
        Log.Message("Cliquer sur 'Info' et vérifier si la fenêtre 'Info Position' est affichée.");
        Get_PortfolioBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinPositionInfo(), "VisibleOnScreen", cmpEqual, true, true);
        
        Log.Message("Cliquer sur l'onglet 'Détails' et vérifier qu'il est sélectionné.");
        Get_WinPositionInfo_TabDetails().Click();
        Get_WinPositionInfo_TabDetails().WaitProperty("IsSelected", true, 60000);
        aqObject.CheckProperty(Get_WinPositionInfo_TabDetails(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Cliquer sur le bouton 'OK' et vérifier que la fenêtre 'Info Position' est fermée.");
        var WinPositionInfoUid = VarToStr(Get_WinPositionInfo().Uid);
        Get_WinPositionInfo_BtnOK().Click();
        SetAutoTimeOut();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["Uid"], [WinPositionInfoUid], 30000);
        aqObject.CheckProperty(Get_WinPositionInfo(), "Exists", cmpEqual, false, true);
        RestoreAutoTimeOut();
        
        
        //3. Mailler une position dans le module Modèles/ Relation/clients/portefeuille/transactions et Titres.
        Log.Message('3. Mailler une position dans le module Modèles/ Relation/clients/portefeuille/transactions et Titres.', "", pmNormal, logAttributes);
        CheckDragPositionToModules(positionCell, "MENU BAR");
        CheckDragPositionToModules(positionCell, "SHORT KEYS");
        CheckDragPositionToModules(positionCell, "DRAG AND DROP");
        
        //4. Sélectionner plusieurs positions/Add note, Résultat attendu: Date de réference == date de création
        Log.Message('3. Sélectionner plusieurs positions/Add note, Résultat attendu: Date de réference == date de création', "", pmNormal, logAttributes);
        DragAccountNumberToPortFolio(accountNumber);
        var arrayOfSelectedPositionsIndexes = [], lastPositionRowIndex, lastPositionCell;
        for (var positionIndex = 1; positionIndex <= portfolioCount; positionIndex++){
            if (arrayOfSelectedPositionsIndexes.length >= maxNbOfPositionsForNoteCheck)
                break;
            
            var isPositionToBeSelected = (Math.round(Math.random()*(1)) == 0);
            
            var positionRow = null;
            positionRow = Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "VisibleOnScreen", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, true, positionIndex], 10);
            if (positionRow == null || !positionRow.Exists)
                continue;
            
            var positionCell = positionRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountNoColumnIndex], 10);
            var isPositionFound = (positionCell.Exists && positionCell.VisibleOnScreen);
            if (isPositionFound && isPositionToBeSelected){
                if (arrayOfSelectedPositionsIndexes.length == 0)
                    positionCell.Click();
                else
                    positionCell.Click(-1, -1, skCtrl);
                arrayOfSelectedPositionsIndexes.push(positionRow.WPFControlOrdinalNo);
            }
            
            lastPositionRowIndex = positionRow.WPFControlOrdinalNo;
            lastPositionCell = positionCell;
            Delay(1000);
        }
        
        //Si la dernière cellule n'est pas sélectionnée, la sélectionner
        if (!lastPositionCell.IsRecordSelected){
            if (arrayOfSelectedPositionsIndexes.length == 0)
                lastPositionCell.Click();
            else
                lastPositionCell.Click(-1, -1, skCtrl);
            
            arrayOfSelectedPositionsIndexes.push(lastPositionRowIndex);
        }
        
        //Faire Click droit.
        lastPositionCell.ClickR();
        
        
        Get_PortfolioGrid_ContextualMenu_AddANote().Click();
        CheckEquals(VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue), noteEffectiveDateEmpty, "Note Effective Date");
        
        //Ajouter une note et sauvegarder
        Get_WinCRUANote_GrpNote_TxtNote().Clear()
        Get_WinCRUANote_GrpNote_TxtNote().Keys(noteText);
        SetDateInDateTimePicker(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), aqString.SubString(VarToStr(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().Text), 0, 10));
        Get_WinCRUANote_BtnSave().Click();
        
        DragAccountNumberToPortFolio(accountNumber);
        var arrayOfPositionsWithNoteOKIndexes = [];
        for (var i = 0; i < arrayOfSelectedPositionsIndexes.length; i++){
            var positionIndex = arrayOfSelectedPositionsIndexes[i];
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "VisibleOnScreen", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, true, positionIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountNoColumnIndex], 10).Click();
            Get_PortfolioBar_BtnInfo().Click();
            Get_WinPositionInfo().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
            
            if (OpenANoteHavingText(noteText)){
                var isNoteOK = CheckEquals(VarToStr(Get_WinCRUANote_GrpNote_TxtNote().Text), noteText, "Note Text");
                var isEffectiveDateOK = CheckEquals(VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue), aqString.SubString(VarToStr(Get_WinCRUANote_TxtCreationDateForPositionAndSecurity().Text), 0, 10), "Note Effective Date");
                if (isNoteOK === true && isEffectiveDateOK === true)
                    arrayOfPositionsWithNoteOKIndexes.push(positionIndex)
                
                Get_WinCRUANote_BtnClose().Click();
            }
            
            Get_WinPositionInfo_BtnCancel().Click();
        }
        
        //5. Modifier une position qui a une note. Résultat attendu: Date de référence ne doit pas être vide et l'utilisateur peut le modifier
        Log.Message("5. Modifier une position qui a une note. Résultat attendu: Date de référence ne doit pas être vide et l'utilisateur peut le modifier", "", pmNormal, logAttributes);
        if (arrayOfPositionsWithNoteOKIndexes.length == 0)
            Log.Error("Aucune position validée avec succès (à l'étape précédente) au regard du texte et de la date de référence de la note.");
        else {
            var positionIndex = ShuffleArray(arrayOfPositionsWithNoteOKIndexes)[0];
            DragAccountNumberToPortFolio(accountNumber);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "VisibleOnScreen", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, true, positionIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountNoColumnIndex], 10).Click();
            Get_PortfolioBar_BtnInfo().Click();
            Get_WinPositionInfo().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
            
            var isANoteUpdated = false;
            if (OpenANoteHavingText(noteText)){
                if (CompareProperty(VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue), cmpNotEqual, noteEffectiveDateEmpty, true, lmError)){
                    Log.Message("Modifier la note et sauvegarder.");
                    var effectiveDateYesterday = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(aqDateTime.Now(), -1), dateStrFormat);
                    var effectiveDateTwoDaysAgo= aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(aqDateTime.Now(), -2), dateStrFormat);
                    var effectiveDateUpdate = (VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue) != effectiveDateYesterday)? effectiveDateYesterday: effectiveDateTwoDaysAgo;
                    Get_WinCRUANote_GrpNote_TxtNote().Clear();
                    Get_WinCRUANote_GrpNote_TxtNote().Keys(noteTextUpdate);
                    SetDateInDateTimePicker(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), effectiveDateUpdate);
                    Get_WinCRUANote_BtnSave().Click();
                    isANoteUpdated = true;
                }
            }
            
            Get_WinPositionInfo_BtnCancel().Click();
            
            if (isANoteUpdated){
                Log.Message("Vérifier si la modification de la note est effective");
                DragAccountNumberToPortFolio(accountNumber);
                Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "VisibleOnScreen", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, true, positionIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", accountNoColumnIndex], 10).Click();
                Get_PortfolioBar_BtnInfo().Click();
                Get_WinPositionInfo().Parent.Position(0, 0, Get_MainWindow().Width, Get_MainWindow().Height);
                
                if (OpenANoteHavingText(noteTextUpdate)){
                    CheckEquals(VarToStr(Get_WinCRUANote_GrpNote_TxtNote().Text), noteTextUpdate, "Updated Note Text");
                    CheckEquals(VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue), effectiveDateUpdate, "Updated Note Effective Date");
                    Get_WinCRUANote_BtnClose().Click();
                }
                
                Get_WinPositionInfo_BtnCancel().Click();
            }
        }
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.Message("Supprimer les notes ajoutées aux positions.", "", pmNormal, logAttributes);
        Delete_Note(noteText, vServerGeneral);
        Delete_Note(noteTextUpdate, vServerGeneral);
        var deletePortefHasNoteSQLQuery = 'update B_PORTEF set HAS_NOTE = "N" where HAS_NOTE = "Y" ';
        if (arrayOfPreviousPositionsHavingNote.length > 0)
            deletePortefHasNoteSQLQuery += ' and POSITION_ID not in (' + arrayOfPreviousPositionsHavingNote + ')';
        Log.Message(deletePortefHasNoteSQLQuery, deletePortefHasNoteSQLQuery);
        Execute_SQLQuery(deletePortefHasNoteSQLQuery, vServerGeneral);
        
        Terminate_CroesusProcess();
    }
    
}



function DragAccountNumberToPortFolio(accountNumber)
{
    Get_ModulesBar_BtnAccounts().Click();
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 30000);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    SearchAccount(accountNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNumber, 10).Click();
    DragToPortfolioByMenuBar();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 30000);
    Get_PortfolioGrid_GrpSummary().set_IsExpanded(false);
    Get_Portfolio_PositionsGrid().Keys("[Home][Home][Home]");
    Delay(3000);
    Sys.Refresh();
}



function OpenANoteHavingText(noteText)
{
    Get_WinInfo_Notes_TabNote().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    Get_WinInfo_Notes_TabGrid().WaitProperty("IsSelected", true, 60000);
            
    if (!Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote().Exists || !Get_WinInfo_Notes_TabGrid_DgvNotes_ChNote().VisibleOnScreen){
        Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    }
    
    if (!Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", noteText, 10).Exists){
        Log.Error("La note " + noteText + " n'a pas été trouvée dans la grille des notes, ceci est inattendu.");
        return false;
    }
    
    Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", noteText, 10).DblClick();
    return Get_WinCRUANote().Exists;
}



function CheckDragPositionToModules(positionCell, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK POSITION DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Models module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Relationships module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Clients module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Portfolio module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true); 
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Transaction module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToTransactionsByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToTransactionsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToTransactionsByMenuBar();
    }
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(2000); //Nécessaire, si possible trouver éventuellement un moyen de rendre cette pause dynamique
    
    Log.Message("Use " + dragMethod + " to Drag Portfolio to the Securities module.");
    Get_ModulesBar_BtnPortfolio().Click();
    Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 100000);
    if (dragMethod == "DRAG AND DROP")
        DragToSecuritiesByDragAndDrop(positionCell);
    else {
        positionCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToSecuritiesByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToSecuritiesByMenuBar();
    }
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
    aqObject.CheckProperty(Get_ModulesBar_BtnSecurities().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
}
