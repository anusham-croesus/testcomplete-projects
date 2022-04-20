//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check the contents of the risk rating criteria manager window
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-212
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0212_Tit_Check_the_contents_of_the_risk_rating_criteria_manager_window()
{
    try {
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to securities module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        
        //1- ***** Check the Bottom Toolbar contents of the Risk Rating Methods Manager window. *****
        
        //1.a- In the securities module click on " Risk Rating Manager "  button, Risk Rating criteria  window is opened, click on   Production Tab , check if the Bottom contains only Close button 
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on Production tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Check if the Risk Rating Criteria Manager window contains only one button as immediate children.")
        //Get all visible buttons in immediate Risk Rating Criteria Manager window children
        var allLevelOneChildren = Get_WinRiskRatingCriteriaManager().FindAllChildren(["ClrClassName", "IsVisible"], ["Button", true]).toArray();
        if (aqObject.CompareProperty(allLevelOneChildren.length, cmpEqual, 1, true, lmError)){
            //Check if the only button is the Close button
            var expectedCloseButton = Get_WinRiskRatingCriteriaManager_BtnClose();
            var actualCloseButton = allLevelOneChildren[0];
            
            //Check the Uid Property
            Log.Message("Check the Uid Property of the unique button.");
            aqObject.CompareProperty(expectedCloseButton.Uid, cmpEqual, actualCloseButton.Uid, true, lmError);
            
            var btnCloseExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnClose", language + client);
            Log.Message("Check if the label of the unique button is : " + btnCloseExpectedLabel);
            aqObject.CompareProperty(btnCloseExpectedLabel, cmpEqual, actualCloseButton.WPFControlText, true, lmError);
        }
        
        
        //1.b- Click on Simulation Tab and check if Bottom Toolbar contains: Send to production, import from production, Simulation All Methods and close buttons.
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Check if "Send to production" button is displayed
        Log.Message("Check if 'Send to production' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "Exists", cmpEqual, true)){
            var btnSendToProductionExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnSendToProduction", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSendToProduction(), "WPFControlText", cmpEqual, btnSendToProductionExpectedLabel);
        }
        
        //Check if "import from production" button is displayed
        Log.Message("Check if 'import from production' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "Exists", cmpEqual, true)){
            var btnImportFromProductionExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnImportFromProduction", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnImportFromProduction(), "WPFControlText", cmpEqual, btnImportFromProductionExpectedLabel);
        }
        
        //Check if "Simulate All Methods" button is displayed
        Log.Message("Check if 'Simulate All Methods' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "Exists", cmpEqual, true)){
            var btnSimulateAllMethodsExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnSimulateAllMethods", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods(), "WPFControlText", cmpEqual, btnSimulateAllMethodsExpectedLabel);
        }
        
        //Check if "Close" button is displayed
        Log.Message("Check if 'Close' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "Exists", cmpEqual, true)){
            var btnCloseExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnClose", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BtnClose(), "WPFControlText", cmpEqual, btnCloseExpectedLabel);
        }
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //2- ***** Check if Production view of Risk Rating Methods Manager Window displays the expected columns. *****
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on Production tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Set 'Default Configuration' for columns.");
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        Log.Message("Check if the 'Name' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Rating' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Created by' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Modified' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Production' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Production Final' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal(), "VisibleOnScreen", cmpEqual, true);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //3- ***** In the securities module click on "Risk Rating Manager "  button, Risk Rating Methods Manager window is opened click on Simulation Tab  check  check if the expected columns are displayed. *****
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Set 'Default Configuration' for columns.");
        Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_HeaderLabelArea().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        Log.Message("Check if the 'Active' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChActive(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Name' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChName(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Rating' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChRating(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Created by' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChCreatedBy(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Modified' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChModified(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Production' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProduction(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Production Final' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChProductionFinal(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Simulation' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulation(), "VisibleOnScreen", cmpEqual, true);
        
        Log.Message("Check if the 'Simulation Final' column is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria_ChSimulationFinal(), "VisibleOnScreen", cmpEqual, true);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //4- ***** Check the Upper Toolbar contents of the Risk Rating criteria window. *****
        
        Log.Message("In securities module click on 'Risk Rating Manager' button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //4.a- Click on Production Tab, check if Upper Toolbar contains only View button 
        
        Log.Message("Click on Production tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Check if the upper toolbar contains only one button as immediate children.")
        //Get all visible buttons in immediate padheader children
        var allLevelOneChildren = Get_WinRiskRatingCriteriaManager_BarPadHeader().FindAllChildren(["ClrClassName", "IsVisible"], ["Button", true]).toArray();
        if (aqObject.CompareProperty(allLevelOneChildren.length, cmpEqual, 1, true, lmError)){
            //Check if the only button is the Close button
            var expectedViewButton = Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnView();
            var actualViewButton = allLevelOneChildren[0];
            
            //Check the Uid Property
            Log.Message("Check the Uid Property of the unique button.");
            aqObject.CompareProperty(expectedViewButton.Uid, cmpEqual, actualViewButton.Uid, true, lmError);
            
            var btnViewExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnView", language + client);
            Log.Message("Check if the label of the unique button is : " + btnViewExpectedLabel);
            aqObject.CompareProperty(btnViewExpectedLabel, cmpEqual, actualViewButton.WPFControlText, true, lmError);
        }
        
        
        //4.b- Click on Simulation Tab and check if header Toolbar contains : Add, Edit, Coppy and Delete buttons.
        
        Log.Message("Click on Simulation tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Check if "Add" button is displayed
        Log.Message("Check if 'Add' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), "Exists", cmpEqual, true)){
            var btnAddExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnAdd", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd(), "WPFControlText", cmpEqual, btnAddExpectedLabel);
        }
        
        //Check if "Edit" button is displayed
        Log.Message("Check if 'Edit' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), "Exists", cmpEqual, true)){
            var btnEditExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnEdit", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnEdit(), "WPFControlText", cmpEqual, btnEditExpectedLabel);
        }
        
        //Check if "Copy" button is displayed
        Log.Message("Check if 'Copy' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), "Exists", cmpEqual, true)){
            var btnCopyExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnCopy", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnCopy(), "WPFControlText", cmpEqual, btnCopyExpectedLabel);
        }
        
        //Check if "Delete" button is displayed
        Log.Message("Check if 'Delete' button is displayed.");
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), "Exists", cmpEqual, true)){
            var btnDeleteExpectedLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinRiskRatingCriteriaManager_BtnDelete", language + client);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnDelete(), "WPFControlText", cmpEqual, btnDeleteExpectedLabel);
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