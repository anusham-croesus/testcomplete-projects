//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_MenuBar_EditSearch

 /* Description : A partir du module "Models", Afficher la fenêtre « Rechercher » par clavier. 
 Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre par X*/

 function Survol_Mod_Search_KeybordSearch()
 {
  Login(vServerModeles, userName , psw ,language);
  
  Get_ModulesBar_BtnModels().Click()
  WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["ModelListView_6fed", true]);
  
  Get_MainWindow().Keys("F");
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_French()} //la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  //Les points de vérification en anglais 
  //else {Check_Properties_English()}// la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  
  //Check_Existence_Of_Controls()// la fonction est dans le script Survol_Mod_MenuBar_EditSearch
  
  Get_WinQuickSearch().Close()
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close()  
 }
 
