//USEUNIT CR1449_Common



/**
    Description : Ajouter, Modifier et Supprimer les sous-catégories
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5435
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5435_Tit_Ajouter_Modifier_et_Supprimer_les_sous_categories()
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var restartMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_RestartMessage", language + client);
        var deletionNotPossibleMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_DeletionNotPossibleMessage", language + client);
        var deletionConfirmationQuestion = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_DeletionConfirmationQuestion", language + client);
        var allFieldsAreMandatoryMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_AllFieldsAreMandatoryMessage", language + client);
        
        var startDateTime = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M%S");
        var englishDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5435_SubcategoryDescription", "english" + client) + startDateTime;
        var shortEnglishDesc = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5435_SubcategoryShortDescription", "english" + client) + startDateTime;
        var frenchDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5435_SubcategoryDescription", "french" + client) + startDateTime;
        var shortFrenchDesc = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5435_SubcategoryShortDescription", "french" + client) + startDateTime;
        var subcategoryDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5435_SubcategoryDescription", language + client) + startDateTime;
        var cashSubcategory = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_CashSubcategory", language + client);
        
        //Se connecter avec l'utilisateur GP1859
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Vérifier les préconditions
        //VerifyPreconditionsOfCR1449(testUserName);
        if(!VerifyPreconditionsOfCR1449(testUserName)){         // Ajouté par A.A
            Activate_Inactivate_Pref(testUserName, "PREF_EDIT_FIRM_FUNCTIONS", "YES", vServerTitre);
            RestartServices(vServerTitre);
        }

        
        //1 : Dans la fenetre de Catégorisation de titres, choisir la sous-catégorie Encaisse et cliquer sur le bouton Modifier, ajouter le 'Année de création', 'Mois de création' et le 'Coût inv. redéfini' et cliquer sur Sauvegarder
        Log.Message("1 : Dans la fenetre de Catégorisation de titres, choisir la sous-catégorie '" + cashSubcategory + "' et cliquer sur le bouton Modifier, ajouter le 'Année de création', 'Mois de création' et le 'Coût inv. redéfini' et cliquer sur Sauvegarder")
        Login(vServerTitre, testUserName, testUserPassword, language);
        OpenSecurityCategorisationWindow();
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(cashSubcategory).Click();
        Get_WinSecurityCategorisationConfigurations_BtnEdit().Click();
        
        //Récupérer les valeurs antérieures pour la restauration (Cleanup)
        var cashPreviousCreationYear = Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Text.OleValue;
        var cashPreviousCreationMonthIndex = Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().SelectedIndex;
        var cashPreviousOverwriteInvCostIndex = Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost().SelectedIndex;
        
        //Faire les modifications
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y"));
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost().ClickItem(1);
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        if (!Get_DlgInformation().Exists)
            Log.Error("La boîte de dialogue 'Information' ne s'est pas affichée");
        else {
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, restartMessage);
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        
        
        //2 : Dans la fenetre de Catégorisation de titres, choisir la sous-catégorie Encaisse et cliquer sur le bouton Supprimer
        Log.Message("2 : Dans la fenetre de Catégorisation de titres, choisir la sous-catégorie '" + cashSubcategory + "' et cliquer sur le bouton Supprimer");
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(cashSubcategory).Click();
        Get_WinSecurityCategorisationConfigurations_BtnDelete().Click();
        Log.Message("Cliquer sur Non pour annuler la confirmation de suppression.");
        if (!Get_DlgConfirmation().Exists)
            Log.Error("La boîte de dialogue 'Confirmation' ne s'est pas affichée");
        else {
            aqObject.CheckProperty(Get_DlgConfirmation_LblMessage(), "Message", cmpEqual, deletionConfirmationQuestion);
            //Cliquer sur Non pour annuler la confirmation de suppression
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(2/3), Get_DlgConfirmation().get_ActualHeight()-45);
        }
        
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(cashSubcategory).Click();
        Get_WinSecurityCategorisationConfigurations_BtnDelete().Click();
        Log.Message("Cliquer sur Oui pour avoir le message 'Il n'est pas possible de supprimer cette sous-catégorie, car des titres y sont associées.'");
        if (!Get_DlgConfirmation().Exists)
            Log.Error("La boîte de dialogue 'Confirmation' ne s'est pas affichée");
        else {
            //Cliquer sur Oui pour avoir le message "Il n'est pas possible de supprimer cette sous-catégorie, car des titres y sont associées.
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), Get_DlgConfirmation().get_ActualHeight()-45);
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, deletionNotPossibleMessage);
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        
        
        //3 : Dans la fenetre de Catégorisation de titres, cliquer sur le bouton Ajouter, remplir les champs de description en anglais, description en anglais courte, description en français et description en français courte et cliquer sur sauvegarder
        Log.Message("3 : Dans la fenetre de Catégorisation de titres, cliquer sur le bouton Ajouter, remplir les champs de description en anglais, description en anglais courte, description en français et description en français courte et cliquer sur sauvegarder.");
        Get_WinSecurityCategorisationConfigurationsBtnAdd().Click();
        Get_WinAddSecurityCategorisation_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtShortEnglishDesc().Keys(shortEnglishDesc);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtShortFrenchDesc().Keys(shortFrenchDesc);
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        if (!Get_DlgInformation().Exists)
            Log.Error("La boîte de dialogue 'Information' ne s'est pas affichée");
        else {
            CheckEquals(VarToStringWithoutInvisibleCharacters(Get_DlgInformation_LblMessage().Message), VarToStringWithoutInvisibleCharacters(allFieldsAreMandatoryMessage), "DlgInformation message");
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        
        
        //4 : Dans la même fenêtre d'ajout de sous-catégorie, remplir tous les informations obligatoires et cliquer sur Sauvegarder
        Log.Message("4 : Dans la même fenêtre d'ajout de sous-catégorie, remplir tous les informations obligatoires et cliquer sur Sauvegarder.");
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbYield().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbIntDivFrequency().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFactorSign().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbDayCount().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays().Keys(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstr().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstrDetail().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y"));
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDisplay_CmbDisplayFactor().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDisplay_CmbNumberOfDecimals().ClickItem(1);
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        if (!Get_DlgInformation().Exists)
            Log.Error("La boîte de dialogue 'Information' ne s'est pas affichée");
        else {
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, restartMessage);
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        
        
        //5 : Fermer et ré-ouvrir l'application, retouner au menu OUTILS> Configuration, cliquer sur l'option 'Répartition et objectifs' > 'Classements globaux' > 'Sous-catégories'
        Log.Message("5 : Fermer et ré-ouvrir l'application, retouner au menu OUTILS> Configuration, cliquer sur l'option 'Répartition et objectifs' > 'Classements globaux' > 'Sous-catégories'.");
        CloseCroesusFromSecurityCategorisationWindow();
        Login(vServerTitre, testUserName, testUserPassword, language);
        if (IsSubcategoryDisplayedInGlobalClassifications(subcategoryDescription))
            Log.Checkpoint("La nouvelle sous-catégorie créée '" + subcategoryDescription + "' se trouve sur la liste de 'Classements globaux'.");
        else
            Log.Error("La nouvelle sous-catégorie créée '" + subcategoryDescription + "' ne se trouve pas sur la liste de 'Classements globaux'.");
        
        
        //6 : Retourner à la fenetre de Catégorisation de titres, choisir la nouvelle sous-catégorie qui a été crée et cliquer sur le bouton Supprimer
        Log.Message("Retourner à la fenetre de Catégorisation de titres, choisir la nouvelle sous-catégorie qui a été crée et cliquer sur le bouton Supprimer");
        OpenSecurityCategorisationWindow(true);
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription).Click();
        Get_WinSecurityCategorisationConfigurations_BtnDelete().Click();
        Log.Message("Dans la fenêtre de confirmation, cliquer sur Oui et confirmer que la sous-catégorie a été supprimée.");
        if (!Get_DlgConfirmation().Exists)
            Log.Error("La boîte de dialogue 'Confirmation' ne s'est pas affichée");
        else
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), Get_DlgConfirmation().get_ActualHeight()-45);
        
        //Cliquer sur le bouton OK de la boîte de dialogue qui informe que ce changement prendra effet après le prochain démarrage de l'application
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        
        var arrayOfTreeviewItems = Get_WinSecurityCategorisationConfiguration_TvwTreeview().FindAllChildren(["ClrClassName", "IsVisible"], ["TreeViewItem", true]).toArray();
        for (var i in arrayOfTreeviewItems) arrayOfTreeviewItems[i].set_IsExpanded(true);
        if (!Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryDescription).Exists)
            Log.Checkpoint("La sous-catégorie '" + subcategoryDescription + "' a été supprimée.");
        else
            Log.Error("La sous-catégorie '" + subcategoryDescription + "' n'a pas été supprimée.");
        
        
        //7 : Fermer et ré-ouvrir l'application, retouner au menu OUTILS> Configuration, cliquer sur l'option 'Répartition et objectifs' > 'Classements globaux' > 'Sous-catégories'
        Log.Message("Fermer et ré-ouvrir l'application, retouner au menu OUTILS> Configuration, cliquer sur l'option 'Répartition et objectifs' > 'Classements globaux' > 'Sous-catégories'");
        CloseCroesusFromSecurityCategorisationWindow();
        Login(vServerTitre, testUserName, testUserPassword, language);
        if (!IsSubcategoryDisplayedInGlobalClassifications(subcategoryDescription))
            Log.Checkpoint("La sous-catégorie '" + subcategoryDescription + "' supprimée n'est plus disponible sur la liste de classements globaux.");
        else {
            Log.Error("La sous-catégorie '" + subcategoryDescription + "' supprimée est encore disponible sur la liste de classements globaux.");
            Log.Error("Bug JIRA CROES-10197 : CR1449 - Suppression de sous-catégorie dans la fenêtre de catégorisation de titres ne supprime pas de la liste de classements globaux");
        }
        
        
        //Fermer Croesus
        Get_WinConfigurations().Close();
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        if (typeof testUserPassword == "undefined")
            return Terminate_CroesusProcess();
        
        Log.Message("********* CLEANUP ***********");
        
        //Supprimer la sous-catégorie créée au cas où elle aurait été créée et mais n'aurait pas été supprimée
        Login(vServerTitre, testUserName, testUserPassword, language);
        OpenSecurityCategorisationWindow();
        DeleteSubcategoryInSecurityCategorisation(subcategoryDescription);
        CloseCroesusFromSecurityCategorisationWindow();
        Terminate_CroesusProcess();
        
        //Restaurer les valeurs antérieures la sous-catégorie 'Encaisse'
        var descFieldName = (language == "french")? "DESC_L1": "DESC_L2";
        Execute_SQLQuery("update B_ASSET set OVERWRITE_INVCOST = null, CREATION_YEAR = null, CREATION_MONTH = null where " + descFieldName + " = '" + cashSubcategory + "'", vServerTitre);
    }
}



function IsSubcategoryDisplayedInGlobalClassifications(subcategoryDescription)
{
    Log.Message("Vérifier si la sous-catégorie '" + subcategoryDescription + "' se trouve sur la liste de classements globaux.");
    
    var numTry = 0;
    do {
        Delay(5000);
        Get_MenuBar_Tools().Click();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 1000, 3500))
        
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations().WaitProperty("VisibleOnScreen", true, 6000);
    Get_WinConfigurations().Parent.Maximize();
    Get_WinConfigurations_TvwTreeview_LlbAssetAllocationsAndObjectives().Click();
    Delay(2000);
    Get_WinConfigurations_LvwListView_LlbGlobalClassifications().DblClick();
    Delay(2000);
    Get_WinConfigurations_LvwListView_LlbSubcategories().DblClick();
    Delay(2000);
    Get_WinConfigurations().Parent.Maximize();
    Get_WinConfigurations_LvwListView().Keys("[Home][Home]");
    do {
        Get_WinConfigurations_LvwListView().Keys("[PageDown]");
        var isSubcategoryDescriptionFound = Get_WinConfigurations_LvwListView().FindChild(["ClrClassName", "WPFControlText", "IsVisible"], ["TextBlock", subcategoryDescription, true], 10).Exists;
    } while (!isSubcategoryDescriptionFound && Get_WinConfigurations_LvwListView().SelectedIndex < Get_WinConfigurations_LvwListView().Items.Count - 1)
    
    return isSubcategoryDescriptionFound;
}
