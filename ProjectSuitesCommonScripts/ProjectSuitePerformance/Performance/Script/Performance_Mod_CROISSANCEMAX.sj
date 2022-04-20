//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_CROISSANCEMAX(){
      
//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 79, language),"Performance_Mod_CROISSANCEMAX","","IAModel");

      var modelUMASeg5 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA2000Seg5", language+client);
      Performance_Mod_UMA_Rebalance(modelUMASeg5,"Performance_Mod_CROISSANCEMAX","","IAModel");
      
}
