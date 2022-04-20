﻿//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titres ».
Afficher La fenêtre Composer par Ctrl+O. Vérifier la présence des contrôles dans le menu 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1776 */
 
 function Survol_Cli_Internet_ComposeAddress_CtrlO()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
   
  //Afficher La fenêtre Composer
   Get_MainWindow().Keys("^o");
   
   //Les points de vérification en français 
   if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
  else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Check_Internet_ComposeAddress_Existence_Of_Controls(); // la fonction est dans CommonCheckpoints 
    
  Get_WinComposeAddress_BtnCancel().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_SysMenu();
 }
 