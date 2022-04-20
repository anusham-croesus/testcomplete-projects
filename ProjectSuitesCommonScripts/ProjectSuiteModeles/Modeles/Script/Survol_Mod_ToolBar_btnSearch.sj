//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_MenuBar_EditSearch

 /* Description : A partir du module "Models", Afficher la fenêtre « Rechercher » par clavier. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre par esc*/

 function Survol_Mod_ToolBar_btnSearch()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()

  Get_Toolbar_BtnSearch().Click()
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_French()} //la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  //Les points de vérification en anglais 
  //else {Check_Properties_English()}// la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  
  //Check_Existence_Of_Controls()// la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X()
 }
 