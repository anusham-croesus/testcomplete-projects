//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider le fonctionnement du bouton Performance d'un seul compte
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1501
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1501_Acc_Validate_the_operation_of_Performance_button_for_one_account()
{
    var accountNo = "800238-SF";
    
    Login(vServerAccounts, userName, psw, language);
    SelectAccounts(accountNo);
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 38, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 39, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 40, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPerformanceCalculations_CmbPerformanceCalculations(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 41, language));
    if (client != "RJ"){
        aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 42, language));
    }
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 43, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 44, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 45, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 46, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 47, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 48, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 49, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 50, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 51, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 52, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 53, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 54, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 55, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 56, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 57, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 58, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 59, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 60, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 61, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 62, language));
    
    Get_WinPerformance_BtnClose().Click();
    Close_Croesus_SysMenu();
}