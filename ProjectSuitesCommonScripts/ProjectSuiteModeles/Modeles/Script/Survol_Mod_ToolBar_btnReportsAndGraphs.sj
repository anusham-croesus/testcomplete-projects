//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Modeles » , afficher la fenêtre « Rapports titre » en cliquant sur Toolbar-btnReportsAndGraphs. 
Vérifier la présence des listes déroulants et des cases à cocher. Vérifier la présence des  boutons OK, Fermer, Modifier, Sauvegarder ,Paramètres  */

 function Survol_Mod_ToolBar_btnReportsAndGraphs()
{
  var module="modeles";
  var btn="reports";
  
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click()
  Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "ModelListView_6fed");
  
  Get_Toolbar_BtnReportsAndGraphs().Click()
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn)
     
  Get_WinReports_BtnClose().Click()
  
  Close_Croesus_X()
}