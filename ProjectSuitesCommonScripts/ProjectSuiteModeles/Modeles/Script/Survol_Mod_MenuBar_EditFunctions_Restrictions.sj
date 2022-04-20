//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

/* Description : Dans le du module « Modeles ». Rechercher le modèle ~M-0000S-0. 
Afficher la fenêtre « Gestionnaire de restrictions » en cliquant sur ModeleBar_btnRestriction. 
Vérifier la présence des contrôles et des étiquetés */

function Survol_Mod_MenuBar_EditFunctions_Restrictions()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
    var model="~M-0000S-0"
  }
  else{//RJ
    var model="~M-00002-0"
  }
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Search_Model(model)
  
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Functions().OpenMenu()
  Get_MenuBar_Edit_FunctionsForModels_Restrictions().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()  
  
  Get_WinRestrictionsManager_BtnClose().Click()
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close()
}

//// Fonctions  (Points de vérification pour les scripts qui testent Restrictions) //////

function Check_Properties_French()
{
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose().Content, "OleValue", cmpEqual, "_Fermer");
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader().Text, "OleValue", cmpEqual, "Restrictions");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Content, "OleValue", cmpEqual, "Ajouter");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Content, "OleValue", cmpEqual, "Modifier");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Content, "OleValue", cmpEqual, "Supprimer");
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChSeverity().Content, "OleValue", cmpEqual, "Sévérité");
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChRestriction().Content, "OleValue", cmpEqual, "Restriction");
}

function Check_Properties_English()
{
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose().Content, "OleValue", cmpEqual, "_Close");
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader().Text, "OleValue", cmpEqual, "Restrictions");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd().Content, "OleValue", cmpEqual, "Add");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit().Content, "OleValue", cmpEqual, "Edit");
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete().Content, "OleValue", cmpEqual, "Delete");
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChType().Content, "OleValue", cmpEqual, "Type");
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChSeverity().Content, "OleValue", cmpEqual, "Severity");
  aqObject.CheckProperty(Get_WinRestrictionsManager_ChRestriction().Content, "OleValue", cmpEqual, "Restriction");
}

function Check_Existence_Of_Controls()
{
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BtnClose(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnAdd(), "IsEnabled", cmpEqual, true);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnEdit(), "IsEnabled", cmpEqual, false);
  
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete(), "IsVisible", cmpEqual, true);
  aqObject.CheckProperty(Get_WinRestrictionsManager_BarPadHeader_BtnDelete(), "IsEnabled", cmpEqual, false);
}
