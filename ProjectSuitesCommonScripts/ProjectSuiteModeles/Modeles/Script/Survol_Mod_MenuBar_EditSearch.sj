//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions

 /* Description : A partir du module "Models", afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant sur le btn Cancel*/

 function Survol_Mod_MenuBar_EditSearch()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()

  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Search().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  else {Check_Properties_English()}
  
  Check_Existence_Of_Controls()
  
  Get_WinQuickSearch_BtnCancel().Click()
  
  Close_Croesus_MenuBar()
  Sys.Browser("iexplore").Close()  
 }
 
 //Fonctions  (les points de vérification pour les scripts qui testent Search)
function Check_Properties_French()
{
    aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Rechercher");
    
    aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Rechercher:");
    aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "Dans:");
    
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Nom");
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoModelNo().DataContext.Label, "OleValue", cmpEqual, "No de modèle");
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "Code de CP");
    
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Annuler");
}

function Check_Properties_English()
{
    aqObject.CheckProperty(Get_WinQuickSearch().Title, "OleValue", cmpEqual, "Search");
    
    aqObject.CheckProperty(Get_WinQuickSearch_LblSearch().Text, "OleValue", cmpEqual, "Search for:");
    aqObject.CheckProperty(Get_WinQuickSearch_LblIn().Text, "OleValue", cmpEqual, "In:");
    
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoName().DataContext.Label, "OleValue", cmpEqual, "Name");
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoModelNo().DataContext.Label, "OleValue", cmpEqual, "Model No.");
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoIACode().DataContext.Label, "OleValue", cmpEqual, "IA Code");
    
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK().Content, "OleValue", cmpEqual, "OK");
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel().Content, "OleValue", cmpEqual, "Cancel");
}

function Check_Existence_Of_Controls()
{
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_TxtSearch(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoModelNo(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoModelNo(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoIACode(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinModelsQuickSearch_RdoIACode(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_BtnOK(), "IsEnabled", cmpEqual, true);
    
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinQuickSearch_BtnCancel(), "IsEnabled", cmpEqual, true);
}