//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils
//USEUNIT Performance_Mod_UMA



function Performance_Mod_ALTER_INFRA(){    
//      Performance_Mod_UMA_Rebalance(GetData(filePath_Performance, sheetName_DataBD, 74, language),"Performance_Mod_ALTER_INFRA","","UMA");

      var modAlterIntra = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelAlterIntra", language+client);
      Performance_Mod_UMA_Rebalance(modAlterIntra,"Performance_Mod_ALTER_INFRA","","UMA");
      
}
