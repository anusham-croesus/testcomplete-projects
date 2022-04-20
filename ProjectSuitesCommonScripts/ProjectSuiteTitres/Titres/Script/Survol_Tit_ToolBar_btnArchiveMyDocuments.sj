//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions

/* Description : A partir du module « Titre » , afficher la fenêtre « Documents personnels » en cliquant sur Toolbar- btnArchiveMyDocuments. 
  Vérifier la présence des contrôles et des étiquetés*/
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-340
 function Survol_Tit_ToolBar_btnArchiveMyDocuments()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_Toolbar_BtnArchiveMyDocuments().Click();
  
  //Les points de vérification
  Check_WinPersonalDocuments_Properties(language);// la fonction est dans CommonCheckpoints
  
//   //Les points de vérification en français 
//  if(language=="french"){Check_WinPersonalDocuments_Properties_French()} // la fonction est dans CommonCheckpoints
//    //Les points de vérification en anglais 
//  else {Check_WinPersonalDocuments_Properties_English()} // la fonction est dans CommonCheckpoints
//    
//   //Les points de vérification: la présence des contrôles
//  Check_WinPersonalDocuments_Existence_Of_Controls()// la fonction est dans CommonCheckpoints
          
  Get_WinPersonalDocuments_BtnOK().Click()
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ(); 
 }