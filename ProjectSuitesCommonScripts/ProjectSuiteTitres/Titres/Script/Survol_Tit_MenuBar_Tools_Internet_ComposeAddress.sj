//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Titre ».
Afficher La fenêtre Composer en cliquant sur MenuBar_Tools_Internet_ComposeAddress. Vérifier la présence des contrôles dans le menu 
// Lien du cas de Test:https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1777*/
 
 function Survol_Tit_MenuBar_Tools_Internet_ComposeAddress()
 {
  Login(vServerTitre, userName , psw ,language);
  Get_ModulesBar_BtnSecurities().Click()
   
  //Afficher La fenêtre Composer
  Get_MenuBar_Tools().OpenMenu()
  Get_MenuBar_Tools_InternetAdresses().OpenMenu()
  WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "VisibleOnScreen"], ["PopupRoot",1,true]);
  Get_MenuBar_Tools_Internet_ComposeAddress().ClickItem()
   
   //Les points de vérification en français 
   if(language=="french"){Check_Internet_ComposeAddress_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_Internet_ComposeAddress_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Check_Internet_ComposeAddress_Existence_Of_Controls() // la fonction est dans CommonCheckpoints
  
  Get_WinComposeAddress_BtnCancel().Click()
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X()
 }
 
