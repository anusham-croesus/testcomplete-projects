//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Comptes », afficher la fenêtre « Ajouter un filtre » en cliquant
sur MenuBar > Search > Filters > Add a filter. Vérifier la présence des contrôles et des étiquettes */
 
function Survol_Acc_MenuBar_Search_Filters_AddAFilter()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Accounts().Click();
  Delay(5000);
  Get_MenuBar_Modules_Accounts_GoTo().Click();
  
  //afficher la fenêtre « Ajouter un filtre » en cliquant sur MenuBar > Search > Filters > Add a filter. 
  Get_MenuBar_Search().OpenMenu();
  Get_MenuBar_Search_QuickFilters().OpenMenu();
  Get_MenuBar_Search_QuickFilters_AddAFilter().Click();
  
  //Les points de vérification 
  Check_AddFilterForRelationshipsClientsAccounts_Properties(language)//la fonction est dans CommonCheckpoints
  
  Get_WinCRUFilter_BtnCancel().Click();
  
  Close_Croesus_MenuBar();
}
 
 