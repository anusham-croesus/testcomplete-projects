//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_SMALLBAL(){
      
//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 82, language),"Performance_Mod_SMALLBAL","","IAModel");

      var modelCP127 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelCP127", language+client);
      Performance_Mod_UMA_Rebalance(modelCP127,"Performance_Mod_SMALLBAL","","IAModel");
      
}
