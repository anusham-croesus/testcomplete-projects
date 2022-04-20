//USEUNIT CR1483_0463_Tit_Check_if_we_click_on_Send_to_production_button_all_active_criteria_are_sent_to_production_BtnCancel



/**
    Description : Check if we click on ''Import from production'' button all production criteria are imported  to Simulation tab
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-462
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0462_Tit_Validate_the_functionality_of_Import_from_production_button()
{
    try {
        var winImportFromProductionExpectedTitle = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "WinImportFromProductionTitle", language + client);
        var basicCriteriaLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "BasicCriteriaLabel", language + client);
        var overwriteCriteriaLabel = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "OverwriteCriteriaLabel", language + client);
        var enabledBasicCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0462_EnabledBasicCriterionNamePrefix", language + client);
        var disabledBasicCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0462_DisabledBasicCriterionNamePrefix", language + client);
        var enabledOverwriteCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0462_EnabledOverwriteCriterionNamePrefix", language + client);
        var disabledOverwriteCriterionNamePrefix = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0462_DisabledOverwriteCriterionNamePrefix", language + client);
        
        
        //Create a set of enabled and disabled criteria
        var nbOfBasicEnabledCriteria = 5;
        var nbOfBasicDisabledCriteria = 6;
        var arrayOfBasicEnabledCriteria = new Array();
        var arrayOfBasicDisabledCriteria = new Array();
        var nbOfOverwriteEnabledCriteria = 7;
        var nbOfOverwriteDisabledCriteria = 8;
        var arrayOfOverwriteEnabledCriteria = new Array();
        var arrayOfOverwriteDisabledCriteria = new Array();
        
        for (var i = 1; i <= nbOfBasicEnabledCriteria; i++){
            var currentCriterionName = enabledBasicCriterionNamePrefix + IntToStr(i);
            arrayOfBasicEnabledCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfBasicDisabledCriteria; i++){
            var currentCriterionName = disabledBasicCriterionNamePrefix + IntToStr(i);
            arrayOfBasicDisabledCriteria.push(currentCriterionName)
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfOverwriteEnabledCriteria; i++){
            var currentCriterionName = enabledOverwriteCriterionNamePrefix + IntToStr(i);
            arrayOfOverwriteEnabledCriteria.push(currentCriterionName);
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        for (var i = 1; i <= nbOfOverwriteDisabledCriteria; i++){
            var currentCriterionName = disabledOverwriteCriterionNamePrefix + IntToStr(i);
            arrayOfOverwriteDisabledCriteria.push(currentCriterionName)
            Delete_FilterCriterion(currentCriterionName, vServerRQS);
        }
        
        //Connect to croesus with sysadmin. Go to the Securities module 
        Log.Message("Connect to croesus with sysadmin. Go to the Securities module.");
        Login(vServerRQS, userNameRQS, pswRQS, language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //Create a set of enabled and disabled criteria
        Log.Message("Create a set of enabled and disabled criteria");
        
        
        //Create Basic criteria
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        for (var i = 0; i < arrayOfBasicEnabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfBasicEnabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfBasicEnabledCriteria[i], null, "true");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        for (var i = 0; i < arrayOfBasicDisabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfBasicDisabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfBasicDisabledCriteria[i], null, "false");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        //Create Overwrite criteria
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        
        for (var i = 0; i < arrayOfOverwriteEnabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfOverwriteEnabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfOverwriteEnabledCriteria[i], null, "true");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        for (var i = 0; i < arrayOfOverwriteDisabledCriteria.length; i++){
            Log.Message("Create criterion : " + arrayOfOverwriteDisabledCriteria[i]);
            Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();    
            
            SetCriterionAttributes(arrayOfOverwriteDisabledCriteria[i], null, "false");
            
            //Criterion Condition
            Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
            Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
            
            Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        }
        
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //Stop if there is any error in pre-conditions
        if (Log.ErrCount > 0)
            return;
        
        
        //1-Connect to croesus with sysadmin.Go to the securities module,click on Risk Rating Manager button
        Log.Message("1 : Connect to croesus with sysadmin. Go to the securities module,click on Risk Rating Manager button.");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        //a- Click on Production Tab .
        Log.Message("b : Click on Production Tab.");
        Get_WinRiskRatingCriteriaManager_TabProduction().Click();
        
        //a.1- In Production, Click on Overwrite criteria and note the list of Overwrite criteria
        Log.Message("a.1 : In Production, Click on Overwrite criteria and note the list of Overwrite criteria");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfOverwriteCriteriaInProduction = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("There is " + arrayOfOverwriteCriteriaInProduction.length + " Overwrite criteria in Production : " + arrayOfOverwriteCriteriaInProduction, arrayOfOverwriteCriteriaInProduction);
        var nbOfOverwriteCriteriaInProduction = arrayOfOverwriteCriteriaInProduction.length;

        //a.1- In Production, Click on Basic criteria and note the list of Basic criteria
        Log.Message("a.2 : In Production, Click on Overwrite criteria and note the list of Overwrite criteria");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfBasicCriteriaInProduction = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("There is " + arrayOfBasicCriteriaInProduction.length + " Basic criteria in Production : " + arrayOfBasicCriteriaInProduction, arrayOfBasicCriteriaInProduction);
        var nbOfBasicCriteriaInProduction = arrayOfBasicCriteriaInProduction.length;
        
                
        //b- click on Simulation Tab .
        Log.Message("b : Click on Simulation Tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        
        //b.1- In Simulation, Click on Overwrite criteria and note the list of active criteria and the list of inactive criteria.
        Log.Message("b.1 : In Simulation, Click on Overwrite criteria and note the list of active criteria and the list of inactive criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfActiveAndInactiveOverwriteCriteria = GetListOfActiveAndInactiveCriteriaInBasicOverwriteCriteriaGrid();
        var arrayOfActiveOverwriteCriteria = arrayOfActiveAndInactiveOverwriteCriteria[0];
        var arrayOfInactiveOverwriteCriteria = arrayOfActiveAndInactiveOverwriteCriteria[1];
        Log.Message("There is " + arrayOfActiveOverwriteCriteria.length + " active Overwrite criteria : " + arrayOfActiveOverwriteCriteria, arrayOfActiveOverwriteCriteria);
        Log.Message("There is " + arrayOfInactiveOverwriteCriteria.length + " inactive Overwrite criteria : " + arrayOfInactiveOverwriteCriteria, arrayOfInactiveOverwriteCriteria);
        var nbOfActiveOverwriteCriteria = arrayOfActiveOverwriteCriteria.length;
        
        //b.2- In Simulation, Click on Basic criteria and note the list of active criteria and the list of inactive criteria.
        Log.Message("b.2 : In Simulation, Click on Basic criteria and note the list of active criteria and the list of inactive criteria.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfActiveAndInactiveBasicCriteria = GetListOfActiveAndInactiveCriteriaInBasicOverwriteCriteriaGrid();
        var arrayOfActiveBasicCriteria = arrayOfActiveAndInactiveBasicCriteria[0];
        var arrayOfInactiveBasicCriteria = arrayOfActiveAndInactiveBasicCriteria[1];
        Log.Message("There is " + arrayOfActiveBasicCriteria.length + " active Basic criteria : " + arrayOfActiveBasicCriteria, arrayOfActiveBasicCriteria);
        Log.Message("There is " + arrayOfInactiveBasicCriteria.length + " inactive Basic criteria : " + arrayOfInactiveBasicCriteria, arrayOfInactiveBasicCriteria);
        var nbOfActiveBasicCriteria = arrayOfActiveBasicCriteria.length;
        
        //3- Click on 'Import from production' button.
        Log.Message("3 : Click on 'Import from production' button.");
        Get_WinRiskRatingCriteriaManager_BtnImportFromProduction().Click();
        
        //4- Check if 'Import from production' window is displayed.
        Log.Message("4 : Check if 'Import from production' window is displayed.");
        if (aqObject.CheckProperty(Get_WinImportFromProduction(), "Exists", cmpEqual, true)){
            aqObject.CheckProperty(Get_WinImportFromProduction(), "VisibleOnScreen", cmpEqual, true);
            aqObject.CheckProperty(Get_WinImportFromProduction(), "Title", cmpEqual, winImportFromProductionExpectedTitle);
        }
        
        //Get number of Importing Basic criteria and Overwrite criteria displayed in Import Criteria from production window
        Log.Message("Get number of 'Importing' Basic criteria and Overwrite criteria displayed in Import Criteria from production window.");
        var nbOfImportingBasicCriteria = null;
        var nbOfImportingOverwriteCriteria = null;
        var lblNumberOfImportingCriteria = VarToSTr(Get_WinImportFromProduction_LblNumberOfImportingCriteria().Text.OleValue);
        var arrayLblNumberOfImportingCriteria = lblNumberOfImportingCriteria.split("\r\n");
        for (var i = 0; i < arrayLblNumberOfImportingCriteria.length; i++){
            if (aqString.Find(arrayLblNumberOfImportingCriteria[i], basicCriteriaLabel) != -1)
                nbOfImportingBasicCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfImportingCriteria[i], basicCriteriaLabel, "")));
            
            if (aqString.Find(arrayLblNumberOfImportingCriteria[i], overwriteCriteriaLabel) != -1)
                nbOfImportingOverwriteCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfImportingCriteria[i], overwriteCriteriaLabel, "")));
        }
        
        //Get number of Overwriting Basic criteria and Overwrite criteria displayed in Import Criteria from production window
        Log.Message("Get number of 'Overwriting' Basic criteria and Overwrite criteria displayed in Import Criteria from production window.");
        var nbOfOverwritingBasicCriteria = null;
        var nbOfOverwritingOverwriteCriteria = null;
        var lblNumberOfOverwritingCriteria = VarToSTr(Get_WinImportFromProduction_LblNumberOfOverwritingCriteria().Text.OleValue);
        var arrayLblNumberOfOverwritingCriteria = lblNumberOfOverwritingCriteria.split("\r\n");
        for (var i = 0; i < arrayLblNumberOfOverwritingCriteria.length; i++){
            if (aqString.Find(arrayLblNumberOfOverwritingCriteria[i], basicCriteriaLabel) != -1)
                nbOfOverwritingBasicCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfOverwritingCriteria[i], basicCriteriaLabel, "")));
            
            if (aqString.Find(arrayLblNumberOfOverwritingCriteria[i], overwriteCriteriaLabel) != -1)
                nbOfOverwritingOverwriteCriteria = StrToInt(Trim(aqString.Replace(arrayLblNumberOfOverwritingCriteria[i], overwriteCriteriaLabel, "")));
        }
        

        //5- Check if the number of Importing Basic criteria displayed in Send Criteria to production window is the same active criteria number noted in step 2.
        Log.Message("5 : Check if the number of Importing Basic criteria displayed in 'Import from Production' window is the expected.");
        if (nbOfImportingBasicCriteria === null)
            Log.Error("Unable to get the displayed number of Importing Basic criteria in the 'Import from Production' window.");
        else
            CheckEquals(nbOfImportingBasicCriteria, nbOfBasicCriteriaInProduction, "Number of Importing Basic criteria displayed in 'Import from Production' window");
        
        //5- Check if the number of Importing Overwrite criteria displayed in Send Criteria to production window is the same active criteria number noted in step 2.
        Log.Message("5 : Check if the number of Importing Overwrite criteria displayed in 'Import from Production' window is the expected.");
        if (nbOfImportingOverwriteCriteria === null)
            Log.Error("Unable to get the displayed number of Importing Overwrite criteria in the 'Import from Production' window.");
        else
            CheckEquals(nbOfImportingOverwriteCriteria, nbOfOverwriteCriteriaInProduction, "Number of Importing Overwrite criteria displayed in 'Import from Production' window");

        
        //6- Check if the number of Overwriting Basic criteria displayed in Send Criteria to production window is the same active criteria number noted in step 2.
        Log.Message("6 : Check if the number of Overwriting Basic criteria displayed in 'Import from Production' window is the expected.");
        if (nbOfOverwritingBasicCriteria === null)
            Log.Error("Unable to get the displayed number of Overwriting Basic criteria in the 'Import from Production' window.");
        else
            CheckEquals(nbOfOverwritingBasicCriteria, nbOfActiveBasicCriteria, "Number of Overwriting Basic criteria displayed in 'Import from Production' window");
        
        //6- Check if the number of Overwriting Overwrite criteria displayed in Send Criteria to production window is the same active criteria number noted in step 2.
        Log.Message("6 : Check if the number of Overwriting Overwrite criteria displayed in 'Import from Production' window is the expected.");
        if (nbOfOverwritingOverwriteCriteria === null)
            Log.Error("Unable to get the displayed number of Overwriting Overwrite criteria in the 'Import from Production' window.");
        else
            CheckEquals(nbOfOverwritingOverwriteCriteria, nbOfActiveOverwriteCriteria, "Number of Overwriting Overwrite criteria displayed in 'Import from Production' window");

        //7- Click on ''Import and  Overwrite'' button.
        Log.Message("7 : Click on 'Import and  Overwrite' button.");
        Get_WinImportFromProduction_BtnImportAndOverwrite().Click();
        
        //Validate if all production criteria are imported to Simulation tab
        Log.Message("Validate if all production criteria are imported to Simulation tab");
        
        //Get new Criteria list in Simulation
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        var arrayOfBasicCriteriaInSimulationNew = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("Now, there is " + arrayOfBasicCriteriaInSimulationNew.length + " Basic criteria in Simulation : " + arrayOfBasicCriteriaInSimulationNew, arrayOfBasicCriteriaInSimulationNew);
                
        CheckEquals(arrayOfBasicCriteriaInSimulationNew.length, arrayOfBasicCriteriaInProduction.length, "The new number of Basic criteria in Simulation");
        
        if (arrayOfBasicCriteriaInSimulationNew.length == arrayOfBasicCriteriaInProduction.length){
            for (var i = 0; i < arrayOfBasicCriteriaInSimulationNew.length; i++)
                CheckEquals(arrayOfBasicCriteriaInSimulationNew[i].toString(), arrayOfBasicCriteriaInProduction[i].toString(), "Basic criteria name and Modified Date in Simulation in new list at position " + IntToStr(i + 1));
        }
        
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
        var arrayOfOverwriteCriteriaInSimulationNew = GetAllDisplayedCriteriaWithModifiedDateInBasicOverwriteCriteriaGrid();
        Log.Message("Now, there is " + arrayOfOverwriteCriteriaInSimulationNew.length + " Overwrite criteria in Simulation : " + arrayOfOverwriteCriteriaInSimulationNew, arrayOfOverwriteCriteriaInSimulationNew);
        
        CheckEquals(arrayOfOverwriteCriteriaInSimulationNew.length, arrayOfOverwriteCriteriaInProduction.length, "The new number of Overwrite criteria in Simulation");
        
        if (arrayOfOverwriteCriteriaInSimulationNew.length == arrayOfOverwriteCriteriaInProduction.length){
            for (var i = 0; i < arrayOfOverwriteCriteriaInSimulationNew.length; i++)
                CheckEquals(arrayOfOverwriteCriteriaInSimulationNew[i].toString(), arrayOfOverwriteCriteriaInProduction[i].toString(), "Overwrite criteria name and Modified Date in Simulation in new list at position " + IntToStr(i + 1));
        }
        
        //Fermer Croesus
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        if (Log.ErrCount > 0)
		    RestoreRQS(arrayOfBasicEnabledCriteria.concat(arrayOfBasicDisabledCriteria), arrayOfOverwriteEnabledCriteria.concat(arrayOfOverwriteDisabledCriteria));
    }
}
