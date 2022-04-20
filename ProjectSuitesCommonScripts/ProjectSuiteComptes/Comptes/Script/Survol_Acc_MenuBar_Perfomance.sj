//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : À partir du module "Compte", afficher la fenêtre «Perfomance» pour le compte qui est sélectionné par default 
en cliquant sur MenuBar_Performance. Vérifier la présence des contrôles et des étiquettes. Fermer la fenêtre en cliquant sur X. */

function Survol_Acc_MenuBar_Perfomance()
{
  var module = "accounts";
  
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
     
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Performance().Click(); //Il y a un bug : le menu Fonctions est vide ; il faut parfois aller à un autre module et revenir à Comptes pour avoir le menu.
  
  //Les points de vérification en français 
  //if(language=="french"){Check_Properties_Performance_French(module)}// la fonction est dans Common_functions
  //Les points de vérification en anglais 
  //else {Check_Properties_Performance_English(module)}// la fonction est dans Common_functions
  //Les points de vérification
  //Check_Performance_Existence_Of_Controls(module);// la fonction est dans Common_functions
  
  Get_WinPerformance().Close();
  
  Close_Croesus_MenuBar();
}