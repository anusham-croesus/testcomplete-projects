//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relationships ».
Afficher La fenêtre Composer en cliquant sur MenuBar_Tools_Internet_ComposeAddress. Vérifier la présence des contrôles dans le menu  */
 
 function Survol_Rel_MenuBar_Tools_Internet_ComposeAddress()
 {
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click(); 
   
  //Afficher La fenêtre Composer
  Get_MenuBar_Tools().OpenMenu();
  Get_MenuBar_Tools_InternetAdresses().OpenMenu();
  Get_MenuBar_Tools_Internet_ComposeAddress().WaitProperty("VisibleOnScreen", true, 500)
  Get_MenuBar_Tools_Internet_ComposeAddress().ClickItem();
   
   //Les points de vérification en français 
  if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
  else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Check_Internet_ComposeAddress_Existence_Of_Controls(); // la fonction est dans CommonCheckpoints
  
  
  Get_WinComposeAddress_BtnCancel().Click();
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X(); 
 }