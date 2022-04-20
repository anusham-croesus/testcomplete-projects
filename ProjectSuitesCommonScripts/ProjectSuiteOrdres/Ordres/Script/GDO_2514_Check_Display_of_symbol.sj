//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables


/* Description :Vérifier l'affichage du symbole pour certains titres
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2514
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2514_Check_Display_of_symbol()
 {             
    try{  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolNA_2514", language+client);        
        var typeForDisplay=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2455", language+client);
        var descSecurityNA_2514=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descSecurityNA_2514", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FinancialInstrumentStocks_2453", language+client);
            
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnSecurities().Click();
        
        Search_SecurityBySymbol(securitySymbol);
        
        Get_SecurityGrid().Find("Value",securitySymbol,10).Click();
        Drag(Get_SecurityGrid().Find("Value",securitySymbol,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Portfolio_PositionsGrid().Find("Value",securitySymbol,10).Click();
        Get_Toolbar_BtnCreateASellOrder().Click();
        
        //Récupérer les données de la fenêtre affichée
        var account = Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Text
        var quantity = Get_WinStocksOrderDetail_TxtQuantity().Text
        var security = Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Text
        Get_WinOrderDetail_BtnSave().Click();
        
        //Validation d'ordre créé 
        var checkPoint = CheckPresenceOrderInAccumulator(VarToString(account),VarToString(quantity),VarToString(descSecurityNA_2514),financialInstrument,typeForDisplay)
        
        var orderSymbol= Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DataContext.DataItem.OrderSymbol
        Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).DblClick()
              
        //validation du symbol
        aqObject.CheckProperty( Get_WinOrderDetail_GrpSecurity_TxtSymbol(), "Text", cmpContains,orderSymbol)
        Get_WinOrderDetail_BtnCancel().Click();
        
        //Remettre les données 
        if(checkPoint==true){
               
            Get_OrderAccumulatorGrid().Find("Value",securitySymbol,10).Click();
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
        else{
          Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        }
                     
        Close_Croesus_MenuBar();         
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
       if(checkPoint==true){               
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