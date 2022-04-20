//USEUNIT CR1485_003_Acc_DateDef_RepCR1905



/**
    Description : 
    Analyste d'assurance qualité : Alberto Quintero
    Analyste d'automatisation : Christophe Paring
*/

function CR1485_097_Acc_DateDef_RepCR1905()
{
    Log.Message("Pré-requis : CR1485_PreparationBD_CR1905");
    
    var reportName = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 1, language);
    var reportFileName_English = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 245);
    var reportFileName_French = GetData(filePath_ReportsCR1485, "097_EVAL_VC", 246);
    
    Activate_Inactivate_Pref(userNameReportsCR1485, "PREF_REPORT_EVAL_VC", "YES", vServerReportsCR1485);
    CR1485_CR1905_Acc_DateDef_RepCR1905(reportName, reportFileName_English, reportFileName_French);
}