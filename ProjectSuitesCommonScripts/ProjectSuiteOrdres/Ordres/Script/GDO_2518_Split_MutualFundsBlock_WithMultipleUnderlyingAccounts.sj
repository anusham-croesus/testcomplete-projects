//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2456_FundReport

/* Description :Diviser un bloc de fonds mutuel détenant plusieurs comptes sous-jacents
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2518
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2518_Split_MutualFundsBlock_WithMultipleUnderlyingAccounts()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2461", language+client);
        var securityDescription =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2461", language+client);
        var security=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Security_2461", language+client);    
        var quantity =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2464", language+client);
        var count=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersCount_2518", language+client);
        var account1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800251GT", language+client);
        var account2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800251RE", language+client);
        var account3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchBlockDgvOrdersAccount_800257RE", language+client);
        var itemCount=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ItenCountGrid_2464", language+client);
         
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        
        //Rechercher un titre 
        Search_Security(security);
        
        Get_SecurityGrid().Find("Value",security,10).Click();
        Drag(Get_SecurityGrid().Find("Value",security,10), Get_ModulesBar_BtnAccounts())
        
        //Selectioner tous 
        Get_RelationshipsClientsAccountsDetails().Keys("^a");   
        Get_Toolbar_BtnSwitchBlock().Click(); 
        
        aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).DataContext, "FilterDescription", cmpContains, security);
        
        //Ajout d'une transaction(s):Vente        
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WinSwitchBlockCmbDescription();
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");   
        if(Get_SubMenus().Exists){      
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();  
        }       
        Get_WinSwitchSource_btnOK().Click()
        
        //Valider que une ventre a été ajouteé  
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "DisplayQuantity", cmpContains,quantity);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SymbolDisplay", cmpContains,securitySymbol);
        aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions_DgvTransactions().Find("Value",securityDescription,10).DataContext.DataItem, "SecurityDisplay", cmpContains,securityDescription);

        Get_WinSwitchBlock_BtnPreview().Click();  
        
        //Valider la présence des comptes dans la grille Order de la fenêtre Échange/Bloc          
        if(Get_WinSwitchBlock_DgvOrders().Items.Count==count){        
            if(CheckAccountPresence(account1)&& CheckAccountPresence(account2) && CheckAccountPresence(account3)){
              Log.Message("Les comptes sont présents")
            } 
            else{
              Log.Message("Les comptes ne sont pas présents")
            }           
        } 
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 1500)
        Get_WinSwitchBlock_BtnGenerate().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_66bd");
        
        //Validation que le bloc a été créé    
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "SecurityDesc", cmpEqual,securityDescription);
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).DataContext.DataItem, "OrderSymbol", cmpEqual,securitySymbol);
        
        //Split
        Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securitySymbol,10).Click();        
        Get_OrderAccumulator_BtnSplit().Click();
        Get_WinSplitBlock_DgvAccounts().Find("Value",account1,10).Click();
        Get_WinSplitBlock_BtnCreateBlock().Click();
        
        //********************************************************************Validations****************************************************************************
        //On devrait avoir deux blocs : 1) contient 1 compte 2) contient 2 comptes       
        var count=Get_OrderAccumulatorGrid().RecordListControl.Items.Count
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items, "Count", cmpEqual,itemCount);
        if(count==itemCount){

            //Verification de comptes  sous-jacents dans bloc 1
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", 1).DblClick();            
            var count=Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Count
            for(var i=0; i< count;i++){           
              aqObject.CheckProperty( Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().Items.Item(i).DataItem, "AccountNumber", cmpEqual,account1);              
            } 
           Get_WinOrderDetail().Close();
                       
             //Verification de comptes  sous-jacents dans bloc 2
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
        } 
        
        //Remettre les données      
        DeleteAllOrdersInAccumulator() 
        //Fermer Croesus   
        Close_Croesus_MenuBar();         
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
         
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }
 
 function CheckAccountPresence(account){
   var count=Get_WinSwitchBlock_DgvOrders().Items.Count
   var found=false;
   for(var i=0; i<count; i++){
      if(Get_WinSwitchBlock_DgvOrders().Items.Item(i).DataItem.AccountNumber==account){
        return found=true;
      } 
   }
 } 