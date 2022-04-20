//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_functions



/**
    Description : Check if Count column displys a number of securities  that have been rated by the External risk rating feed for the selected rating (first column).
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-261
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0261_Tit_Check_the_contents_of_the_Count_column()
{
    try {
        var criterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0261_Criterion1", language + client);
        
        //Delete the criterion with the same name
        Delete_FilterCriterion(criterionName, vServerRQS);
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //Go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //1- Click on " Risk Rating Manager"  button, in the risk rating criteria window , click on Simulation tab, then External risk rating feed , note the number displayed in production final column for medium  rating and close this window.
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        Log.Message("Get Nb Of 'Production final' Items for Medium rating in  'External risk rating feed'");
        var mediumRating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
        var nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed = GetNbOfMatchingItemsForRatingInExternalRiskRatingFeed("Production final", mediumRating);
        
        //2- In the securities module add a search criteria with the speciified condition and retrieve the nbOfCheckedSecurities
        var nbOfCheckedSecurities = GetNbOfCorrespondingSecuritiesForCriterion(criterionName);
        
        //3- Compare the nbOfCheckedSecurities of the securities grid with the nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed of the Risk Index Manager
        Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed of the Risk Index Manager are the same.");
        aqObject.CompareProperty(nbOfProductionFinalForMediumRatingInExternalRiskRatingFeed, cmpEqual, nbOfCheckedSecurities, true, lmError);
        
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



function GetNbOfCorrespondingSecuritiesForCriterion(criterionName)
{
    CreateSourceExternalRiskRatingFeedRatingMediumCriterion(criterionName);
    
    //Get The number of checked securities
    Delay(1000); //For the NbOfcheckedElements to be updated
    var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
    Log.Message("In the Security grid, The number of checked securities is : " + nbOfCheckedSecurities);
    
    return nbOfCheckedSecurities;
}