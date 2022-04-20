//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1404_16_GenererRapport


function CR1404_16_08_RapportDeBaseAvecIndices()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","YES",vServerPortefeuille);

  var excelPageName = "CR1404_16_08";
  var reportName = GetData(filePath_Portefeuille, excelPageName, 1, language);
  var reportFolderPath = Project.Path + "GENERATED_REPORTS\\CR1404\\CR1404_16_08\\";
  GenererRapport(excelPageName, reportName, reportFolderPath);

  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
}