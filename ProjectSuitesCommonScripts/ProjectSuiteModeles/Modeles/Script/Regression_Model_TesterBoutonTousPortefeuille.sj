//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2430

function Regression_Model_TesterBoutonTousPortefeuille()
{
  Login(vServerModeles, ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username"),
                        ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"), language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModele = "CH BONDS";
  
  var namePosition = "OBL QC OTF R 5.20%M14JL14";
  if(language == "english")
	  namePosition = "QUE FRB  R 5.20%M  14JL14";
  
  if (client == "CIBC"){
       nameModele = "*FALL BACK";
       namePosition = "ALT H/I CSH PRF/NL/N";
       if(language == "frensh")
            namePosition = "ALT COM SURET  /SF/N";
       }
    
  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  Get_MenuBar_Modules().Click();
  Get_MenuBar_Modules_Portfolio().Click();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  Get_Portfolio_PositionsGrid().Keys(namePosition.charAt(0));
  Get_WinQuickSearch_TxtSearch().keys(namePosition.slice(1));
  Get_WinQuickSearch_BtnOK().Click();
  Get_Portfolio_PositionsGrid().FindChild("Value", namePosition, 10).Click();
  Get_Toolbar_BtnDelete().Click();
  
  var textActive = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "regression", "ModeleActif", language);
  if(Get_DlgConfirmation_LblMessage().Message.Contains(textActive)) //EM : Modifié depuis CO: 90-07-22 - Avant Text
  {
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(2/3)),73);
  }
  
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
  
  Get_PortfolioBar_BtnSave().Click();
  Get_WinWhatIfSave_BtnOK().Click();
  
  if(!Get_Portfolio_PositionsGrid().FindChild("Value", namePosition, 10).Exists)
    Log.Checkpoint("Position supprimée."); else Log.Error("Position non supprimmée.");
  
  Get_PortfolioBar_BtnAll().Click();
  if(Get_Portfolio_PositionsGrid().FindChild("Value", namePosition, 10).Exists)
    Log.Checkpoint("Position supprimée est visible dans \"Tous\"."); else Log.Error("Position non supprimmée n'est pas visible dans \"Tous\".");
  Get_Portfolio_PositionsGrid().FindChild("Value", namePosition, 10).Click();
  Get_PortfolioBar_BtnInfo().Click();
  
  var posValue = Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Text;
  if(posValue == "0,000" || posValue == "0.000" || posValue == "0")
    Log.Checkpoint("Position supprimée est réduite à une valeur de 0."); else Log.Error("Position supprimée n'est pas réduite à une valeur de 0.");
  Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Click();
  Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Keys("^a20");
  Get_WinPositionInfo_BtnOK().Click();
  Get_PortfolioBar_BtnSave().Click();
  Get_WinWhatIfSave_BtnOK().Click();
  
  Close_Croesus_MenuBar();
}