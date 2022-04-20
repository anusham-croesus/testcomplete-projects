//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Afficher la fenêtre «Orders Module »
[La fenêtre avec les trois choix (Stocks, Fixed Income, Mutual Funds)]
en cliquant sur le bouton Toolbar-btnCreateSellOrder.Vérifier le texte et la présence des contrôles */
 
 function Survol_Por_Toolbar_btnCreateSellOrder()
 {
    
      var type="sell"
      
      Login(vServerPortefeuille, userName , psw ,language);
      Get_ModulesBar_BtnClients().Click()
  
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
      
      //Afficher la fenêtre «Orders Module »
      Get_Toolbar_BtnCreateASellOrder().Click()
  
      Check_Properties_FinancialInstrumentSelector(language,type)// la fonction est dans le CommonCheckpoints
        
      Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "Button_b055", 30000);
      
      Close_Croesus_MenuBar();
   
 }