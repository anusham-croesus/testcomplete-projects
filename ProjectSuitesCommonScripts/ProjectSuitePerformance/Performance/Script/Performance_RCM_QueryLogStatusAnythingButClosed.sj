//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCM_QueryLogStatusClosed
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_QueryLogStatusAnythingButClosed(){

//        var queryLogFromDate = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "QueryLogFromDate", language+client);
        var statusValue      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "StatusValueAnything", language+client);
             
        Performance_RCM_QueryLogStatus(statusValue, "Performance_RCM_QueryLogStatusAnythingButClosed");     
}