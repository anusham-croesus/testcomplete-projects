//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Survol_Mod_ContextualMenu_Functions_UnderPerfomance

 /* Description : A partir du module "Models". Assigner un compte au Modèle ~M-0000S-0,  afficher la fenêtre « Perfomance des comptes sous- jacents » 
en cliquant sur ModelsBar_UnderPerfomance. Vérifier la présence des contrôles et des étiquetés.Fermer la fenêtre en cliquant par ESC*/

 function Survol_Mod_ModelsBar_UnderPerfomance()
 {
   if (client == "BNC" ){
    var model="~M-0000S-0"
  }
  else if(client == "US" ){
    var model="~M-00006-0"
  }
  else if(client == "CIBC" ){  //Adapté pour CIBC
    var model="~M-00005-0"  
  } 
  else{//RJ
    var model="~M-00002-0"
  }
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Model(model)}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  Get_ModelsBar_BtnUnderlyingPerformance().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_French(model)} // la fonction est dans Survol_Mod_ContextualMenu_Functions_UnderPerfomance
  //Les points de vérification en anglais 
  else {Check_Properties_English(model)}// la fonction est dans Survol_Mod_ContextualMenu_Functions_UnderPerfomance
  
  Check_Existence_Of_Controls()// la fonction est dans Survol_Mod_ContextualMenu_Functions_UnderPerfomance
  
  Get_WinPerformance_BtnClose().Keys("[Esc]");
  
  Close_Croesus_MenuBar();     
 }