//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Survol_Por_Bond_MenuBar_EditFunctions_Info
//USEUNIT Survol_Por_Bond_WhatIf_ContextualMenu_Functions_Info

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Cliquer sur le btn What-if
Rechercher une position avec le symbol AGU. Afficher la fenêtre Info
en cliquant sur MenuBar_EditFunctions. Fermer la fenêtre par ESC */
 
function Survol_Por_Other_WhatIf_Ctrl_E()
{
  // Les variables utilisées dans les points de vérifications 
  var type="other";
  var btnType="whatif";
  
  Login(vServerPortefeuille, userName, psw, language);
  Get_ModulesBar_BtnClients().Click();
  
  //Rechercher un client 800300.
  if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client("800300")}
  else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}
  
  //Get_RelationshipsClientsAccountsGrid().Find("Value","1CALCUL SCORE",1000).Click();

  //maillage vers le module portefeuille 
  Get_MenuBar_Modules().OpenMenu();
  Get_MenuBar_Modules_Portfolio().OpenMenu();
  Get_MenuBar_Modules_Portfolio_DragSelection().Click();
  Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
      
  //Vérifier que le module portefeuille sélectionné 
  aqObject.CheckProperty(Get_ModulesBar_BtnPortfolio(), "IsChecked", cmpEqual, true);
   
  Get_PortfolioBar_BtnWhatIf().Click();
  
  Search_Position("CBL170");
  
  Get_MainWindow().Keys("^e");

  //Les points de vérification 
  Check_WhatIfInfo_Properties(language, type) // la fonction est dans le Survol_Por_Bond_WhatIf_ContextualMenu_Functions_Info
  Check_Existence_Of_Controls_InfoWhatif(type)// la fonction est dans le Survol_Por_Bond_WhatIf_ContextualMenu_Functions_Info
  Check_PositionInfo_Properties(language, type)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  Check_Existence_Of_Controls_PositionInfo(type,btnType)// la fonction est dans le Survol_Por_Bond_MenuBar_EditFunctions_Info
  
  Get_WinPositionInfo_BtnCancel().Keys("[Esc]");
  
  Close_Croesus_SysMenu();   
 }