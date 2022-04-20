//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_ContextualMenu_Edit

 /* Description :Dans le du module « Modeles », rechercher un Modèle ~M-00002-0 , afficher la fenêtre « Modèle Info » en cliquant sur ModelsBar - BtnInfo. 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_ModelsBar_BtnInfo()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_TestedModel();
  
  Get_ModelsBar_BtnInfo().Click();

  //Les points de vérification en français 
   //if(language=="french"){Check_Properties_French();}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit  (Info)
   //Les points de vérification en anglais 
   //else {Check_Properties_English();}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit
    
  //Check_Existence_Of_Controls(); // la fonction est dans le script Survol_Mod_ContextualMenu_Edit
  
  CloseByESC_WinModelInfo();// la fonction est dans le script Survol_Mod_ContextualMenu_Edit
  
  Close_Croesus_AltF4();
}