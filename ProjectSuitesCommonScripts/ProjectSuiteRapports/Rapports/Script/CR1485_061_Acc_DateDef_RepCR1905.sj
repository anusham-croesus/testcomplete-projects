//USEUNIT CR1485_003_Acc_DateDef_RepCR1905



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_061_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    
    var reportName = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 291);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "061_EVAL_INTER", 292);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_INTER", "YES", vServerReportsCR1485);
    CR1485_CR1905_Acc_DateDef_RepCR1905(reportName, reportFileName_English, reportFileName_French);
}