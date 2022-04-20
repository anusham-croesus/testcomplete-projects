//USEUNIT CR1483_Common_functions




/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-
    Analyste d'assurance qualité : 
    Analyste d'automatisation : 
*/

function CR1958_PreparationBD()
{
    try {
        var productionPassword = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "PreparationBD", "CroesusEncryptedPassword", language + client);
        
        //Activer les prefs
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_OBJECTIVES_GRAPH", "YES", vServerRQS);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_COMPLIANCE_MANAGER", "YES", vServerRQS);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_RISK_RATING", "2", vServerRQS);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ALLOW_RISK_RATING", "YES", vServerRQS);
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_SECURITY_RATING_PASSWORD", productionPassword, vServerRQS);
        
        //Risk Rating levels labels
        var ratingLabel_Low         = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client);
        var ratingLabel_LowMedium   = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_LowMedium", language + client);
        var ratingLabel_Medium      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client);
        var ratingLabel_MediumHigh  = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_MediumHigh", language + client);
        var ratingLabel_High        = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client);
        
        //All Risk Rating levels labels
        var arrayofAllRatingLabels = [];
            arrayofAllRatingLabels.push(ratingLabel_Low);
            arrayofAllRatingLabels.push(ratingLabel_LowMedium);
            arrayofAllRatingLabels.push(ratingLabel_Medium);
            arrayofAllRatingLabels.push(ratingLabel_MediumHigh);
            arrayofAllRatingLabels.push(ratingLabel_High);
        
        //Create relevant maps containing Risk Rating levels weighs for levels displayed in the graph
        var riskRatingWeightsForLowLevel    = GetLevelWeightsInfosFromExcel(ratingLabel_Low);
        var riskRatingWeightsForMediumLevel = GetLevelWeightsInfosFromExcel(ratingLabel_Medium);
        var riskRatingWeightsForHighLevel   = GetLevelWeightsInfosFromExcel(ratingLabel_High);
        
        //Configs
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\CR1958_PreparationBD_1.sql", vServerRQS);//////
        ExecuteSQLFile_ThroughISQL(folderPath_ProjectSuiteCommonScripts + "ProjectSuiteRQS\\RQS\\SQL\\CR1958_PreparationBD_2.sql", vServerRQS);//////
        
        RestartServices(vServerRQS);
        
        //Connect to croesus (user = Keynej, Firm Administrator
        var userKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var pswdKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        Login(vServerRQS, userKEYNEJ, pswdKEYNEJ, language);
        
        var numTry = 0;
        do {
            Get_MenuBar_Tools().OpenMenu();
        } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
        
        Get_MenuBar_Tools_Configurations().Click();
        Get_WinConfigurations_TvwTreeview_LlbRiskComplianceManager().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
            
        Get_WinConfigurations_LvwListView_LlbRiskRatingAllocation().DblClick();
        WaitObject(Get_CroesusApp(),"Uid", "Window_2efc");
        
        //Risk Rating Weights for level : Low
        for (j in arrayofAllRatingLabels){
            var ratingRow = arrayofAllRatingLabels[j];
            var levelColumn = ratingLabel_Low;
            var weightValue = riskRatingWeightsForLowLevel.get(ratingRow);
            WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevel(ratingRow, levelColumn, weightValue);
        }
        
        //Risk Rating Weights for level : Medium
        for (j in arrayofAllRatingLabels){
            var ratingRow = arrayofAllRatingLabels[j];
            var levelColumn = ratingLabel_Medium;
            var weightValue = riskRatingWeightsForMediumLevel.get(ratingRow);
            WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevel(ratingRow, levelColumn, weightValue);
        }
        
        //Risk Rating Weights for level : High
        for (j in arrayofAllRatingLabels){
            var ratingRow = arrayofAllRatingLabels[j];
            var levelColumn = ratingLabel_High;
            var weightValue = riskRatingWeightsForHighLevel.get(ratingRow);
            WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevel(ratingRow, levelColumn, weightValue);
        }
        
        //Risk Rating Profiles Mnemonic codes
        WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(ratingLabel_Low,      GetLevelProfileInfosFromExcel(ratingLabel_Low).get("Mnemonic-Code"));
        WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(ratingLabel_Medium,   GetLevelProfileInfosFromExcel(ratingLabel_Medium).get("Mnemonic-Code"));
        WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(ratingLabel_High,     GetLevelProfileInfosFromExcel(ratingLabel_High).get("Mnemonic-Code"));
        
        //Save
        Get_WinRiskAllocationConfigurationTool_BtnSave().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["BaseWindow",1]);
        Get_DlgConfirmation_TxtRiskIndexPasswordBox().Keys(productionPassword);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 80);
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "Window_2efc");
        
        Get_WinConfigurations().Close();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
        
        //Fermer Croesus
        Close_Croesus_X();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        RestoreAutoTimeOut();
        
        //Excute Risk Rating plugin
        ExecuteDefaultSSHCommands();
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}



function GetLevelWeightsInfosFromExcel(riskRatingLevel)
{
    //Get all Risk Rating levels labels
    var arrayofAllRatingLabels = [];
        arrayofAllRatingLabels.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Low", language + client));
        arrayofAllRatingLabels.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_LowMedium", language + client));
        arrayofAllRatingLabels.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_Medium", language + client));
        arrayofAllRatingLabels.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_MediumHigh", language + client));
        arrayofAllRatingLabels.push(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "Labels", "Rating_High", language + client));
        
    //Set Weight values
    var riskRatingWeightsForLevel = new Map();
    for (var i in arrayofAllRatingLabels)
        riskRatingWeightsForLevel.set(arrayofAllRatingLabels[i], ConvertStrToNumberFormat(ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Risk_Ratings_" + language + client, arrayofAllRatingLabels[i], riskRatingLevel)));
    
    return riskRatingWeightsForLevel;
}



function GetLevelProfileInfosFromExcel(riskRatingLevel)
{
    //Set Profile infos
    var riskRatingProfileForLevel = new Map();
        riskRatingProfileForLevel.set("Color-RGBA", ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Risk_Ratings_" + language + client, "Color-RGBA", riskRatingLevel));
        riskRatingProfileForLevel.set("Mnemonic-Code", ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Risk_Ratings_" + language + client, "Mnemonic-Code", riskRatingLevel));
        riskRatingProfileForLevel.set("Profile-Code", ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958_Risk_Ratings_" + language + client, "Profile-Code", riskRatingLevel));

    return riskRatingProfileForLevel;
}



function WinRiskAllocationConfigurationTool_DgvRiskAllocation_TxtRatingLevel(rating, level, value)
{
    
    switch(rating){
        case "Low":
        {                 
            Log.Message("The security risk ratings: low");  
            var rating = 1;                
            break;
        }
        case "Low-Medium":
        {  
            Log.Message("The security risk ratings: low-Medium");  
            var rating = 2;               
            break;
        }
        case "Medium":
        {  
            Log.Message("The security risk ratings: Medium");  
            var rating = 3;                    
            break;
        }
        case "Medium-High":
        {  
            Log.Message("The security risk ratings: Medium-High");  
            var rating = 4;                  
            break;
        }                  
        case "High":
        {  
            Log.Message("The security risk ratings: High");  
            var rating = 5;                   
            break;
        }
    }
    
    
    switch(level){
        case "Low":
        {  
            Log.Message("The security risk ratings: Low");  
            var level = 3;                    
            break;
        }
        case "Medium":
        {  
            Log.Message("The security risk ratings: Medium");  
            var level = 4;                  
            break;
        }                  
        case "High":
        {  
            Log.Message("The security risk ratings: High");  
            var level = 5;                   
            break;
        }
    }
    
    Log.Message("The value: " + value);
    Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", level], 10).WPFObject("XamNumericEditor", "", 1).Click();
    Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", level], 10).WPFObject("XamNumericEditor", "", 1).Keys(value + "[Tab]");
    Delay(500);
    var isTotalEqualToHundredEverywhere = true;
    for (var i = 1; i <= 5; i++)
        if ('100' != VarToStr(Get_WinRiskAllocationConfigurationTool_DgvRiskAllocation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", i], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).DisplayText.OleValue)){
            isTotalEqualToHundredEverywhere = false;
            break;
        }
    
    CompareProperty(Get_WinRiskAllocationConfigurationTool_BtnSave().IsEnabled, cmpEqual, isTotalEqualToHundredEverywhere, true, lmError);
}




function WinRiskAllocationConfigurationTool_TabRiskAllocationLevel(rating, value)
{
    switch(rating){
        case "Low":
        {
            Log.Message("The Risk allocation levels: low");  
            var rating = 1;                
            break;
        }
        case "Medium":
        {
            Log.Message("The Risk allocation levels: Medium");  
            var rating = 2;          
            break;
        }          
        case "High":
        {  
            Log.Message("The Risk allocation levels: High");  
            var rating = 3;                   
            break;
        }
    }
    
    Log.Message("The value: " + value);
    Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Click()
    Get_WinRiskAllocationConfigurationTool_TabRiskAllocationLevel().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["RecordListControl", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", rating], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamTextEditor", "", 1).Keys(value);
}




function Create_profiles(mnemonic, frenchShort, frenchLong, englishShort, englishLong, txtLenght, vServer)
{
    var numTry = 0;
    do {
        Get_MenuBar_Tools().OpenMenu();
    } while (++numTry < 5 && !WaitObjectWithPersistenceCheck(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PopupRoot", 1], 3000, 4000))
    
    Get_MenuBar_Tools_Configurations().Click();
    Get_WinConfigurations_TvwTreeview_LlbProfilesAndDictionaries().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
    
    Get_WinConfigurations_LvwListView_LlbProfiles().DblClick();
    WaitObject(Get_CroesusApp(),"Uid", "ConfigurationWindow_a034");
          
    if (Validate_CreateProfiles(mnemonic) == true)
        Log.Message("The profiles" + mnemonic + " already created");
    else {
        Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid", "ProfilConfigurationWindow_41d4");
        
        Get_WinAddOrEditProfile_GrpProfile_TxtMnemonic().Keys(mnemonic);
        Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchShort().Keys(frenchShort);
        Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtFrenchLong().Keys(frenchLong);
        Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishShort().Keys(englishShort);
        Get_WinAddOrEditProfile_GrpProfile_GrpDescription_TxtEnglishLong().Keys(englishLong);
        
        Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType().DropDown();
        Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbType_ItemNumeric().Click();
        Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_TxtLenght().set_Text(txtLenght);
        
        Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel().Click();
        Get_WinAddOrEditProfile_GrpProfile_GrpDefinition_CmbAccessLevel_ItemReadOnly().Click();
        
        Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkExportToMSWord().set_IsChecked(false)
        Get_WinAddOrEditProfile_GrpProfile_GrpAlsoDisplayIn_ChkSearchCriteria().set_IsChecked(true)
        
        Get_WinAddOrEditProfile_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ProfilConfigurationWindow_41d4");   
    }
    
    Get_WinProfilesAndDictionaryConfiguration_BtnClose().Click()
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "ConfigurationWindow_a034");
    
    Get_WinConfigurations().Close();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName","WPFControlOrdinalNo"], ["ListViewItem",1]);
    
    var indexRub = Execute_SQLQuery_GetField("select INDEX_RUB from  b_struc where tablesrc= 'b_Profil' and NOM_RUBR = '" + mnemonic + "'", vServer, "INDEX_RUB");
    return indexRub;
}



function Validate_CreateProfiles(mnemonic)
{
    var count = Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().WPFObject("RecordListControl", "", 1).Items.Count;
    var found = false;
    
    for (var i = 0; i < count; i++){
        found = (Get_WinProfilesAndDictionaryConfiguration_TabListOfProfiles_DgvListOfProfiles().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Name == mnemonic)
        if (found)
            break;
    }
    
    return found;
}


//Mettre dans Common_function et utiliser ailleurs si tests concluants
function WaitObjectWithPersistenceCheck(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject, maxWaitTimeForWaitUntilObjectDisappears)
{
    return (WaitObject(parentObject, properties, propertiesValues, maxWaitTimeForWaitObject) && !WaitUntilObjectDisappears(parentObject, properties, propertiesValues, maxWaitTimeForWaitUntilObjectDisappears));
}
