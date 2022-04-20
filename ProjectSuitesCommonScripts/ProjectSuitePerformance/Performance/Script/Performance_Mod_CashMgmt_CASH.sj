//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA


function Performance_Mod_CashMgmt_CASH(){
  
//        Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 77, language),"Performance_Mod_CashMgmt_CASH", "Cash Management","UMA");
      
      var modelUMA500 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA500", language+client);
      Performance_Mod_UMA_Rebalance(modelUMA500,"Performance_Mod_CashMgmt_CASH","Cash Management","UMA");

}