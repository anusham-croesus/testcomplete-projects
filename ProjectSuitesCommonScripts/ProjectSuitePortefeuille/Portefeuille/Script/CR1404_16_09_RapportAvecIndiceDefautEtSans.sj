//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT CR1404_16_GenererRapport


function CR1404_16_09_RapportAvecIndiceDefautEtSans()
{
  var configTxt = Execute_SQLQuery_GetField("select config_txt from b_succ where no_succ = '0'", vServerPortefeuille, "config_txt");
  Activate_Inactivate_PrefBranch("0","PREF_REPORT_PORTFOLIO_PERFORMANCE_ASSET_CLASS","YES",vServerPortefeuille);

  var excelPageName = "CR1404_16_09-1";
  var reportName = GetData(filePath_Portefeuille, excelPageName, 1, language);
  var reportFolderPath = Project.Path + "GENERATED_REPORTS\\CR1404\\CR1404_16_09\\";
  var reportFileName = GetData(filePath_Portefeuille, excelPageName, 6, language);
  
  try
  {
    PreparationRapport(excelPageName, reportName, reportFolderPath);
    
    //rapport 1
    CreationRapport(excelPageName, reportName, reportFolderPath, reportFileName)
    
    //rapport 2
    excelPageName = "CR1404_16_09-2";
    reportName = GetData(filePath_Portefeuille, excelPageName, 1, language);
    reportFileName = GetData(filePath_Portefeuille, excelPageName, 6, language);
    CreationRapport(excelPageName, reportName, reportFolderPath, reportFileName)
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
  }

  Execute_SQLQuery("update b_succ set config_txt = '" + configTxt + "' from b_succ where no_succ = '0'", vServerPortefeuille);
}