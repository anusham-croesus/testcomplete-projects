//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT CommonCheckpoints


/* Description : Aller au module "Orders".
    Rechercher un ordre d'achat/Vente de Stocks/mutualFunds/fixedIncome et l'afficher avec le bouton "Consulter" de la barre des Ordres.
    Vérifier le texte et la présence des contrôles.
    @author : christophe.paring@croesus.com
    
    Regroupé par : A.A Version ref90-19-2020-09-6      
*/

function Survol_Ord_ViewBuySellOrder_CombinatedAccess(){
    
        var mutualFundsType = "mutualFunds";
        var fixedIncomeType = "fixedIncome";    
        var stocksType      = "stocks";
    
        var moduleOrders = "orders";
        var buyOrder     = "buy";
        var sellOrder    = "sell";

        var calledFromView = "View";        
        var calledFromCFO  = "CFO";
        
        var orderStatusOpen           = "Open";
        var orderStatusTraderApproval = "TraderApproval";
        var orderStatusRejected       = "Rejected";
        var orderStatusPartialFill    = "PartialFill";
        
        var currencyUSD = "USD";    
        var waitTime = 3000;
      
        if(client == "RJ" || client == "BNC" || client == "CIBC" || client == "TD" ){
            try{
                Login(vServerOrders, userNameOrders, pswOrders, language);
                Get_ModulesBar_BtnOrders().Click();
                Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, waitTime);
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_e262", true, waitTime);
                    
                //Ordre d'achat: mutualFunds 
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre d'Achat: mutualFunds");
                Search_Order_Symbol("AGF110C");
                Get_OrdersBar_BtnView().Click();          
                Check_Properties_CreateOrder_DifType_BE(language, mutualFundsType, moduleOrders, buyOrder, calledFromView, orderStatusRejected);
                Get_WinOrderDetail_BtnCancel().Click();
        
                //Ordre d'achat: fixedIncome                
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre d'Achat: fixedIncome");
                Search_Order_Symbol("B01610");
                Get_OrderGrid().Keys("[Down]");
                Get_OrderGrid().Keys("[Down]");
                Get_OrderGrid().Keys("[Down]");    
                Get_OrdersBar_BtnView().Click();
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, buyOrder, calledFromView, orderStatusTraderApproval);
                Get_WinOrderDetail_BtnCancel().Click();
        
                //Ordre d'achat: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre d'Achat: stocks");
                Search_Order_Symbol("RY");
                Get_OrdersBar_BtnCFO().Click();                
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, buyOrder, calledFromCFO, orderStatusOpen);            
                Get_WinOrderDetail_BtnCancel().Click();

                //Ordre de vente: mutualFunds
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre de Vente: mutualFunds");
                Search_Order_Symbol("FID224");
                Get_OrderGrid().Keys("[Down]");   
                Get_OrdersBar_BtnView().Click();
                Check_Properties_CreateOrder_DifType_BE(language, mutualFundsType, moduleOrders, sellOrder, calledFromView, orderStatusTraderApproval);
                Get_WinOrderDetail_BtnCancel().Click();  
                    
                //Ordre de vente: fixedIncome
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre de Vente: fixedIncome");
                Search_Order_Symbol("B03774");    
                Get_OrdersBar_BtnView().Click();
                Check_Properties_CreateOrder_DifType(language, fixedIncomeType, moduleOrders, sellOrder, calledFromView, orderStatusPartialFill);
                Get_WinOrderDetail_BtnCancel().Click();

                //Ordre de vente: stocks
                Log.PopLogFolder();
                logEtape1 = Log.AppendFolder("Consulter un ordre de Vente: stocks");
                Search_Order_Symbol("MSFT");    
                Get_OrdersBar_BtnView().Click(); 
                Check_Properties_CreateOrder_DifType(language, stocksType, moduleOrders, sellOrder, calledFromView, orderStatusTraderApproval, currencyUSD);// la fonction est dans CommonCheckpoints    
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


//Fonctions  (les points de vérification , btnCreateBuyOrder -Stocks ) 
//Fonction transférer a partir de CommonCheckpoints car il ya des changements spécifiques pour Be ( il y a deux boutons radios qui sont enlevés pour Be)

/** 
    Cette fonction vérifie les composants qui sont dans les fenêtres Buy Order et Sell Order .  
    Elle fonction pour tous les modules et pour trois types d’ordre. 
    type – pour distinguer entre les  Stocks, Fixed Income et Mutual Funds
    module – pour distinguer entre les différents modules à partir desquelles on lance un script 
    order - pour distinguer entre la fenêtre sell et buy 
    calledFrom - le bouton à partir duquel la fenêtre a été ouverte
    orderStatus - le statut de l'ordre
*/

function Check_Properties_CreateOrder_DifType_BE(language, type, module, order, calledFrom, orderStatus)
{
    Get_WinOrderDetail().Set_Width(828);
    Get_WinOrderDetail().Set_Height(635);
  
    //***************************************************   Vérification de la partie en haut « BUY » **************************************
    if(calledFrom == "CFO"){
      aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 117, language)); 
    }else{
      aqObject.CheckProperty(Get_WinOrderDetail(), "Title", cmpContains, GetData(filePath_Common, "Create_Order_DifType", 2, language)); 
    }
    if ((calledFrom == "CFO") || (calledFrom == "View")){
        aqObject.CheckProperty(Get_WinOrderDetail_CmbAccount(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_CmbAccount(), "IsEnabled", cmpEqual, false);
        
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 4, language));
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsVisible", cmpEqual, true);
            aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsEnabled", cmpEqual, false);
        }
    } else {
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 3, language));
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_BtnSave(), "IsEnabled", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 4, language));
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_BtnVerify(), "IsEnabled", cmpEqual, true);
    }
    
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 5, language));
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "IsVisible", cmpEqual, true);
    aqObject.CheckProperty(Get_WinOrderDetail_BtnCancel(), "IsEnabled", cmpEqual,true);
    
    if (orderStatus == "TraderApproval"){
        aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 87, language));
		if(client!="RJ"){
			aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "IsVisible", cmpEqual, true);
			aqObject.CheckProperty(Get_WinOrderDetail_BtnReject(), "IsEnabled", cmpEqual, false);
		}
        
        if ((type == "stocks") || (type == "fixedIncome")){
            aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 86, language));
			if(client!="RJ"){
				aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "IsVisible", cmpEqual, true);
				aqObject.CheckProperty(Get_WinOrderDetail_BtnApprove(), "IsEnabled", cmpEqual, false);
			}
        }
    }
    
    
    if (type == "stocks"){
        
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 115, language));
        } else {
            if (order == "buy"){
                aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 110, language));
            }
      
            if (order == "sell"){
                aqObject.CheckProperty(Get_WinStocksOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 113, language));
            }
        }
      
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 8, language));
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 9, language));
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if (type == "fixedIncome"){
  
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 114, language));
        } else {
            if (order == "buy"){
              aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 107, language));
            }
    
            if(order == "sell"){
                aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 111, language));
            }
        }
        
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 8, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 9, language));
        
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblFaceValue().Text, "OleValue", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",53,language));
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
        }
    }
  
    if (type == "mutualFunds"){
  
        if (calledFrom == "CFO"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 83, language));
        } else {
            if (order == "buy"){
                aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 108, language));
            }
    
            if (order == "sell"){
                aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblOrderType().Text, "OleValue", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 112, language));
            }
        }
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblAccount(), "Text", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",8,language));
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblQuantity(), "Text", cmpEqual, GetData(filePath_Common,"Create_Order_DifType",9,language));
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEditable", cmpEqual, false);
        
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, false);
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_TxtQuantity(), "IsEnabled", cmpEqual, true);
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_CmbQuantityType(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if ((calledFrom != "CFO") && (calledFrom != "View")){
    
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_CmbTypePicker(), "IsEnabled", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey(), "IsEnabled", cmpEqual, true);
  
        if ((module == "titre") || (module == "orders")){ //Exécution du script a partir du module  «Titre» et «Orders»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_BtnSearch(), "IsEnabled", cmpEqual, false);
        }
  
        if (module == "portefeuille"){ //Exécution du script a partir du module  «portefeuille»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_BtnSearch(), "IsEnabled", cmpEqual, true);
        }
  
        aqObject.CheckProperty(Get_WinOrderDetail_GrpAccount_TxtName(), "IsVisible", cmpEqual, true);
      
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_CmbTypePicker(), "IsEnabled", cmpEqual, true);

        if (module == "orders" || (module == "titre")){ //Exécution du script a partir du module  «Orders» et  «Titre»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_BtnSearch(), "VisibleOnScreen", cmpEqual, true);
        }
  
        if ((module == "portefeuille")){ //Exécution du script a partir du module «portefeuille»
            aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_BtnSearch(), "IsEnabled", cmpEqual, true);
        }
    }
    
    if(type =="mutualFunds"){
      Log.message("Selon Karima: les deux points qui  manquent, documentation vont rentrer un jira")
      aqObject.CheckProperty(Get_WinOrderDetail_LblSecurity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 120, language));
    }
    else{
      aqObject.CheckProperty(Get_WinOrderDetail_LblSecurity(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType",10, language));
    }
    
    if ((calledFrom == "CFO") || (calledFrom == "View")){
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "IsEnabled", cmpEqual, false);
    } else {
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey(), "IsEnabled", cmpEqual, true);
    }
    aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_LblSymbol(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 11, language));
    aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtSymbol(), "IsVisible", cmpEqual, true);
    
    
    if (type == "stocks"){
        aqObject.CheckProperty(Get_WinStocksOrderDetail_GrpSecurity_LblMarket(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 12, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_GrpSecurity_TxtMarket(), "IsVisible", cmpEqual, true);
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblPrice(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 13, language));

        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 15, language));
        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsEnabled", cmpEqual, true);
        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoMarket(), "IsChecked", cmpEqual, true);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 16, language));
        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsEnabled", cmpEqual, true);
        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoAt(), "IsChecked", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtAtPrice(), "IsEnabled", cmpEqual, false);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblExpiration(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 17, language));
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 18, language));
        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsEnabled", cmpEqual, true);
        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoToday(), "IsChecked", cmpEqual, true);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 19, language));
        if (calledFrom == "View"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsEnabled", cmpEqual, false);
        } else {
            aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsEnabled", cmpEqual, true);
        }
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSpecificDate(), "IsChecked", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_DtpExpirationSpecificDate(), "IsEnabled", cmpEqual, false);
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false);
       //aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, false);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
    
    
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkOnStop(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 24, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkOnStop(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkStopLimit(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 25, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkStopLimit(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 26, language));
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual, false);
  
        aqObject.CheckProperty(Get_WinStocksOrderDetail_TxtStopLimit(), "IsEnabled", cmpEqual, false);
    }
    
    if (type == "fixedIncome"){
        //Price
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPrice().Text, "OleValue", cmpEqual, aqConvert.VarToStr(GetData(filePath_Common, "Create_Order_DifType", 52, language)));    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceIA(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 54, language)); 
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 55, language)); 
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblPriceClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 55, language)); 
        //Yield
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYield(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 56, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIA(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 57, language));    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIASAPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 58, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblYieldIAANNPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 59, language));
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClient(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 60, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClientSAPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 61, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblClientANNPercent(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 62, language));
    
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
        
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false);
       //aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoSolicited(), "IsChecked", cmpEqual, false);
  
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
    }
  
    if (type == "mutualFunds"){
        Log.Message("CROES-8053")
        Log.Message("Jira CROES-7696 : Renommer Distribution et corriger Réinvesti")
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblDistribution(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 69, language)); //EM: CROES-8053
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 70, language)); //EM: CROES-8053
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsEnabled", cmpEqual, false); // EM: Fonctionnalité Enlevé seulement pour ordre de vente Be //CROES-8053
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsEnabled", cmpEqual, true);//EM: CROES-8053
        }
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoReinvested(), "IsChecked", cmpEqual, true);//EM: CROES-8053
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 71, language));//EM: CROES-8053
        if ((calledFrom == "CFO") || (calledFrom == "View")){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsEnabled", cmpEqual, false); //EM: Fonctionnalité Enlevé seulement pour ordre de vente Be  //CROES-8053
        } else {
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsEnabled", cmpEqual, true);//EM: CROES-8053
        }
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoCash(), "IsChecked", cmpEqual, false);//EM: CROES-8053
       
        //Vérifier l'inexistance des boutons radios Comptant et Réinvesti
       // if(Get_WinMutualFundsOrderDetail_RdoReinvested().Exists){ //EM: CROES-8053
            //Log.Error("Le Bouton Radio Réinvesti existe!")
      //  }else{
           /// Log.Checkpoint("Le Bouton Radio Réinvesti n'existe pas.")} //EM: CROES-8053
        
       // if(Get_WinMutualFundsOrderDetail_RdoCash().Exists){
            //Log.Error("Le Bouton Radio Comptant existe!") //EM: CROES-8053
        //}else{
         //   Log.Checkpoint("Le Bouton Radio Comptant n'existe pas.")}
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblSolicited(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 20, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 21, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "IsEnabled", cmpEqual, false);
        //aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoSolicited(), "IsChecked", cmpEqual,false);
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 22, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoUnsolicited(), "IsChecked", cmpEqual, false);
    
        if (order == "buy"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblFrontEndFund(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 72, language));
        }
       
        if (order == "sell"){
            aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_LblFrontEndFund(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 80, language));
        }
      
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 73, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoGross(), "IsChecked", cmpEqual, true); //A enlever?? Peut varier pour les ordres existants
    
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 74, language));
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "IsEnabled", cmpEqual, false);
        aqObject.CheckProperty(Get_WinMutualFundsOrderDetail_RdoNet(), "IsChecked", cmpEqual,false); //A enlever?? Peut varier pour les ordres existants
    }
    
    
    //*********************** L’onglet "Comptes sous-jacents" (Underlying Accounts) tab *****************************
    
    if ((calledFrom == "CFO") || (calledFrom == "View")){
    
        //Vérification du titre de l'onglet
        Get_WinOrderDetail_TabUnderlyingAccounts().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 91, language));
        
        //Vérification des boutons dans l'onglet
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 93, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit(), "IsEnabled", cmpEqual, false);
        
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 94, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "IsVisible", cmpEqual, true);
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_BtnDelete(), "IsEnabled", cmpEqual, false);
        
        //Vérification des en-têtes de colonne de l'onglet 
        Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChAccountNo(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 96, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChName(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 97, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChIACode(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 98, language));
        Log.Message("BNC-2243")
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChCurrency(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 99, language)); //EM: 90-06-Be-13 datapool modifié selon le Jira BNC-2243
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChRequestedQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 100, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChAllocatedQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 101, language));
        Log.Message("BNC-2243")
        aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChTotalValue(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 102, language)); //EM: 90-06-Be-13 datapool modifié selon le Jira BNC-2243
        //aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_ChSource(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 103, language));//la story  GDO-686
    }
  
    //*************************************************** L’onglet "Fills" **************************************
    if ((type == "stocks") || (type == "fixedIncome")){
        
        Get_WinOrderDetail_TabFills().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 28, language));
        
        Get_WinOrderDetail_TabFills_ChStatus().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
  
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChStatus(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 29, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 32, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 33, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 34, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 35, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChPrice(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 36, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChTotal(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 37, language));
        
        //Vérification du contenu de la liste. Le nombre de colonnes qu’on peut ajouter
        Get_WinOrderDetail_TabFills_ChStatus().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        aqObject.CheckProperty(Sys.Process("CroesusClient").WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1), "ChildCount", cmpEqual, 3);
      
        Get_WinOrderDetail_TabFills_ChStatus().ClickR();
        while ( Get_GridHeader_ContextualMenu_AddColumn().IsEnabled == true){
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 100).Click() 
            //Get_CroesusApp().Find("ClrClassName","PopupRoot",10).Find(["ClrClassName", "WPFControlIndex"], ["MenuItem", "1"], 10).Click()
            Get_WinOrderDetail_TabFills_ChStatus().ClickR();
        }
    
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChStatus(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 29, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChOurRole(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 30, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChMarket(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 31, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChExecutionDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 32, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSettlementDate(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 33, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChQuantity(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 34, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChSymbol(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 35, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChPrice(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 36, language));
        aqObject.CheckProperty(Get_WinOrderDetail_TabFills_ChTotal(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 37, language));
    }
  
  
    //*************************************************** L’onglet "Warnings" ***********************************
    Get_WinOrderDetail_TabWarnings().Click();
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 39, language));
  
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings_ChLevel(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 40, language));
    aqObject.CheckProperty(Get_WinOrderDetail_TabWarnings_ChMessage(), "Content", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 41, language));
  
  
    //*************************************************** L’onglet "Order Log" ***********************************
    Get_WinOrderDetail_TabOrderLog().Click();
  
    aqObject.CheckProperty(Get_WinOrderDetail_TabOrderLog(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 43, language));  
  
  
   //*************************************************** L’onglet "Notes" ***************************************
    if ((type == "stocks") || (type == "fixedIncome")){
        Get_WinOrderDetail_TabNotes().Click();
        aqObject.CheckProperty(Get_WinOrderDetail_TabNotes(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 45, language));
  
        aqObject.CheckProperty(Get_WinOrderDetail_TabNotes_GrpNotes(), "Header", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 45, language));
  
        if(type=="stocks"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_LblTradingNotes(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 47, language));
        }
      
        if(type=="fixedIncome"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_LblClientNotes(), "Text", cmpEqual, GetData(filePath_Common, "Create_Order_DifType", 64, language));
        }
      
        if(type=="stocks"){
            aqObject.CheckProperty(Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes(), "IsVisible", cmpEqual, true);
        }
      
        if(type=="fixedIncome"){
            aqObject.CheckProperty(Get_WinFixedIncomeOrderDetail_TabNotes_GrpNotes_TxtClientNotes(), "IsVisible", cmpEqual, true);
        }
    }
}

