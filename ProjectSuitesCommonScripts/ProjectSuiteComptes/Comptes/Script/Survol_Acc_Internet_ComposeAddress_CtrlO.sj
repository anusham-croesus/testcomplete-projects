//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/**
  Description : À partir du module « Comptes », afficher La fenêtre Composer par Ctrl+O.
  Vérifier la présence des contrôles et des étiquettes.
  @author : christophe.paring@croesus.com
*/

function Survol_Acc_Internet_ComposeAddress_CtrlO()
{
  Login(vServerAccounts, userName, psw, language);
  Get_ModulesBar_BtnAccounts().Click();
   
  //Afficher La fenêtre Composer
  Get_MainWindow().Keys("^o");
  
  //Les points de vérification en français 
  if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
  
  //Les points de vérification en anglais 
  else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Check_Internet_ComposeAddress_Existence_Of_Controls(); // la fonction est dans CommonCheckpoints
    
  Get_WinComposeAddress_BtnCancel().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_SysMenu();
}