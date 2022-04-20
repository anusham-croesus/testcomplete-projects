//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_MenuBar_EditSearch

 /* Description : A partir du module « Titre » , afficher la fenêtre « Rechercher » par clavier . 
Vérifier la présence de boutons radio : Description, Symbole ,Titre
Vérifier la présence de champs de texte et les boutons OK, Annuler */
// https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-327 
 function Survol_Tit_Search_KeyboardSearch()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
 
  Get_SecurityGrid().Keys("F");
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_MenuBar_EditSearch
  //Les points de vérification en anglais 
  else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_MenuBar_EditSearch
  
  Check_Existence_Of_Controls()

  Get_WinQuickSearch_BtnCancel().Click()
  
  Close_Croesus_AltF4()  
 }
 
 
