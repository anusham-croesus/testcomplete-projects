//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre « Documents personnels » en cliquant sur Menubar- btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquetés*/

 function Survol_Ord_MenuBar_BtnArchiveMyDocuments()
 {
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
  
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_ArchiveMyDocuments().Click()
  
  Check_WinPersonalDocuments_Properties(language)
  
//   //Les points de vérification en français 
//  if(language=="french"){Check_WinPersonalDocuments_Properties_French()} // la fonction est dans Common_functions
//    //Les points de vérification en anglais 
//  else {Check_WinPersonalDocuments_Properties_English()} // la fonction est dans Common_functions
//    
//    //Les points de vérification: la présence des contrôles
//  Check_WinPersonalDocuments_Existence_Of_Controls()// la fonction est dans Common_functions
      
  Get_WinPersonalDocuments_BtnOK().Click()    
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X(); 
 }