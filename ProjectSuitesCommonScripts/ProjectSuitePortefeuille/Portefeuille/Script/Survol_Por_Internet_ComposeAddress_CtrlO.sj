//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).A partir du module « Portefeuille ».
Afficher La fenêtre Composer par Ctrl+O. Vérifier la présence des contrôles dans le menu  */
 
 function Survol_Por_Internet_ComposeAddress_CtrlO()
 {
  Login(vServerPortefeuille, userName , psw ,language);
  Get_ModulesBar_BtnClients().Click();
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()

    //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
   //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
   
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
 