//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_Add_ClickR

 /* Description : A partir du module « Modeles » , afficher la fenêtre « Ajouter un modèle » en cliquant sur MenuBar_EditAdd. 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_MenuBar_EditAdd()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_MenuBar_Edit().OpenMenu()
  Get_MenuBar_Edit_Add().Click()
   
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
    else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  Get_WinModelInfo_BtnCancel().Keys("[Esc]")
  
  Close_Croesus_MenuBar()
}