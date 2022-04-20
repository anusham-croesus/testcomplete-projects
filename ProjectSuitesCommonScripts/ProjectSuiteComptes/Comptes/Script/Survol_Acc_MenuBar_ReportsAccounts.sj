//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

 /* Description : A partir du module « Accounts » , afficher la fenêtre « Rapports titre » en cliquant sur MenuBar-Reports . 
Vérifier la présence des listes déroulants et des cases à cocher   
Vérifier la présence des  boutons */

 function Survol_Acc_MenuBar_ReportsAccounts()
{
  var module="accounts";
  var btn="reports";
  
  Login(vServerAccounts, userName , psw ,language);
  Get_ModulesBar_BtnAccounts().Click()
  
  Get_MenuBar_Reports().OpenMenu();
  Get_MenuBar_Reports_Accounts().Click();
  
  //Les points de vérification
  Check_Properties_Reports(language,module,btn);
  
  Get_WinReports_BtnClose().Click();
  
  Close_Croesus_MenuBar(); 
}
