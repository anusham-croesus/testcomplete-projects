//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AltF4
//USEUNIT CommonCheckpoints


/*Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Affichage du module avec le titre "Comptes".
Fermêture de l’application par SysClose*/

function Survol_Acc_SysClose()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_ModulesBar_BtnAccounts().Click();
  
  Check_Properties(language);
  
  Close_Croesus_SysMenu();
}