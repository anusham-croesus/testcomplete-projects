//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_BDC5050(){
      
//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 81, language),"Performance_Mod_BDC5050","","IAModel");

      var modelCP172 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelCP172", language+client);
      Performance_Mod_UMA_Rebalance(modelCP172,"Performance_Mod_BDC5050","","IAModel");
      
}
