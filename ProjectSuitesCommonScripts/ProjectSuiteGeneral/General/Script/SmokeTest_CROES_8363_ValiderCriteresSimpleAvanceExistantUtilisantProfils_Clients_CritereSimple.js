//USEUNIT SmokeTest_Common




/*
    Description : Valider les critères (simple/avancé) existant dans la BD et utilisant des profils
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
    https://jira.croesus.com/browse/CROES-8363
        l`objectif est de s`assurer que leurs conditions sur les champs profils ne seront pas ignorées(CROES-8363)"
        1. Critere simple : Liste des clients(Client réel) ayant Profession différent(e) de Commis.
        2. Critere avancé : clients dont toutes ces conditions sont vraies(ET)
            Classe du client égale  Client réel
            conatct de la banque n`égale pas chrsitine
           Valeur totale(client) est plus grande que 100 000,00"
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients_CritereSimple()
{
    var searchCriteriaName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_SimpleCriteriaName", language + client);
    var isCriteriaSimple = true;
    SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients(searchCriteriaName, isCriteriaSimple);
}



function SmokeTest_CROES_8363_ValiderCriteresSimpleAvanceExistantUtilisantProfils_Clients(searchCriteriaName, isCriteriaSimple)
{
    Log.Message("JIRA CROES-8363");
    
    try {
        var profileOccupation = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_ProfileOccupation", language + client);
        var profileBankContact = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_ProfileBankContact", language + client);
        var arrayOfProfilesColumnsNames = [profileOccupation, profileBankContact];
        
        var realClientUnexpectedChar = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "RealClientAccountUnexpectedChar", language + client);
        
        var simpleCriteriaUnexpectedOccupation = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_SimpleCriteriaProfileValue", language + client);
        var simpleCriteriaProfileCondition = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_SimpleCriteriaProfileCondition", language + client);
        var arrayOfSimpleCriteriaPartControl = [profileOccupation, simpleCriteriaProfileCondition, simpleCriteriaUnexpectedOccupation];
        
        var advancedCriteriaUnexpectedBankContact = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_AdvancedCriteriaProfileValue", language + client);
        var advancedCriteriaProfileCondition = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_AdvancedCriteriaProfileCondition", language + client);
        var arrayOfAdvancedCriteriaPartControl = [profileBankContact, advancedCriteriaProfileCondition, advancedCriteriaUnexpectedBankContact];
        var advancedCriteriaMinTotalValue = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "ValidateCriteria_AdvancedCriteriaMinTotalValue", language + client);
        
        
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        //Cocher les profils nécessaires
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        var arrayOfProfileCheckboxPreviousState = new Array();
        for (var i = 0; i < arrayOfProfilesColumnsNames.length; i++){
            var profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfilesColumnsNames[i]);
            if (!profileCheckbox.Exists)
                return Log.Error("Profile '" + arrayOfProfilesColumnsNames[i] + "' was not found, this is unexpected.");
            else {
                var previousState = profileCheckbox.IsChecked.OleValue;
                arrayOfProfileCheckboxPreviousState.push(previousState);
                if (previousState != true)
                    profileCheckbox.Click();
            }

        }
        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        //Ajouter les colonnes des profils
        ClickRightAndExpectSubmenus(Get_ClientsGrid_ChName());
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        for (var j = 0; j < arrayOfProfilesColumnsNames.length; j++){
            ClickRightAndExpectSubmenus(Get_ClientsGrid_ChName());
            Get_GridHeader_ContextualMenu_AddColumn().Click();
            Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
            var columnMenuItem = Get_GridHeader_ContextualMenu_AddColumnOrInsertField_Profiles_ProfileName(arrayOfProfilesColumnsNames[j], arrayOfProfilesColumnsNames[j]);
            if (columnMenuItem.Exists)
                columnMenuItem.Click();
        }
        
        //Récupérer tous les clients (sans filtre)
        var arrayOfAllDisplayedClientsBeforeFilter = GetAllDisplayedClients();
        
        //Récupérer la liste des clients attendus après le filtre
        var arrayOfExpectedDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfAllDisplayedClientsBeforeFilter.length; i ++){
            var currentClientNumber = arrayOfAllDisplayedClientsBeforeFilter[i][0];
        
            //Both Criteria are on real Clients
            if (aqString.Find(currentClientNumber, realClientUnexpectedChar) != -1)
                continue;
            else {
        
                //Simple Criteria
                if (isCriteriaSimple){
                    var currentClientOccupation = arrayOfAllDisplayedClientsBeforeFilter[i][2];
                    if (currentClientOccupation != "" && currentClientOccupation != simpleCriteriaUnexpectedOccupation)
                        arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(currentClientNumber);
                }
            
                //Advanced Criteria
                else {
                    var currentClientTotalValue = arrayOfAllDisplayedClientsBeforeFilter[i][1];
                    var currentClientBankContact = arrayOfAllDisplayedClientsBeforeFilter[i][3];
                    if (StrToFloat(currentClientTotalValue) > StrToFloat(advancedCriteriaMinTotalValue) && currentClientBankContact != "" && currentClientBankContact != advancedCriteriaUnexpectedBankContact)
                        arrayOfExpectedDisplayedClientsNumbersAfterFilter.push(currentClientNumber);
                }
            }
        }
        
        //Ouvrir la fenêtre de gestionnaire des critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
    
        //Faire apparaître le critère de recherche
        Get_WinSearchCriteriaManager_DgvCriteria().Keys(searchCriteriaName.substring(0, 1));
        Sys.Keys(searchCriteriaName.substring(1));
        Sys.Keys("[Enter]");
    
        //Vérifier si le critère existe
        Log.Message("Check if Criteria '" + searchCriteriaName + "' is displayed.");
        var searchCriteriaNameCell = Get_WinSearchCriteriaManager_DgvCriteria().FindChild(["ClrClassName", "Uid", "Value"], ["CellValuePresenter", "Description", searchCriteriaName], 10);
        if (!searchCriteriaNameCell.Exists)
            return Log.Error("Criteria '" + searchCriteriaName + "' was not found, this is unexpected.");
            
        Log.Checkpoint("Criteria '" + searchCriteriaName + "' was displayed");
    
        //Vérifier si le bouton Modifier est actif
        Log.Message("Check if 'Edit' button is enabled for Criteria '" + searchCriteriaName + "'.");
        searchCriteriaNameCell.Click();
        if (!Get_WinSearchCriteriaManager_BtnEdit().IsEnabled)
            Log.Error("'Edit' button is not enabled for Criteria '" + searchCriteriaName + "', this is unexpected.");
        else
            Log.Checkpoint("'Edit' button is enabled for Criteria '" + searchCriteriaName + "'.");
    
        //Cliquer sur le bouton Edit et vérifier si la fenêtre d'édition s'ouvre
        Log.Message("Click on 'Edit' button and check if the expected window is opened.");
        Get_WinSearchCriteriaManager_BtnEdit().Click();
        
        //Vérifier s'il y a un message d'erreur.
        SetAutoTimeOut();
        
        //Cette partie est issue d'une adapation pour version Co
        //Elle a été faite ainsi du fait qu'on ne pouvait pas reproduire le message d'erreur. Les nouvelles boîtes de dialogue étant des BaseWindow, normalement elle devrait toujours fonctionner
        //Une fois confirmée, supprimer la partie subséquente : if (Get_DlgCroesus().Exists)...
        var BaseWindow = Get_CroesusApp().FindChildEx(["ClrClassName", "Visible"], ["BaseWindow", true], 10, true, 10000);
        if (BaseWindow.Exists){
            Log.Error(BaseWindow.Title + " dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.")
            BaseWindow.Close();
        }
        
        //Condition à supprimer une fois la partie précédente confirmée
        if (Get_DlgCroesus().Exists){
            Log.Error("The Croesus dialog box was displayed, this is unexpected. Please check the screenshot to see the exact message.")
            Get_DlgCroesus().Click(Get_DlgCroesus().Width/2, Get_DlgCroesus().Height - 45);
        }
        
        RestoreAutoTimeOut();
    
        //Vérifier si la fenêtre d'édition du critère est affichée et vérifier si la condition sur le profil existe
        //Pour Critère Simple
        if (isCriteriaSimple){
            if (!Get_WinAddSearchCriterion().Exists)
                Log.Error("The WinAddSearchCriterion window was not displayed, this is unexpected.");
            else {
                Log.Checkpoint("The WinAddSearchCriterion window was displayed.");
        
                //Vérifier si le bouton Sauvegarder est actif
                Log.Message("Check if 'Save' button is enabled for Criteria '" + searchCriteriaName + "'.");
                if (!Get_WinAddSearchCriterion_BtnSave().IsEnabled)
                    Log.Error("'Save' button is not enabled for Criteria '" + searchCriteriaName + "', this is unexpected.");
                else
                    Log.Checkpoint("'Save' button is enabled for Criteria '" + searchCriteriaName + "'.");
            
                //Vérifier si la condition sur le champ profil est présente
                var profilePartControl = Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(arrayOfSimpleCriteriaPartControl[0]);
                if (!profilePartControl.Exists || !profilePartControl.IsVisible)
                    Log.Error("The profile Part control '" + arrayOfSimpleCriteriaPartControl[0] + "' in condition was not displayed, this is unexpected.");
                else {
                    var partControlIndex = profilePartControl.WPFControlOrdinalNo;
                    Log.Message("Check if Profile condition is present for Criteria '" + searchCriteriaName + "'.");rtcontrolNotFoundAtExpectedPosition = false;
                    var isPartcontrolNotFoundAtExpectedPosition = false;
                    for (var k = 1; k < arrayOfSimpleCriteriaPartControl.length; k++){
                        var partControl = Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "IsVisible", "WPFControlOrdinalNo", "DataContext.SelectedValue"], ["PartControl", true, ++partControlIndex, arrayOfSimpleCriteriaPartControl[k]], 10);
                        if (!partControl.Exists){
                            Log.Error("Partcontrol '" + arrayOfSimpleCriteriaPartControl[k] + "' was not found at position " + partControlIndex + "; this is unexpected.")
                            isPartcontrolNotFoundAtExpectedPosition = true;
                        }
                    }
                    if (!isPartcontrolNotFoundAtExpectedPosition)
                        Log.Checkpoint("The profile condition '" + arrayOfSimpleCriteriaPartControl.join(" ") + "' was displayed.");
                    else
                        Log.Error("The profile condition '" + arrayOfSimpleCriteriaPartControl.join(" ") + "' was not displayed.");
                }
            
                //Cliquer sur le bouton Annuler
                Get_WinAddSearchCriterion_BtnCancel().Click();
            }
        }
        
        //Pour Critère Avancé
        else {
            if (!Get_WinCRUSearchCriterionAdvanced().Exists)
                Log.Error("The WinCRUSearchCriterionAdvanced window was not displayed, this is unexpected.");
            else {
                Log.Checkpoint("The WinCRUSearchCriterionAdvanced window was displayed.");
        
                //Vérifier si le bouton Sauvegarder est actif
                Log.Message("Check if 'Save' button is enabled for Criteria '" + searchCriteriaName + "'.");
                if (!Get_WinCRUSearchCriterionAdvanced_BtnSave().IsEnabled)
                    Log.Error("'Save' button is not enabled for Criteria '" + searchCriteriaName + "', this is unexpected.");
                else
                    Log.Checkpoint("'Save' button is enabled for Criteria '" + searchCriteriaName + "'.");
        
                //Vérifier si la condition sur le champ profil est présente
                var advancedCriteriaProfileConditionText = arrayOfAdvancedCriteriaPartControl.join(" ");
                Log.Message("Check if Profile condition is present for Criteria '" + searchCriteriaName + "'.");
                var profileCondition = Get_WinCRUSearchCriterionAdvanced_GrpDefinition_TvwTreeView().FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["TextBlock", true, advancedCriteriaProfileConditionText], 20);
                if (!profileCondition.Exists)
                    Log.Error("The profile condition '" + advancedCriteriaProfileConditionText+ "' was not displayed, this is unexpected.");
                else 
                    Log.Checkpoint("The profile condition '" + advancedCriteriaProfileConditionText+ "' was displayed.");
        
                //Cliquer sur le bouton Annuler
                Get_WinCRUSearchCriterionAdvanced_BtnCancel().Click();
            }
        }
        
        //Charger le critère de recherche
        Log.Message("Refresh the Search criteria.");
        Get_WinSearchCriteriaManager_BtnRefresh().Click();
        
        //Clic sur l'éventuel message Pas de données
        SetAutoTimeOut();
        if (Get_DlgWarning().Exists)
            Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-45);
        RestoreAutoTimeOut();
        
        //S'assurer que le critère de recherche a été chargé
        Log.Message("Make sure the Search criteria is loaded.");
        if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
            return Log.Error("The Search criteria was not loaded.");
        
        CheckEquals(VarToStr(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext.ActiveCriteria.CriteriaDescription.OleValue), searchCriteriaName, "Search Criteria description");
        
        //Récupérer la liste des clients affichés après le filtre
        var arrayOfActualDisplayedClientsAfterFilter = GetAllDisplayedClients();
        var arrayOfActualDisplayedClientsNumbersAfterFilter = new Array();
        for (var i = 0; i < arrayOfActualDisplayedClientsAfterFilter.length; i ++)
            arrayOfActualDisplayedClientsNumbersAfterFilter.push(arrayOfActualDisplayedClientsAfterFilter[i][0]);
    
        //Vérifier si la liste des clients affichés après le filtre est celle attendue
        Log.Message("Check if the displayed clients are the expected ones.");
        DoubleCheckArrayDiff(arrayOfActualDisplayedClientsNumbersAfterFilter, arrayOfExpectedDisplayedClientsNumbersAfterFilter);

        //Fermer Croesus
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        if (arrayOfProfileCheckboxPreviousState == undefined)
            return;
            
        //Restore Profiles previous state
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        RedisplayAndRemoveCheckmarksOfRelationshipsClientsAccountsGrid();
        Get_ClientsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabProfile().Click();
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        for (var i = 0; i < arrayOfProfilesColumnsNames.length; i++){
            var profileCheckbox = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfilesColumnsNames[i]);
            if (!profileCheckbox.Exists)
                Log.Error("Profile '" + arrayOfProfilesColumnsNames[i] + "' was not found, this is unexpected.");
            else if (profileCheckbox.IsChecked.OleValue != arrayOfProfileCheckboxPreviousState[i])
                    profileCheckbox.Click();
        }
        
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        
        //Rétablir la configuration par défaut des colonnes
        ClickRightAndExpectSubmenus(Get_ClientsGrid_ChName());
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
        Terminate_CroesusProcess();
    }
    
}



/*
    Return Array of Array
        ClientNumber Index = 0
        ClientTotalValue Index = 1
        ClientOccupation Index = 2
        ClientBankContact Index = 3
*/
function GetAllDisplayedClients()
{
    var arrayOfAllDisplayedClients = new Array();
    
    if (Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count() < 1)
        return arrayOfAllDisplayedClients;
    
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    var isEndOfGriReached = false;
    while (!isEndOfGriReached){
        Get_RelationshipsClientsAccountsGrid().Refresh();
        var clientsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < clientsPageCount; i++){
            var currentClientNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_ClientNumber());
            var currentClientTotalValue = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_MainTotalValue());
            var currentClientOccupation = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Profiles.Item(0).get_ValueForDisplay());
            var currentClientBankContact = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Profiles.Item(1).get_ValueForDisplay());
            
            var isCurrentClientNew = true
            for (var j = 0; j < arrayOfAllDisplayedClients.length; j++){
                if (arrayOfAllDisplayedClients[j][0] == currentClientNumber){
                    isCurrentClientNew = false;
                    break;
                }
            }
            
            if (isCurrentClientNew)
                arrayOfAllDisplayedClients.push([currentClientNumber, currentClientTotalValue, currentClientOccupation, currentClientBankContact]);
        }
        
        var firstRowClientBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowClientAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        
        if (firstRowClientBeforeScroll == firstRowClientAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowClientAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        }
        
        isEndOfGriReached = (firstRowClientBeforeScroll == firstRowClientAfterScroll);
    }
    
    return arrayOfAllDisplayedClients;
}
