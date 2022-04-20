//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description : Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).
Afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
Vérifier la présence des contrôles et des étiquetés  */
 
 function Survol_Por_Calculator_Ctrl_Maj_O()
 {
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click()
  
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click()
  
   //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
  
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
  
  Search_Security("101750");
   
  //Afficher la fenêtre « Calculatrice d'obligations » avec Ctrl+Maj+O. 
  Get_MainWindow().Keys("^O");
   
   //Les points de vérification en français 
   if(language=="french"){Check_BondCalculator_Properties_French()}// la fonction est dans CommonCheckpoints
    
    //Les points de vérification en anglais 
   else {Check_BondCalculator_Properties_English()}// la fonction est dans CommonCheckpoints
     
  Get_WinBondCalculator_BtnClose().Click()       
  Get_MainWindow().SetFocus();
  Close_Croesus_MenuBar(); 
 }
 
 
