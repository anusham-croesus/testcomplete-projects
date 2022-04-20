//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


 /* Description : A partir du module « Clients » , afficher la fenêtre « Rapports titre » en cliquant sur Toolbar-btnReportsAndGraphs. 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons OK, Fermer, Modifier, Sauvegarder ,Paramètres  */

 function Survol_Cli_ToolBar_btnReportsAndGraphs()
{
  var module="clients";
  var btn="reports";
  
  Login(vServerClients, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click()
  
  Get_Toolbar_BtnReportsAndGraphs().Click();
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn) //la fonction est dans le script CommonCheckpoints 
   
  Get_WinReports_BtnClose().Click();
  
  Close_Croesus_X();
}