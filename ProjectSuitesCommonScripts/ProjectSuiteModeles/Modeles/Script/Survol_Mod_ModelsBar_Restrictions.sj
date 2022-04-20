//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_MenuBar_EditFunctions_Restrictions

/* Description : Dans le du module « Modeles ». Rechercher le modèle ~M-0000S-0. 
Afficher la fenêtre « Gestionnaire de restrictions » en cliquant sur MenuBar_EditFunctions_Restrictions. 
Vérifier la présence des contrôles et des étiquetés */

function Survol_Mod_MenuBar_Restrictions()
{
  if (client == "CIBC" || client == "BNC"  || client == "US" || client == "TD" ){
      var model="~M-0000S-0"
  }
  else{//RJ
      var model="~M-00002-0"
  }
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Search_Model(model)
  
  Get_ModelsBar_BtnRestrictions().Click()
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_French()}
  //Les points de vérification en anglais 
  //else {Check_Properties_English()}
    
  //Check_Existence_Of_Controls()  
  
  Get_WinRestrictionsManager_BtnClose().Click()
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close() 
}