//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2456_FundReport


/* Description :Split d`un bloc trade cas 1
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2465
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2465_Split_Of_BlockTrade()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
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
        
        Login(vServerOrders, user , psw ,language);        
        //Valider que Accamulator est vide 
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator()
        
        Get_ModulesBar_BtnAccounts().Click();        
        SelectAccounts(arrayOfAccountsNo)       
        Get_Toolbar_BtnSwitchBlock().Click();
        
        //Ajout d'une transaction(s):Vente        
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
        
        //Validation
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "Quantity", cmpEqual,quantity*4);       
             
        Get_OrderAccumulator_BtnSplit().Click();
        
        //Split
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
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,itemQuantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
            
            //Verification de comptes  sous-jacents
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            for(var i=0; i< count;i++){           
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(i).DataItem, "AccountCurrency", cmpEqual,currencyUSD);              
            } 
           Get_WinOrderDetail().Close();
            
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "DisplayQuantityStr", cmpEqual,itemQuantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,securitySymbol); 
            
             //Verification de comptes  sous-jacents
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
        
        DeleteAllOrdersInAccumulator() 
                    
        Close_Croesus_MenuBar();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
      Login(vServerOrders, user , psw ,language);
      Get_ModulesBar_BtnOrders().Click(); 
      DeleteAllOrdersInAccumulator(); 
      Terminate_CroesusProcess(); //Fermer Croesus     
    }
 }


