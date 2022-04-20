//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Validate the contents of the Bottom Toolbar in Simulation View
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-461
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0461_Tit_Validate_the_contents_of_the_Bottom_Toolbar_in_Simulation_View()
{
    try {
        var btnSendToProductionExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnSendToProduction", language + client);
        var btnImportFromProductionExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnImportFromProduction", language + client);
        var btnSimulateAllMethodsExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnSimulateAllMethods", language + client);
        var btnCloseExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnClose", language + client);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //In the securities module click on " Risk Rating Manager "  button
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        // Click on Simulation Tab, then Override criteria and check if Bottom Toolbar contains: Send to production, import from production, Simulation All Methods and close buttons.
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Click on 'Overwrite criteria'.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        //Check if "Send to production" button is displayed
        Log.Message("Check if 'Send to production' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "WPFControlText", cmpEqual, btnSendToProductionExpectedLabel);
        }
        
        //Check if "import from production" button is displayed
        Log.Message("Check if 'import from production' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "WPFControlText", cmpEqual, btnImportFromProductionExpectedLabel);
        }
        
        //Check if "Simulate All Methods" button is displayed
        Log.Message("Check if 'Simulate All Methods' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "WPFControlText", cmpEqual, btnSimulateAllMethodsExpectedLabel);
        }
        
        //Check if "Close" button is displayed
        Log.Message("Check if 'Close' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "WPFControlText", cmpEqual, btnCloseExpectedLabel);
        }
        
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
