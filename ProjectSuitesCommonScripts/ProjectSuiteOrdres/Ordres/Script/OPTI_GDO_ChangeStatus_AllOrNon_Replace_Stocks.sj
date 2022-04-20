//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT DBA 

/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2455_Create_SellOrder_Stocks
GDO_2510_Checkbox_AllOrNon_CAD
GDO_2477_ChangeStatus_Of_TradeBlock_Open
GDO_2485_ChangeStatus_Of_ActionBlockTrade_Modified
GDO_2484_ChangeStatus_Of_ActionTradeBlock_Canceled
GDO_2510_Checkbox_AllOrNon_WithoutSymbol
GDO_2462_ReplaceCancelledOrder

 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-19-2020-09-36 */ 
 
 function OPTI_GDO_ChangeStatus_AllOrNon_Replace_Stocks()
 {    
       var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logRetourEtatInitial;
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolNA_2514", language+client);   
        var descSecurityNA_2514=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descSecurityNA_2514", language+client);      
        var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity="97";
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2477", language+client);
        var statusModified=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusModified_2485", language+client); 
        var modifiedQuantity="33";
        var statusCancelled=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusCancelled_2484", language+client);
        
        // ********************************************************Étape 1*******************************************
        /*Étape 1:  accéder au module Ordres. créer un ordre de vente - 'Action'  account: 800001-NA quantité :97 security: NA
                    valider la présence d'orbe créé dans l'accumulateur */
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: couverture de Croes-2455 creation d'un ordre de vente -SellOrder Stocks ");
                      
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        Log.Message("Creat an order");
        Get_Toolbar_BtnCreateASellOrder().Click();        
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        CreateEditStocksOrder(account,quantity,descSecurityNA_2514,securitySymbol)
        
        Log.Message("Check if the order was created");
        Log.Message("L'anomalie ouverte par Karima CROES-8317")
        if(Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Exists){
           Log.Checkpoint("The order was successfully created in Accumulateur") 
       }  else{
          Log.Error("The order wasn't created in Accumulateur")
        };
     
        // ********************************************************Étape 2*******************************************
        /*Étape 2: Double cliquer sur l'ordre créé et valider la case 'tout ou rien' est grisée pour l'ordre en CAD */
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: couverture de Croes-2510 Vérifier la case 'Tout ou rien' pour les titres CAD (Jira CROES-277)- Checkbox AllOrNon_CAD");
        Log.Message("Check the state of checkbox All or non");
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual,false);    
        Get_WinOrderDetail().Close(); 
        
        // ********************************************************Étape 3*******************************************
        /*Étape 3:  Vérifier et soumettre l'ordre créé. Puis consulter et approuver - le statut d'ordre change a ouvert. 
                    Valider la colonne Progression ->la colonne Progression est blanche pour les ordres en statut ouvert. */
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: couverture de Croes-2477 Changement de statut d`un block trade en statut Ouvert");
          
        Log.Message("Sélectionner l'ordre créé");
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
        Get_OrdersBar_BtnView().Click();
        Get_WinOrderDetail_BtnApprove().Click();
        
        Log.Message("Vérifier le changement du statut"); 
        Get_OrderGrid().Find("Value",quantity,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",quantity,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",quantity,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 

        Log.Message("Valider la colonne Progression (ajouté dans la version LU)");
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",quantity,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);
        
        // ********************************************************Étape 4*******************************************
        /*Étape 4: Cliquer sur CFO..  ( Modifier un ordre depuis la version AT). Sélectionner un (ou le ) compte sous-jacent et diminuer sa quantité puis sauvegarder. 
                   La quantité de l’ordre est diminuée mais il garde son statut.* une copie de son original est créée avec le statut modifié.*/
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: couverture de Croes-2485 Changement de statut d`un block trade Action en statut Modifié"); 
                
        Get_OrdersBar_BtnCFO().Click(); 
        
        Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Find("Value",account,10).Click();
        Get_WinOrderDetail_TabUnderlyingAccounts_BtnEdit().Click();
            
        Get_WinEditQuantity_TxtRequestedQuantity().Keys(modifiedQuantity);
        Get_WinEditQuantity_BtnOK().Click();
       
        Log.Message("Verify and submit")
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnVerify().Click();
       
        Log.Message("Check if the status was changed to modified");
        if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", statusModified,10)){
             //Vérifier le changement du statut 
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,statusModified);
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);
         }
         else{
           Log.Error("There is a probleme with the order's status")
         }; 
       
         Log.Message("Check the presence of original order");
         if(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10)){
             //Vérifier le changement du statut 
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).DataContext.DataItem, "Status", cmpEqual,statusOpen);
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,modifiedQuantity);
         }
         else{
           Log.Error("The order with " +modifiedQuantity+ "quantity doesn't exist")
         };
         
        // ********************************************************Étape 5*******************************************
        /*Étape 5: Sélectionner l’ordre original (statat -ouvert, qauntite 33) puis cliquer sur CXL ( annuler un ordre depuis la version AT).
                   L’ordre obtient le statut annulé.*/

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: couverture de Croes-2484 Changement de statut d`un block trade Action en statut Canceled");
                                 
        Log.Message("To cancel an order");
        Get_OrderGrid().RecordListControl.Find("Value", modifiedQuantity,10).Click();
        Get_OrdersBar_BtnCXL().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       
        Log.Message("Check the change of the status");
        if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", statusCancelled,10)){
             //Vérifier le changement du statut 
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,statusCancelled);
             aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,modifiedQuantity);
         }
         else{
           Log.Error("There is a probleme with the order's status")
         } ;  
         
        // ********************************************************Étape 6*******************************************
        /*Étape 6: cliquer sur le bouton Replacer.Dans l`Accumulateur on obtient une copie de l`ordre replacé*/

        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 6: couverture de Croes-2462 GDO_2462_ReplaceCancelledOrder");
        
        Log.Message("JIRA: GDO-2262");         
         if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", statusCancelled,10)){
            Get_OrdersBar_BtnReplace().Click();
            if(Get_OrderAccumulatorGrid().Find("Value",modifiedQuantity,10).Exists){
                  Log.Checkpoint("The order was successfully sent to Accumulateur") 
            } else{
                  Log.Error("The order wasn't sent to Accumulateur")
            }; 
         }
         else{
           Log.Error("There is a probleme with the order's status")
         } ; 
         
        // ********************************************************Étape 7*******************************************
        /* Étape 7: créer un ordre de vente sans saisir  aucun symbole.
                    Double cliquer sur l'ordre créé et valider la case 'tout ou rien' est grisée pour l'ordre en CAD */
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: couverture de Croes-2510 GDO_2510_Checkbox_AllOrNon_WithoutSymbol");
        var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);
        
        DeleteAllOrdersInAccumulator();   
        if(language=="french"){
          var todayDate=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y")
        }
        else{
          var todayDate=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y")
        };  
         
        Log.Message("Creation d'ordre");         
        Get_Toolbar_BtnCreateASellOrder().Click();        
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();     
        Get_WinOrderDetail_BtnSave().Click();
        
        Log.Message("L'anomalie ouverte par Karima CROES-8317")
        Log.Message("Validation");
        Get_OrderAccumulatorGrid().Find("Value",todayDate,10).DblClick();
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual,false);    
        Get_WinOrderDetail().Close();
      
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
 
