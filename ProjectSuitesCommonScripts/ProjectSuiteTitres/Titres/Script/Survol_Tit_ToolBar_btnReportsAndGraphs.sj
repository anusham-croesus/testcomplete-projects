//USEUNIT CommonCheckpoints
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT Survol_Tit_MenuBar_ReportsSecurities

 /* Description : A partir du module « Titre » , afficher la fenêtre « Rapports titre » en cliquant sur Toolbar-btnReportsAndGraphs. 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons OK, Fermer, Modifier, Sauvegarder ,Paramètres  */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-334
 function Survol_Tit_ToolBar_btnReportsAndGraphs()
{
  var module="security";
  var btn="reports";
  
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click();
  
  Get_Toolbar_BtnReportsAndGraphs().Click();
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn) //la fonction est dans le script CommonCheckpoints 
   
  Get_WinReports_BtnClose().Click()
  
  Close_Croesus_X();
}