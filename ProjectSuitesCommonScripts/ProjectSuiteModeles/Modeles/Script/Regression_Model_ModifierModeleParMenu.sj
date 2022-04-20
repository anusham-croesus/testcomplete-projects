//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2318

function Regression_Model_ModifierModeleParMenu()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  Get_Toolbar_BtnSearch().Click();
  
  var nameModel = "*FALL BACK";
  var createNewModel = false;
  
  Get_WinQuickSearch_TxtSearch().keys(nameModel);
  Get_WinQuickSearch_BtnOK().Click();
  Get_MenuBar_Edit().Click();
  Get_MenuBar_Edit_Edit().Click();
  if(Get_WinModelInfo_GrpModel_TxtFullName().Text != nameModel)
    nameModel = Get_WinModelInfo_GrpModel_TxtFullName().Text;
  if(Get_WinModelInfo_GrpModel_TxtFullName().Enabled == false)
  {
    createNewModel = true;
    var UniqueID = "" + Math.floor(Math.random() * 1000);
    nameModel = "TEST-" + UniqueID;
    Get_WinModelInfo_BtnCancel().Click();
    Get_Toolbar_BtnAdd().Click();
    Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModel);
    Get_WinModelInfo_BtnOK().Click();
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_Edit().Click();
  }
  
  Get_WinModelInfo_GrpModel_TxtFullName().Click();
  Get_WinModelInfo_GrpModel_TxtFullName().Keys("[End]-TEST");
  Get_WinModelInfo_BtnOK().Click();
  if(Get_ModelsGrid().FindChildEx("Value", nameModel + "-TEST", 10, true, 10000).Exists)
    Log.Checkpoint("Nom changé."); else Log.Error("Nom non changé.");
  
  if(createNewModel)
    DeleteModelByName(nameModel + "-TEST");
  else
  {
    Get_MenuBar_Edit().Click();
    Get_MenuBar_Edit_Edit().Click();
    Get_WinModelInfo_GrpModel_TxtFullName().Click();
    Get_WinModelInfo_GrpModel_TxtFullName().Keys("^a");
    Get_WinModelInfo_GrpModel_TxtFullName().Keys(nameModel);
    Get_WinModelInfo_BtnOK().Click();
  }
  
  Close_Croesus_MenuBar();
}