//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1483_Common_functions


/**
    Description : Préparation de l'environnement de test partie Risk Rating
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-209
    Analyste d'assurance qualité : Malika Idir
    Analyste d'automatisation : Christophe Paring
*/

function CR1483_EnvironmentPreparation()
{
    try {
        CR1483_EnvironmentPreparation_Step1();
        CR1483_EnvironmentPreparation_Step2();
        CR1483_EnvironmentPreparation_Steps_3_4();
        CR1483_EnvironmentPreparation_Step6();
        //CR1483_EnvironmentPreparation_Step7(); //Problème de scroll à résoudre dans le module Titres
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    } 
}



function CR1483_EnvironmentPreparation_Step1()
{
    Log.Message("CR1483 Environment Preparation Step 1 ...");
    
    //Execute SQL Query
    var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\preparation_step1.sql"
    var queryString = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Log.Message("Execute SQL query", queryString);
    Execute_SQLQuery(queryString, vServerRQS);
}


function CR1483_EnvironmentPreparation_Step2()
{
    Log.Message("CR1483 Environment Preparation Step 2 ...");
    
    //Execute SQL Query
    var SQLFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\preparation_step2.sql"
    var queryString = aqFile.ReadWholeTextFile(SQLFilePath, aqFile.ctANSI);
    Log.Message("Execute SQL query", queryString);
    Execute_SQLQuery(queryString, vServerRQS);
    
    //Restart Services
    RestartServices(vServerRQS);
}



function CR1483_EnvironmentPreparation_Steps_3_4()
{
    //Login
    Login(vServerRQS, userNameRQS, pswRQS, language);
    
    Log.Message("CR1483 Environment Preparation Step 3 ...");
    
    //Aller au Module Titres et ouvrir la fenêtre de classification du risque
    Get_ModulesBar_BtnSecurities().Click();
    Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);
    
    Get_SecuritiesBar_BtnRiskRatingManager().Click();
    
    //Créer le critère CAD
    Get_WinRiskRatingCriteriaManager_TabSimulation().Click();
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    
    var criterionCADName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereCAD", language + client);
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionCADName);
    
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemPriceCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCAD", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemAnd", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemNotHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSubcategory", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemCdaBondsIncome", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
    
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(true);
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().set_IsChecked(false);
    Get_WinRiskRatingCriteriaEditor_GrpRating_RdoMedium().set_IsChecked(true);
    
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Vérifier que le critère CAD a été créé
    Log.Message("Check that the criterion '" + criterionCADName + "' is created.");
    var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionCADName);
    aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
    
    
    Log.Message("CR1483 Environment Preparation Step 4 ...");
    
    //Créer le critère USD
    Get_WinRiskRatingCriteriaManager_BarPadHeader_BtnAdd().Click();
    
    var criterionUSDName = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "NomCritereUSD", language + client);
    Get_WinRiskRatingCriteriaEditor_TxtName().Keys(criterionUSDName);
    
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlVerb", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemHaving", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlField", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemInformative", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemSecurityCurrency", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlOperator", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemEqualTo", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlValue", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemUSD", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_LlbPartControl(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "PartControlNext", language + client)).Click();
    Get_WinRiskRatingCriteriaEditor_LstCondition_Item(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CriterionCondition", "ItemDot", language + client)).Click();
    
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkActive().set_IsChecked(true);
    Get_WinRiskRatingCriteriaEditor_GrpStatus_ChkOverwriteCriteria().set_IsChecked(true);
    Get_WinRiskRatingCriteriaEditor_GrpRating_RdoHigh().set_IsChecked(true);
    
    Get_WinRiskRatingCriteriaEditor_BtnSave().Click();
    
    //Vérifier que le critère USD a été créé
    Log.Message("Check that the criterion '" + criterionUSDName + "' is created.");
    Log.Message("Select 'Overwrite criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionUSDName);
    aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
    
    //Cliquer sur le bouton Simulate All
    Log.Message("Click on 'Simulate All' button.");
    Get_WinRiskRatingCriteriaManager_BtnSimulateAllMethods().Click();
    
    
    //Envoyer en production
    SendToProduction();
    
    
    //Vérifier que les critères CAD et USD ont été envoyés en production
    Log.Message("Check that the criteria '" + criterionCADName + "' and '" + criterionUSDName + "' are sent to Production.");
    Get_WinRiskRatingCriteriaManager_TabProduction().Click();
    
    Log.Message("Select 'Basic criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnBasicCriteria().Click();
    var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionCADName);
    aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
    
    Log.Message("Select 'Overwrite criteria' rating method.");
    Get_WinRiskRatingCriteriaManager_RatingMethods_BtnOverwriteCriteria().Click();
    var isCriterionDisplayed = CheckIfCriterionIsDisplayedInBasicOverwriteCriteriaGrid(criterionUSDName);
    aqObject.CompareProperty(isCriterionDisplayed, cmpEqual, true, true, lmError);
    
    
    //Fermer la fenêtre de classification du risque
    Get_WinRiskRatingCriteriaManager_BtnClose().Click();
    
    
    //Fermer Croesus
    Close_Croesus_X();
}



function CR1483_EnvironmentPreparation_Step6()
{
    Log.Message("CR1483 Environment Preparation Step 6 ...");
    
    //Create PLINK batch file
    var hostname = GetVserverHostName(vServerRQS);
    var rootPassword = GET_VSERVER_SSH_ROOT_PSWD();
    var batchCmdLine = "chcp 1252 \r\n" + "echo y | plink -ssh root@" + hostname + " -pw " + GetBatchEscapedCharsString(rootPassword) + " -m ssh_preparation_step6.txt > ssh_preparation_step6_output.txt";
    var plinkBatchFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SSH\\ssh_preparation_step6_plink.bat";
    CreateFileAndWriteText(plinkBatchFilePath, batchCmdLine);
    
    //Execute PLINK batch file (The PLINK application must be present in the same folder)
    ExecuteBatchFile(plinkBatchFilePath);
}



function CR1483_EnvironmentPreparation_Step7()
{
    Get_SecurityGrid_ChDescription().ClickR();
    
    //Configuration par défaut des colonnes
    var numberOftries = 0;
    do {
        Get_SecurityGrid_ChDescription().ClickR();
        numberOftries++;
    } while (numberOftries < 5 && !Get_SubMenus().Exists)
    
    Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
    
    //Ajout de la colonne "Risk Rating"
    var numberOftries = 0;
    do {
        Get_SecurityGrid_ChDescription().ClickR();
        numberOftries++;
    } while (numberOftries < 5 && !Get_SubMenus().Exists)
    
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName("Cote de risque", "Risk Rating").Click();
    
    //Ajout de la colonne "Risk Rating Source"
    var numberOftries = 0;
    do {
        Get_SecurityGrid_ChDescription().ClickR();
        numberOftries++;
    } while (numberOftries < 5 && !Get_SubMenus().Exists)
    
    Get_GridHeader_ContextualMenu_AddColumn().Click();
    Get_GridHeader_ContextualMenu_AddColumnOrInsertField_ColumnOrFieldName("Prov. de la cote de risque", "Risk Rating Source").Click();
    

}



function GetColumnHeaderIndex(columnHeaderObject)
{
    return columnHeaderObject.WPFControlOrdinalNo;
} 



function Test3()
{
    Log.Message(GetColumnHeaderIndex(Get_SecurityGrid_ChRiskRating()));
    Log.Message(GetColumnHeaderIndex(Get_SecurityGrid_ChRiskRatingSource()));
    Log.Message(GetColumnHeaderIndex(Get_SecurityGrid_ChOverwrite()));
    Log.Message(GetColumnHeaderIndex(Get_SecurityGrid_ChCurrencyPrice()));
    Log.Message(GetColumnHeaderIndex(Get_SecurityGrid_ChYTMMarket()));
    return;
    Get_SecurityGrid_ChRiskRating().HoverMouse();
    Get_SecurityGrid_ChRiskRatingSource().HoverMouse();
    Get_SecurityGrid_ChOverwrite().HoverMouse();
}


function SelectAllSecurities()
{
    try {
    //    if (GetVarType(arrayOfSecuritiesNamesToBeSelected) != varArray && GetVarType(arrayOfSecuritiesNamesToBeSelected) != varDispatch)
    //        arrayOfSecuritiesNamesToBeSelected = new Array(arrayOfSecuritiesNamesToBeSelected);
        
        Get_ModulesBar_BtnSecurities().Click();
    
        Get_Toolbar_BtnSum().Click();
        securitiesTotalCount = Get_WinSecuritySum_GrpFinancialInstruments_DgvFinancialInstrumentsSum().WPFObject("RecordListControl", "", 1).Items.Item(12).DataItem.get_Count();
        Log.Message("The securities total count is : " + securitiesTotalCount);
        Get_WinSecuritySum_BtnClose().Click();
    
        Get_SecurityGrid().Click(Get_SecurityGrid().Width - 10, 22);
    
        Sys.Desktop.KeyDown(0x11); //Press Ctrl
        nbOfSelectedSecurities = 0;
        arrayOfAllSecuritiesNames = new Array();
    
        while (arrayOfAllSecuritiesNames.length < securitiesTotalCount){
            securitiesPageCount = Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
            for (i = 0; i < securitiesPageCount; i++){
                displayedSecurityName = VarToStr(Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description());
                isFound = false;
                for (j = 0; j < arrayOfAllSecuritiesNames.length; j++){
                    if (displayedSecurityName == arrayOfAllSecuritiesNames[j]){ 
                        isFound = true;
                        break;
                    }
                }
			
    //            if (!isFound){
    //                arrayOfAllSecuritiesNames.push(displayedSecurityName);
    //                
    //                for (k = 0; k < arrayOfSecuritiesNamesToBeSelected.length; k++){
    //                    if (displayedSecurityName == arrayOfSecuritiesNamesToBeSelected[k]){
    //                        Get_SecurityGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
    //                        nbOfSelectedSecurities ++;
    //                        break;
    //                    }
    //                }  
    //			}
            }
        
    //        if (nbOfSelectedSecurities == arrayOfSecuritiesNamesToBeSelected.length)
    //            break;

            Get_SecurityGrid().Click(Get_SecurityGrid().Width - 10, Get_SecurityGrid().Height - 40);
    
        }
    
        Sys.Desktop.KeyUp(0x11); //Release Ctrl
    
    //    if (nbOfSelectedSecurities < arrayOfSecuritiesNamesToBeSelected.length)
    //        Log.Warning("Only " + nbOfSelectedSecurities + " out of " + arrayOfSecuritiesNamesToBeSelected.length + " securities have been selected!");
    
    }
    catch (e){
        Log.Error("Exception", e.message);
        Sys.Desktop.KeyUp(0x11);
    }
}