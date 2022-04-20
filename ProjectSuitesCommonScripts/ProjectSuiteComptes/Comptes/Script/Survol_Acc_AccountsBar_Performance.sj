//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


 /* Description : À partir du module "Comptes", afficher la fenêtre «Perfomance» pour le compte qui est sélectionné par défaut
en cliquant sur AccountsBar_Perfomance. Vérifier la présence des contrôles et des étiquettes.Fermer la fenêtre en cliquant par ESC. */

function Survol_Acc_AccountsBar_Perfomance()
{
  var module = "accounts";
  
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
  
  Get_RelationshipsClientsAccountsBar_BtnPerformance().Click();
  
  //Les points de vérification en français 
  if(language=="french"){Check_Properties_Performance_French(module)}// la fonction est dans CommonCheckpoints
  //Les points de vérification en anglais 
  else {Check_Properties_Performance_English(module)}//la fonction est dans CommonCheckpoints
  //Les points de vérification
  Check_Performance_Existence_Of_Controls(module)//  la fonction est dans CommonCheckpoints
  
  Get_WinPerformance_BtnClose().Keys("[Esc]");
  
  Close_Croesus_MenuBar(); 
}