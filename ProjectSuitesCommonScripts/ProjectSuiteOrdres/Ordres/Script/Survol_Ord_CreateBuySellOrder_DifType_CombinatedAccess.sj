//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders". Afficher la fenêtre «Orders Module » en cliquant sur le MenuBar-OrderEntryModule-CreateBuyOrder
                Selectioner le bouton radio "Stocks"/"mutualFunds"/"fixedIncome". 
    Vérifier le texte et la présence des contrôles 
    
    Regroupé par : A.A Version ref90-19-2020-09-6      
*/

function Survol_Ord_CreateBuySellOrder_DifType_CombinatedAccess(){
    
        var mutualFundsType = "mutualFunds";
        var fixedIncomeType = "fixedIncome";    
        var stocksType      = "stocks";
    
        var moduleOrders = "orders";
        var buyOrder  = "buy";
        var sellOrder = "sell";
        var calledBuyFrom  = "CreateABuyOrder";
        var calledSellFrom = "CreateASellOrder";
        var orderStatus = "Creation";
    
        var waitTime = 3000;
      
        if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" ){
            try{
                Login(vServerOrders, userName, psw, language);
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);
                    
                //Ordre d'achat: mutualFunds 
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre d'Achat»: mutualFunds");
                Get_MenuBar_Edit().OpenMenu();
                Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
                Get_MenuBar_Edit_OrderEntryModule_CreateABuyOrder().Click();     
                Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click();
                Check_Properties_CreateOrder_DifType(language, mutualFundsType, moduleOrders, buyOrder, calledBuyFrom, orderStatus);
                Get_WinOrderDetail_BtnCancel().Click();
        
                //Ordre d'achat: fixedIncome                
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre d'Achat» : fixedIncome");
                Get_Toolbar_BtnCreateABuyOrder().Click();      
                Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click();
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, buyOrder, calledBuyFrom, orderStatus);
                Get_WinOrderDetail_BtnCancel().Click();
        
                //Ordre d'achat: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre d'Achat» : stocks");
                Get_Toolbar_BtnCreateABuyOrder().Click();    
                Get_WinFinancialInstrumentSelector_RdoStocks().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click();
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, buyOrder, calledBuyFrom, orderStatus);            
                Get_WinOrderDetail_BtnCancel().Click();

                //Ordre de vente: mutualFunds
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre de Vente » : mutualFunds");
                Get_MenuBar_Edit().OpenMenu();
                Get_MenuBar_Edit_OrderEntryModule().OpenMenu();
                Get_MenuBar_Edit_OrderEntryModule_CreateASellOrder().Click();    
                Get_WinFinancialInstrumentSelector_RdoMutualFunds().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click(); 
                Check_Properties_CreateOrder_DifType(language, mutualFundsType, moduleOrders, sellOrder, calledBuyFrom, orderStatus);
                Get_WinOrderDetail_BtnCancel().Click();  
                    
                //Ordre de vente: fixedIncome
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre de vente» : fixedIncome");
                Get_Toolbar_BtnCreateASellOrder().Click();   
                Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click();
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, sellOrder, calledBuyFrom, orderStatus);
                Get_WinOrderDetail_BtnCancel().Click();

                //Ordre de vente: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher la fenêtre «Créer un ordre de vente» : stocks");
                Get_Toolbar_BtnCreateASellOrder().Click();    
                Get_WinFinancialInstrumentSelector_RdoStocks().Click();
                Get_WinFinancialInstrumentSelector_BtnOK().Click(); 
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, sellOrder, calledSellFrom, orderStatus);// la fonction est dans CommonCheckpoints    
                Get_WinOrderDetail_BtnCancel().Click();        
            }
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));     
            }
            finally {     
                //Fermer Croesus
                Get_MainWindow().SetFocus();
                Close_Croesus_MenuBar(); 
            }
        }
}
