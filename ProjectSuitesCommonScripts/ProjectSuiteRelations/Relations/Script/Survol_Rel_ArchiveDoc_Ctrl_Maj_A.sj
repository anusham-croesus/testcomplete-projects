//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relation » , afficher la fenêtre « Documents personnels » avec Ctrl+Maj+A. 
  Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Rel_ArchiveDoc_Ctrl_Maj_A()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click()
  
  Get_RelationshipsClientsAccountsGrid().Keys("^A");
  
  //Les points de vérification
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
 