//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA


function Performance_Mod_GE_BLEND(){
  
//        Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 76, language),"Performance_Mod_GE_BLEND","","UMA");

      var modelUMA200 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA200", language+client);
      Performance_Mod_UMA_Rebalance(modelUMA200,"Performance_Mod_GE_BLEND","","UMA");

}