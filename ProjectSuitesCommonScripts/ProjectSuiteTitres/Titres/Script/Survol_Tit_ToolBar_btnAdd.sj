﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Agenda_Get_functions
//USEUNIT Survol_Tit_Add_ClickR

 /* Description : A partir du module « Titre » , afficher la fenêtre « Ajouter un titre » en cliquant sur Toolbar- btnAdd. 
Vérifier la présence de boutons radio : Réel, Manuel 
Vérifier la présence de  boutons OK, Annuler */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-331
 function Survol_Tit_ToolBar_btnAdd()
{
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_Toolbar_BtnAdd().Click();
  
  //Les points de vérification en français 
   if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Tit_Add_ClickR
   //Les points de vérification en anglais 
    else {Check_Properties_English()} // la fonction est dans le script Survol_Tit_Add_ClickR
    
  Check_Existence_Of_Controls()// la fonction est dans le script Survol_Tit_Add_ClickR
  
  Get_WinCreateSecurity_BtnCancel().Click()
  
  Close_Croesus_AltQ()
  //Sys.Browser("iexplore").Close() 
}