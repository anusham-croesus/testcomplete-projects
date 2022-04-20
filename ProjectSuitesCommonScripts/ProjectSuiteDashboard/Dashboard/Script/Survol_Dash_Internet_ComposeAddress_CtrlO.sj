//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Dashboard ».
Afficher La fenêtre Composer par Ctrl+O. Vérifier la présence des contrôles dans le menu  */
 
function Survol_Dash_Internet_ComposeAddress_CtrlO()
{
    Login(vServerDashboard, userName, psw, language);
    Get_ModulesBar_BtnDashboard().Click();
    Get_ModulesBar_BtnDashboard().WaitProperty("IsChecked", true, 50000);
   
    //Afficher La fenêtre Composer
    Get_MainWindow().Keys("^o");
   
    //Les points de vérification en français 
    if (language == "french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans Common_functions
    
    //Les points de vérification en anglais 
    else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans Common_functions
     
    Check_Internet_ComposeAddress_Existence_Of_Controls(); // la fonction est dans Common_functions 
    
    Get_WinComposeAddress_BtnCancel().Click();
    
    Get_MainWindow().SetFocus();
    Close_Croesus_SysMenu();
}
 