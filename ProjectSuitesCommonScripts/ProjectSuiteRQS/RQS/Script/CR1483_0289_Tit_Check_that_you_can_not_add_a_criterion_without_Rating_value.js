//USEUNIT Common_functions
//USEUNIT Global_variables



/**
    Description : Check that you can not add a criterion without Rating value
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-289
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0289_Tit_Check_that_you_can_not_add_a_criterion_without_Rating_value()
{
    try {
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        
        //1-In the tool bare menu of Securities Module, click on the button"Risk Rating  Manager ", "Risk Rating criteria" window is displayed
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //Check that "Risk Rating criteria" window is displayed
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
        
        //2-Click on simulation tab then "add" button. 
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Créer le critère
        Log.Message("Click on 'add' button.");
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        
        //Check that "Add a criterion" windows is displayed.
        if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
            aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
        
        
        //3-Check if Rating component is a radio button.
        
        //Get Rating groupbox visible children
        Log.Message("Get all Rating groupbox children.");
        var ratingGroupboxAllChildren = Get_WinRiskRatingCriteriaEditor_GrpRating().FindAllChildren("IsVisible", true).toArray();
        
        //There should exist at least one visible child for the Rating groupbox
        Log.Message("Check if Rating groupbox has at least one child.");
        aqObject.CompareProperty(ratingGroupboxAllChildren.length, cmpGreater, 0, true, lmError);
        
        //Check if all children are radiobutton
        Log.Message("Check if all Rating groupbox children are RadioButton.");
        for (var i = 0; i < ratingGroupboxAllChildren.length; i++)
            aqObject.CheckProperty(ratingGroupboxAllChildren[i], "ClrClassName", cmpEqual, "RadioButton");
        
        //Close Risk Rating Criteria Editor window
        Log.Message("Click on 'Cancel' button.");
        Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
        
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