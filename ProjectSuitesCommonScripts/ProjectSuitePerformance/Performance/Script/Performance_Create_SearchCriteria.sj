//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA

/* Analyste d'assurance qualité:
Analyste d'automatisation: Xian Wei */

function Performance_CreateSearchCriteria() {
//          var criterionAccountsName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
//          var criterionClientsName = GetData(filePath_Performance, sheetName_DataBD, 30, language);
//          var criterionRelationsName = GetData(filePath_Performance, sheetName_DataBD, 31, language);
//          var criterionSecuritiesName = GetData(filePath_Performance, sheetName_DataBD, 32, language);
//          var criterionSleevesName = GetData(filePath_Performance, sheetName_DataBD, 47, language);
//          var criterionNoAssignModeleName = GetData(filePath_Performance, sheetName_DataBD, 48, language);
//          var criterionModelName = GetData(filePath_Performance, sheetName_DataBD, 36, language);
//          var criterionModelNameCP = GetData(filePath_Performance, sheetName_DataBD, 46, language);
//          var TransactionNomFiltre = GetData(filePath_Performance, sheetName_DataBD, 11, language);
//          var accFilterValueGreat = GetData(filePath_Performance, sheetName_DataBD, 55, language);
//          var cliFilterValueGreat = GetData(filePath_Performance, sheetName_DataBD, 56, language);
//          var filterValue1 = GetData(filePath_Performance, sheetName_DataBD, 57, language);
//          var filterValue2 = GetData(filePath_Performance, sheetName_DataBD, 58, language);
//          var filterValue3 = GetData(filePath_Performance, sheetName_DataBD, 59, language);
//          var criterionValue1 = GetData(filePath_Performance, sheetName_DataBD, 33, language);
//          var criterionValue2 = GetData(filePath_Performance, sheetName_DataBD, 34, language);
//          var criterionValue3 = GetData(filePath_Performance, sheetName_DataBD, 35, language);
          
        var criterionSleevesName    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceSleeves", language+client); 
        var criterionAccountsName   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceAccounts", language+client);
        var criterionClientsName    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceClients", language+client); 
        var criterionRelationsName  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceRelations", language+client);        
        var criterionSecuritiesName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceSecurities", language+client);

        var criterionNoAssignModeleName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionNoAssignModele", language+client); 
        var criterionModelName   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceModel", language+client);
        var criterionModelNameCP = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionModelCP", language+client); 
        var TransactionNomFiltre = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "OptionFilterTrans", language+client);        
        var accFilterValueGreat  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PerformanceAccountValueGreat", language+client);       
        var cliFilterValueGreat  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PerformanceClientValueGreat", language+client);  
 
        var filterValue1 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter1", language+client);
        var filterValue2 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter2", language+client); 
        var filterValue3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter3", language+client);   
             
        var criterionValue1 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionValue1", language+client);
        var criterionValue2 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionValue2", language+client);
        var criterionValue3 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionValue3", language+client);

          try {

                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);

                    Get_Toolbar_BtnManageSearchCriteria().Click();
                    Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
                    DeleteFilter(criterionAccountsName);
                    DeleteFilter(criterionClientsName);
                    DeleteFilter(criterionRelationsName);
                    DeleteFilter(criterionSecuritiesName);
                    DeleteFilter(criterionSleevesName);
                    DeleteFilter(criterionNoAssignModeleName);
                    DeleteFilter(criterionModelName);
                    DeleteFilter(criterionModelNameCP);
                    Get_WinSearchCriteriaManager_BtnClose().Click();

                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    // Crée le critère de recherche pour le module comptes
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionAccountsName);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(criterionValue1);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(criterionValue2);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    // Crée le critère de recherche Sleeves pour le module comptes
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionSleevesName);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSleeves().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    // Créer le critère de recherche NoAssignModele pour le module comptes
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionNoAssignModeleName);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemModele().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemModele_ItemModelAssign().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemNo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(0);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    // Crée le critère de recherche pour le module clients
                    Get_ModulesBar_BtnClients().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "15"], 10).WaitProperty("VisibleOnScreen", true, 15000);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionClientsName);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterOrEqualTo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(criterionValue1);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(criterionValue1);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    // Crée le critère de recherche pour le module relations
                    Get_ModulesBar_BtnRelationships().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", 30000);
                    Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionRelationsName);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue().Keys(criterionValue1);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(criterionValue1);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    // Crée le critère de recherche pour le module modele UMA
                    Get_ModulesBar_BtnModels().Click();
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionModelName);
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType().Click();
                                   
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUMA().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
                    
                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);
                    

                    // Crée le critère de recherche pour le module modele CP
                    Get_ModulesBar_BtnModels().Click();
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionModelNameCP);
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType().Click();
                                   
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIAModel().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
                    
                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);                  


                    // Crée le critère de recherche pour le module titres
                    Get_ModulesBar_BtnSecurities().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", 30000);
                    Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionSecuritiesName);
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSubcategory().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemStripBonds().Click();
                    //Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOptions().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHeldByPortfoliosHaving().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemQuantity().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemNotEqualTo().Click();

                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(criterionValue3);

                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();

                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);

                    CreateFilterAccounts(accFilterValueGreat, filterValue1);
                    CreateFilterAccounts(accFilterValueGreat, filterValue2);

                    CreateFilterClients(cliFilterValueGreat, filterValue1);
                    CreateFilterClients(cliFilterValueGreat, filterValue3);

                    CreateFilterTransactions(TransactionNomFiltre, 0)

          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {

                    Terminate_CroesusProcess(); //Fermer Croesus
                    Terminate_IEProcess();
          }

}

function CreateFilterAccounts(filterName, val) {
          Get_ModulesBar_BtnAccounts().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);

          var filtre = Get_Toolbar_BtnQuickFilters_ContextMenu().Find(["ClrClassName", "WPFControlText"], ["MenuItem", filterName + val], 100);
          if (filtre.Exists) {
                    Log.Message("The filter " + filterName + val + " was found in the filter list.");
                    Get_ModulesBar_BtnAccounts().Click();
          } else {
                    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935");

                    Get_WinCRUFilter_GrpDefinition_TxtName().set_Text(filterName + val);
                    Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
                    Get_WinCRUFilter_CmbAccess_ItemUser().Click();
                    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
                    Get_WinCRUFilter_CmbField_ItemTotalValue().Click();
                    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
                    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
                    Get_WinCRUFilter_GrpCondition_TxtValueDouble().set_Text(val);

                    Get_WinCRUFilter_BtnOK().Click();
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists) {
                              Get_ModulesBar_BtnAccounts().Click();
                    } else {
                              Log.Message("le filtre n'est pas initialisation")
                    }
          }
}

function CreateFilterClients(filterName, val) {
          Get_ModulesBar_BtnClients().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);

          var filtre = Get_Toolbar_BtnQuickFilters_ContextMenu().Find(["ClrClassName", "WPFControlText"], ["MenuItem", filterName + val], 10);
          if (filtre.Exists) {
                    Log.Message("The filter " + filterName + val + " was found in the filter list.");
                    Get_ModulesBar_BtnClients().Click();
          } else {
                    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935");

                    Get_WinCRUFilter_GrpDefinition_TxtName().set_Text(filterName + val);
                    Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
                    Get_WinCRUFilter_CmbAccess_ItemUser().Click();
                    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
                    Get_WinCRUFilter_CmbField_ItemTotalValue().Click();
                    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
                    Get_WinCRUFilter_CmbOperator_ItemIsGreaterThan().Click();
                    Get_WinCRUFilter_GrpCondition_TxtValueDouble().set_Text(val);

                    Get_WinCRUFilter_BtnOK().Click();
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists) {
                              Get_ModulesBar_BtnClients().Click();
                    } else {
                              Log.Message("le filtre n'est pas initialisation")
                    }
          }
}

function Get_WinCRUFilter_CmbField_ItemTotalValue() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Valeur totale"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", "Total Value"], 10)
          }
}

function CreateFilterTransactions(filterName, val) {
          // Clique le module Transactions
          WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
          Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);
          Get_ModulesBar_BtnTransactions().Click();
          WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["BrowserCellTemplateSimple", 1]);
          Get_Toolbar_FieldQuickFilters().WaitProperty("IsChecked", false, 60000);
          Delay(3000);
          // ajoute un filtre
          Get_Toolbar_BtnQuickFilters().Click();
          var filtre = Get_Toolbar_BtnQuickFilters_ContextMenu().Find(["ClrClassName", "WPFControlText"], ["UniCheckMenu", filterName], 10);
          if (filtre.Exists) {
                    Log.Message("The filter " + filterName + " was found in the filter list.");
                    Get_ModulesBar_BtnTransactions().Click();
          } else {
                    WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", 1]);
                    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1], 30000);
                    Get_WinAddFilter_TxtName().set_Text(filterName);
                    Get_WinAddFilter_GrpCondition_RdoMyFilter().Click();
                    Get_WinAddFilter_GrpCondition_CmbField().set_IsDropDownOpen(true);
                    Get_WinAddFilter_GrpCondition_CmbField_ItemCashBalance().Click();
                    Get_WinAddFilter_GrpCondition_CmbOperator().set_IsDropDownOpen(true);
                    Get_WinAddFilter_GrpCondition_CmbOperator_ItemIsGreaterThan().Click();
                    Get_WinAddFilter_GrpCondition_TxtValueDouble().set_Text(0);
                    Get_WinAddFilter_BtnOK().Click();
                    if (!Get_WinAddFilter().Exists) {
                              Get_Toolbar_FieldQuickFilters().Click();
                    }
                    Get_Toolbar_FieldQuickFilters().WaitProperty("IsChecked", false, 60000);
          }
}

function test() {

var criterionModelNameCP = GetData(filePath_Performance, sheetName_DataBD, 46, language);

                    Get_ModulesBar_BtnModels().Click();
                    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    
                    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                    Get_WinAddSearchCriterion_TxtName().Clear();
                    Get_WinAddSearchCriterion_TxtName().Keys(criterionModelNameCP);
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType().Click();
                                   
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIAModel().Click();
                    
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
                    
                    Get_WinAddSearchCriterion_BtnSave().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5", 30000);
}

function Get_WinAddFilter_GrpCondition_RdoMyFilter() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_Mon filtre"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["RadioButton", "_My Filter"], 10)
          }
}

function Get_WinAddFilter_GrpCondition_CmbField_ItemCashBalance() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Solde du compte"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "Cash Balance"], 10)
          }
}

function Get_WinAddFilter_GrpCondition_CmbOperator_ItemIsGreaterThan() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "est plus grand que"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", "is greater than"], 10)
          }
}

function Get_Toolbar_FieldQuickFilters() {
          return Get_barToolbar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClickBox", 1], 10)
}

function Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter() {
          if (language == "french") {
                    return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< Aucun filtre >"], 10)
          } else {
                    return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< No Filter >"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemModele() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Modèle"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Model"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemModele_ItemModelAssign() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "assignation à un modèle"], 100)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "model assignation"], 100)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "et"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "and"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_Item() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "et"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "and"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemBalance() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "solde"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "balance"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "inférieur(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "lower than"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemNotEqualTo() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "différent(e) de"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "not equal to"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "égal(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "equal to"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterOrEqualTo() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "supérieur(e) ou égal(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "greater or equal to"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "supérieur(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "greater than"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSubcategory() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "sous-catégorie"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "subcategory"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemType() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "type"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSleeves() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "segments"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "sleeves"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemOptions() {
          return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Options"], 10)
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemStripBonds() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Coupons détachés"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Strip Bonds"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemYes() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Oui"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Yes"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemNo() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Non"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "No"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemUMA()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "UMA"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "UMA"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemIAModel()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Modèle CP"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "IA model"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHeldByPortfoliosHaving() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "détenus dans des portefeuilles ayant"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "held by portfolios having"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemQuantity() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "quantité"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "quantity"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtNotEqualTo_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)
          }
}

function DeleteFilter(criterion) {

          var count = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
                    var findFilter = false;
          for (i = 0; i <= count - 1; i++) {
                    if (Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description() == criterion) {
                              findFilter = true;
                              break;
                    }
          }
          if (findFilter == true) {
                    Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                    Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                    Get_WinSearchCriteriaManager_BtnDelete().Click();
                    var width = Get_DlgCroesus().Get_Width();
                    Get_DlgCroesus().Click((width * (1 / 3)), 73);
                    Log.Message(" Le critère " + criterion + " a été supprimé ");
          } else {
                    Log.Message(" Le critère " + criterion + " n'est pas sur la liste ");
          }

}