//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions


/**
    Description : Check if we double click on criterion, Risk Rating Method Window is open in read only
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-447
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0447_Tit_Check_if_we_double_click_on_criterion_Risk_Rating_Method_Window_is_open_in_read_only()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
        var overwriteCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to the securities module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //1- Click on " Risk Rating  Manager"  button, in Risk Rating criteria window , click on Production Tab then on Overwrite Criteria, double click on criteria and check if Edit a criterion windows is opened in read only
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();

        //click on Production Tab
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        //click on Overwrite Criteria rating method
        Log.Message("Select 'Overwrite criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        Log.Message("Select the criterion : " + overwriteCriterionName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(overwriteCriterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.DblClick();
        
        //Check if Edit a criterion windows is opened in read only
        CheckIfEditCriterionWindowIsOpenInReadOnly();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //2- Click on " Risk Rating  Manager"  button, in Risk Rating criteria window , click on Production Tab then on Basic Criteria, double click on criteria and check if Edit a criterion windows is opened in read only
        
        Log.Message("Open the Risk Rating Criteria Manager window.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();

        //click on Production Tab
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Click on Basic Criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        Log.Message("Select the criterion : " + basicCriterionName);
        var criterionRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
        var criterionRow = Get_WinRiskRatingCriteriaManager_DgvBasicOverwriteCriteria().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", criterionRowIndex], 10); 
        criterionRow.DblClick();
        
        //Check if Edit a criterion windows is opened in read only
        CheckIfEditCriterionWindowIsOpenInReadOnly();
        
        
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



function CheckIfEditCriterionWindowIsOpenInReadOnly()
{
    //Vérifier que les composants de la fenêtre ne sont pas actifs
    
    Log.Message("Check if Risk Rating Criteria Editor window is displayed.");
    if (!aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
        return;
    
    Log.Message("Check if Risk Rating Criteria Editor window title is the expected.");
    var criteriaEditorWindowEditModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowEditionModeTitle", language + client);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowEditModeExpectedTitle);
    
    Log.Message("Check if 'Name' field is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_TxtName(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_TxtName(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Description' field is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_TxtDescription(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_TxtDescription(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Condition' field is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_LstCondition(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_LstCondition(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Active' status checkbox is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Overwrite' status checkbox is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Low' rating radio button is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'Medium' rating radio button is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium(), "IsEnabled", cmpEqual, false);
    
    Log.Message("Check if 'High' rating radio button is not enabled");
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoHigh(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor_GrpRating_RdoHigh(), "IsEnabled", cmpEqual, false);
    
    //Close Risk Rating Criteria Method window
    Get_WinRiskRatingCriteriaEditor_BtnClose().Click();
}