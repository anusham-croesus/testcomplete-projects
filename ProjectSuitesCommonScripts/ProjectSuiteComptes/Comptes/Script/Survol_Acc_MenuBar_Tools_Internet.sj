//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Comptes ». Afficher le menu Internet en cliquant 
sur MenuBar > Tools > Internet. Vérifier la présence des contrôles dans le menu */
 
function Survol_Acc_MenuBar_Tools_Internet()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_GoTo().Click();
  
  
 //Get_MenuBar_Tools().OpenMenu();
  
 var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MenuBar_Tools().OpenMenu();
    numberOftries++;
  } 

//  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_InternetAdresses().Click();
  
  Check_MenuBarToolsInternet_Properties();
  
  Close_Croesus_MenuBar();
}
