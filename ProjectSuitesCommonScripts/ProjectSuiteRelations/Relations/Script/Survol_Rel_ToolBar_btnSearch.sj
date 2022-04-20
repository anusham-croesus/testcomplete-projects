//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Survol_Rel_MenuBar_EditSearch

 /* Description : A partir du module « Relations » , afficher la fenêtre « Rechercher » en cliquant sur Toolbar - btnSearch. 
Vérifier la présence des étiquettes et contrôles */

 function Survol_Rel_ToolBar_btnSearch()
 {
  Login(vServerRelations,userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
 
  //afficher la fenêtre « Rechercher » en cliquant sur Toolbar - btnSearch
  Get_Toolbar_BtnSearch().Click();
    
  //Les points de vérification 
  //Check_Properties(language) // la fonction est dans le script Survol_Rli_MenuBar_EditSearch
  
  Get_WinQuickSearch_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_X();
 }