//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders ». Afficher le menu contextuel en cliquant sur MenuBar-Tolls_ Internet. Vérifier la présence des contrôles dans le menu */
 
 function Survol_Ord_MenuBar_Tools_Internet()
 {
   Login(vServerOrders, userName , psw ,language);
   Get_ModulesBar_BtnOrders().Click();
  
   Get_MenuBar_Tools().OpenMenu();
   Get_MenuBar_Tools_InternetAdresses().Click();
   Get_MenuBar_Tools_InternetAdresses().Click();
   
   //Les points de vérification
   Check_MenuBarToolsInternet_Properties(); // la fonction est dans CommonCheckpoints 
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X();    
 }
 
