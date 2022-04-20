//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_functions



/**
    Description : Check if the Count colomn contains the number of securities belonging in a subcategory in simulation and production view
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-256
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0256_Tit_Check_the_Corresponding_securities_colomn_contents_in_simulation_and_production_view()
{
    try {
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0256_Criterion", language + client);
        
        //Delete the criterion with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        //Open the risk rating criteria manager window, click on Simulation Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        //Check NbOfCorrespondingSecuritiesInDefaultSubcategories for 'Certificates of Deposit' subcategory
        var subcategoryNameInRiskRatingCriteriaManager = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Subcategory_CertificatesOfDeposit", language + client);
        var subcategoryNameInSearchCriteriaManager = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCertificatesOfDeposit", language + client);
        CheckNbOfCorrespondingSecuritiesInDefaultSubcategories(subcategoryNameInRiskRatingCriteriaManager, subcategoryNameInSearchCriteriaManager, criterionName);
        
        //Go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        //Open the risk rating criteria manager window, click on Production Tab then Default category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        //Check NbOfCorrespondingSecuritiesInDefaultSubcategories for 'Canadian Equity Funds' subcategory
        var subcategoryNameInRiskRatingCriteriaManager = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Subcategory_CanadianEquityFunds", language + client);
        var subcategoryNameInSearchCriteriaManager = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCanadianEquityFunds", language + client);
        CheckNbOfCorrespondingSecuritiesInDefaultSubcategories(subcategoryNameInRiskRatingCriteriaManager, subcategoryNameInSearchCriteriaManager, criterionName);
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criterion
        Delete_FilterCriterion(criterionName, vServerRQS);
    } 
}



function CheckNbOfCorrespondingSecuritiesInDefaultSubcategories(subcategoryNameInRiskRatingCriteriaManager, subcategoryNameInSearchCriteriaManager, criterionName)
{
    
    Log.Message("Select 'Default subcategories' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnDefaultSubcategories().Click();
    
    Log.Message("Set 'Default Configuration' for columns.");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories_HeaderLabelArea().ClickR();
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
    //Goto the first row
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[Home]");
    Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[Home]");
    
    //Navigate through the grid in other to find the needed subcategory
    var isEndOfGridReached = false;
    var isSearchedSubcategoryFound = false;
    while (!isSearchedSubcategoryFound && !isEndOfGridReached){
        var count = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).ChildCount;
        for (var i = 1; i <= count; i++){
            
            var currentRow = Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(i);
            if (currentSubcategory == subcategoryNameInRiskRatingCriteriaManager){
                var nbOfCorrespondingSecurities = GetDefaultSubcategoriesDisplayedNbOfCorrespondingSecurities(i);
                isSearchedSubcategoryFound = true;
                break;
            }
        }
        
        if (isSearchedSubcategoryFound)
            break;
        
        var previousFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
        Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
        var currentFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
        
        if (previousFirstSubcategory == currentFirstSubcategory){
            var previousFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
            Get_WinRiskRatingCriteriaManager_DgvDefaultSubcategories().Keys("[PageDown]");
            var currentFirstSubcategory = GetDefaultSubcategoriesDisplayedSubcategory(1);
            
            if (previousFirstSubcategory == currentFirstSubcategory)
                isEndOfGridReached = true;
        }  
    }
    
    if (isSearchedSubcategoryFound)
        Log.Message("The number of corresponding securities for the '" + subcategoryNameInRiskRatingCriteriaManager + "' subcategory is : " + nbOfCorrespondingSecurities);
    else {
        Log.Error("'" + subcategoryNameInRiskRatingCriteriaManager + "' subcategory not found in the grid.");
        return;
    }
    
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    //Create Subcategory Search Criteria
    
    //Delete the criterion if it exists
    Log.Message("Delete criterion : " + criterionName);
    Delete_FilterCriterion(criterionName, vServerRQS);
    
    //Add the criterion
    Log.Message("Add criterion : " + criterionName);
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    Get_Toolbar_BtnManageSearchCriteria().Click();
    Get_WinSearchCriteriaManager_BtnAdd().Click();
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(subcategoryNameInSearchCriteriaManager).Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinAddSearchCriterion_LvwDefinition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
    
    //Cliquer sur OK si le message "Les éléments de cette requête sont introuvables ou cette liste est vide." apparaît
    if (Get_DlgCroesus().Exists){
        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
        Get_WinSearchCriteriaManager_BtnClose().Click();
    }
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 100000);
    
    //Get The number of checked securities
    Delay(1000); //For the NbOfcheckedElements to be updated
    var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
    Log.Message("In the Security grid, The number of checked securities for the '" + subcategoryNameInSearchCriteriaManager + "' subcategory is : " + nbOfCheckedSecurities);
    
    //Compare the nbOfCheckedSecurities of the securities grid with the nbOfCorrespondingSecurities of the Risk Index Manager
    Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfCorrespondingSecurities of the Risk Index Manager are the same.");
    aqObject.CompareProperty(nbOfCorrespondingSecurities, cmpEqual, nbOfCheckedSecurities, true, lmError);
}