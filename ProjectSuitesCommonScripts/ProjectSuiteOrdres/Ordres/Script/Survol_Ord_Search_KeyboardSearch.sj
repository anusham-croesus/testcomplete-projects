//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Survol_Ord_MenuBar_EditSearch


 /* Description : A partir du module « Orders » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Tit_Search_KeyboardSearch()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
  Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true); 
  
  Get_MainWindow().Keys("F");
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Ord_MenuBar_EditSearch
  //Les points de vérification en anglais 
  else {Check_Properties_English()} // la fonction est dans le script Survol_Ord_MenuBar_EditSearch
    
  Check_Existence_Of_Controls()// la fonction est dans le script Survol_Ord_MenuBar_EditSearch
  
  Get_WinQuickSearch().Close()
  
  Close_Croesus_AltF4()
 }