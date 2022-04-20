//USEUNIT CR1449_Common
//USEUNIT PDFUtils



/**
    Description : Valider l'affichage de nouvelles sous-catégories dans Croesus
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5439
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5439_Tit_Valider_laffichage_de_nouvelles_sous_categories_dans_Croesus()
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var subcategoryEnglishDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryDescription", "english" + client);
        var subcategoryShortEnglishDesc = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryShortDescription", "english" + client);
        var subcategoryFrenchDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryDescription", "french" + client);
        var subcategoryShortFrenchDesc = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryShortDescription", "french" + client);
        var subcategoryDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryDescription", language + client);
        var subcategoryShortDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryShortDescription", language + client);
        
        var categoryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_CategoryLabel", language + client);
        var subcategoryYield = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoryYield", language + client);
        var financialInstrument = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_FinancialInstrument", language + client);
        var financialInstrumentDetail = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_FinancialInstrumentDetail", language + client);
        
        var securityEnglishDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityDescription", "english" + client);
        var securityFrenchDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityDescription", "french" + client);
        var securityDescription = aqString.ToUpper(ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityDescription", language + client));
        var securityCountry = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityCountry", language + client);
        var securityBid = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityBid", language + client);
        var securityAsk = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SecurityAsk", language + client);
        var securityNumber = "Z~" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d%H%M");
        
        var externalAccountNumber, modelNumber;
        var externalAccountClientName = aqString.ToUpper(ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_ExternalAccountClientName", language + client));
        var IACode = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_IACode", language + client);
        var tansactionType = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_TansactionType", language + client);
        var tansactionQuantity = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_TansactionQuantity", language + client);
        var tansactionPrice = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_TansactionPrice", language + client);
        
        var securityFilterName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_FilterName", language + client);
        var securityFilterConditionField = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_FilterConditionField", language + client);
        var securityFilterConditionOperator = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_FilterConditionOperator", language + client);
        
        var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SearchCriterionName", language + client);
        var searchCriterionConditionVerb = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SearchCriterionConditionVerb", language + client);
        var searchCriterionConditionOperator = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SearchCriterionConditionOperator", language + client);
        
        var reportDisplayedName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_ReportDisplayedName", language + client);
        
        var subcategoriesLabelInRestictions = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_SubcategoriesLabelInRestictions", language + client);
        var percentageOfTotalValueMin = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RestrictionPercentageOfTotalValueMin", language + client);
        var percentageOfTotalValueMax = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RestrictionPercentageOfTotalValueMax", language + client);
        
        var modelName = aqString.ToUpper(ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_ModelName", language + client));
        var modelPositionPercentage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_ModelPositionPercentage", language + client);
        var rebalancingAccountNumber = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RebalancingAccountNumber", language + client);
        var rebalancingConfirmationMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RebalancingConfirmationMessage", language + client);
        var rebalancingNewOrdersCount = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RebalancingNewOrdersCount", language + client);
        var rebalancingNewAccumulatorOrdersCount = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5439_RebalancingNewAccumulatorOrdersCount", language + client);
        
        var pathReportName = Project.Path + "CR1449_5439_Tit_Report";
        
        //Se connecter avec l'utilisateur GP1859
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw");
        
        //Supprimer les filtres et critères de recherche de même nom        
        Delete_FilterCriterion(securityFilterName, vServerTitre);
        Delete_FilterCriterion(searchCriterionName, vServerTitre);
       
        //Activer la pref du rapport à générer de l'étape 7
        Activate_Inactivate_Pref(testUserName, "PREF_REPORT_GRAPH_ASSET_CAT", "YES", vServerTitre);
        
        //Vérifier les préconditions
        VerifyPreconditionsOfCR1449(testUserName);
        Activate_Inactivate_Pref(testUserName, "PREF_EDIT_REAL_SECURITY", "YES", vServerTitre);
        RestartServices(vServerTitre);
        
        
        //1 : Aller à la fenêtre de configuration > catégorisation de titres, cliquer dans la catégorie 'Titres à revenues fixes' et créer une nouvelle sous-catégorie (cliquer sur Ajouter) basée sur le 'Rendement' Obligations ordinaires avec 'Instr. financier' et 'Détail instr. financier' de type Obligation.
        Log.Message("1 : Aller à la fenêtre de configuration > catégorisation de titres, cliquer dans la catégorie '" + categoryLabel + "' et créer une nouvelle sous-catégorie (cliquer sur Ajouter) basée sur le 'Rendement' " + subcategoryYield + " avec 'Instr. financier' de type " + financialInstrument + " et 'Détail instr. financier' de type " + financialInstrumentDetail);
        Login(vServerTitre, testUserName, testUserPassword, language);
        
        OpenSecurityCategorisationWindow();
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbCategory(categoryLabel).Click();
        Get_WinSecurityCategorisationConfigurationsBtnAdd().Click();
        
        //Attributs spécifiés dans le cas de test
        var yieldValueIndex = GetComboboxItemIndex(Get_WinAddSecurityCategorisation_GrpDefinition_CmbYield(), subcategoryYield);
        if (yieldValueIndex === null)
            return Log.Error("L'élément '" + subcategoryYield + "' n'a pas été trouvé dans la liste des éléments du combobox 'Rendement'.");
        
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbYield().ClickItem(yieldValueIndex);
        
        var financialInstrumentValueIndex = GetComboboxItemIndex(Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstr(), financialInstrument);
        if (financialInstrumentValueIndex === null)
            return Log.Error("L'élément '" + financialInstrument + "' n'a pas été trouvé dans la liste des éléments du combobox 'Instr. financier'.");
        
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstr().ClickItem(financialInstrumentValueIndex);
        
        var financialInstrumentDetailValueIndex = GetComboboxItemIndex(Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstrDetail(), financialInstrumentDetail);
        if (financialInstrumentDetailValueIndex === null)
            return Log.Error("L'élément '" + financialInstrumentDetail + "' n'a pas été trouvé dans la liste des éléments du combobox 'Détail instr. financier'.");
        
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFinancialInstrDetail().ClickItem(financialInstrumentDetailValueIndex);
        
        //Autres attributs (choix libre)
        Get_WinAddSecurityCategorisation_GrpDescription_TxtEnglishDescription().Keys(subcategoryEnglishDescription);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtShortEnglishDesc().Keys(subcategoryShortEnglishDesc);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtFrenchDescription().Keys(subcategoryFrenchDescription);
        Get_WinAddSecurityCategorisation_GrpDescription_TxtShortFrenchDesc().Keys(subcategoryShortFrenchDesc);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbIntDivFrequency().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbFactorSign().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbDayCount().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtSettlementDays().Keys(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbOverwriteInvCost().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y"));
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDisplay_CmbDisplayFactor().ClickItem(1);
        Get_WinAddSecurityCategorisation_GrpDisplay_CmbNumberOfDecimals().ClickItem(1);
        
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        Get_DlgInformation_BtnOK().Click();
        
        if (Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryDescription).Exists)
            Log.Checkpoint("La nouvelle sous-catégorie '" + subcategoryDescription + "' a été bien créée dans la liste '" + categoryLabel + "'.");
        else
            Log.Error("La nouvelle sous-catégorie '" + subcategoryDescription + "' n'a pas été bien créée dans la liste '" + categoryLabel + "'.");
        
        CloseCroesusFromSecurityCategorisationWindow();
        
        
        //2 : Retourner à l'application et aller au module Titres, faire une Ctrl+N pour créer un nouveau titre (réel ou manuel) basée sur l'instrument financier 'Obligation'
        Log.Message("2 : Retourner à l'application et aller au module Titres, faire une Ctrl+N pour créer un nouveau titre (réel ou manuel) basée sur l'instrument financier '" + financialInstrument + "'");
        Login(vServerTitre, testUserName, testUserPassword, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Get_MainWindow().Keys("^n");
        Get_WinCreateSecurity_GrpFinancialInstrument_RdoReal().Click();
        Get_WinCreateSecurity_LstCategories_Item(financialInstrument).Click();
        Get_WinCreateSecurity_BtnOK().Click();
        
        Get_WinInfoSecurity_GrpDescription_CmbSubCategory().Click();
        var subcategoryDescriptionComboBoxItem = Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", subcategoryDescription]);
        if (!subcategoryDescriptionComboBoxItem.Exists)
            return Log.Error("La nouvelle sous-catégorie '" + subcategoryDescription + "' n'est pas disponible dans la liste de sous-catégories'.");
        
        Log.Checkpoint("La nouvelle sous-catégorie '" + subcategoryDescription + "' est disponible dans la liste de sous-catégories'.");
        
        
        //3 : Choisir la nouvelle sous-catégorie et remplir les champs obligatoires pour compléter l'ajout d'un nouveau titre et cliquer sur OK pour confirmer la création du titre.
        Log.Message("3 : Choisir la nouvelle sous-catégorie et remplir les champs obligatoires pour compléter l'ajout d'un nouveau titre et cliquer sur OK pour confirmer la création du titre.")
        subcategoryDescriptionComboBoxItem.Click();
        Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(securityEnglishDescription);
        Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(securityFrenchDescription);
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbCountry(), securityCountry);
        Get_WinInfoSecurity_GrpDescription_TxtSecurity().Click();
        Get_WinInfoSecurity_GrpDescription_TxtSecurity().set_Text(securityNumber);
        Get_WinInfoSecurity_TabInfo().Click();
        Get_WinInfoSecurity_TabInfo().WaitProperty("IsSelected", true, 60000);
        Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity().Click();
        Get_WinInfoSecurity_TabInfo_GrpDividends_TxtMaturity().Keys("[Tab][Enter]");
        Get_Calendar_BtnToday().Click();
        Get_Calendar_BtnOK().Click();
        Get_WinInfoSecurity_BtnOK().Click();
                
        var securityRowIndex = GetSecurityDescriptionRowIndex(securityDescription);
        if (securityRowIndex === null)
            return Log.Error("Le nouveau titre '" + securityDescription + "' ne s'est pas affiché dans le module.");
        
        var securityDisplayedSubcategory = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, securityRowIndex], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SubCategoryDescription"], 10).WPFControlText;
        CheckEquals(securityDisplayedSubcategory, subcategoryDescription, "The displayed subcategory for security '" + securityDescription + "'");
        
        
        //4 : Dans le module titres, créer un filtre rapide (Ctrl+Shift+F),  basée sur le champ sous-catégorie.
        Log.Message("4 : Dans le module titres, créer un filtre rapide (Ctrl+Shift+F),  basée sur le champ sous-catégorie.");
        Get_MainWindow().Keys("^F");
        Get_WinQuickFiltersManager_PadHeaderBar_BtnAdd().Click();
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(), securityFilterConditionField);
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(), securityFilterConditionOperator);
        Get_WinAddFilter_GrpCondition_CmbValue().Click();
        var subcategoryShortDescriptionComboBoxItem = Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", subcategoryShortDescription]);
        if (!subcategoryShortDescriptionComboBoxItem.Exists)
            return Log.Error("La nouvelle sous-catégorie '" + subcategoryShortDescription + "' n'a pas été trouvée dans la liste des éléments du combobox 'Valeur'.");
        
        Log.Checkpoint("La nouvelle sous-catégorie '" + subcategoryShortDescription + "' se trouve dans la liste des éléments du combobox 'Valeur'.");
        subcategoryShortDescriptionComboBoxItem.Click();
        
        Get_WinAddFilter_TxtName().Keys(securityFilterName);
        Get_WinAddFilter_BtnOK().Click();
        Get_WinQuickFiltersManager_BtnClose().Click();
        
        LoadExistingSecuritiesAndOrdersFilter(securityFilterName);
        CheckEquals(Get_SecurityGrid_RecordListControl().Items.Count, 1, "The number of securities displayed upon " + securityFilterName + " filter execution");
        var firstRowDisplayedSubcategory = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SubCategoryDescription"], 10).WPFControlText;
        var firstRowDisplayedDescription = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Description"], 10).WPFControlText;
        CheckEquals(firstRowDisplayedSubcategory, subcategoryDescription, "The first row displayed subcategory");
        CheckEquals(firstRowDisplayedDescription, aqString.ToUpper(securityDescription), "The first row displayed description");
        
        
        //5 : Dans le module titres, crée une critère de recherche (Menu RECHERCHE > Critères de recherche > Ajouter un critère), basée sur la nouvelle sous-catégorie.
        Log.Message("5 : Dans le module titres, crée une critère de recherche (Menu RECHERCHE > Critères de recherche > Ajouter un critère), basée sur la nouvelle sous-catégorie.");
        ExecuteActionAndExpectSubmenus(Get_MenuBar_Search(), "Click()");
        Get_MenuBar_Search_SearchCriteria().Click();
        Get_MenuBar_Search_SearchCriteria_AddACriterion().CLick();
        
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(searchCriterionName);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(searchCriterionConditionVerb).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSubcategory().HoverMouse();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSubcategory().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(searchCriterionConditionOperator).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
        Get_WinAddSearchCriterion_LvwDefinition_Item(subcategoryShortDescription).Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 30000);
        Delay(1000); //For the NbOfcheckedElements to be updated
        
        CheckEquals(VarToStr(Get_MainWindow_StatusBar_NbOfcheckedElements().ToolTip.OleValue), searchCriterionName, "Search Criterion Name in the status bar tooltip");
        CheckEquals(Get_SecurityGrid_RecordListControl().Items.Count, 1, "The number of securities displayed upon " + searchCriterionName + " criterion execution");
        var firstRowDisplayedSubcategory = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SubCategoryDescription"], 10).WPFControlText;
        var firstRowDisplayedDescription = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Description"], 10).WPFControlText;
        CheckEquals(firstRowDisplayedSubcategory, subcategoryDescription, "The first row displayed subcategory");
        CheckEquals(firstRowDisplayedDescription, aqString.ToUpper(securityDescription), "The first row displayed description");
        
        
        //6 : Associer le nouveau titre contenant la nouvelle sous-catégorie à une compte externe ou fictif  (ou créer à partir du module comptes) et mailler vers portefeille
        Log.Message("6 : Associer le nouveau titre contenant la nouvelle sous-catégorie à une compte externe ou fictif  (ou créer à partir du module comptes) et mailler vers portefeille");
        
        //Ajouter un prix d'achat et un prix de vente au titre
        Log.Message("Ajouter un prix d'achat et un prix de vente au titre '" + securityDescription + "'.");
        Get_SecurityGrid().FindChild("Value", securityDescription, 10).Click();
        Get_SecuritiesBar_BtnInfo().Click();
        Get_WinInfoSecurity_TabInfo().Click();
        Get_WinInfoSecurity_TabInfo().WaitProperty("IsSelected", true, 60000);
        Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Keys(securityBid);
        Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Keys(securityAsk);
        Get_WinInfoSecurity_BtnOK().Click();    
        
        //Créer un Compte externe
        CreateExternalClient(externalAccountClientName, IACode);
        SearchClientByName(externalAccountClientName);
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", externalAccountClientName, 10), Get_ModulesBar_BtnAccounts());
        Get_Toolbar_BtnAdd().Click();
        Get_WinDetailedInfo_BtnOK().Click();
        Delay(10000);
        
        //Créer une transaction portant sur le titre avec le compte
        Search_AccountByName(externalAccountClientName);
        externalAccountNumber = Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["Name", externalAccountClientName], 10).DataContext.DataItem.AccountNumber.OleValue;
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["Name", externalAccountClientName], 10), Get_ModulesBar_BtnTransactions());
        CreateATransaction(tansactionType, externalAccountNumber, securityNumber, tansactionQuantity, tansactionPrice);
        
        //Mailler le compte vers Portefeuille
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        SearchAccount(externalAccountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["AccountNumber", externalAccountNumber], 10).Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["AccountNumber", externalAccountNumber], 10), Get_ModulesBar_BtnPortfolio());
        CheckDisplayedSubcategoryDescriptionForSecurityInPortfolioGrid(securityDescription, subcategoryDescription);
        
        
        //7 : Dans le module comptes, choisir le compte externe ou fictif qui contient le nouveau titre et générer le rapport de 'Répartition d'actifs (graphique par sous-catégorie)'
        Log.Message("7 : Dans le module comptes, choisir le compte externe ou fictif '" + externalAccountNumber + "' qui contient le nouveau titre et générer le rapport de '" + reportDisplayedName + "'.");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
        SearchAccount(externalAccountNumber);
        Get_RelationshipsClientsAccountsGrid().FindChild(["Uid", "Value"], ["AccountNumber", externalAccountNumber], 10).Click();
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitReportsWindow();
        SelectReports(reportDisplayedName);
        ValidateAndSaveReportAsPDF(pathReportName);
        
        //Vérifier si la nouvelle sous-catégorie apparaît dans le graphique du rapport.
        Log.Message("Vérifier si la nouvelle sous-catégorie '" + subcategoryDescription + "' apparaît dans le graphique du rapport.");
        var reportFilePath = pathReportName + ".pdf"; //Chemin d'accès du fichier PDF
        var PDFPageNumber = 1; //Numéro de la page cible du fichier PDF
        CheckIfExpectedStringIsDisplayedInPDFPagePicture(subcategoryDescription, reportFilePath, PDFPageNumber, null, null, 15000);
        
        //Vérifier si le nombre d'images a évolué, dans la page cible du fichier PDF
        var arrayOfPDFPagePictures = GetPdfPagesImagesThroughCommandLine(reportFilePath, PDFPageNumber);
        var expectedNumberOfPicturesInPDFPage = 1;
        var actualNumberOfPicturesInPDFPage = arrayOfPDFPagePictures.length;
        if (expectedNumberOfPicturesInPDFPage != actualNumberOfPicturesInPDFPage)
            Log.Warning(actualNumberOfPicturesInPDFPage + " image(s) au lieu de " + expectedNumberOfPicturesInPDFPage + " attendue(s) ont pu être récupérée(s) dans la page " + PDFPageNumber + " du fichier " + reportFilePath, "Fichier : " + reportFilePath);
        
        //8 : Dans le module Comptes, cliquer sur le bouton de 'Restrictions', ajouter une restriction basée sur 'Groupe ou classe', choisir l'option sous-catégorie.
        Log.Message("8 : Dans le module Comptes, cliquer sur le bouton de 'Restrictions', ajouter une restriction basée sur 'Groupe ou classe', choisir l'option " + subcategoriesLabelInRestictions);
        //Que la sous-catégorie ne soit pas trouvée ou qu'il y ait un problème lors de la création de la restriction, la fonction AddGroupOrClassRestriction() va générer une erreur
        Get_RelationshipsAccountsBar_BtnRestrictions().Click();
        AddGroupOrClassRestriction(subcategoriesLabelInRestictions, subcategoryShortDescription, percentageOfTotalValueMin, percentageOfTotalValueMax);
        
        
        //9 : Dans le module Modèles, associer le nouveaux titre avec la nouvelle sous-catégorie dans une modèle, activer le modèle et mailler vers portefeille.
        Log.Message("9 : Dans le module Modèles, associer le nouveau titre avec la nouvelle sous-catégorie dans une modèle, activer le modèle et mailler vers portefeille.");
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Create_Model(modelName, "", IACode);
        var modelNumber = Get_ModelNo(modelName);
        ActivateDeactivateModel(modelName, false);
        Drag(Get_ModelsGrid().FindChild(["Uid", "Value"], ["Name", modelName], 10), Get_ModulesBar_BtnPortfolio());
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityDescription, modelPositionPercentage, "Description", securityDescription);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_ChkReactivateTheModelAfterSaving().set_IsChecked(false);
        Get_WinWhatIfSave_BtnOK().Click();
        Log.Message("Bug JIRA CROES-10000");
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        ActivateDeactivateModel(modelName, true);
        Drag(Get_ModelsGrid().FindChild(["Uid", "Value"], ["Name", modelName], 10), Get_ModulesBar_BtnPortfolio());
        CheckDisplayedSubcategoryDescriptionForSecurityInPortfolioGrid(securityDescription, subcategoryDescription);
        
        
        //10 : Dans le module Modèles, choisir le même modèle avec le titre qui contient la nouvelle sous-catégorie et faire une rééquilibrage.
        Log.Message("10 : Dans le module Modèles, choisir le même modèle avec le titre qui contient la nouvelle sous-catégorie et faire une rééquilibrage.");    
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 30000);
        var formerAccumulatorCount = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Count;
        
        AssignAccountToModel(rebalancingAccountNumber, modelNumber);
        Get_ModulesBar_BtnModels().Click();
        Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_ModelsGrid().FindChild(["Uid", "Value"], ["Name", modelName], 10).Click();
        Get_Toolbar_BtnRebalance().Click();
        Get_WinRebalance().Parent.Maximize();
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 1
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 2
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 3
        if (Get_WinWarningDeleteGeneratedOrders().Exists)
            Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        
        Get_WinRebalance_BtnNext().Click(); //Rebalancing step 4
        CheckEquals(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Items.Count, rebalancingNewOrdersCount, "The number of new orders to be generated");
        Get_WinRebalance_BtnGenerate().Click(); //Rebalancing step 5
        Get_WinGenerateOrders_BtnGenerate().Click(); //Rebalancing Results
        
        CheckEquals(VarToStringWithoutInvisibleCharacters(Get_DlgConfirmation_LblMessage().Message), VarToStringWithoutInvisibleCharacters(rebalancingConfirmationMessage), "The rebalancing Confirmation Message");
        Get_DlgConfirmation_BtnNo().Click();
    
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 30000);
        aqObject.CheckProperty(Get_ModulesBar_BtnOrders().IsChecked, "OleValue", cmpEqual, true, true);
        var updatedAccumulatorCount = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Count;
        CheckEquals((updatedAccumulatorCount - formerAccumulatorCount), rebalancingNewAccumulatorOrdersCount, "After rebalancing the number of new orders generated in the Accumulator");
        
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
        Execute_SQLQuery("update b_compte set lock_id = null", vServerTitre);
        Login(vServerTitre, testUserName, testUserPassword, language);
        if (modelNumber != undefined)
            DeleteRebalancingOfModel(modelNumber);
        RemoveAccountFromModel(rebalancingAccountNumber, modelName);
        DeleteModelByName(modelName);
        if (externalAccountNumber != undefined)
            DeleteAccount(externalAccountNumber);
        DeleteClient(externalAccountClientName);
        Delay(10000);
        DeleteSecurityByDescription(securityDescription);
        OpenSecurityCategorisationWindow();
        DeleteSubcategoryInSecurityCategorisation(subcategoryDescription, categoryLabel);
        CloseCroesusFromSecurityCategorisationWindow();
        Execute_SQLQuery("update b_compte set lock_id = null", vServerTitre);
        Delete_FilterCriterion(securityFilterName, vServerTitre);
        Delete_FilterCriterion(searchCriterionName, vServerTitre);
        Activate_Inactivate_Pref(testUserName, "PREF_EDIT_REAL_SECURITY", null, vServerTitre);
        Execute_SQLQuery("update b_compte set lock_id = null", vServerTitre);
        RestartServices(vServerTitre);
        Terminate_CroesusProcess();
        TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
        TerminateProcess("ONENOTE");
    }
}



function DeleteRebalancingOfModel(modelNumber)
{
    //Delete generated orders in the accumulator
    Get_ModulesBar_BtnOrders().Click();
    Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 30000);
    Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, 1], 10).Click();
    var accumulatorCount = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Count;
    var isModelOrderFound = false;
    for (var i = 0; i < accumulatorCount; i++){
        var currentAccumulatorItem = Get_OrderAccumulatorGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).Items.Item(i);    
        if (currentAccumulatorItem.DataItem.SourceForDisplay.OleValue == modelNumber){
            currentAccumulatorItem.set_IsSelected(true);
            isModelOrderFound = true;
        }
        else
            currentAccumulatorItem.set_IsSelected(false);
    }
    
    if (isModelOrderFound){
        Get_OrderAccumulator_BtnDelete().HoverMouse();
        Get_OrderAccumulator_BtnDelete().WaitProperty("IsEnabled", true, 10000);
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation_BtnDelete().Click();
    }
        
    //Cancel Rebalancing
    Get_ModulesBar_BtnModels().Click();
    Get_ModulesBar_BtnModels().WaitProperty("IsChecked.OleValue", true, 100000);
    Search_Model(modelNumber);
    Get_ModelsGrid().FindChild(["Uid", "Value"], ["AccountNumber", modelNumber], 10).Click();
    Get_Toolbar_BtnRebalance().Click();
    Get_WinRebalance().Parent.Maximize();
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 1
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 2
    Get_WinRebalance_BtnNext().Click(); //Rebalancing step 3
    if (Get_WinWarningDeleteGeneratedOrders().Exists)
        Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
    Get_WinRebalance_BtnClose().Click();
    Get_DlgConfirmation_BtnContinue().Click();
}



function CheckDisplayedSubcategoryDescriptionForSecurityInPortfolioGrid(securityDescription, subcategoryDescription)
{
    var portfolioCount = VarToInt(Get_Portfolio_PositionsGrid().Items.Count);
    Get_Portfolio_PositionsGrid_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    Get_Portfolio_PositionsGrid_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
    Get_GridHeader_ContextualMenu_AddColumn_Subcategory().Click();
    var isPositionFound = false;
    for (var positionIndex = 1; positionIndex <= portfolioCount; positionIndex++){
        var positionRow = Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, positionIndex], 10);
        var positionDescription = positionRow.FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "SecurityDescription", true], 10).WPFControlText;
        if (positionDescription != securityDescription)
            continue;
            
        isPositionFound = true;
        positionRow.set_IsSelected(true);
        var subcategoryDisplayedValue = positionRow.FindChild(["ClrClassName", "Uid", "IsVisible"], ["CellValuePresenter", "SubCategoryDescription", true], 10).WPFControlText;
        CheckEquals(subcategoryDisplayedValue, subcategoryDescription, "The position displayed subcategory for security '" + securityDescription + "'");
        positionRow.set_IsSelected(false);
    }
    
    if (!isPositionFound)
        Log.Error("Aucune position relative au titre '" + securityDescription + "' n'a été trouvée, ceci est inattendu.");
    
    Get_Portfolio_PositionsGrid_ChDescription().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
}



function CreateATransaction(tansactionType, tansactionAccount, tansactionSecurityNumber, tansactionQuantity, tansactionPrice, tansactionCurrency)
{
    Get_Toolbar_BtnAdd().Click();
    Log.Message("Bug JIRA PF-371 / QAV-773 : Crash lors de l'ajout d`une transaction sur un compte externe.");
    
    var numberOftries = 0;
    while (numberOftries < 5 && !Get_WinAddTransaction().Exists){
        Get_Toolbar_BtnAdd().Click(); 
        numberOftries++;
    }
    
    Get_WinAddTransaction_GrpType_cmbType().Click(); 
    Get_SubMenus().Find("WPFControlText", tansactionType, 10).Click();

    Get_WinAddTransaction_GrpAccounts_TxtFromAccount().Click();
    Get_WinAddTransaction_GrpAccounts_TxtFromAccount().set_Text(tansactionAccount);
    
    Get_WinAddTransaction_GrpSecurity_TxtSecurity().Click();
    Get_WinAddTransaction_GrpSecurity_TxtSecurity().set_Text(tansactionSecurityNumber);

    Get_WinAddTransaction_GrpAmounts_TxtQuantity().Click();
    Get_WinAddTransaction_GrpAmounts_TxtQuantity().set_Text(tansactionQuantity);

    Get_WinAddTransaction_GrpAmounts_TxtPrix().Click();
    Get_WinAddTransaction_GrpAmounts_TxtPrix().set_Text(tansactionPrice);

    if (tansactionCurrency != undefined && Trim(VarToStr(tansactionCurrency)) !== ""){
        Get_WinAddTransaction_GrpAmounts_cmbCurrency().Click(); 
        Get_SubMenus().Find("WPFControlText", tansactionCurrency, 10).Click();
    }
    
    Get_WinAddTransaction_BtnOK().Click();
    Delay(10000);
}
