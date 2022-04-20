//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT CR1483_EnvironmentPreparation



/**
    Description : Check if production Final column displys a number of securities that remain ranked
                  by External risk rating feed after the entire ranking processing has occurred
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-263
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0263_Tit_Validate_the_contents_of_Production_Final_column()
{
    try {
        var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
        var highRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0263_Criterion1", language + client);
        
        //Delete Criterion with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //1-Go to the securities module, click on " Risk Rating Manager" button, in the risk rating criteria window/production tab , click on External risk rating feed , note the number displayed in production Final column for medium rating and close this window.
        
        //Login and go to Security module
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Production Tab then External risk Rating feed
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Get Nb Of 'Production final' Items for Medium rating in  'External risk rating feed'");
        var nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed = GetNbOfMatchingItemsForRatingInExternalRiskRatingFeed("Production final", mediumRating);
        
        
        //2- In the securities module add a search criteria with the condition: List of securities having source equal to external feed and having rating equal to medium..
        
        CreateSourceExternalRiskRatingFeedRatingMediumCriterion(criterionName);
        
        
        //3- Rate manualy 1 securitie among N remaining securities noted in step 2 to high.
        
        var row1Security = Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).WPFObject("DataRecordPresenter", "", 1);
        
        if (!row1Security.Exists || StrToInt(Get_MainWindow_StatusBar_NbOfcheckedElements().Text) == 0){
            Log.Error("There is no matching security for the active criterion.");
            return;
        }
        
        //To be used to restore the rating
        var row1SecurityDescription = row1Security.get_Description();
        
        //Open row1 Info Security
        row1Security.DblClick();
        WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
        
        //Change Rating to High
        SelectComboBoxItem(Get_WinInfoSecurity_GrpDescription_CmbRiskRating(), highRating);
        Get_WinInfoSecurity_BtnOK().Click();
        Get_DlgConfirmAction_TxtRiskIndexPasswordBox().Keys(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CroesusEncryptedPassword", language + client));
        Get_DlgConfirmAction().Click(Get_DlgConfirmAction().get_ActualWidth()/3, Get_DlgConfirmAction().get_ActualHeight()-45);
        
        
        //4- Check if production Final column displays number noted in the step1 minus 1.
        
        //Open the risk rating criteria manager window, click on Production Tab then External risk Rating feed
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Log.Message("Go to 'Production' tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        Log.Message("Get Nb Of 'Production final' Items for Medium rating in  'External risk rating feed'");
        var newNbOfProductionFinalForMediumRatingInExternalRiskRatingFeed = GetNbOfMatchingItemsForRatingInExternalRiskRatingFeed("Production final", mediumRating);
        
        //Check if all the expected Rating values were displayed
        Log.Message("Check if production Final column displays number noted in the step1 minus 1");
        aqObject.CompareProperty(StrToInt(nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed)-1, cmpEqual, StrToInt(newNbOfProductionFinalForMediumRatingInExternalRiskRatingFeed), true, lmError);
        
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete Criterion
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Restore the rating
        CR1483_EnvironmentPreparation_Step6(); //Eventuellement remplacer par la requête fournie par Malika
    } 
}