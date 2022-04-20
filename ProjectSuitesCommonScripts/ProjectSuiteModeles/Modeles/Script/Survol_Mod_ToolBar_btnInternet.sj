//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Modeles ». Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu */
 
 function Survol_Mod_ToolBar_btnInternet()
 { 
  Login(vServerModeles, userName , psw ,language);
  Get_ModulesBar_BtnModels().Click();
  
  //fficher le menu contextuel en cliquant sur ToolBar- btnInternet
  Get_Toolbar_BtnInternetAddresses().Click();
   
  //Check_ToolBarInternet_Properties();// la fonction est dans CommonCheckpoints
   
  Get_MainWindow().SetFocus();
  Close_Croesus_X();
 }
 
