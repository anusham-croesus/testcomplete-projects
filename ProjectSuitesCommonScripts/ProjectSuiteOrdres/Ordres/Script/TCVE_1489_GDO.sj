//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables

/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2461_Generate_TradeBlock_viaWinExchangeBlock()
GDO_2476_ChangeStatus_Of_TradeBlock_TraderApproval()
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-18-2020-08-7 */ 

function TCVE_1489_GDO()
{
    var logEtape1, logEtape2, logEtape3, logEtape4,logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-1489");
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username"); 
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2461", language+client);
        var securityDescription =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2461", language+client);
        var security=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Security_2461", language+client);    
        var quantity =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2461", language+client);
        
        var account2453=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity2453=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);
        var security2453= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityStocks_2453", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
         
       
        // ********************************************************Étape 2*******************************************
        logEtape2 = Log.AppendFolder("Étape 2: Dans le module Titres, rechercher le titre FID224 puis le mailler vers le module Comptes");
        
        Log.Message("Login");
        Login(vServerOrders, user , psw ,language);    
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked",true,1500); 
        
        Log.Message("Rechercher le titre FID224");      
        Search_Security(security);        
        Get_SecurityGrid().Find("Value",security,10).Click();
        
        Log.Message("Mailler vers le module Comptes")
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnAccounts())

          aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, security);
                            
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner tous les comptes correspondants et cliquer sur l'icône 'Ordres multiples, en bloc et échange')");
                 
        Get_RelationshipsClientsAccountsDetails().Keys("^a");   
        Get_Toolbar_BtnSwitchBlock().Click(); 
                         
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Ajouter la transaction source : par exemple 100 % de la position détenue, et rechercher le symbole FID224. Générer le bloc trade");
        
        Log.message("Ajout d'une transaction(s):Vente");        
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
              
//        WinSwitchBlockCmbDescription();        
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbol);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]"); 
        SetAutoTimeOut(); 
        if(Get_SubMenus().Exists){       
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();     
        }  
        RestoreAutoTimeOut();  
        Get_WinSwitchSource_btnOK().Click();
        
        Log.Message("Valider que le Bloc trade généré")
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantity", cmpContains,quantity);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SymbolDisplay", cmpContains,securitySymbol);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SecurityDisplay", cmpContains,securityDescription);

         Log.Message("Générer le bloc trade");
        Get_WinSwitchBlock_BtnPreview().Click();
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
        Get_WinSwitchBlock_BtnGenerate().Click(); 
        if (Get_WinSwitchBlock().Exists)
          Get_WinSwitchBlock_BtnGenerate().Click();      
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");      
        WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd");
        
        // ********************************************************Étape 5*******************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: De l`accumulateur, sélectionner un ordre d`Action ou de revenu fixe ou de fonds mutuels");
        
        Log.Message("Creation d'ordre");
        Get_Toolbar_BtnCreateABuyOrder().Click();
                
        Log.Message("Selectioner 'Stoks'");
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        Log.Message("Creation d'ordre"); 
        CreateEditStocksOrder(account2453,quantity2453,security2453)
        
        Log.Message("Sélectionner l'ordre créé");
        Get_OrderAccumulatorGrid().Find("Value",account2453,10).Click();
        Get_OrderAccumulator_BtnEdit().Click(); 
        
        Log.Message("Verifier");
        Get_WinOrderDetail_BtnVerify().Click();
        Log.Message("Submit");
        Get_WinOrderDetail_BtnVerify().Click();
                                
        Log.Message("Verification");
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "SecurityDesc", cmpEqual,security2453); 
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity2453);
          
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
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
        Terminate_CroesusProcess(); //Fermer Croesus 
    }
}