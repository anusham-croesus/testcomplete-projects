//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints


/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers).Rechercher la position R13369. Afficher la fenêtre «Orders Module » par Ctrl+Shift+B
Vérifier le texte et la présence des contrôles */

/*    Date: 29-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons de création d'ordre de vente
*/
 
 function Survol_Por_CreateSellOrder_CombinedAccess()
 {
   try {
          // Les variables utilisées dans les points de vérifications 
          var typeFixedIncome = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "typeFixedIncome", language+client);//"fixedIncome";
          var module = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "module", language+client);
          var order = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "orderSell", language+client);
          var calledFrom = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "calledFromSell", language+client);
          var orderStatus = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "orderStatus", language+client);
          
          var clientFixedIncome = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800300", language+client);
          var positionFixedIncome = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "positionFixedIncome", language+client);//"R13369"
          
          var typeMutualFunds = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "typeMutualFunds", language+client);//"mutualFunds"
          var clientMutualFunds = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "clientMutualFunds", language+client);//"800217"
          var positionMutualFunds = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "positionMutualFunds", language+client);//"FID285"
          
          var typeSell = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "typeSell", language+client);
          
          var typeStocks = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "typeStocks", language+client);//"stocks";
          var positionStocks = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "positionStocks", language+client);
          
          
          
          //Étape 1 : Se connecter à croesus avec COPERN
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
    
          Login(vServerPortefeuille, userName , psw ,language);
          Get_ModulesBar_BtnClients().Click();
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientFixedIncome)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);    
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){ Search_Position(positionFixedIncome)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}  
  
 //----------- Étape 2 : Accès à la fenêtre «Orders Module » par Ctrl+Shift+B ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Accès à la fenêtre «Orders Module » par Ctrl+Shift+B");
          
          //Afficher la fenêtre «Orders Module » par Ctrl+Shift+B
          Get_Portfolio_PositionsGrid().Keys("^S");
  
          //points de vérifications 
          Check_Properties_CreateOrder_DifType(language, typeFixedIncome, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
          Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
          
 //----------- Étape 3 : Accès à la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Accès à la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder");
          
          
          Get_ModulesBar_BtnClients().Click()
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientMutualFunds)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){ Search_Position(positionMutualFunds)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}  
      
          //Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder
          Get_MenuBar_Edit().OpenMenu();
          Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
          Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();
  
          Check_Properties_CreateOrder_DifType(language, typeMutualFunds, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
          Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
          
 //----------- Étape 4 : Accès à la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Accès à la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder");
          
          Get_ModulesBar_BtnClients().Click();
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientFixedIncome)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);    
  
          
          //Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
          Get_Toolbar_BtnCreateASellOrder().Click();
  
          Check_Properties_FinancialInstrumentSelector(language,typeSell);// la fonction est dans le CommonCheckpoints
        
          Get_WinFinancialInstrumentSelector_BtnCancel().Keys("[Esc]");
          
 //----------- Étape 5 : Accès à la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder ---------------------------------------
          Log.PopLogFolder();
          logEtape5 = Log.AppendFolder("Étape 5: Accès à la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder");
          
          Get_ModulesBar_BtnClients().Click();
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientFixedIncome)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);    
  
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){ Search_Position(positionStocks)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}  
  
          //Afficher la fenêtre «Orders Module » en cliquant sur le bouton Toolbar-btnCreateBuyOrder
          Get_Toolbar_BtnCreateASellOrder().Click();
  
          Check_Properties_CreateOrder_DifType(language, typeStocks, module, order, calledFrom, orderStatus);// la fonction est dans CommonCheckpoints
    
          Get_WinOrderDetail_BtnCancel().Keys("[Esc]");
       }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 6 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
      
 }
 