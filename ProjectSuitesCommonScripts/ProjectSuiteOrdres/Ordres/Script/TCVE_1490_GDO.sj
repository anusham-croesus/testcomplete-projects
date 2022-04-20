//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2524_Create_Order_When_PortfolioGroupedByTitle()
GDO_2496_ExportToExcel()
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-18-2020-08-7 */ 

function TCVE_1490_GDO()
{
    var logEtape1, logEtape2, logEtape3, logEtape4,logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-1490");
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username"); 
        var clientNo=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ClientNo_2517", language+client);
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolRY_2517", language+client);  
         
       
        // ********************************************************Étape 1*******************************************
        logEtape1 = Log.AppendFolder("Étape 1: Accéder au module Clients");
        
        Log.Message("Login");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked",true,1500); 
        
        Log.Message("Sélectionner le client 800049"); 
        Search_Client(clientNo);
        
        Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,10).Click();
                     
        // ********************************************************Étape 2*******************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Mailler vers portefeuille et grouper par titres (cliquer sur le bouton 'Grouper par titres')");
                 
        Log.Message("mailler vers portefeuille")  
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",clientNo,10), Get_ModulesBar_BtnPortfolio()); 
        
        Log.Message("cliquer sur le bouton 'Grouper par titres'");
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnBySecurity().Click();
                         
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner le symbole RY et cliquer sur créer un ordre de vente");
        
        Search_Security(securitySymbol)                
        Get_Portfolio_PositionsGrid().Find("Value",securitySymbol,10).Click();
        
        Get_Toolbar_BtnCreateASellOrder().Click();                
        Get_WinOrderDetail_BtnSave().Click();
        
        Log.Message("Valider que l'ordre de vente affiché dans l'accumulateur");
        var date= aqConvert.DateTimeToFormatStr(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Clique droit sur un ordre et cliquer sur export vers MS Excel");
        
         //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
       Get_OrderAccumulatorGrid().FindChild("Value", securitySymbol, 10).ClickR();
       ClickOnExportToExcel(Get_OrderAccumulatorGrid());
       
       Sys.WaitProcess("EXCEL", 30000);
       //Dans le cas demande de valider que  Fichier MS Excel généré sans crash .
       aqObject.CheckProperty(Sys.Process("EXCEL"), "Exists", cmpEqual, true); 
          
        //Fermer Croesus
        Terminate_CroesusProcess(); //Fermer Croesus 
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        //(Cleanup)
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked",true,1500);
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess(); //Fermer Croesus 
    }
}