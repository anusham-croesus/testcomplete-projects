//USEUNIT CR1485_003_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_097_Acc_DateDef_Grph_Pie_BkVL_AssAllFirm_NumVis_SortMat()
{
    var reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 233);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 234);
    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    
    Activate_Inactivate_Pref(userNameKEYNEJ, "PREF_REPORT_EVAL_VC", "YES", vServerReportsCR1485);
    CR1485_CROES_9126_Acc_Evaluation_du_portefeuille(reportName, reportFileName_English, reportFileName_French);
}