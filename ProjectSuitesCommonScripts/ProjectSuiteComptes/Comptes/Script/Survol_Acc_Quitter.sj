//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Comptes_Get_functions
//USEUNIT Survol_Acc_AltF4
//USEUNIT CommonCheckpoints


/*Description : Aller au module "Comptes" en cliquant sur BarModules-btnAccounts. Affichage du module avec le titre "Comptes".
Fermeture de l’application par Quitter*/

function Survol_Acc_Quitter()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_ModulesBar_BtnAccounts().Click();
  
  Check_Properties(language);
  
  Close_Croesus_MenuBar();
}