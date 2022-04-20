//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Rel_MenuBar_EditSearch

 /* Description : A partir du module « Relations » , afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Rel_Search_KeyboardSearch()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
  Get_RelationshipsClientsAccountsGrid().WaitProperty("IsEnabled", true, 15000);
 
  //afficher la fenêtre « Rechercher » en cliquant sur MenuBar -Edit- Search
  Get_MainWindow().Keys("F");
  Get_WinQuickSearch().WaitProperty("VisibleOnScreen", true, 3000);    
  
  //Les points de vérification 
  //Check_Properties(language) // la fonction est dans le script Survol_Rel_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Click();
  
  Close_Croesus_AltF4();
 }