//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Modeles ».
Afficher La fenêtre Composer en cliquant sur ToolBar- btnInternet-composer_Address. Vérifier la présence des contrôles dans le menu  */
 
 function Survol_Mod_ToolBar_BtnInternet_ComposeAddress()
 {
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click(); 
  
  //Afficher La fenêtre Composer 
  Get_Toolbar_BtnInternetAddresses().Click();
  Get_Toolbar_BtnInternetAddresses_ContextMenu_ComposeAddress().Click()
   
   //Les points de vérification en français 
   if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Check_Internet_ComposeAddress_Existence_Of_Controls() // la fonction est dans CommonCheckpoints 
  
  Get_WinComposeAddress_BtnCancel().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_AltQ();  
 }