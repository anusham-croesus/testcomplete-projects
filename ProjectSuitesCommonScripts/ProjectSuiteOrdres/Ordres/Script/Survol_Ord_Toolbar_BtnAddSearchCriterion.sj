﻿//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders » , afficher la fenêtre  "Ajouter un critère de recherche" en cliquant sur ToolBar – BtnAddOrDisplayAnActiveCriterion
Vérifier la présence des contrôles et des étiquetés. */


function Survol_Ord_Toolbar_BtnAddSearchCriterion()
{
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click();
  
  Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click()
  
   //Les points de vérification en français 
   if(language=="french"){Check_AddOrDisplayAnActiveCriterion_Properties_French()} // la fonction est dans Common_functions
   //Les points de vérification en anglais 
   else {Check_AddOrDisplayAnActiveCriterion_Properties_English()} // la fonction est dans Common_functions
    
  //Les points de vérification: la présence des contrôles
  Check_Check_AddOrDisplayAnActiveCriterion_Properties_French_Existence_Of_Controls()// la fonction est dans Common_functions
    
  Get_WinAddSearchCriterion_BtnCancel().Click()
  
  Get_MainWindow().SetFocus()
  Close_Croesus_AltF4()
}