//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2308

function Regression_Model_AjouterModeleParBouton()
{
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "username"),
                             ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "GP1859", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  
  var UniqueID = "" + new Date().getDate() + "_" + new Date().getMonth() + "_" + Math.floor(Math.random() * 1000);
  var nameUsed = "Test-" + UniqueID;
  Get_Toolbar_BtnAdd().Click();
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
  
  Get_Toolbar_BtnAdd().Click();
  Get_WinModelInfo_BtnOK().Click();
  if(Get_DlgInformation().Exists)
  {
    Log.Checkpoint("Demande un nom et code pour créer un modèle.");
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual,
                  ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "ajoutModeleSansNom", language));
    Get_DlgInformation().Close();
  }
  else
  {
    Log.Error("Ne demande pas un nom et code pour créer un modèle.");
    if(!Get_WinModelInfo().Exists)
      Get_Toolbar_BtnAdd().Click();
  }
  
  Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameUsed);
  Get_WinModelInfo_BtnOK().Click();
  if(Get_DlgInformation().Exists)
  {
    Log.Checkpoint("Demande un code pour créer un modèle.");
    aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "Message", cmpEqual,
                  ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "ajoutModeleSansCode", language));
    Get_DlgInformation().Close();
  }
  else
  {
    Log.Error("Ne demande pas un code pour créer un modèle.");
    if(!Get_WinModelInfo().Exists)
      Get_Toolbar_BtnAdd().Click();
  }
  
  Get_WinModelInfo_BtnCancel().Click();
  if(Get_ModelsGrid().FindChild("Value", nameUsed, 10).Exists)
  {
    Log.Error("Modèle créé.")
    DeleteModelByName(nameUsed);
  }
  
  Close_Croesus_MenuBar();
}