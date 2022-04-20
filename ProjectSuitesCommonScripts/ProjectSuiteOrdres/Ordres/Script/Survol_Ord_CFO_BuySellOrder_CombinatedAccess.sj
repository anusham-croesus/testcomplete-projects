//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders". 
                 Rechercher un ordre d'achat/Vente de Stocks/fixedIncome et l'afficher avec le bouton "CFO" de la barre des Ordres.
                 Vérifier le texte et la présence des contrôles.
    @author : christophe.paring@croesus.com

    Regroupé par : A.A Version ref90-19-2020-09-6      
*/

function Survol_Ord_CFO_BuySellOrder_CombinatedAccess(){

        var fixedIncomeType = "fixedIncome";    
        var stocksType      = "stocks";
    
        var moduleOrders = "orders";
        var buyOrder  = "buy";
        var sellOrder = "sell";
        var calledFromCFO  = "CFO";
        var orderStatusPartialFill = "PartialFill";
        var orderStatusOpen        = "Open";
    
        var waitTime = 3000;
 
        if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" ){
            try{
                Login(vServerOrders, userNameOrders, pswOrders, language);
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);             
      
                //Ordre d'achat: fixedIncome                
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher  un ordre d'Achat : fixedIncome");
                Search_Order_Symbol("B01610");
                Get_OrderGrid().Keys("[Down]");
                Get_OrderGrid().Keys("[Down]");    
                Get_OrdersBar_BtnCFO().Click();
                // la fonction est dans CommonCheckpoints            
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, buyOrder, calledFromCFO, orderStatusOpen);
                Get_WinOrderDetail_BtnCancel().Click();
        
                //Ordre d'achat: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher un ordre d'Achat : stocks");
                Search_Order_Symbol("RY");    
                Get_OrdersBar_BtnCFO().Click();  
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, buyOrder, calledFromCFO, orderStatusOpen);            
                Get_WinOrderDetail_BtnCancel().Click();
                  
                //Ordre de vente: fixedIncome
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher un ordre de vente : fixedIncome");
                Search_Order_Symbol("B03774");    
                Get_OrdersBar_BtnCFO().Click();
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, sellOrder, calledFromCFO, orderStatusPartialFill);
                Get_WinOrderDetail_BtnCancel().Click();

                //Ordre de vente: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Afficher ordre de vente : stocks");
                Search_Order_Symbol("TD");   
                Get_OrdersBar_BtnCFO().Click();
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, sellOrder, calledFromCFO, orderStatusOpen);
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
