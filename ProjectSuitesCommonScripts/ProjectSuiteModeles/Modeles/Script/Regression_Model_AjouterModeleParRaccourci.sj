//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2311

function Regression_Model_AjouterModeleParRaccourci()
{
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username"),
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameUsed = "Test-" + UniqueID;
  
  Get_ModelsGrid().Keys("^n");
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameUsed);
  Get_WinModelInfo_GrpModel_CmbIACode().Click();
  Get_WinModelInfo_GrpModel_CmbIACode().Keys("BD88");
  Log.Message("Il n'est pas possible d'entrer un code CP manuellement (CROES-8812)");
  Get_WinModelInfo_BtnOK().Click();
  if(Get_ModelsGrid().FindChild("Value", nameUsed, 10).Exists)
  {
    Log.Checkpoint("Modèle créé.");
    DeleteModelByName(nameUsed);
  }
  else
    Log.Error("Le modèle n'a pas été créé.");
  
  Close_Croesus_MenuBar();
}