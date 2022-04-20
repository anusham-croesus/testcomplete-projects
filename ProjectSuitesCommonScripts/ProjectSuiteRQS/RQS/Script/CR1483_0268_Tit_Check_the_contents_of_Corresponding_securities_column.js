//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check if Corresponding securities column displys the number of securities that have been manually rated to the selected rating
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-268
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0268_Tit_Check_the_contents_of_Corresponding_securities_column()
{
    try {
        var security_number = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0268_Security_Number", language + client);
        var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
        var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Change Rating manually to Medium
        RateSecurityManually(security_number, mediumRating);
        
        //1.
        
        //Open the risk rating criteria manager window, click on Simulation Tab, and then Manual overwrite
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        
        //Get Number of CorrespondingSecurities for Medium Rating
        var mediumRatingIndex = GetRatingRowIndexInManualOverwriteGrid(mediumRating);
        var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities().WPFControlOrdinalNo;
        if (mediumRatingIndex == null)
            var formerMediumRatingNbOfCorrespondingSecurities = 0;
        else
            var formerMediumRatingNbOfCorrespondingSecurities = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", mediumRatingIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
        
        //Get Number of CorrespondingSecurities for High Rating
        var highRatingIndex = GetRatingRowIndexInManualOverwriteGrid(highRating);
        var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities().WPFControlOrdinalNo;
        if (highRatingIndex == null)
            var formerHighRatingNbOfCorrespondingSecurities = 0;
        else
            var formerHighRatingNbOfCorrespondingSecurities = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", highRatingIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
        
        Log.Message("formerMediumRatingNbOfCorrespondingSecurities = " + formerMediumRatingNbOfCorrespondingSecurities);
        Log.Message("formerHighRatingNbOfCorrespondingSecurities = " + formerHighRatingNbOfCorrespondingSecurities);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //2.
        //Change the security manually rated Medium to High
        RateSecurityManually(security_number, highRating);
        
        //Check new Number of Corresponding securities for Medium an High ratings
        
        //Open the risk rating criteria manager window, click on Simulation Tab, and then Manual overwrite
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Manual overwrite' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnManualOverwrite().Click();
        
        //Get Number of CorrespondingSecurities for Medium Rating
        var mediumRatingIndex = GetRatingRowIndexInManualOverwriteGrid(mediumRating);
        var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities().WPFControlOrdinalNo;
        if (mediumRatingIndex == null)
            var newMediumRatingNbOfCorrespondingSecurities = 0;
        else
            var newMediumRatingNbOfCorrespondingSecurities = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", mediumRatingIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
        
        //Get Number of CorrespondingSecurities for High Rating
        var highRatingIndex = GetRatingRowIndexInManualOverwriteGrid(highRating);
        var correspondingSecuritiesColumnIndex = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite_ChCorrespondingSecurities().WPFControlOrdinalNo;
        if (highRatingIndex == null)
            var newHighRatingNbOfCorrespondingSecurities = 0;
        else
            var newHighRatingNbOfCorrespondingSecurities = Get_WinRiskRatingCriteriaManager_DgvManualOverwrite().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", highRatingIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", correspondingSecuritiesColumnIndex], 10).WPFControlText;
        
        Log.Message("newMediumRatingNbOfCorrespondingSecurities = " + newMediumRatingNbOfCorrespondingSecurities);
        Log.Message("newHighRatingNbOfCorrespondingSecurities = " + newHighRatingNbOfCorrespondingSecurities);
        
        
        CheckEquals(newMediumRatingNbOfCorrespondingSecurities, formerMediumRatingNbOfCorrespondingSecurities - 1, "Corresponding securities number for Medium rating");
        CheckEquals(newHighRatingNbOfCorrespondingSecurities, formerHighRatingNbOfCorrespondingSecurities + 1, "Corresponding securities number for High rating");
        
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
        
        //Restore Ratings
        ExecuteDefaultSSHCommands();
    }
}