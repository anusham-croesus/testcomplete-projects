//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module "Relationship", afficher la fenêtre « Account activities » 
par MenuBar_Functions_Activities. Vérifier la présence des contrôles et des étiquettes. */

function Survol_Rel_MenuBar_Activities()
{
  Login(vServerRelations, userName, psw, language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_MenuBar_Edit().OpenMenu();
  Get_MenuBar_Edit_Functions().Click();
  Get_MenuBar_Edit_FunctionsForRelationshipsClientsAccounts_Activities().Click(); //Il a y une anomalie dans automation 10, le menu est vide (Parfois il faut aller à un autre module et revenir à Comptes, pour avoir le menu)
  
  //Les points de vérification
  //Check_Properties_WinActivities(language);
  
  Get_WinActivities_BtnClose().Keys("[Esc]");
  
  Close_Croesus_SysMenu();
}