//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Common_Get_functions

/* Description :Aller au module "Clients" en cliquant sur BarModules-btnClients. Rechercher un client 800300. 
Par la suite, le mailler vers le module portefeuille (menuBar-Modules-Portefeuille-Chaîner vers). Afficher la fenêtre « Sold (CAD) » 
en cliquant sur PortfolioBar -btnTradeDateBal. Fermer la fenêtre par Esc */

/*    Date: 30-12-2020
      Analyste Auto: Abdel.M
      Objectif: Combiner les différentes façons pour afficher la fenêtre « Solde (CAD) »
*/
 
 function Survol_Por_TradeDateBal_CombinedAccess()
 {
   try {
          // Les variables utilisées dans les points de vérifications 
          var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Portefeuille, "Survol", "client800300", language+client);
          
 //---------- Étape 1 : Se connecter à croesus avec COPERN -------------------------------
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter avec le user COPERN");
          Login(vServerPortefeuille, userName, psw, language);
          Get_ModulesBar_BtnClients().Click();
          if (Get_Toolbar_BtnSearch().WaitProperty("IsVisible", true, 15000)){Search_Client(clientNumber)}
          else {Log.Error("The BtnSearch didn't become enabled within 15 seconds.");}

          //maillage vers le module portefeuille 
          Get_MenuBar_Modules().OpenMenu();
          Get_MenuBar_Modules_Portfolio().OpenMenu();
          Get_MenuBar_Modules_Portfolio_DragSelection().Click();
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 30000);
          
 //----------- Étape 2 : Afficher la fenêtre « Sold (CAD) » avec clickR Functions- btnTradeDateBal ---------------------------------------
          Log.PopLogFolder();
          logEtape2 = Log.AppendFolder("Étape 2: Afficher la fenêtre « Solde (CAD) » avec clickR Functions- btnTradeDateBal");
  
          Get_PortfolioPlugin().ClickR();
          Get_PortfolioGrid_ContextualMenu_Functions().Click();
          Get_PortfolioGrid_ContextualMenu_Functions_TradeDateBalance().Click();
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnTradeDateBal
          //Les points de vérification en anglais 
          else{Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnTradeDateBal
          //Les points de vérification
          Check_Existence_Of_Controls();
  
          Get_WinBalance().Close();
          
 //----------- Étape 3 : Afficher la fenêtre « Sold (CAD) » en cliquant sur MenuBar -Edit- Functions- btnTradeDateBal ---------------------------------------
          Log.PopLogFolder();
          logEtape3 = Log.AppendFolder("Étape 3: Afficher la fenêtre « Solde (CAD) » en cliquant sur MenuBar -Edit- Functions- btnTradeDateBal");
  
          Get_MenuBar_Edit().OpenMenu();
          Get_MenuBar_Edit_Functions().OpenMenu();
          Get_MenuBar_Edit_FunctionsForPortfolio_TradeDateBalance().Click();
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()} // la fonction est dans le script Survol_Por_PortfolioBar_btnTradeDateBal
          //Les points de vérification en anglais 
          else{Check_Properties_English()} // la fonction est dans le script Survol_Por_PortfolioBar_btnTradeDateBal
          //Les points de vérification 
          Check_Existence_Of_Controls();
  
          Get_WinBalance_BtnClose().Click();
          
  //----------- Étape 4 : Afficher la fenêtre « Sold (CAD) » en cliquant sur MenuBar -Edit- Functions- btnTradeDateBal   ---------------------------------------
          Log.PopLogFolder();
          logEtape4 = Log.AppendFolder("Étape 4: Afficher la fenêtre « Solde (CAD) » en cliquant sur MenuBar -Edit- Functions- btnTradeDateBal ");
          
          //Afficher la fenêtre « Sold (CAD) » en cliquant sur PortfolioBar -btnTradeDateBal
          Get_PortfolioBar_BtnTradeDateBalance().Click();
  
          //Les points de vérification en français 
          if(language=="french"){Check_Properties_French()}
          //Les points de vérification en anglais 
          else{Check_Properties_English()} 
  
          Check_Existence_Of_Controls();
  
          Get_WinBalance_BtnClose().Keys("[Esc]");
  
     }  
     catch(e) 
     {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                     
     }
     finally 
     {   
       //Étape 5 : Se déconnecter de Croesus  ------------------------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Se déconnecter de Croesus ");
        //Fermer Croesus
        Terminate_CroesusProcess();         
        Runner.Stop(true)       
        
    }
      
 }
 
 
 //Fonctions  (les points de vérification pour les scripts qui testent «Sold (CAD)» )
function Check_Properties_French()
{
   aqObject.CheckProperty(Get_WinBalance().Title, "OleValue", cmpEqual, "Solde (CAD)");
   
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate().Header, "OleValue", cmpEqual, "Date de transaction");
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblSettlementDateBalance().Content, "OleValue", cmpEqual, "Solde à la date de règlement:");
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblReviewedTransactions().Content, "OleValue", cmpEqual, "Transactions révisées:");
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblTradeDateBalance().Content, "OleValue", cmpEqual, "Solde à la date de transaction:");
      
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate().Header, "OleValue", cmpEqual, "Ajusté à la date de règlement");
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate_LblSettlementDateBalance().Content, "OleValue", cmpEqual, "Solde à la date de règlement:");
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate_LblAdjustedSettlementDateBalance().Content, "OleValue", cmpEqual, "Solde ajusté à la date de règlement:");
      
   aqObject.CheckProperty(Get_WinBalance_BtnClose().Content, "OleValue", cmpEqual, "Fermer");
}

function Check_Properties_English()
{
   aqObject.CheckProperty(Get_WinBalance().Title, "OleValue", cmpEqual, "Balance (CAD)");
   
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate().Header, "OleValue", cmpEqual, "Trade Date");
   if(client != "US" )
   {aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblSettlementDateBalance().Content, "OleValue", cmpEqual, "Settlement Date Balance:");}
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblReviewedTransactions().Content, "OleValue", cmpEqual, "Reviewed Transactions:");
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_LblTradeDateBalance().Content, "OleValue", cmpEqual, "Trade Date Balance:");
   if(client != "US" && client != "TD" && client != "CIBC"){
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate().Header, "OleValue", cmpEqual, "Adjusted Settlement Date");
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate_LblSettlementDateBalance().Content, "OleValue", cmpEqual, "Settlement Date Balance:");
   aqObject.CheckProperty(Get_WinBalance_GrpAdjustedSettlementDate_LblAdjustedSettlementDateBalance().Content, "OleValue", cmpEqual, "Adjusted Settlement Date Balance:");}
   
   aqObject.CheckProperty(Get_WinBalance_BtnClose().Content, "OleValue", cmpEqual, "Close");   
}

function Check_Existence_Of_Controls()
{
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtSettlementDateBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtSettlementDateBalance(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtReviewedTransactions(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtReviewedTransactions(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtTradeDateBalance(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinBalance_GrpTradeDate_TxtTradeDateBalance(), "IsReadOnly", cmpEqual, true);
   
   aqObject.CheckProperty(Get_WinBalance_BtnClose(), "IsVisible", cmpEqual, true);
   aqObject.CheckProperty(Get_WinBalance_BtnClose(), "IsEnabled", cmpEqual, true);
}

