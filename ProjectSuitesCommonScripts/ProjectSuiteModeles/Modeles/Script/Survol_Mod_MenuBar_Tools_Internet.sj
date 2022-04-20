//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Modeles ». Afficher le menu contextuel en cliquant sur MenuBar-Tolls_ Internet. Vérifier la présence des contrôles dans le menu */
 
 function Survol_Mod_MenuBar_Tools_Internet()
 {
   Login(vServerModeles, userName , psw ,language);
   Get_ModulesBar_BtnModels().Click();
  
   //Afficher le menu contextuel en cliquant sur MenuBar-Tolls_ Internet
   Get_MenuBar_Tools().OpenMenu();
   Get_MenuBar_Tools_InternetAdresses().Click();
   Get_MenuBar_Tools_InternetAdresses().Click();
   
   Check_MenuBarToolsInternet_Properties();// la fonction est dans CommonCheckpoints 
    
   Get_MainWindow().SetFocus();
   Close_Croesus_X()    
 }
 