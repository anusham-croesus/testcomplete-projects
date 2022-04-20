//USEUNIT Agenda_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints

 
/* Description : Aller au module "Ordres" en cliquant sur BarModules-btnOrders. 
 Afficher la fenêtre « Agenda » en cliquant sur ToolBar_btnAgenda. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements.*/

 function Survol_Ord_ToolBar_btnAgenda()
{
  Login(vServerOrders, userName , psw ,language);
  Get_ModulesBar_BtnOrders().Click()
  
  Get_Toolbar_BtnAgenda().Click()
  
  Check_WinAgenda_Properties(language)
  
//  //Les points de vérification en français 
//   if(language=="french"){Check_WinAgenda_Properties_French()} // la fonction est dans Common_functions
//   //Les points de vérification en anglais 
//   else {Check_WinAgenda_Properties_English()} // la fonction est dans Common_functions
//   
//  Check_WinAgenda_Existence_Of_Controls()// la fonction est dans Common_functions
  
  Get_WinAgenda().Close()
  Delay(100)
  Close_Croesus_MenuBar()
}

