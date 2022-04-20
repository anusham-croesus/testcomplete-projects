//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_Add_ClickR

 /* Description : A partir du module « Modeles » , afficher la fenêtre « Ajouter un modèle » en cliquant sur ToolBar_btnAdd. 
Vérifier la présence des contrôles et des étiquetés */

 function Survol_Mod_ToolBar_btnAdd()
{
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_Toolbar_BtnAdd().Click();

  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()}
   //Les points de vérification en anglais 
    else {Check_Properties_English()}
    
  Check_Existence_Of_Controls()   
  Get_WinModelInfo_BtnCancel().Keys("[Esc]")
  
  Close_Croesus_MenuBar()
}