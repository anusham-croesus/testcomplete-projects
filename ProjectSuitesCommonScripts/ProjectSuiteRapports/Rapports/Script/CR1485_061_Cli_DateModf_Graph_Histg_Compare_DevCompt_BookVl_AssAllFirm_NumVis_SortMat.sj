//USEUNIT CR1485_003_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_061_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat()
{
    var reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 285);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 286);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_INTER", "YES", vServerReportsCR1485);
    CR1485_CR1458_Evaluation_du_portefeuille_Cli_DateModf_Graph_Histg_Compare_DevCompt_BookVl_AssAllFirm_NumVis_SortMat(reportName, reportFileName_English, reportFileName_French);
}