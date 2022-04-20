//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : A partir du module « Relation ». Afficher le menu contextuel en cliquant sur ToolBar- btnInternet. Vérifier la présence des contrôles dans le menu */
 
 function Survol_Rel_ToolBar_btnInternet()
 {  
  Login(vServerRelations, userName , psw ,language);
  Get_ModulesBar_BtnRelationships().Click();
  
  Get_Toolbar_BtnInternetAddresses().Click()
   
  //Check_ToolBarInternet_Properties();// la fonction est dans CommonCheckpoints 
    
  Get_MainWindow().SetFocus();
  Close_Croesus_X()
 }
 