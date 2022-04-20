//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_ContextualMenu_Edit

 /* Description :Dans le du module « Modeles », rechercher un Modèle ~M-00002-0 , afficher la fenêtre « Modèle Info » par Ctrl+L. 
Vérifier la présence des contrôles et des étiquetés */

function Survol_Mod_i_Ctrl_L()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  Get_TestedModel(); // la fonction est dans le script Survol_Mod_ContextualMenu_Edit
  
  Get_MainWindow().Keys("^l");

  //Les points de vérification en français
  if(language=="french"){Check_Properties_French();}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info)
  //Les points de vérification en anglais
  else {Check_Properties_English();}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info)
    
  Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info)
  
  ClickToClose_WinModelInfo();// la fonction est dans le script Survol_Mod_ContextualMenu_Edit (Info)
  
  Close_Croesus_AltF4()
}