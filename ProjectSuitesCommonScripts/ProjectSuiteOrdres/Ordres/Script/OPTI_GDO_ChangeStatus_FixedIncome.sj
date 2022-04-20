//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2453_Create_BuyOrder_FixedIncome
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade

/* Description :Statut Partiel pour un ordre d`obligation
Regrouper les scripts suivants:

GDO_2453_Create_SellOrder_FixedIncome
GDO_2482_PartialStatus_for_FixedIncome
GDO_2483_ChangeStatus_Of_TradeBlock_Executed
GDO_3125_ChangeStatus_Of_ObligationTradeBlock_Canceled

Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-19-2020-09-36 */ 
 
 function OPTI_GDO_ChangeStatus_FixedIncome()
 {  
    var logEtape1, logEtape2, logEtape3, logEtape4, logRetourEtatInitial;           
    try{ 
      
        // ********************************************************Étape 1*******************************************
        /*Étape 1: accéder au module Ordres. créer un ordre de vente FixedIncome - Compte: 800001-NA
                   Quantité: 202
                   Titre: PROV T-NEUV   8.45% 5FB26 */ 
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: couverture de Croes-2453 GDO_2453_Create_SellOrder_FixedIncome"); 
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");        
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2482", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityFixedIncome_2482", language+client);
        var securitySymbol= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolFixedIncome_2482", language+client);                
        var quantityFillOrder=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFillOrder_2482", language+client);
        var price=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Price_2482", language+client);
        var indexationFactor=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "IndexationFactor_2482", language+client);
        var yieldANN=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldANN_2482", language+client);
        var yieldSA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "YieldSA_2482", language+client);
        var inventoryCode=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", " InventoryCode_2482", language+client);
        var statusPartialFill= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusPartialFill_2482", language+client); 
        var TypeColorToolTip=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2482", language+client);
        var fillStatus=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "fillStatus_2482", language+client);
        var StatusExecuted= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusExecuted_2483", language+client);
        var TypeColorToolTip2483=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeColorToolTip_2483", language+client);
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var statusCancelled=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusCancelled_2484", language+client); 
        var statusTraderApproval=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "statusTraderApproval", language+client);
    
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
      
        Get_MainWindow().Maximize();
        Log.Message("Creat a FixedIncome order  ");  
        Get_Toolbar_BtnCreateASellOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoFixedIncome().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        //***Emna IHM: Remplacé par la recherche par symbol/security car La recherche par description ne fonctionne pas correctement, 
        //***C'est peut être lié au bug de la recherche par description détecté dernièrement (Pour plus de détails Voir le fichier d'analyse ref90-28-2021-12-49)
        //Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        //Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinFixedIncomeOrderDetail_TxtQuantity().Keys(quantity);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securitySymbol);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        SetAutoTimeOut();
        if(Get_SubMenus().Exists){  
          Aliases.CroesusApp.subMenus.Find("Value",security,10).DblClick();
        }
        RestoreAutoTimeOut(); 
        Get_WinOrderDetail_BtnSave().WaitProperty("IsEnabled",true,30000);
        Get_WinOrderDetail_BtnSave().Click();
        
        Log.Message("Check if the order was created");
        if(Get_OrderAccumulatorGrid().Find("Value",quantity,10).Exists){
           Log.Checkpoint("The order was successfully created in Accumulateur") 
       }  else{
          Log.Error("The order wasn't created in Accumulateur")
        };
        
        // ********************************************************Étape 2*******************************************
        /*Étape 2:  Sélectionner l`ordre dans le Blotter. Sélectionner l`ordre puis cliquer sur CXL ( Annuler un ordre ordre depeuis la version AT)
                    L`ordre obtient le statut Annulé*/ 
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: couverture de Croes-3125 GDO_3125_ChangeStatus_Of_ObligationTradeBlock_Canceled");
        
        Log.Message("Verifieret puis sumettre");        
        Get_OrderAccumulatorGrid().Find("Value",quantity,10).DblClick();
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnVerify().Click();
        Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
        Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
        
          
        if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem.Status==statusTraderApproval){
              Log.Message("cancel un order")
              Get_OrdersBar_BtnCXL().Click();                     
              Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
              Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Click(); 
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,statusCancelled);
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);  
              aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity); 
                   
         }
         else{
           Log.Error("There is a probleme with the order's status. The stats should be "+statusTraderApproval)
         }; 
        
        // ********************************************************Étape 3*******************************************
        /*Étape 3: cliquer sur le bouton Replacer. Sélectionner l`ordre dans l`Accumulateur. Sélectionner l`ordre dans le blotter puis Consulter
                   Cliquer sur Approuver et puis Ajouter.
                   Remplir les champs(quantité=101, prix =65, Facteur = 1.111111111111, rendement 2 et 3, code = AB)
                   L`ordre obtient le statut partiel
                   Valider la colonne Progression et passe le curseur sur la colonne
                   La colonne Progression est colorée bleue à moitié.
                   Quand le curseur passe sur la colonne est affichée le libellé: 50% exécuté    */ 
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: couverture de Croes-2482 GDO_2482_PartialStatus_for_FixedIncome"); 
        
        if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem.Status==statusCancelled){
            Get_OrdersBar_BtnReplace().Click();
            if(Get_OrderAccumulatorGrid().Find("Value",quantity,10).Exists){
                  Log.Checkpoint("The order was successfully sent to Accumulateur");                  
                  Log.Message("Verifieret puis sumettre");
                  Get_OrderAccumulatorGrid().Find("Value",quantity,10).DblClick();
                  Get_WinOrderDetail_BtnVerify().Click();
                  Get_WinOrderDetail_BtnVerify().Click();
                  Get_OrderGrid().RecordListControl.Items.Item(0).set_IsSelected(true);
                  Get_OrderGrid().RecordListControl.Items.Item(0).set_IsActive(true);
                    
                  if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem.Status==statusTraderApproval){
        
                     Get_OrdersBar_BtnView().Click();
                     Get_WinOrderDetail_BtnApprove().Click();
                     Get_WinOrderFills_GrpFills_BtnAdd().Click();                     
                     Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFillOrder);
                     Get_WinAddOrderFill_TxtClientPrice().Keys(price);
                     Get_WinAddOrderFill_TxtIAPrice().Keys(price);
                     Get_WinAddOrderFill_TxtIndexationFactor().set_Value(indexationFactor);
                     Get_WinAddOrderFill_TxtYieldANN().set_Value(yieldANN);
                     Get_WinAddOrderFill_TxtYieldSA().set_Value(yieldSA);
                     Get_WinAddOrderFill_CmbInvetoryCode().set_Text(inventoryCode);        
                     Get_WinAddOrderFill_BtnOK().Click();           
                     Get_WinOrderFills_BtnSave().Click();    
           
                     Log.Message("Vérifier le changement du statut"); 
                     Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Click()
 
                     aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,statusPartialFill); 
                     aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "SecurityDesc", cmpEqual,security); 
                     Log.Message("La colonne Progression est 50% exécuté")
                     aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip);
                     aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,fillStatus); 
               
                  } 
                  else{
                    Log.Error("There is a probleme with the order's status. The status should be "+statusTraderApproval)
                  }; 
                                                           
            } else{
                  Log.Error("The order wasn't sent to Accumulateur")
            }; 
         }
         else{
           Log.Error("There is a probleme with the order's status. The status should be "+statusCancelled)
         } ;
          
        // ********************************************************Étape 4*******************************************
        /*Étape 4: Ajouter des exécutions jusqu`à ce que la quantité restante du block trade soit égale à zéro(0)     
                   Cliquer sur Modifier, Vérifier puis Soumettre 
                   l`ordre tombe à exécuté 
                   Vérifier la colonne Progression  (ajoutée dans la version LU)
                   La colonne Progression est colorée au complet (bleue pour les achat et rose pour les ventes)*/ 
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: couverture de Croes-2483 GDO_2483_ChangeStatus_Of_TradeBlock_Executed");
        Get_OrdersBar_BtnFills().Click();
                  
        Get_WinOrderFills_GrpFills_BtnAdd().Click();                     
        Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFillOrder);
        Get_WinAddOrderFill_TxtClientPrice().Keys(price);
        Get_WinAddOrderFill_TxtIAPrice().Keys(price);
        Get_WinAddOrderFill_TxtIndexationFactor().set_Value(indexationFactor);
        Get_WinAddOrderFill_TxtYieldANN().set_Value(yieldANN);
        Get_WinAddOrderFill_TxtYieldSA().set_Value(yieldSA);
        Get_WinAddOrderFill_CmbInvetoryCode().set_Text(inventoryCode);        
        Get_WinAddOrderFill_BtnOK().Click();           
        Get_WinOrderFills_BtnSave().Click();    
                   
        Log.Message("Vérifier le changement du statut");       
        if(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).Find("Text", StatusExecuted,10)){
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "Status", cmpEqual,StatusExecuted);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "SecurityDesc", cmpEqual,security);
            Log.Message("Vérifier la colonne Progression  (ajoutée dans la version LU)");  
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual,quantity);  
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Find("IsActive", true,10).DataContext.DataItem, "TypeColorToolTip", cmpEqual,TypeColorToolTip2483);          
         }
         else{
           Log.Error("There is a probleme with the order's status. The status should be "+StatusExecuted)
         }; 
                   
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
 
 