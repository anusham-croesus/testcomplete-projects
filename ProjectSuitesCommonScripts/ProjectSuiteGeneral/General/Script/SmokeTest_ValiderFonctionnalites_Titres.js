//USEUNIT SmokeTest_Common
//USEUNIT DBA
//USEUNIT Common_functions
//USEUNIT Titres_Get_functions




/*
    Description : Valider les fonctionnalités du module Titres
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Faire "info" sur un titre. Cliquer sur les onglets "info", "historique des prix", "Profil" et "Sites internet" et faire OK.
        2. Mailler un titre dans le module Modèles/ Relation/Clients/Comptes /Portefeuille et Transactions
        3. Sélectionner plusieurs titres/right click add notes, Résultat attendu: Une icône jaune doit s'afficher à côte gauche"
        4. Modifier un note (Laisser vide le champ: Date de référence)
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ValiderFonctionnalites_Titres()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ValiderFonctionnalites_Titres()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var noteText = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValiderFonctionnalites_Titres_NoteText", language + client);
        var noteUpdatedText = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValiderFonctionnalites_Titres_NoteTextMAJ", language + client);
        var noteEffectiveDate = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValiderFonctionnalites_Titres_NoteDateReference", language + client);
        var previousPrefValueSmokeTestValiderFonctionnalitesTitres = GetUserPrefValue(vServerGeneral, "PREF_EDIT_SECURITY_NOTE", userNameGeneral);
        Activate_Inactivate_Pref(userNameGeneral, "PREF_EDIT_SECURITY_NOTE", "YES", vServerGeneral);
        RestartServices(vServerGeneral);
        
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        var securitiesCount = VarToInt(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        
        if (securitiesCount < 1)
            return Log.Error("There is no record in the securities grid.");
        
        var securityIndex = Math.round(Math.random()*(securitiesCount - 1));
        var randomSecurity = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(securityIndex).DataItem.SecuFirm.OleValue);
        Log.Message("Titre choisi : " + randomSecurity);
        
        Search_Security(randomSecurity);
        var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", randomSecurity, 10);
        
        //1. Faire "info" sur un titre. Cliquer sur les onglets "info", "historique des prix", "Profil" et "Sites internet" et faire OK.
        Log.Message("1. Faire 'info' sur un titre. Cliquer sur les onglets 'info', 'historique des prix', 'Profil' et 'Sites internet' et faire OK.", "", pmNormal, logAttributes);
        securityCell.Click();
        
        Log.Message("Cliquer sur le bouton 'Info' et vérifier si la fenêtre 'Info Titre' est affichée.");
        Get_SecuritiesBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinInfoSecurity(), "VisibleOnScreen", cmpEqual, true, true);
        
        Log.Message("Cliquer sur l'onglet 'Info' et vérifier qu'il est sélectionné.");
        Get_WinInfoSecurity_TabInfo().Click();
        aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Cliquer sur l'onglet 'historique des prix' et vérifier qu'il est sélectionné.");
        Get_WinInfoSecurity_TabPriceHistory().Click();
        aqObject.CheckProperty(Get_WinInfoSecurity_TabPriceHistory(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Cliquer sur l'onglet 'Profil' et vérifier qu'il est sélectionné.");
        Get_WinInfoSecurity_TabProfiles().Click();
        aqObject.CheckProperty(Get_WinInfoSecurity_TabProfiles(), "IsSelected", cmpEqual, true, true);
        
        Log.Message("Cliquer sur l'onglet 'Sites internet' et vérifier qu'il est sélectionné.");
        if (!Get_WinInfoSecurity_TabInternetSites().Exists)
            Log.Message("L'onglet 'Sites internet' n'existe pas.")
        else {
            Get_WinInfoSecurity_TabInternetSites().Click();
            aqObject.CheckProperty(Get_WinInfoSecurity_TabInternetSites(), "IsSelected", cmpEqual, true, true);
        }
        
        Log.Message("Cliquer sur le bouton 'OK' et vérifier que la fenêtre 'Info Titre' est fermée.");
        var winInfoSecurityUid = VarToStr(Get_WinInfoSecurity().Uid.OleValue);
        Get_WinInfoSecurity_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", winInfoSecurityUid, 30000);
        SetAutoTimeOut();
        aqObject.CheckProperty(Get_WinInfoSecurity(), "Exists", cmpEqual, false, true);
        RestoreAutoTimeOut();
        
        
        //2. Mailler un titre dans le module Modèles/Relation/Clients/Comptes/Portefeuille et Transactions
        Log.Message('2. Mailler un titre dans le module Modèles/Relation/Clients/Comptes/Portefeuille et Transactions.', "", pmNormal, logAttributes);
        CheckDragSecurityToModules(randomSecurity, "MENU BAR");
        CheckDragSecurityToModules(randomSecurity, "SHORT KEYS");
        CheckDragSecurityToModules(randomSecurity, "DRAG AND DROP");
        
        
        //3. Sélectionner plusieurs titres/right click add notes, Résultat attendu: Une icône jaune doit s'afficher à côte gauche"
        Log.Message("3. Sélectionner plusieurs titres/right click add notes, Résultat attendu : Une icône jaune doit s'afficher à côte gauche", "", pmNormal, logAttributes);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
        
        var arrayOfFormerSecuritiesWithNote = Execute_SQLQuery_GetFieldAllValues('select * from b_titre where has_note = "Y"', vServerGeneral, 'SECUFIRME');
        
        var nbOfTries = 0;
        var maxNbOfTries = 100;
        var arrayOfRandomSecurities = new Array();
        
        var maxNbOfRandomSecurities = 0;
        while (maxNbOfRandomSecurities < 2)
            maxNbOfRandomSecurities = Math.round(Math.random()*10);
        
        Log.Message("Trouver un maximum de " + maxNbOfRandomSecurities + " titres choisis au hasard.");
        while (arrayOfRandomSecurities.length < maxNbOfRandomSecurities && nbOfTries <= maxNbOfTries){
            var securityIndex = Math.round(Math.random()*(securitiesCount - 1));
            var randomSecurity = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(securityIndex).DataItem.SecuFirm.OleValue);
            
            if (GetIndexOfItemInArray(arrayOfFormerSecuritiesWithNote, randomSecurity) == -1
                && GetIndexOfItemInArray(arrayOfRandomSecurities, randomSecurity) == -1
                && !IsSecurityNoteIconDisplayed(randomSecurity))
                arrayOfRandomSecurities.push(randomSecurity);
            
            nbOfTries++;
        }
        
        if (arrayOfRandomSecurities.length < 2)
            return Log.Error("On n'a pu trouver que " + arrayOfRandomSecurities.length + " titre choisi au hasard qui n'aie pas de note.", arrayOfRandomSecurities);
    
        Log.Message("Sélectionner tous les " + arrayOfRandomSecurities.length + " titres choisis au hasard puis Click droit.", arrayOfRandomSecurities);
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        for (var i = 0; i < arrayOfRandomSecurities.length; i++){
            Search_Security(arrayOfRandomSecurities[i]);
            Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", arrayOfRandomSecurities[i], 10).Click(-1, -1, skCtrl);
        }
    
        //Clic droit sur le dernier titre sélectionné
        Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", arrayOfRandomSecurities[i - 1], 10).ClickR();
        Get_SecurityGrid_ContextualMenu_AddANote().Click();
    
        //Ajouter une note et sauvegarder
        Get_WinCRUANote_GrpNote_TxtNote().Keys(noteText);
        SetDateInDateTimePicker(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity(), noteEffectiveDate);
        Get_WinCRUANote_BtnSave().Click();
        
        
        //Vérifier qu'une icône jaune s'est affichée à gauche de chaque titre auquel la note a été ajoutée
        Log.Message("Vérifier qu'une icône jaune s'est affichée à gauche de chaque titre auquel la note a été ajoutée");
        
        var arrayOfRandomSecuritiesWithNote = new Array();
        for (var i = 0; i < arrayOfRandomSecurities.length; i++){
            var currentSecurity = arrayOfRandomSecurities[i];
        
            if (IsSecurityNoteIconDisplayed(currentSecurity)){
                Log.Checkpoint("Une icône jaune s'est affichée à gauche du titre : " + currentSecurity);
                arrayOfRandomSecuritiesWithNote.push(currentSecurity);
            }
            else
                Log.Error("Une icône jaune n'est pas affichée à gauche du titre : " + currentSecurity);
        }
    
        
        //4. Modifier un note (Laisser vide le champ: Date de référence)
        Log.Message("4. Modifier un note (Laisser vide le champ: Date de référence)", "", pmNormal, logAttributes);
    
        var randomSecurityIndex = Math.round(Math.random()*(arrayOfRandomSecuritiesWithNote.length - 1));
        var randomSecurity = arrayOfRandomSecuritiesWithNote[randomSecurityIndex];
    
        Log.Message("Modifier la note du titre : " + randomSecurity);
        
        //Clic sur le titre puis Info
        Search_Security(randomSecurity);
        Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", randomSecurity, 10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfo_Notes_TabNote().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", noteText, 10).DblClick();
        
        //Valider que la Date de référence est vide
        Log.Message("Valider que la date de référence affichée est vide.");
        var effectiveDate = VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue.OleValue);
        Log.Message("La date de référence affichée est : " + effectiveDate);
        CheckEquals(Trim(aqString.Replace(effectiveDate, "/", "")), "", "Note Effective Date");
        
        //Modifier la note et sauvegarder
        Log.Message("Saisir le nouveau contenu de la note : " + noteUpdatedText);
        Get_WinCRUANote_GrpNote_TxtNote().Clear()
        Get_WinCRUANote_GrpNote_TxtNote().Keys(noteUpdatedText);
        Get_WinCRUANote_BtnSave().Click();
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Vérifier que la note a été effectivement modifiée
        Log.Message("Vérifier que la note du titre " + randomSecurity + "a été effectivement modifiée et que la date de référence est toujours vide.");
        Search_Security(randomSecurity);
        Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", randomSecurity, 10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfo_Notes_TabNote().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        Get_WinInfo_Notes_TabGrid_DgvNotes_ChCreationDate().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        if (Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", noteText, 10).Exists)
            return Log.Error("La note " + noteText + " a été trouvée dans la grille des notes, ceci est inattendu.");
        
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", noteUpdatedText, 10).DblClick();    
        
        var displayedNoteEffectiveDate = VarToStr(Get_WinCRUANote_TxtEffectiveDateForPositionAndSecurity().StringValue.OleValue);
        var displayedNoteText = VarToStr(Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue);
        Log.Message("Displayed effective date is : " + effectiveDate);
        CheckEquals(Trim(aqString.Replace(effectiveDate, "/", "")), "", "Note Effective Date after update");
        CheckEquals(displayedNoteText, noteUpdatedText, "Note Text after update");
        
        Get_WinCRUANote().Close();
        Get_WinInfoSecurity_BtnOK().Click();
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        Log.Message("Supprimer les notes des titres choisis au hasard.");
        Delete_Note(noteText, vServerGeneral);
        Delete_Note(noteUpdatedText, vServerGeneral);
        for (var i = 0; i < arrayOfRandomSecurities.length; i++)
            Execute_SQLQuery('update b_titre set has_note = "N" where SECUFIRME = "' + arrayOfRandomSecurities[i] + '"', vServerGeneral);
        
        Activate_Inactivate_Pref(userNameGeneral, "PREF_EDIT_SECURITY_NOTE", previousPrefValueSmokeTestValiderFonctionnalitesTitres, vServerGeneral);
        RestartServices(vServerGeneral);
    }
    
}



function IsSecurityNoteIconDisplayed(security)
{
    Log.Message("Vérifier qu'une icône jaune s'est affichée à gauche du titre : " + security);
    
    Search_Security(security);
        
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (!securityCell.Exists){
        Log.Error("Le titre '" + security + "' n'a pas été trouvé, ceci est innatendu.");
        return;
    }
        
    //Trouver l'index de la ligne du titre
    var securityRowIndex = null;
    var maxNbOfParents = 10;
    var securityParentObject = securityCell;
    for (var j = 1 ; j <= maxNbOfParents; j++){
        var securityParentObject = securityParentObject.Parent;
        if (securityParentObject.ClrClassName == "DataRecordPresenter"){
            securityRowIndex = securityParentObject.WPFControlOrdinalNo;
            break;
        }
    }
        
    if (securityRowIndex === null){
        Log.Error("L'index de la ligne du titre '" + security + "'n'a pas été trouvé, ceci est innatendu.");
        return;
    }

    var noteCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, securityRowIndex], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "HasNote"], 10);
    if (!noteCell.Exists){
        Log.Message("The note cell was not found.")
        return false;
    }
    
    var noteImage = noteCell.FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo"], ["Image", true, 1], 10);
    return (noteImage.Exists);
}



function DeleteAllNotesOfSecurity(security){
    Log.Message("Supprimer toutes les notes du titre : " + security);
    
    if (!IsSecurityNoteIconDisplayed(security)){
        Log.Message("Une icône jaune n'est pas affichée à gauche du titre : " + security);
        return true
    }
    
    Search_Security(security);
    Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10).Click();
    Get_SecuritiesBar_BtnInfo().Click();
    Get_WinInfo_Notes_TabNote().Click();
    Get_WinInfo_Notes_TabGrid().Click();
    
    while (Get_WinInfo_Notes_TabGrid_BtnDelete().IsEnabled){
        Get_WinInfo_Notes_TabGrid_BtnDelete().Click();
        Get_WinInfo_Notes_TabGrid_BtnDelete().WaitProperty("IsEnabled", false, 10000);
    }
    
    Get_WinInfoSecurity_BtnOK().Click();
    
    var IsNoteIconDisplayed = IsSecurityNoteIconDisplayed(security);
    
    if (IsNoteIconDisplayed)
        Log.Error("Une icône jaune est toujours affichée à gauche du titre : " + security);
    else
        Log.Message("Une icône jaune n'est pas affichée à gauche du titre : " + security);
    
    return !IsNoteIconDisplayed;
}



function CheckDragSecurityToModules(security, dragMethod)
{
    var arrayOfDragMethods = ["DRAG AND DROP", "SHORT KEYS", "MENU BAR"];
    if (GetIndexOfItemInArray(arrayOfDragMethods, dragMethod) == -1){
        Log.Error("Value '" + dragMethod + "' is not supported as drag method. Supported drag methods are : " + arrayOfDragMethods, arrayOfDragMethods);
        return;
    }
    
    Log.Message("***** CHECK SECURITY DRAG TO MODULES WITH : " + dragMethod + " *****");
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Models module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToModelsByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToModelsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToModelsByMenuBar();
    }
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnModels().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Relationships module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToRelationshipsByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
             DragToRelationshipsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToRelationshipsByMenuBar();
    }
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked.OleValue", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnRelationships().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Clients module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToClientsByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToClientsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToClientsByMenuBar();
    }
    Get_ModulesBar_BtnClients().WaitProperty("IsChecked.OleValue", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnClients().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Accounts module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToAccountsByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToAccountsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToAccountsByMenuBar();
    }
    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnAccounts().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Portfolio module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToPortfolioByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToPortfolioByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToPortfolioByMenuBar();
    }
    
    SetAutoTimeOut();
    if (Get_DlgInformation().Exists){
        Log.Picture(Sys.Desktop, "The information dialog box was displayed.")
        Get_DlgInformation().Click(Get_DlgInformation().Width/2, Get_DlgInformation().Height - 45);
        aqObject.CheckProperty(Get_ModulesBar_BtnSecurities().IsChecked, "OleValue", cmpEqual, true, true);
    }
    else {
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked.OleValue", true, 30000);
        aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio().IsChecked, "OleValue", cmpEqual, true, true);
    }
    RestoreAutoTimeOut();
    
    Log.Message("Use " + dragMethod + " to Drag Security to the Transactions module.");
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 30000);
    Search_Security(security);
    var securityCell = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).FindChild("Value", security, 10);
    if (dragMethod == "DRAG AND DROP")
        DragToTransactionsByDragAndDrop(securityCell);
    else {
        securityCell.Click();
        if (dragMethod == "SHORT KEYS")
            DragToTransactionsByShortKeys();
        else if (dragMethod == "MENU BAR")
            DragToTransactionsByMenuBar();
    }
    Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked.OleValue", true, 30000);
    aqObject.CheckProperty(Get_ModulesBar_BtnTransactions().IsChecked, "OleValue", cmpEqual, true, true);
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(2000); //Nécessaire, si possible trouver éventuellement un moyen de rendre cette pause dynamique
}
