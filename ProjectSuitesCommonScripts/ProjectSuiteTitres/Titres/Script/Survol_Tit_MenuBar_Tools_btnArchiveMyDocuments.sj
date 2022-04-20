//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_ArchiveDoc_Ctrl_Maj_A

/* Description : A partir du module « Titre » , afficher la fenêtre « Documents personnels » en cliquant sur Menubar- btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquetés*/
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-339
 function Survol_Tit_MenuBar_btnArchiveMyDocuments()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_ArchiveMyDocuments().Click();
  
  //Les points de vérification
  Check_WinPersonalDocuments_Properties(language);
  
//   //Les points de vérification en français 
//  if(language=="french"){Check_WinPersonalDocuments_Properties_French()} // la fonction est dans CommonCheckpoints
//    //Les points de vérification en anglais 
//  else {Check_WinPersonalDocuments_Properties_English()} // la fonction est dans CommonCheckpoints
//    
//    //Les points de vérification: la présence des contrôles
//  Check_WinPersonalDocuments_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
      
  Get_WinPersonalDocuments_BtnOK().Click();    
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X();  
 }