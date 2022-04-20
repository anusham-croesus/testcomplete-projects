//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints


/**
  Description : À partir du module « Comptes », afficher La fenêtre Composer en cliquant sur MenuBar > Tools > Internet > ComposeAddress.
  Vérifier la présence des contrôles et des étiquettes.
  @author : christophe.paring@croesus.com
*/

function Survol_Acc_MenuBar_Tools_Internet_ComposeAddress()
{
  Login(vServerAccounts, userName, psw, language);
  
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Accounts().Click();
  Get_MenuBar_Modules_Accounts_GoTo().Click();
  
  //Afficher La fenêtre Composer
  Get_MenuBar_Tools().Click();
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MenuBar_Tools().Click();
    numberOftries++;
  } 
  
  Get_MenuBar_Tools_InternetAdresses().OpenMenu();
  var numberOftries=0;  
  while ( numberOftries < 5 && !Get_SubMenus().Exists){
    Get_MenuBar_Tools_InternetAdresses().OpenMenu();
    numberOftries++;
  } 
  Get_MenuBar_Tools_Internet_ComposeAddress().ClickItem();
   
  //Les points de vérification en français 
  //if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
    
  //Les points de vérification en anglais 
  //else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  //Check_Internet_ComposeAddress_Existence_Of_Controls(); // la fonction est dans CommonCheckpoints
  
  
  Get_WinComposeAddress_BtnCancel().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar(); 
}