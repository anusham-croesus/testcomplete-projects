//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CR1483_Common_functions



/**
    Description : Check the "Simulate" column contents if we modified a criterion
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-443
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_0443_Tit_Check_the_contents_of_Production_column_in_the_datagrid_of_Simple_Overwrite_category_window()
{
    try {
        var basicCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0443_Criterion1", language + client);
        var basicCriterionNameInSecuritiesGrid = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionNames", "CR1483_0443_SecuritiesCriterion1", language + client);        
        var criterionSymbol = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Misc", "CR1483_0443_CriterionSymbol", language + client);
        
        //Delete the criteria with same names
        Delete_FilterCriterion(basicCriterionName, vServerRQS);
        Delete_FilterCriterion(basicCriterionNameInSecuritiesGrid, vServerRQS);
        
        
        //Login
        Login(vServerRQS, userNameRQS, pswRQS, language);
        
        
        //1.1- Go to the securities module,click on "Risk Rating Methods Manager"  button, in Risk Rating Methods Manager window , click on Basic criteria
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        //Open the risk rating criteria manager window, click on Simulation Tab then Basic Criteria category
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Go to 'Simulation' tab.");
        Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    
        Log.Message("Create the criterion : " + basicCriterionName);
        Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
        Get_WinRiskRatingCriteriaEditor_TxtName().Keys(basicCriterionName);
        Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(true);
        Get_WinRiskRatingCriteriaEditor_GrpRating_RdoLow().set_IsChecked(true);
        
        CreateRiskRatingCondition_SecuritiesHavingSymbolEqualTo(criterionSymbol);
        
        Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
        
        //Envoyer en production
        SendToProduction();
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        //1.2- Execute SSH commands
        ExecuteDefaultSSHCommands();
        
        
        //1.3- Click on " Risk Rating Methods Manager"  button, in the risk rating criteria manager window , click on Basic Criteria, select  Criteria19. note the number displayed in  "Production" column.
        
        Log.Message("Open the Risk Rating Criteria Manager window");
        Get_SecuritiesBar_BtnRiskRatingManager().Click();
        
        Log.Message("Select 'Basic criteria' rating method.");
        Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
        
        var basicCriterionNameRowIndex = GetCriterionRowIndexInBasicOverwriteCriteriaGrid(basicCriterionName);
        var nbOfProductionsInBasicCriteriaGrid = GetBasicOverwriteCriteriaDisplayedNbOfProduction(basicCriterionNameRowIndex);
        
        Log.Message("The number of Production in Basic Criteria grid for '" + basicCriterionName + "' is : " + nbOfProductionsInBasicCriteriaGrid);
        
        //Close Risk Rating Criteria Manager window
        Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
        
        //1.4- In the securities toolbar click on "Manage Search Creteria" button, create a searche Critera:
        
        CreateCriterionInSecurities_SecuritiesHavingSymbolEqualTo(criterionSymbol, basicCriterionNameInSecuritiesGrid);
        
        //Get The number of checked securities
        Delay(1000); //For the NbOfcheckedElements to be updated
        var nbOfCheckedSecurities = Get_MainWindow_StatusBar_NbOfcheckedElements().Text;
        Log.Message("In the Security grid, The number of checked securities is : " + nbOfCheckedSecurities);
        
        
        //1.5- Check if the number displayed in "Production" column equal to the number of checked securities in Securities grid.

        Log.Message("Check if the nbOfCheckedSecurities of the securities grid and the nbOfProductionsInBasicCriteriaGrid of the Risk Index Manager are the same.");
        nbOfCheckedSecurities = ConvertStrToNumberFormat(nbOfCheckedSecurities);
        nbOfProductionsInBasicCriteriaGrid = ConvertStrToNumberFormat(nbOfProductionsInBasicCriteriaGrid);
        aqObject.CompareProperty(StrToInt(nbOfProductionsInBasicCriteriaGrid), cmpEqual, StrToInt(nbOfCheckedSecurities), true, lmError);       
                
        
        //Close Croesus
        Close_Croesus_X();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
        
        //Delete the criteria
        Delete_FilterCriterion(basicCriterionNameInSecuritiesGrid, vServerRQS);
        
        RestoreRQS(basicCriterionName, null, true, true, false);
    } 
}