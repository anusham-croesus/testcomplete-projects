//USEUNIT CR1449_Common



/**
    Description : Valider le type de negotiation de titres par le GDO
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5438
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5438_Tit_Valider_le_type_de_negotiation_de_titres_par_le_GDO()
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var restartMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "WinSecurityCategorisation_RestartMessage", language + client);
        var securityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_SecurityDescription", language + client);
        var securityMainMarket = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_SecurityMainMarket", language + client);
        var accountNumber = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_AccountNumber", language + client);
        var subcategoryFullDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_SubcategoryFullDescription", language + client);
        var financialInstrument = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_FinancialInstrument", language + client);
        var subcategoryTradeAs_FormerValue = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_SubcategoryTradeAs_FormerValue", language + client);
        var subcategoryTradeAs_UpdateValue = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5438_SubcategoryTradeAs_UpdateValue", language + client);
        
        //Se connecter avec l'utilisateur GP1859
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Vérifier les préconditions
        VerifyPreconditionsOfCR1449(testUserName);
        
        
        //1 : Dans Croesus aller au module titres, chercher le titre 'WORKING VENTURE CD-A', cliquer sur info et associer la bourse TSE, et cliquer sur OK.
        Log.Message("1 : Dans Croesus aller au module titres, chercher le titre '" + securityDescription + "', cliquer sur info et associer la bourse '" + securityMainMarket + "', et cliquer sur OK.");
        Login(vServerTitre, testUserName, testUserPassword, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Search_SecurityByDescription(securityDescription);
        var securityDescriptionCell = Get_SecurityGrid_RecordListControl().FindChild(["Uid", "Value"], ["Description", securityDescription], 10);
        if (!securityDescriptionCell.Exists)
            return Log.Error("Le Titre '" + securityDescription + "' n'a pas été trouvé.");
        
        securityDescriptionCell.Click();
        Get_SecuritiesBar_BtnInfo().Click();
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_GrpMarket_CmbMainMarket(), securityMainMarket);
        Get_WinInfoSecurity_BtnOK().Click();
        
        
        //2 : Aller au module de gestion des ordres, créer une ordre d'achat de type Action, ajouter un numéro de compte et une quantité et checher par le titre 'WORKING VENTURE CD-A'
        Log.Message("2 : Aller au module de gestion des ordres, créer une ordre d'achat de type '" + financialInstrument + "', ajouter un numéro de compte et une quantité et chercher par le titre '" + securityDescription + "'.")
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        if (!Get_WinFinancialInstrumentSelector().FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["RadioButton", true, financialInstrument], 10).Exists)
            return Log.Error("Le bouton radio de l'instrument financier '" + financialInstrument + "' n'a pas été trouvé.");
        
        Get_WinFinancialInstrumentSelector().FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["RadioButton", true, financialInstrument], 10).Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 10000);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountNumber + "[Tab]");
        if (VarToStr(Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Text.OleValue) != accountNumber || VarToStr(Get_WinOrderDetail_GrpAccount_TxtName().WPFControlText) == "")
            return Log.Error("Le compte Numéro '" + accountNumber + "' n'a pas été trouvé.");
        
        Get_WinStocksOrderDetail_TxtQuantity().Clear();
        Get_WinStocksOrderDetail_TxtQuantity().Keys(1);
        
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_SubMenus().Find("Text", "Description", 10).Click();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(securityDescription + "[Tab]");
        if (VarToStr(Get_WinOrderDetail_GrpSecurity_TxtSymbol().WPFControlText) != "")
            return Log.Error("Le titre '" + securityDescription + "' n'est pas disponible dans la liste de titres pour l'ordre d'achat.");
        
        Log.Checkpoint("Le titre '" + securityDescription + "' n'est pas disponible dans la liste de titres pour l'ordre d'achat.");
        Get_WinOrderDetail_BtnCancel().Click();
        
        
        //3 : Aller dans le menu OUTILS > Configurations > Catégorisation de Titres et trouver la sous-catégorie 'Fonds de placement spéciaux (5810)', faire une click-droit et cliquer sur Modifier
        Log.Message("3 : Aller dans le menu OUTILS > Configurations > Catégorisation de Titres et trouver la sous-catégorie '" + subcategoryFullDescription + "', faire une click-droit et cliquer sur Modifier.");
        OpenSecurityCategorisationWindow();
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryFullDescription).ClickR();
        Get_Win_ContextualMenu_Edit().Click();
        
        
        //4 : Dans la fenetre de modification du fonds, ajouter un mois et année de création et dans le champ 'Négocier en tant que:' replacer l'option Fond d'investissement par Action et sauvegarder.
        Log.Message("4 : Dans la fenetre de modification du fonds, ajouter un mois et année de création et dans le champ 'Négocier en tant que:' remplacer l'option '" + subcategoryTradeAs_FormerValue + "' par '" + subcategoryTradeAs_UpdateValue + "', et sauvegarder.")
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y"));
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().ClickItem(0);
        
        CheckEquals(VarToStr(Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs().SelectedItem.Value), subcategoryTradeAs_FormerValue, "'" + subcategoryFullDescription + "' subcategory 'Trade As' former value");
        
        var subcategoryTradeAs_UpdateValueIndex = GetComboboxItemIndex(Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs(), subcategoryTradeAs_UpdateValue);
        if (subcategoryTradeAs_UpdateValueIndex === null)
            return Log.Error("L'élément '" + subcategoryTradeAs_UpdateValue + "' n'a pas été trouvé dans la liste des éléments du combobox 'Négocier en tant que'.");
        
        Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs().ClickItem(subcategoryTradeAs_UpdateValueIndex);
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        if (!Get_DlgInformation().Exists)
            Log.Error("La boîte de dialogue 'Information' ne s'est pas affichée");
        else {
            aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual, restartMessage);
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        
        
        //5 : Re-ouvrir l'application et aller dans le module de Gestion des ordres, créer un ordre d'achat de type Action, ajouter un numero de compte et quantité et dans le champ titres chercher par le titre 'WORKING VENTURE CD-A'
        Log.Message("5 : Re-ouvrir l'application et aller dans le module de Gestion des ordres, créer un ordre d'achat de type '" + financialInstrument + "', ajouter un numero de compte et quantité et dans le champ titres chercher par le titre '" + securityDescription + "'.");
        CloseCroesusFromSecurityCategorisationWindow();
        Login(vServerTitre, testUserName, testUserPassword, language);
        
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        Get_WinFinancialInstrumentSelector().FindChild(["ClrClassName", "IsVisible", "WPFControlText"], ["RadioButton", true, financialInstrument], 10).Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 10000);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountNumber + "[Tab]");
        if (VarToStr(Get_WinOrderDetail_GrpAccount_TxtName().WPFControlText) == "")
            return Log.Error("Le compte Numéro '" + accountNumber + "' n'a pas été trouvé.");
        
        Get_WinStocksOrderDetail_TxtQuantity().Clear();
        Get_WinStocksOrderDetail_TxtQuantity().Keys(1);
        
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_SubMenus().Find("Text", "Description", 10).Click();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(securityDescription + "[Tab]");
        Get_WinOrderDetail_GrpSecurity_TxtMarket().WaitProperty("WPFControlText", securityMainMarket, 5000);
        Get_WinOrderDetail_GrpSecurity_TxtSymbol().WaitProperty("WPFControlText", securityDescription, 5000);
        if (VarToStr(Get_WinOrderDetail_GrpSecurity_TxtSymbol().WPFControlText) == securityDescription && VarToStr(Get_WinOrderDetail_GrpSecurity_TxtMarket().WPFControlText) == securityMainMarket)
            Log.Checkpoint("Le titre '" + securityDescription + "' est maintenant disponible comme un ordre de type achat, même si le titre en question est de type '" + subcategoryTradeAs_FormerValue + "'.");
        else {
            Log.Error("Échec de la vérification si le titre '" + securityDescription + "' est maintenant disponible comme un ordre de type achat.");
            CheckEquals(VarToStr(Get_WinOrderDetail_GrpSecurity_TxtSymbol().WPFControlText), securityDescription, "Security Description");
            CheckEquals(VarToStr(Get_WinOrderDetail_GrpSecurity_TxtMarket().WPFControlText), securityMainMarket, "Security Market");
        }
        
        Get_WinOrderDetail_BtnCancel().Click();
        
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        if (typeof testUserPassword == "undefined")
            return Terminate_CroesusProcess();
        
        Log.Message("********* CLEANUP ***********");
        
        //Restaurer l'ancienne valeur de la rubrique 'Négocier en tant que'
        if (typeof subcategoryTradeAs_FormerValue != "undefined" && typeof subcategoryTradeAs_UpdateValueIndex != "undefined" && subcategoryTradeAs_UpdateValueIndex !== null){
            Login(vServerTitre, testUserName, testUserPassword, language);
            OpenSecurityCategorisationWindow();
            Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategory(subcategoryFullDescription).ClickR();
            Get_Win_ContextualMenu_Edit().Click();
            var subcategoryTradeAs_FormerValueIndex = GetComboboxItemIndex(Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs(), subcategoryTradeAs_FormerValue);
            if (subcategoryTradeAs_FormerValueIndex === null)
                Log.Error("L'élément '" + subcategoryTradeAs_FormerValue + "' n'a pas été trouvé dans la liste des éléments du combobox 'Négocier en tant que'.");
            else
                Get_WinAddSecurityCategorisation_GrpDisplay_CmbTradeAs().ClickItem(subcategoryTradeAs_FormerValueIndex);
            Get_WinAddSecurityCategorisation_BtnSave().Click();
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
            CloseCroesusFromSecurityCategorisationWindow();
        }
        
        //Supprimer le marché du titre
        var descFieldName = (language == "french")? "DESC_L1": "DESC_L2";
        Execute_SQLQuery("update B_TITRE set BOURSE = '' where " + descFieldName + " = '" + securityDescription + "'", vServerTitre);
        Terminate_CroesusProcess();
    }
}
