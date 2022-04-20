//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_CashMgmt_EQUILIBRE(){
      
//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 80, language),"Performance_Mod_CashMgmt_EQUILIBRE","Cash Management","IAModel");
 
      var modelCP35 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelCP35", language+client);
      Performance_Mod_UMA_Rebalance(modelCP35,"Performance_Mod_CashMgmt_EQUILIBRE","Cash Management","IAModel");
      
}
