//USEUNIT CR1449_Common



/**
    Description : Valider les conditions initiale et secondaire
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5437
    Analyste d'assurance qualité : Daniel-Patrick Colas
    Analyste d'automatisation : Christophe Paring
*/

function CR1449_5437_Tit_Valider_les_conditions_initiale_et_secondaire()
{
    try {
        NameMapping.TimeOutWarning = false;
        
        var categoryLabel = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_CategoryLabel", language + client);
        var subcategoryFullDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_SubcategoryFullDescription", language + client);
        var subcategoryShortDescription = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_SubcategoryShortDescription", language + client);
        var initialConditionDefaultDefinition = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionDefaultDefinition", language + client);
        var initialConditionVerb = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionVerb", language + client);
        var initialConditionFieldCategory = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionFieldCategory", language + client);
        var initialConditionFieldName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionFieldName", language + client);
        var initialConditionOperator = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionOperator", language + client);
        var initialConditionSecurityNo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_InitialConditionSecurityNo", language + client);
        var secondaryConditionSecurityNo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_SecondaryConditionSecurityNo", language + client);
        var secondaryConditionFirstSecurityNo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_SecondaryConditionFirstSecurityNo", language + client);
        var secondaryConditionLastSecurityNo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_SecondaryConditionLastSecurityNo", language + client);
        var loaderFileName = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_LoaderFileName", language + client);
        var loaderFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTitres\\Titres\\" + loaderFileName;
        var vserverFolder = "/tmp/";
        
        //Se connecter avec l'utilisateur GP1859
        var user = "GP1859";
        if (client == "CIBC")
            user = "UNI00"
        var testUserName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", user, "username");
        var testUserPassword = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", user, "psw");
        
        //Vérifier les préconditions
        VerifyPreconditionsOfCR1449(testUserName);
        
        
        //1 : Aller à la fenêtre de catégorisation de titres, choisir l'option 'Titres de croissance' > 'Actions ordinaires (650) faire un click-droit et cliquer sur Modifier
        Log.Message("1 : Aller à la fenêtre de catégorisation de titres, choisir l'option '" + categoryLabel + "' > '" + subcategoryFullDescription + "', faire un click-droit et cliquer sur Modifier.");
        Login(vServerTitre, testUserName, testUserPassword, language);
        OpenSecurityCategorisationWindow();
        Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryFullDescription).ClickR();
        Get_Win_ContextualMenu_Edit().Click();
        
        //Voir que la partie de Condition initale contient la définition 'Liste des titre <Verbe>
        CheckEquals(Trim(GetCriterionConditionDisplayedText(Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition())), initialConditionDefaultDefinition, "Initial condition existing definition");
        
        //Voir que la condition secondaire affiche 0 pour le premier no de titre et 749999 pour le dernier no de titre.
        if (Get_WinEditSecurityCategorisation_GrpSecondaryCondition_DgvConditions().FindChild(["IsVisible", "ClrClassName", "DataContext.SecurityLo.OleValue", "DataContext.SecurityHi.OleValue"], [true, "ListViewItem", secondaryConditionFirstSecurityNo, secondaryConditionLastSecurityNo]).Exists)
            Log.Checkpoint("La condition secondaire affiche '" + secondaryConditionFirstSecurityNo + "' pour le premier no de titre et '" + secondaryConditionLastSecurityNo + "' pour le dernier no de titre.");
        else
            Log.Error("La condition secondaire n'affiche pas '" + secondaryConditionFirstSecurityNo + "' pour le premier no de titre et '" + secondaryConditionLastSecurityNo + "' pour le dernier no de titre.");
        
        
        //2 : Remplir les champs de mois et année de création et Modifier la condition iniale avec la définition suivant: 'Liste des titres ayant numéro de titre égal(e) à 987654.'. Sauvegarder et quitter l'application
        Log.Message("2 : Remplir les champs de mois et année de création et Modifier la condition iniale avec la définition suivant: 'Liste des titres " + initialConditionVerb + " " + initialConditionFieldName + " " + initialConditionOperator + " " + initialConditionSecurityNo + ".'. Sauvegarder et quitter l'application.");
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Clear();
        Get_WinAddSecurityCategorisation_GrpDefinition_TxtCreationYear().Keys(aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y"));
        Get_WinAddSecurityCategorisation_GrpDefinition_CmbCreationMonth().ClickItem(1);
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbVerb().Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(initialConditionVerb).Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbField().Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(initialConditionFieldCategory).Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(initialConditionFieldName).Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbOperator().Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_Item(initialConditionOperator).Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbValue().DblClick(); Sys.Keys(initialConditionSecurityNo);
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_LlbNext().Click();
        Get_WinEditSecurityCategorisation_GrpInitialCondition_LstDefinition_ItemDot().Click();
        Get_WinAddSecurityCategorisation_BtnSave().Click();
        Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        CloseCroesusFromSecurityCategorisationWindow();
        
        
        //3 : Via SSH accéder le vserver en mode root, et rédémarrer le 'agent server' pour valider la nouvelle définition créée : service cfagentserver restart
        Log.Message("3 : Via SSH accéder le vserver en mode root, et rédémarrer le 'agent server' pour valider la nouvelle définition créée : service cfagentserver restart");
        var nbOfSecurities_BeforeLoaderCommand = Execute_SQLQuery_GetField("select count(*) as nbSecurities from b_titre", vServerTitre, "nbSecurities");
        ExecuteSSHCommandCFLoader("CR1449", vServerTitre, "service cfagentserver restart", testUserName);
        
        //3 suite : Ensuite copier le fichier sec_catego.xml dans le vserver et lancer la commande loader : loader sec_categ.xml -FORCE -LOG2STDOUT
        Log.Message("3 suite : Ensuite copier le fichier '" + loaderFileName + "' dans le vserver et lancer la commande loader : loader " + loaderFileName + " -FORCE -LOG2STDOUT");
        CopyFileToVserver(vServerTitre, testUserName, vserverFolder + loaderFileName, loaderFilePath);
        var sshCommands = "cd " + vserverFolder;
        sshCommands += "\nloader " + loaderFileName + " -FORCE -LOG2STDOUT";
        ExecuteSSHCommandCFLoader("CR1449", vServerTitre, sshCommands, testUserName);
        
        //Vérifier que deux nouveaux titres ont été ajoutés dans Croesus.
        Log.Message("Vérifier que deux nouveaux titres ont été ajoutés dans Croesus.");
        var nbOfSecurities_AfterLoaderCommand = Execute_SQLQuery_GetField("select count(*) as nbSecurities from b_titre", vServerTitre, "nbSecurities");
        var nbOfNewSecurities = nbOfSecurities_AfterLoaderCommand - nbOfSecurities_BeforeLoaderCommand;
        CheckEquals(nbOfNewSecurities, 2, "Number of new securities added after SSH Commands");
        
        
        //4 : Retourner à l'application et aller vers le module titres, chercher les titres 123456 et 987654
        Log.Message("4 : Retourner à l'application et aller vers le module titres, chercher les titres '" + initialConditionSecurityNo + "' et '" + secondaryConditionSecurityNo + "' et valider leur sous-catégorie.");
        Login(vServerTitre, testUserName, testUserPassword, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked.OleValue", true, 100000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

        var initialConditionSecurityRowIndex = GetSecurityRowIndex(initialConditionSecurityNo);        
        var actualSubcategory_ForInitialConditionSecurityNo = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, initialConditionSecurityRowIndex], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SubCategoryDescription"], 10).WPFControlText;
        if (actualSubcategory_ForInitialConditionSecurityNo == subcategoryShortDescription)
            Log.Checkpoint("Le titre '" + initialConditionSecurityNo + "' a la sous-catégorie '" + subcategoryShortDescription + "' configurée en raison de la condition primaire.");
        else
            Log.Error("Le titre '" + initialConditionSecurityNo + "' n'a pas la sous-catégorie '" + subcategoryShortDescription + "' (qui devrait être configurée en raison de la condition primaire).", "Le titre '" + initialConditionSecurityNo + "' a plutôt la sous-catégorie '" + actualSubcategory_ForInitialConditionSecurityNo + "'." );
        
        var secondaryConditionSecurityRowIndex = GetSecurityRowIndex(secondaryConditionSecurityNo);
        var actualSubcategory_ForSecondaryConditionSecurityNo = Get_SecurityGrid_RecordListControl().FindChild(["ClrClassName", "IsHeaderRecord", "WPFControlOrdinalNo"], ["DataRecordPresenter", false, secondaryConditionSecurityRowIndex], 10).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "SubCategoryDescription"], 10).WPFControlText;
        if (actualSubcategory_ForSecondaryConditionSecurityNo == subcategoryShortDescription)
            Log.Checkpoint("Le titre '" + secondaryConditionSecurityNo + "' a la sous-catégorie '" + subcategoryShortDescription + "' configurée en raison de la condition secondaire.");
        else
            Log.Error("Le titre '" + secondaryConditionSecurityNo + "' n'a pas la sous-catégorie '" + subcategoryShortDescription + "' (qui devrait être configurée en raison de la condition secondaire).", "Le titre '" + secondaryConditionSecurityNo + "' a plutôt la sous-catégorie '" + actualSubcategory_ForSecondaryConditionSecurityNo + "'." );
        
        
        //Fermer Croesus
        CloseCroesus();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        if (typeof testUserPassword == "undefined") return Terminate_CroesusProcess();
        
        Log.Message("********* CLEANUP ***********");
        
        //Supprimer la condition initiale de la sous-catégorie 'Titres de croissance' > 'Actions ordinaires (650)'
        Login(vServerTitre, testUserName, testUserPassword, language);
        OpenSecurityCategorisationWindow();
        if (Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryFullDescription).Exists){
            Get_WinSecurityCategorisationConfiguration_TvwTreeview_LlbSubcategoryInCategory(categoryLabel, subcategoryFullDescription).ClickR();
            Get_Win_ContextualMenu_Edit().Click();
            Get_WinEditSecurityCategorisation_GrpInitialCondition_BtnDelete().Click();
            Get_WinAddSecurityCategorisation_BtnSave().Click();
            Get_DlgInformation().Click(Get_DlgInformation().get_ActualWidth()/2, Get_DlgInformation().get_ActualHeight()-45);
        }
        CloseCroesusFromSecurityCategorisationWindow();
        Terminate_CroesusProcess();
        
        //Supprimer les titres qui ont été ajoutés par la commande Loader
        var stringOfSecurityNos = "('" + initialConditionSecurityNo + "'" + ", '" + secondaryConditionSecurityNo + "')";
        Execute_SQLQuery("delete B_SECURITY_EXCHANGE where SYMBOL in (select SYMBOLE from B_TITRE where SECUFIRME in " + stringOfSecurityNos + ")", vServerTitre);
        Execute_SQLQuery("delete B_TITRE where SECUFIRME in " + stringOfSecurityNos, vServerTitre);
    }
}

