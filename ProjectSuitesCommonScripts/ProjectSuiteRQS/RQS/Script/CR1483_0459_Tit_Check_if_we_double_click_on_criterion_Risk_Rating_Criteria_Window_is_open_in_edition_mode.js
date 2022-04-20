//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check if we double click on Simple/overwrite criterion, in Simulation tab, Risk Rating Criteria Window is open in edition mode
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-459
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0459_Tit_Check_if_we_double_click_on_criterion_Risk_Rating_Criteria_Window_is_open_in_edition_mode()
{
    try {
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //1- Click on Simulation Tab then on Overwrite criteria, double click on criteria and check if Edit a Criterion Window is opened in edition mode
        
        //Open the risk rating criteria manager window, click on Simulation Tab
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Click on Overwrite criteria.
        Log.Message("Click on Overwrite criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        //Double-Click on a criterion and check if Edit criterion Window is opened in edition mode
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
        DblClickOnCriterionRowAndCheckIfEditCriterionWindowIsOpenedInEditionMode(overwriteCriterionName);
        
        
        //2- Click on Simulation Tab then on Basic criteria, double click on criteria and check if Edit criterion Window is opened in edition mode.
        
        //Click on Basic criteria,.
        Log.Message("Click on Basic criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        //Double-Click on a criterion and check if Edit criterion Window is opened in edition mode
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
        DblClickOnCriterionRowAndCheckIfEditCriterionWindowIsOpenedInEditionMode(basicCriterionName);
                
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    } 
}



function DblClickOnCriterionRowAndCheckIfEditCriterionWindowIsOpenedInEditionMode(criterionName)
{
    var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(criterionName);
    var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
    
    Log.Message("Double-Click on the criterion row.");
    criterionRow.DblClick();

    Log.Message("check if 'Edit a Criterion' Window is opened in edition mode");
    
    var maxWaitTime = 30000;
    var waitTime = 0;
    var isFound = false;
    do {
        isFound = Get_WinRiskRatingCriteriaEditor().Exists;
        Delay(100);
        waitTime += 100;
    } while (!isFound && waitTime < maxWaitTime)
    
    if (isFound){
        Log.Checkpoint("Risk Rating Criteria Editor window was displayed.");
        var expectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
        aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, expectedTitle);
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
    }
    else
        Log.Error("Risk Rating Criteria Editor window was not displayed within " + maxWaitTime + " milliseconds.");
}