//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Modeles » , afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A. 
  Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Mod_ArchiveDoc_Ctrl_Maj_A()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  
  Get_MainWindow().Keys("^A");
  
  Check_WinPersonalDocuments_Properties(language)
  
//    //Les points de vérification en français 
//  if(language=="french"){Check_WinPersonalDocuments_Properties_French()}// la fonction est dans CommonCheckpoints
//    //Les points de vérification en anglais 
//  else {Check_WinPersonalDocuments_Properties_English()}// la fonction est dans CommonCheckpoints
//    
//    //Les points de vérification: la présence des contrôles
//  Check_WinPersonalDocuments_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
 
  Get_WinPersonalDocuments_BtnOK().Click()
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar();
 }
 