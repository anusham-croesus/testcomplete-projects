//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_functions
//USEUNIT Survol_Mod_ContextualMenu_Edit

 /* Description :Dans le du module « Modeles », rechercher un Modèle ~M-00002-0 , afficher la fenêtre « Modèle Info » en cliquant sur MenuBar Edit i (info). 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_MenuBar_Edit_i()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Search_Model("~M-00002-0")
  
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Info().Click()

  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit
   //Les points de vérification en anglais 
    else {Check_Properties_English()}// la fonction est dans le script Survol_Mod_ContextualMenu_Edit
    
  Check_Existence_Of_Controls() // la fonction est dans le script Survol_Mod_ContextualMenu_Edit
  Get_WinModelInfo_BtnClose().Keys("[Esc]")
  
  Close_Croesus_SysMenu()
  //Sys.Browser("iexplore").Close() 
}