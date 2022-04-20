//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints


/* Description : A partir du module « Orders ». Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu */
 
 function Survol_Ord_ToolBar_btnInternet()
 {
   Login(vServerOrders, userName , psw ,language);
   Get_ModulesBar_BtnOrders().Click();
  
   Get_Toolbar_BtnInternetAddresses().Click();
   
   //Les points de vérification
   Check_ToolBarInternet_Properties();// la fonction est dans CommonCheckpoints
   
  Get_MainWindow().SetFocus();
  Close_Croesus_X(); 
 }
 

