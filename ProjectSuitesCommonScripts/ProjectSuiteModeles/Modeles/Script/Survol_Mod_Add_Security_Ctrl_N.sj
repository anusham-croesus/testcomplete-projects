//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_Add_ClickR

 /* Description : A partir du module « Modeles » , afficher la fenêtre « Ajouter un modèle » par Ctrl+N . 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_Add_Security_Ctrl_N()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_ModelsGrid().Keys("^n");
   
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
    else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  Get_WinModelInfo().Close()
  
  Close_Croesus_MenuBar()
  Sys.Browser("iexplore").Close() 
}