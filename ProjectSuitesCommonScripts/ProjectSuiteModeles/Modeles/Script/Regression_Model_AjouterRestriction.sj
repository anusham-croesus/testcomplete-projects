//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

//Croes-2346

function Regression_Model_AjouterRestriction()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  var nameModele = "SUBS_PRORATA";
  
  if (client == "CIBC") nameModele = "*FALL BACK";
  
  var nameRestriction = "BANQUE NATIONALE DU CDA";
  if(language == "english")
	  nameRestriction = "NATIONAL BANK OF CDA";

  Get_Toolbar_BtnSearch().Click();
  Get_WinQuickSearch_TxtSearch().keys(nameModele);
  Get_WinQuickSearch_BtnOK().Click();  
  Get_ModelsGrid().FindChild("Value", nameModele, 10).Click();
  
  //Get_Models_Details_TabAssignedPortfolios_BtnRestrictions().Click(); //EM: 90-06-Be-26 :  Reponse Karima :  on doit cliquer sur le bouton restriction en haut et pas celui en bas
  Get_ModelsBar_BtnRestrictions().Click();
  Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Click();
  
  Get_WinCRURestriction_GrpSecurity_TxtQuickSearchKey().Keys(nameRestriction.substring(0,6));
  Get_WinCRURestriction_GrpSecurity_BtnQuickSearchListPicker().Click();
  Get_SubMenus().FindChild("Value", nameRestriction, 10).DblClick();
  Get_WinCRURestriction_BtnOK().Click();
  
  var restrictionListe = Get_WinRestrictionsManager_DgvRestriction().findAllChildren("ClrClassName", "CellValuePresenter", 10).toArray();
  var restrictionCree = null;
  for(n = 0; n < 40 && restrictionListe[n] != null; n++)
    if(restrictionListe[n].Value.Contains(nameRestriction))
    {
      restrictionCree = restrictionListe[n];
      break;
    }
  if(restrictionCree != null)
  {
    Log.Checkpoint("Restriction créée.");
    restrictionCree.Click();
    Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Click();
    /*var width = Get_DlgConfirmAction().Get_Width();
    Get_DlgConfirmAction().Click((width*(1/3)),73)*/ //EM : Modifié depuis CO: 90-07-22
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
  }
  else
    Log.Error("Restriction non créée.");
  
  Get_WinRestrictionsManager_BtnClose().Click();
  Close_Croesus_MenuBar();
}