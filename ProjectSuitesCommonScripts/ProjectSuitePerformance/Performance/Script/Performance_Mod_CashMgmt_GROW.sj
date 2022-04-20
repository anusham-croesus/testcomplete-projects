//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_CashMgmt_GROW(){

//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 75, language),"Performance_Mod_CashMgmt_GROW", "Cash Management","UMA");

      var modelUMA25 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA25", language+client);
      Performance_Mod_UMA_Rebalance(modelUMA25,"Performance_Mod_CashMgmt_GROW","Cash Management","UMA");

}