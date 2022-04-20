//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2456_FundReport

/* Description :Split d`un bloc trade cas 1
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2494
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2464_Split_Of_BlockTrade()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800066FS", language+client);   
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800002OB", language+client); 
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_800049OB", language+client);   
        var account4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800002NA", language+client); 
        var quantity= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2464", language+client); 
        var itemQuantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItemQuantity_2464", language+client); 
        var item= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var securityDescription= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescMMM_2464", language+client);
        var securitySymbol= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolMMM_2464", language+client);
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        var itemCount=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItenCountGrid_2464", language+client); 
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
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "Quantity", cmpEqual,itemQuantity);
        
        //Split
        Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).Click();        
        Get_OrderAccumulator_BtnSplit().Click();
                      
        Get_WinSplitBlock_DgvAccounts().Find("Value",arrayOfAccountsNo[0],10).Click();
        Get_WinSplitBlock_BtnCreateBlock().Click();
        
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items, "Count", cmpEqual,itemCount);
        if(count==itemCount){
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,quantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol); 
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "DisplayQuantityStr", cmpEqual,itemQuantity-quantity);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,securitySymbol);           
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
  
 
 function DeleteAllOrdersInAccumulator()
{   
    var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
    if(count>0){
    
//       for (var i = 0; i < count; i++){
//          Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
//       } 
       
      Get_OrderAccumulatorGrid().RecordListControl.Keys("^a"); 
      Get_OrderAccumulator_BtnDelete().Click();
      Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    }   
}

