//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions
//USEUNIT DBA



/**
    Description : Add a criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-284
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-285
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-286
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-287
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-288
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-290
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-291
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-292
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-293
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-294
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-295
    
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_Tit_AddACriterion_Testcases()
{
    try {
        var arrayOfCriteriaNames = new Array();
        var arrayOfBasicCriteriaNames = new Array();
        var arrayOfOverwriteCriteriaNames = new Array();
        
        var riskRatingCriteriaManagerWindowExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "RiskRatingCriteriaManagerWindowTitle", language + client);
        var criteriaEditorWindowAddModeExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "CriteriaEditorWindowAddModeTitle", language + client);        
        var expectedErrorMessage = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_CriterionCreation_ErrorMessage", language + client);
        
        //Connect to croesus with sysadmin
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        //go to Security module
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        var Driver = DDT.ExcelDriver(filePath_RQS, "AddACriterionTestCases_" + client, true);
        
        //Parcourir les lignes pour récupérer le contenu de la cellule cible
        while (! Driver.EOF()) {
            var toBeRun = Driver.Value("ToBeRun");
            
            //If toBeRun is not Yes or True or Default, go to next row
            if (toBeRun != null && toBeRun.toUpperCase() != "YES" && toBeRun.toUpperCase() != "TRUE") {
                Driver.Next();
                continue;
            }
            
            var caseID = VarToStr(Driver.Value("CaseID"));
            var caseSummary = VarToStr(Driver.Value("CaseSummary"));
            
            Log.AppendFolder(caseID, caseSummary);
            
            try {
                var criterionName = VarToStr(Driver.Value("CriterionName_" + language));
                var criterionDescription = VarToStr(Driver.Value("CriterionDescription_" + language));
                var activeStatus = Driver.Value("ActiveStatus");
                var overwriteStatus = Driver.Value("OverwriteStatus");
                var rating = Driver.Value("Rating_" + language);
                var isConditionPresent = (aqString.ToUpper(VarToStr(Driver.Value("IsConditionPresent"))) == "YES");
                var creationShouldSuccess = (aqString.ToUpper(VarToStr(Driver.Value("CreationShouldSuccess"))) == "YES");
            
                //Delete the criteria with the same name
                Delete_FilterCriterion(criterionName, vServerRQS);
        
                //Open the risk rating criteria manager window
                Log.Message("Open the Risk Rating Criteria Manager window");
                Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
                //Check that "Risk Rating criteria" window is displayed
                if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Exists", cmpEqual, true))
                    aqObject.CheckProperty(Get_WinRiskRatingCriteriaManager(), "Title", cmpEqual, riskRatingCriteriaManagerWindowExpectedTitle);
        
                //3-Click on simulation tab then "add" button. 
            
                Log.Message("Go to 'Simulation' tab.");
                Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
                
                //Créer le critère
                Log.Message("Click on 'add' button.");
                Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
            
                //Check that "Add a criterion" windows is displayed.
                if (aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Exists", cmpEqual, true))
                    aqObject.CheckProperty(Get_WinRiskRatingCriteriaEditor(), "Title", cmpEqual, criteriaEditorWindowAddModeExpectedTitle);
            
                //Fill fields
                var CreateRiskRatingConditionFunction = null;
                if (isConditionPresent)
                    CreateRiskRatingConditionFunction = "CreateRiskRatingCondition_SecuritiesHavingPriceCurrencyEqualToUSD()";
                
                SetCriterionAttributes(criterionName, criterionDescription, activeStatus, overwriteStatus, rating, CreateRiskRatingConditionFunction);
                
                var isOverwriteChecked = Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().IsChecked.OleValue;
                
                //Click on Save button. check if criteria is created
                Log.Message("Click on 'Save' button.");
                Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
                arrayOfCriteriaNames.push(criterionName);
            
                if (!creationShouldSuccess){
                    Log.Message("Check if the Croesus dialog box is displayed.");
                    if (aqObject.CheckProperty(Get_DlgCroesus(), "Exists", cmpEqual, true)){
                        Log.Message("Check if the error message is the expected.");
                        aqObject.CheckProperty(Get_DlgCroesus_LblMessage(), "Text", cmpEqual, expectedErrorMessage);
                        Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-45);
                    }
                
                    Get_WinRiskRatingCriteriaEditor_BtnCancel().Click();
                }
                
                //Check if the criterion is added.
                if (isOverwriteChecked){
                    Log.Message("Select 'Overwrite criteria' rating method.");
                    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
                }
                else {
                    Log.Message("Select 'Basic criteria' rating method.");
                    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
                }
                
                Log.Message("Check if criterion '" + criterionName + "' creation result is : " + creationShouldSuccess);
                var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionName);
                aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, creationShouldSuccess, true, lmError);
                
                if (isCriterionDisplayed){
                    if (isOverwriteChecked)
                        arrayOfOverwriteCriteriaNames.push(criterionName);
                    else
                        arrayOfBasicCriteriaNames.push(criterionName);
                }
                
                //Close Risk Rating Criteria Manager window
                Get_WinRiskRatingCriteriaManager_BtnClose().Click();
            }
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
                
                //Close Risk Rating Criteria Editor window
                if (Get_WinRiskRatingCriteriaEditor().Exists)
                    Get_WinRiskRatingCriteriaEditor().Close();
                
                //Close Risk Rating Criteria Manager window
                if (Get_WinRiskRatingCriteriaManager().Exists)
                    Get_WinRiskRatingCriteriaManager().Close();
            }
            
            Driver.Next();
            Log.PopLogFolder();
        }
        
        // Close the driver
        DDT.CloseDriver(Driver.Name);
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criteria
        RestoreRQS(arrayOfBasicCriteriaNames, arrayOfOverwriteCriteriaNames, false, false, false);
        /*
        for (var i = 0; i < arrayOfCriteriaNames.length; i++)
            Delete_FilterCriterion(arrayOfCriteriaNames[i], vServerRQS);
        */
    } 
}