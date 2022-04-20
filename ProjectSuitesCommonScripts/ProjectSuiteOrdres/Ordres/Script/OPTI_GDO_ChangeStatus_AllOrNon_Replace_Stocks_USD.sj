//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT DBA 

/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2510_Checkbox_AllOrNon_USD
GDO_2478_ChangeStatus_Of_TradeBlock_Rejected
GDO_2462_ReplaceRejectedOrder
GDO_2462_ReplaceExpiredOrder


 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-19-2020-09-36 */ 
 
 function OPTI_GDO_ChangeStatus_AllOrNon_Replace_Stocks_USD()
 {      
        var logEtape1, logEtape2, logEtape3, logEtape4, logRetourEtatInitial;
    try {
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolMSFT_2514", language+client);       
        var SecurityDescMSFT_2514=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescMSFT_2514", language+client); 
        var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var statusRejected=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2478", language+client);
        var reason=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Reason_2478", language+client);   
        var quantity="96";
        var account="800000-GT";
        var OrdersStatusExpired=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "OrdersStatusExpired", language+client);
        
        // ********************************************************Étape 1*******************************************
        /*Étape 1:  accéder au module Ordres. créer un ordre de vente - 'Action'  account: 800000-GT quantité :96 security: MSFT
                     Double cliquer sur l'ordre créé et valider la case 'tout ou rien' est grisée pour l'ordre en USD*/ 
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: couverture de Croes-2510 GDO_2510_Checkbox_AllOrNon_USD ");        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator(); 
        
        Log.Message("Creat an order");
        Get_Toolbar_BtnCreateASellOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        CreateEditStocksOrder(account,quantity,SecurityDescMSFT_2514,securitySymbol);
         Log.Message("L'anomalie ouverte par Karima CROES-8317");
         
        Log.Message("Check the state of checkbox All or non");
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual,true);    
        Get_WinOrderDetail().Close(); 
        
      
        // ********************************************************Étape 2*******************************************
        /*Étape 2: Vérifier et soumettre l'ordre créé. Puis consulter et approuver - le statut d'ordre change a ouvert. 
                   Cliquer sur puis Consulter puis Rejeter. L`ordre tombe à Rejeté*/
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: couverture de Croes-2478 GDO_2478_ChangeStatus_Of_TradeBlock_Rejected");  
               
        //Sélectionner l'ordre créé
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnEdit().Click(); 
        
        Log.Message("Verifieret puis sumettre");
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnVerify().Click();
        
        Log.Message("Check if the order was sent to the blotter")
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);
        
        Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
        Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
        
        Log.Message("Rejeter l'ordre");
        Get_OrdersBar_BtnView().Click();
        Get_WinOrderDetail_BtnReject().Click();        
        Get_DlgConfirmation_TxtReason().Keys(reason);
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
              
        Log.Message("Vérifier le changement du statut"); 
        Get_OrderGrid().Find("Value",quantity,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",quantity,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",quantity,10).DataContext.DataItem, "Status", cmpEqual,statusRejected);        
                    
        // ********************************************************Étape 3*******************************************
        /*Étape 3:Sélectionner un ordre Rejeté et cliquer sur le bouton Replacer. Dans l`Accumulateur on obtient une copie de l`ordre replacé */
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: couverture de Croes-2462 GDO_2462_ReplaceRejectedOrder"); 
              
        Get_OrderGrid().Find("Value",quantity,10).Click();       
        Log.Message("JIRA: GDO-2262");         
         if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", statusRejected,10)){
            Get_OrdersBar_BtnReplace().Click();
            if(Get_OrderAccumulatorGrid().Find("Value",quantity,10).Exists){
                  Log.Checkpoint("The order was successfully sent to Accumulateur") 
            } else{
                  Log.Error("The order wasn't sent to Accumulateur")
            }; 
         }
         else{
           Log.Error("There is a probleme with the order's status")
         } ; 
         
        // ********************************************************Étape 4*******************************************
        /*Étape 4:Sélectionner un ordre expiré et cliquer sur le bouton Replacer.Dans l`Accumulateur on obtient une copie de l`ordre replacé */
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: couverture de Croes-2462 GDO_2462_ReplaceExpiredOrder"); 
        DeleteAllOrdersInAccumulator(); 
        
        Get_OrderGrid().Find("Value",OrdersStatusExpired,10).Click();
        var security= Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem.SecurityDesc.OleValue;
        
        Log.Message("JIRA: GDO-2262");         
         if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", OrdersStatusExpired,10)){
            Get_OrdersBar_BtnReplace().Click();
            if( Get_OrderAccumulatorGrid().Find("Value",security,10).Exists){
                  Log.Checkpoint("The order was successfully sent to Accumulateur") 
            } else{
                  Log.Error("The order wasn't sent to Accumulateur")
            }; 
         }
         else{
           Log.Error("There is a probleme with the order's status")
         } ;
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
    }
    finally {
      Log.PopLogFolder();
      logRetourEtatInitial = Log.AppendFolder("CleanUp");
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      Login(vServerOrders, user , psw ,language);
      Get_ModulesBar_BtnOrders().Click(); 
      DeleteAllOrdersInAccumulator();  
      Runner.Stop(true); 
    }
 }