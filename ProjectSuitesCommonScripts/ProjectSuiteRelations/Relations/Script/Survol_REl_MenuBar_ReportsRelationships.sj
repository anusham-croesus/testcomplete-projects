//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Relationships » , afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-Reports . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons */

 function Survol_Rel_MenuBar_ReportsAccounts()
{
  var module="relationships";
  var btn="reports";
  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click()
  
  Get_MenuBar_Reports().OpenMenu();
  Get_MenuBar_Reports_Relationships().Click();
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn);
  
  Get_WinReports_BtnClose().Click();
  
  Close_Croesus_MenuBar(); 
}