﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description Aller au module "Modeles". Afficher la fenêtre « Print » avec ClickR. 
Cliquer sur le btnCancel, Vérifier le message «Impression annulée». Fermer la fenêtre du message par Esc   */
 
 function Survol_Mod_Print_ClickR()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_ModelsGrid().ClickR()
  Get_ModelsGrid_ContextualMenu_Print().Click()
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Print_Properties_French()}// la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  //else{Check_Print_Properties_English()} // la fonction est dans le script CommonCheckpoints
  
  //Get_DlgPrinting_BtnOK().Keys("[Esc]"); //EM: Modifié pour CO-90-07-22
    Get_DlgInformation().Keys("[Esc]");
  
  
  Close_Croesus_MenuBar()
  Sys.Browser("iexplore").Close()
    
 }
 
 