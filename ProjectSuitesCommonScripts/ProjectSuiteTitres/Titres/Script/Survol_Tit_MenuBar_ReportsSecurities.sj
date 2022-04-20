//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Titres_Get_functions
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Titre » , afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-ReportsSecurities . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons */
// Cas de test: https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-333
 function Survol_Tit_MenuBar_ReportsSecurities()
{
  var module="security";
  var btn="reports";
  
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
  
  Get_MenuBar_Reports().OpenMenu()
  Get_MenuBar_Reports_Securities().Click()
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn)
  
  Get_WinReports_BtnClose().Click()
  
  Close_Croesus_MenuBar() 
}

