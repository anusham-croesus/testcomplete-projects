//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Modeles_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Modeles".  Afficher la fenêtre « Print » en cliquant sur MenuBar - btnPrint. 
Cliquer sur le btnCancel, Vérifier le message «Impression annulée». Fermer la fenêtre en cliquant sur le bouton "OK" */
 
 function Survol_Mod_MenuBar_FilePrint()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()

  Get_MenuBar_File().OpenMenu()
  Get_MenuBar_File_Print().Click()
  
  //Les points de vérification en français 
  if(language=="french"){Check_Print_Properties_French()}// la fonction est dans le script CommonCheckpoints
  //Les points de vérification en anglais 
  else{Check_Print_Properties_English()}// la fonction est dans le script CommonCheckpoints
  
  //Get_DlgPrinting_BtnOK().Click() //EM: Modifié pour CO-90-07-22
  Get_DlgInformation().Close();
  
  Close_Croesus_AltF4()
  Sys.Browser("iexplore").Close()
    
 }
 