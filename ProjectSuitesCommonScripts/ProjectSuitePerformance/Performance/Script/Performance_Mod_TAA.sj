//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA


function Performance_Mod_TAA(){
  
//        Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 78, language),"Performance_Mod_TAA","","UMA");

      var modelUMASeg0 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA2000Seg0", language+client);
      Performance_Mod_UMA_Rebalance(modelUMASeg0,"Performance_Mod_TAA","","UMA");

}