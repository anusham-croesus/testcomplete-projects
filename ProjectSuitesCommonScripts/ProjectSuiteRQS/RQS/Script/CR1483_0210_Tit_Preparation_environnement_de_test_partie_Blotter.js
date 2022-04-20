//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_functions



/**
    Description : Préparation de l'environnement de test partie Risk Rating
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-210
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/



function CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter()
{
    try {
        CR1483_0210_Tit_EnvironmentPreparation_Step1();
        CR1483_0210_Tit_EnvironmentPreparation_Step2();
        CR1483_0210_Tit_EnvironmentPreparation_Step3();
        CR1483_0210_Tit_EnvironmentPreparation_Step4();
        CR1483_0210_Tit_EnvironmentPreparation_Step5_6()
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    }
}


function CR1483_0210_Tit_EnvironmentPreparation_Step1()
{
    Log.Message("CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter Step 1 ...");
    
    //Pour LOB, la commande cfLoader DashboardRegenerator est plutôt comme suit : cfLoader -DashboardRegenerator generateClientPortfolio=true -firm=FIRM_1
    Log.Message("Pour LOB, la commande cfLoader DashboardRegenerator est plutôt comme suit : cfLoader -DashboardRegenerator generateClientPortfolio=true -firm=FIRM_1");
    Log.Message("Pour LOB, modifier en conséquence le fichier : ssh_CR1483_0210_step1.txt"); 
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_CR1483_0210_step1.txt > ssh_CR1483_0210_step1_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\ssh_CR1483_0210_step1_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}


function CR1483_0210_Tit_EnvironmentPreparation_Step2()
{
    Log.Message("CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter Step 2 ...");
    
    //Execute SQL Query
    var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\sql_CR1483_0210_step2.sql"
    var queryString = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Log.Message("Execute SQL query", queryString);
    Execute_SQLQuery(queryString, vServerRQS);
    
    //Restart Services
    RestartServices(vServerRQS);
}


function CR1483_0210_Tit_EnvironmentPreparation_Step3()
{
    Log.Message("CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter Step 3 ...");
    
    var criterion1_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion1_Name", language + client);
    var criterion1_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion1_Description", language + client);
    var criterion1_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion1_ActiveStatus", language + client);
    var criterion1_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion1_OverwriteStatus", language + client);
    var criterion1_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion1_Rating", language + client);
    var criterion1_conditionFunction = "CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToCAD()";
    
    var criterion2_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion2_Name", language + client);
    var criterion2_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion2_Description", language + client);
    var criterion2_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion2_ActiveStatus", language + client);
    var criterion2_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion2_OverwriteStatus", language + client);
    var criterion2_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion2_Rating", language + client);
    var criterion2_conditionFunction = "CreateRiskRatingCondition_SecuritiesHavingSecurityCurrencyEqualToUSD()";
    
    var criterion3_name = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion3_Name", language + client);
    var criterion3_description = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion3_Description", language + client);
    var criterion3_activeStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion3_ActiveStatus", language + client);
    var criterion3_overwriteStatus = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion3_OverwriteStatus", language + client);
    var criterion3_rating = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Criterion3_Rating", language + client);
    var criterion3_subcategory1 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemBondFunds", language + client);
    var criterion3_subcategory2 = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCommonStock", language + client);
    
    
    //Delete the criteria with the same names
    Delete_FilterCriterion(criterion1_name, vServerRQS);
    Delete_FilterCriterion(criterion2_name, vServerRQS);
    Delete_FilterCriterion(criterion3_name, vServerRQS);
    
    //Login
    Login(vServerRQS, userNameRQS, pswRQS, language);
    
    //Aller au Module Titres et ouvrir la fenêtre de classification du risque
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
    
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    
    //Créer Critere 1
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    SetCriterionAttributes(criterion1_name, criterion1_description, criterion1_activeStatus, criterion1_overwriteStatus, criterion1_rating, criterion1_conditionFunction);
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Créer Critere 2
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    SetCriterionAttributes(criterion2_name, criterion2_description, criterion2_activeStatus, criterion2_overwriteStatus, criterion2_rating, criterion2_conditionFunction);
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Créer Critere 3
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    SetCriterionAttributes(criterion3_name, criterion3_description, criterion3_activeStatus, criterion3_overwriteStatus, criterion3_rating);
    CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo(criterion3_subcategory1);
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlDot", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemOr", language + client)).Click();
    CreateRiskRatingCondition_SecuritiesHavingSubcategoryEqualTo(criterion3_subcategory2);
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Send to Production
    SendToProduction();
        
    //Close Risk Rating Criteria Manager window
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
        
    //Execute SSH commands
    ExecuteDefaultSSHCommands();
    
    //Close Croesus
    Close_Croesus_X();
}



function CR1483_0210_Tit_EnvironmentPreparation_Step4()
{
    Log.Message("CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter Step 4 ...");
    
    //Execute SQL Query
    var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\sql_CR1483_0210_step4.sql"
    var queryString = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Log.Message("Execute SQL query", queryString);
    Execute_SQLQuery(queryString, vServerRQS);
}



function CR1483_0210_Tit_EnvironmentPreparation_Step5_6()
{
    Log.Message("CR1483_0210_Tit_Preparation_environnement_de_test_partie_Blotter Step 5 ...");
    
    //5.1-
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_CR1483_0210_step5_1.txt > ssh_CR1483_0210_step5_1_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\ssh_CR1483_0210_step5_1_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    //Execute PLINK batch file
    ExecuteBatchFile(plinkBatchFilePath);
    
    
    //5.2-
    //Execute SQL Query
    var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\sql_CR1483_0210_step5_2.sql"
    var queryString = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Log.Message("Execute SQL query", queryString);
    Execute_SQLQuery(queryString, vServerRQS);
    
    
    //5.3-
    //Create PLINK batch file
    Log.Message("Bug JIRA CROES-9103.");
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_CR1483_0210_step5_3.txt > ssh_CR1483_0210_step5_3_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\ssh_CR1483_0210_step5_3_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    //Execute PLINK batch file
    ExecuteBatchFile(plinkBatchFilePath);
    
    
    //Validate if there is alert created in b_rqs_alert with Alert_test_id=5
    Log.Message("Validate if there is alert created in b_rqs_alert with Alert_test_id = 5");
    var queryString = "select count(*) as nbAlerts from b_rqs_alert where alert_test_id = 5";
    var nbAlerts = Execute_SQLQuery_GetField(queryString, vServerRQS, "nbAlerts");
    aqObject.CompareProperty(nbAlerts, cmpGreater, 0, true, lmError);
    
    
    //Validate if alerts are created in b_rqs_alert_security
    var queryString = "select * from b_rqs_alert where ALERT_TEST_ID = 5"; //Get all ALERT_ID for ALERT_TEST_ID = 5
    var arrayOfALertIdValues = Execute_SQLQuery_GetFieldAllValues(queryString, vServerRQS, "ALERT_ID");
    for (var i = 0; i < arrayOfALertIdValues.length; i++){
        var alertID = arrayOfALertIdValues[i];
        Log.Message("Check if in b_rqs_alert_security table there is a record with alert_id = " + alertID);
        var queryString = "select count(*) as nbAlerts from b_rqs_alert_security where alert_id = " + alertID;
        var nbAlerts = Execute_SQLQuery_GetField(queryString, vServerRQS, "nbAlerts");
        aqObject.CompareProperty(nbAlerts, cmpGreater, 0, true, lmError);
    }
    
    
    //Login
    Login(vServerRQS, userNameRQS, pswRQS, language);
    
    Get_Toolbar_BtnRQS().Click();
    
    //5.4-Valider si des alertes sont génerées dans l'onglet Security Alerts
    Log.Message("Check if some alerts are generated in the Security Alerts tab.");
    Get_WinRQS_TabSecurityAlerts().Click();
    aqObject.CompareProperty(Get_WinRQS_TabSecurityAlerts_DgvAlerts().Items.Count, cmpGreater, 0, true, lmError);
    
    //6.3 Dans l'onglet Transaction blotter Valider si la grille est populée
    Log.Message("In the Transaction Blotter tab, check if the grid is populated.");
    Get_WinRQS_TabTransactionBlotter().Click();
    aqObject.CompareProperty(Get_WinRQS_TabTransactionBlotter_DgvTransactions().Items.Count, cmpGreater, 0, true, lmError);
    
    //6.4 Dans l'onglet Alerts valider si des alertes de type (la valeur de la clonne test) concentration, suitability alert,Deposit and transfer in et Taking opposite sides of the same position  sont génrées.
    Log.Message("In the Alerts tab, check if all the expected alert types are displayed.");
    var expectedTestValues = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CR1483_0210_Alert_TestTypes", language + client);
    var arrayOfExpectedTestValues = expectedTestValues.split("|");
    Get_WinRQS_TabAlerts().Click();
    aqObject.CompareProperty(CheckIfExpectedTestValuesAreFoundInAlertsGrid(arrayOfExpectedTestValues), cmpEqual, true, true, lmError);
    
    Get_WinRQS().Close();
    
    //Close Croesus
    Close_Croesus_X();
    
}



function CheckIfExpectedTestValuesAreFoundInAlertsGrid(arrayOfExpectedTestValues)
{
    Log.Message("Expected column Test values : " + arrayOfExpectedTestValues, arrayOfExpectedTestValues);
    
    if (GetVarType(arrayOfExpectedTestValues) != varArray && GetVarType(arrayOfExpectedTestValues) != varDispatch)
        arrayOfExpectedTestValues = new Array(arrayOfExpectedTestValues);
    
    var TestColumnIndex = Get_WinRQS_TabAlerts_DgvAlerts_ChTest().WPFControlOrdinalNo;
    var AlertNoColumnIndex = Get_WinRQS_TabAlerts_DgvAlerts_ChAlertNo().WPFControlOrdinalNo;
    
    //Goto the first row
    Get_WinRQS_TabAlerts_DgvAlerts().Keys("[Home][Home]");
    
    //Navigate through the grid
    var isEndOfGridReached = false;
    while (!isEndOfGridReached){
        Get_WinRQS_TabAlerts_DgvAlerts().Refresh();
        var rowCount = Get_WinRQS_TabAlerts_DgvAlerts().ChildCount;
        for (var rowIndex = 1; rowIndex <= rowCount; rowIndex++){
            var currentRow = Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rowIndex], 10); 
            if (!currentRow.Exists)
                break;
            
            var currentTestValue = currentRow.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", TestColumnIndex], 10).WPFControlText;
            
            var indexOfTestInExpectedValues = arrayOfExpectedTestValues.indexOf(currentTestValue);
            if (indexOfTestInExpectedValues == -1)
                continue;
            
            //If Test value found, remove it from the arrayOfExpectedTestValues
            arrayOfExpectedTestValues.splice(indexOfTestInExpectedValues, 1);
            
            if (arrayOfExpectedTestValues.length == 0)
                return true;
        }
        
        var previousFirstAlertNo = Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", AlertNoColumnIndex], 10).WPFControlText;
        Get_WinRQS_TabAlerts_DgvAlerts().Keys("[PageDown]");
        var currentFirstAlertNo = Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", AlertNoColumnIndex], 10).WPFControlText;
        
        if (previousFirstAlertNo == currentFirstAlertNo){
            var previousFirstAlertNo = Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", AlertNoColumnIndex], 10).WPFControlText;
            Get_WinRQS_TabAlerts_DgvAlerts().Keys("[PageDown]");
            var currentFirstAlertNo = Get_WinRQS_TabAlerts_DgvAlerts().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", AlertNoColumnIndex], 10).WPFControlText;
            
            if (previousFirstAlertNo == currentFirstAlertNo)
                isEndOfGridReached = true;
        }
    }
    
    Log.Message("The following Test values were not found : " + arrayOfExpectedTestValues, arrayOfExpectedTestValues);
    return false;
}