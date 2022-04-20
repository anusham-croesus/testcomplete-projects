//USEUNIT CR1679_001_Acc_all_trans


/**
    Description : CR1679, CAS DE TEST 2
    https://jira.croesus.com/browse/DAS-4418
    P:\aq\Conseillers QA\Carole\TEST AUTO\CR1679\Procédure pour régresser le CR1679.docx
    Analyste d'assurance qualité : Carole Turcotte
    Analyste d'automatisation : Christophe Paring
    Version de scriptage : ref90-09-Er-15--V9-croesus-co7x-1_5_565
*/
function CR1679_002_Acc_full_b_statis()
{
    Log.Link("https://jira.croesus.com/browse/DAS-4418", "CR1679_002_Acc_full_b_statis()");
    
    var accountNo = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Account_Number", language + client);
    var FIRST_TRANS_DATE = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Account_FIRST_TRANS_DATE", language + client);
    var Portfolio_Performance_DisplayDetails = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Portfolio_Performance_DisplayDetails", language + client);
    var Performance_Monthly_StartDate = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Performance_Monthly_StartDate", language + client);
    var reportFileName = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_ReportFileName", language + client);
    
    var Portfolio_Performance_Period_ToValidate = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Report_Portfolio_Performance_Period_ToValidate", language + client);
    var NetInvestmentAsOfReportDate_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_NetInvestmentAsOfReportDate_Value", language + client);
    var InitialValue_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_InitialValue_Value", language + client);
    var NetInvestment_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_NetInvestment_Value", language + client);
    var Inflows_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Inflows_Value", language + client);
    var Outflows_ExpectedValue = ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "CR1679", "CR1679_002_Acc_full_b_statis_Outflows_Value", language + client);
    
    CR1679(accountNo, FIRST_TRANS_DATE, Portfolio_Performance_DisplayDetails, Performance_Monthly_StartDate, reportFileName, Portfolio_Performance_Period_ToValidate, NetInvestmentAsOfReportDate_ExpectedValue, InitialValue_ExpectedValue, NetInvestment_ExpectedValue, Inflows_ExpectedValue, Outflows_ExpectedValue);
}