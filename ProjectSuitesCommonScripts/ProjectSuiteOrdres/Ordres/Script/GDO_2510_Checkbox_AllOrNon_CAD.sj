//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks

/* Description ::Vérifier la case "Tout ou rien" pour les titres CAD
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2510
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2510_Checkbox_AllOrNon_CAD()
 {             
    try{  

        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolNA_2514", language+client);   
        var descSecurityNA_2514=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descSecurityNA_2514", language+client);      
        var symbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client);   
                
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        
        //Creation d'ordre 
        //SelectItemInCmb(symbol)
        CreateEditStocksOrder("","",descSecurityNA_2514)
        Log.Message("L'anomalie ouverte par Karima CROES-8317")
        //Validation
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DataContext.DataItem , "OrderSymbol", cmpEqual,securitySymbol);
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick();
        aqObject.CheckProperty(Get_WinStocksOrderDetail_ChkAllOrNone(), "IsEnabled", cmpEqual,false);    
        Get_WinOrderDetail().Close();
      
        //Remettre les données 
        if(Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Exists){
           Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Click();
           Get_OrderAccumulator_BtnDelete().Click();
           Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
       } 
                     
        Close_Croesus_MenuBar();         
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        
        if(Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Exists){
          Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Click();
          Get_OrderAccumulator_BtnDelete().Click();
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }  
         
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Runner.Stop(true); 
    }
 }
 
 function SelectItemInCmb(item)
 {
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().set_IsDropDownOpen(true);
    var count=Aliases.CroesusApp.subMenus.DataContext.Fields.Count
    for(var i=1;i<count;i++){
    Log.Message(VarToString(Aliases.CroesusApp.subMenus.DataContext.Fields.Item(i).ShortDefinition))
      if(VarToString(Aliases.CroesusApp.subMenus.DataContext.Fields.Item(i).ShortDefinition)==VarToString(item)){
         Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "",i+1).Click();
         break;
       }
    }    
 } 