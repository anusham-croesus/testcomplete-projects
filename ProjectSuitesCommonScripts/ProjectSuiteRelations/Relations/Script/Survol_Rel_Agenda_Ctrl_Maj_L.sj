//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions
//USEUNIT CommonCheckpoints
 
/* Description : A partir du module « Relations » , afficher la fenêtre « Agenda » avec Ctl+Shift+L. 
 Vérifier la correspondance d’un titre a l’onglet sélectionné en cliquant sur les onglets  
 Horaire, Taches, Activités échues, Anniversaires, Alarmes, Traitements */

function Survol_Rel_Agenda_Ctrl_Maj_L()
{
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click()
  
  Get_MainWindow().Keys("^L");
  
  Check_WinAgenda_Properties(language)// la fonction est dans CommonCheckpoints
   
  Get_WinAgenda().Close()
  Close_Croesus_AltQ()
}
