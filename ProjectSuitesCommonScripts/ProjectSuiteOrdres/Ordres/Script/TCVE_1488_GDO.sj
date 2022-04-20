//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
 
/* Description :Ajout d`un ordre d'achat
Regrouper les scripts suivants:

GDO_2517_Submission_of_MutualFundOrde_TotallySold()
GDO_2518_Split_MutualFundsBlock_WithMultipleUnderlyingAccounts()
GDO_2514_Check_Display_of_symbol
GDO_2464_Split_Of_BlockTrade
GDO_2465_Split_Of_BlockTrade
 
Analyste d'automatisation: Youlia Raisper
La version du scriptage: ref90-17-2020-07-63 */ 

function TCVE_1488_GDO()
{
    var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10, logEtape11, logEtape12, logEtape13, logEtape14, logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-1488");
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");                
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2461", language+client);        
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2517", language+client);
        var itemQuantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItemQuantity_2517", language+client);
        var typeOrder = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2455", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_2517", language+client);
        var quantity100=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantiteTransactionVente", language+client);
        var securityDescription =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2461", language+client);
        var count=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersCount_2518", language+client);
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800251GT", language+client);
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800251RE", language+client);
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800257RE", language+client);
        var itemCount=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItenCountGrid_2464", language+client);
        
        
        // ********************************************************Étape 1*******************************************
        logEtape1 = Log.AppendFolder("Étape 1: Accéder au module Titres");
        
        Log.Message("Login");
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked",true,1500);       
        
        // ********************************************************Étape 2*******************************************
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Sélectionner le titre FID224 et mailler vers portefeuille");
         
        Log.Message("Sélectionner le titre FID224")      
        Search_SecurityBySymbol(securitySymbol);        
        Get_SecurityGrid().Find("Value",securitySymbol,10).Click();
        
        Log.Message("mailler vers portefeuille")  
        Drag(Get_SecurityGrid().Find("Value",securitySymbol,10), Get_ModulesBar_BtnPortfolio());
           
        // ********************************************************Étape 3*******************************************
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner une position et cliquer sur l`icône Créer un ordre de vente");
        
        Get_Portfolio_PositionsGrid().Find("Value",account,10).Click();
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        // ********************************************************Étape 4*******************************************
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Sélectionner Tout (pour le type de quantité) puis vérifier et soumettre");
        
        Get_WinMutualFundsOrderDetail_CmbQuantityType().Click();
        Aliases.CroesusApp.subMenus.Find("WPFControlText",itemQuantity,10).Click();
        Get_WinOrderDetail_BtnSave().Click();
        
        Log.Message("Couverture de Croes-2514 GDO_2514_Check_Display_of_symbol")
        var orderSymbol= Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DataContext.DataItem.SecurityDesc
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        
        Log.Message("validation du symbol");
        aqObject.CheckProperty(Get_WinOrderDetail_GrpSecurity_TxtSymbol(), "Text", cmpContains,orderSymbol)
        Get_WinOrderDetail_BtnCancel().Click();
                
        Log.Message("vérifier");
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        Get_WinOrderDetail_BtnVerify().Click();
        Log.Message("soumettre");
        Get_WinOrderDetail_BtnVerify().Click();
        
        Log.Message("vérifier que l'ordre passe dans le Blotter et obtient le statut 'En approbation (négociateur)'")
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "TypeForDisplay", cmpEqual,typeOrder);    
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "Status", cmpEqual,status);  
        aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);
        
        // ********************************************************Étape 5*******************************************
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Accéder au module Portefeuille / Sélectionner toutes les positions et cliquer sur 'Ordres multiples, en bloc et échange'");
         
        Get_ModulesBar_BtnPortfolio().Click();
        Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked",true,1500); 
        
        Log.Message("Sélectionner toutes les positions et cliquer sur 'Ordres multiples")
        Get_Portfolio_PositionsGrid().Keys("^a");   
        Get_Toolbar_BtnSwitchBlock().Click(); 
        
        
        //Adaptation des scripts GDO suite au retrait de la story GDO-1675
        //Ajout d'une transaction(s):Vente  
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantity100)
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbol);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        Get_WinSwitchSource_btnOK().Click();
        
        // ********************************************************Étape 6*******************************************
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Valider que l'ordre généré dans l'accumulateur");
        
        Log.Message("Automatiquement une position de Vente de 100% de la position détenue - Symbole FID224 doit être affichée dans la section Transaction(S): Vente Aperçu/Générer.")
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securitySymbol,10).DataContext.DataItem, "DisplayQuantity", cmpEqual,quantity100);
        
        Log.Message("Aperçu");
        Get_WinSwitchBlock_BtnPreview().Click();
        Log.Message("Générer");
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 1500)
        Get_WinSwitchBlock_BtnGenerate().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_66bd");
        
        Log.Message("Ordre généré dans l'accumulateur");
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        
        // ********************************************************Étape 7*******************************************
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Diviser l'ordre");
        
        Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).Click();        
        Get_OrderAccumulator_BtnSplit().Click();
        Get_WinSplitBlock_DgvAccounts().Find("Value",account1,10).Click();
        Get_WinSplitBlock_BtnCreateBlock().Click();
        
        // ********************************************************Étape 8*******************************************
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 7: Validation de division");

        Log.Message("Valider qu'on a deux blocs : 1) contient 1 compte 2) contient 2 comptes");       
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items, "Count", cmpEqual,itemCount);
        if(count==itemCount){

            Log.Message("Verification de comptes  sous-jacents dans bloc 1");
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            for(var i=0; i< count;i++){           
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(i).DataItem, "AccountNumber", cmpEqual,account1);              
            } 
           Get_WinOrderDetail().Close();
                       
            Log.Message("Verification de comptes  sous-jacents dans bloc 2");
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 2).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            if(count==itemCount){    
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(0).DataItem, "AccountNumber", cmpEqual,account2);  
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(1).DataItem, "AccountNumber", cmpEqual,account3);             
            } 
            else{
              Log.Error("Le nombre de comptes n’est pas correct")
            } 
            Get_WinOrderDetail().Close();          
        }
        else{
          Log.Error("Le bloc n’a pas été ajouté")
        };
        
        // ********************************************************Étape 9*******************************************
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Croes-2465 GDO_2465_Split_Of_BlockTrade");
        
        GDO_2465_Split_Of_BlockTrade();  
        
        Log.Message("Fermer Croesus");
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
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
    }
}


function GDO_2465_Split_Of_BlockTrade()
 {              
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800066FS", language+client);   
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800002OB", language+client); 
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800049OB", language+client);   
        var account4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800002NA", language+client);
        var quantity= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2464", language+client); 
        var itemQuantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItemQuantity_2465", language+client); 
        var item= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var securityDescription= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescMMM_2464", language+client);
        var securitySymbol= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolMMM_2464", language+client);
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        var itemCount=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItenCountGrid_2464", language+client); 
        var currencyUSD= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CurrencyUSD_2465", language+client); 
        var currencyCAD= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CurrencyCAD_2465", language+client); 
        var arrayOfAccountsNo = new Array(account1,account2,account3,account4)
            
        Log.Message("Valider que Accamulator est vide"); 
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator()
        
        Get_ModulesBar_BtnAccounts().Click();        
        SelectAccounts(arrayOfAccountsNo)       
        Get_Toolbar_BtnSwitchBlock().Click();
        
        Log.Message("Ajout d'une transaction(s):Vente");        
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WinSwitchBlockCmbDescription(); 
        Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
        Aliases.CroesusApp.subMenus.Find("WPFControlText",item,10).Click();
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]"); 
        SetAutoTimeOut();
        if(Get_SubMenus().Exists){        
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
        }   
        RestoreAutoTimeOut();      
        Get_WinSwitchSource_btnOK().Click();
            
        Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
        Get_WinSwitchBlock_BtnGenerate().Click(); 
        
        SetAutoTimeOut();
        if(Get_DlgConfirmation().Exists){
          Get_DlgConfirmation_BtnYes().Click();
        };          
        RestoreAutoTimeOut();  
        
        Log.Message("Valider la creation dans accumulator ");
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "Quantity", cmpEqual,quantity*4);       
        
        Log.Message("Split");     
        Get_OrderAccumulator_BtnSplit().Click();
        var  countAccounts = Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Count
        for(var i=0; i<countAccounts; i++){          
           if(VarToString(Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountCurrency)==VarToString(currencyUSD)){
             Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsSelected(true);
             Get_WinSplitBlock_DgvAccounts().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i+1).set_IsActive(true);
           } 
        } 
                      
        Get_WinSplitBlock_BtnCreateBlock().Click();
        
        //********************************************************************Validations****************************************************************************
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items, "Count", cmpEqual,itemCount);
        if(count==itemCount){
          
            Log.Message("Verification de comptes  sous-jacents du bloc 1 -la devise devrait être en USD ");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,itemQuantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);                     
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            for(var i=0; i< count;i++){           
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(i).DataItem, "AccountCurrency", cmpEqual,currencyUSD);              
            } 
            Get_WinOrderDetail().Close();
            
            Log.Message("Verification de comptes  sous-jacents du bloc 2 la devise devrait être en CAD ");
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "DisplayQuantityStr", cmpEqual,itemQuantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,securitySymbol);                  
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 2).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            for(var i=0; i< count;i++){           
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(i).DataItem, "AccountCurrency", cmpEqual,currencyCAD);              
            } 
            Get_WinOrderDetail().Close();          
        }
        else{
          Log.Error("Le bloc n’a pas été ajouté")
        } 
        
 }
 
