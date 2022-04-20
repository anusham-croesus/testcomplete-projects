//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints
//USEUNIT Comptes_Get_functions



/**
    Description : Valider le fonctionnement du bouton Performance de plusieurs comptes
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1502
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/
 
function CR1352_1502_Acc_Validate_the_operation_of_Performance_button_for_multiple_accounts()
{
    
    var accountsNo = new Array("800238-SF", "800238-RE", "800238-GT");
    
    Login(vServerAccounts, userName, psw, language);
    SelectAccounts(accountsNo);
    Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpPeriod_CmbPeriod(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 65, language));
    if ( client == "US" ){
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 155, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 156, language));
    }
    else{ 
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_CmbCurrency(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 66, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpAccountsConvertedTo_LblDefaultCurrency(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 67, language));}
    if (client != "RJ"){
        aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_GrpMethod_CmbMethod(), "Text", cmpEqual, GetData(filePath_Accounts, "CR1352", 68, language));
    }
        
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 69, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 70, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 71, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 72, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 73, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 74, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4From(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 75, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4To(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 76, language));
    if ( client == "US" ){
      aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 157, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 158, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 159, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 160, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 161, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 162, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 163, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 164, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 165, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 166, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 167, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 168, language));
    } 
    else {
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 77, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 78, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod1NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 79, language));
    
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 80, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 81, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod2NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 82, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 83, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 84, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod3NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 85, language));

    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetROIPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 86, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetStandardDeviationPercent(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 87, language));
    aqObject.CheckProperty(Get_WinPerformance_GrpPerformances_TxtPeriod4NetSharpeIndex(), "WPFControlText", cmpEqual, GetData(filePath_Accounts, "CR1352", 88, language));}
    
    Get_WinPerformance_BtnClose().Click();
    Close_Croesus_SysMenu();
}