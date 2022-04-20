﻿//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre ». Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1802*/

 function Survol_Tit_ToolBar_btnInternet()
 {
  var module="titre"
  
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_Toolbar_BtnInternetAddresses().Click()
   
   //Les points de vérification en français 
  if(language=="french"){Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_French(module)}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
  else {Check_ToolBar_InternetForPortfolioTransactionsSecurity_Properties_English(module)}// la fonction est dans CommonCheckpoints
     
  Check_ToolBar_InternetForPortfolioTransactionsSecurity_Existence_Of_Controls(module) // la fonction est dans CommonCheckpoints 
  
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar()
 }
 