//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_2473_Report_Of_FidessRates_Case1
//USEUNIT GDO_2477_ChangeStatus_Of_TradeBlock_Open
//USEUNIT DBA 

/* Description :Rapport des ordres Fidessa cas 3
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2475
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
 function GDO_2475_Report_Of_FidessRates_Case3()
 {             
    try{ 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityStocks_2453", language+client);       
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Message_2471", language+client);
        var security= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2471", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo_2453", language+client);
        var status=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2517", language+client);
        
        var securitySymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2473", language+client);
        var securitySymbol1=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_2471", language+client);        
        var securitySymbol2=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolB03774_2475", language+client);
        var securitySymbol3=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolMMM_2475", language+client);
        var securitySymbol4=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolFID224_2475", language+client);
        var securitySymbol5=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolAGF110C_2475", language+client);
        var securitySymbol6=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbolLLL_2475", language+client);
        
        if(language=="french"){
          var today="%Y/%m/%d"
        } else{
          var today="%m/%d/%Y"
        } 
        
        //fermer les fichiers excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
        
        //*********************************************Ajout d'ordre de statut ouvert************************************************ 
        ChangeStatus_Of_TradeBlock_Open();
        
        //********************************************Ajout d'ordre de statut en approbation ****************************************
        Get_Toolbar_BtnCreateABuyOrder().Click();        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateEditStocksOrder(account,quantity,security)
        
        //Sélectionner l'ordre créé
        Get_OrderAccumulatorGrid().Find("Value",account,10).Click();
        Get_OrderAccumulator_BtnEdit().Click();         
        //Verifier
        Get_WinOrderDetail_BtnVerify().Click();
        //Submit
        Get_WinOrderDetail_BtnVerify().Click();
        
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",security,10).DataContext.DataItem, "Status", cmpEqual,status); 
        
        
        //Sélectionner à la fois les ordres de tous les statuts possibles
        Get_OrderGrid().Find("Value",securitySymbol,10).Click();
        Get_OrderGrid().Find("Value",securitySymbol1,10).Click(10,10,skCtrl);
        Get_OrderGrid().Find("Value",securitySymbol2,10).Click(10,10,skCtrl);
        Get_OrderGrid().Find("Value",securitySymbol3,10).Click(10,10,skCtrl);
        Get_OrderGrid().Find("Value",securitySymbol4,10).Click(10,10,skCtrl);
        Get_OrderGrid().Find("Value",securitySymbol5,10).Click(10,10,skCtrl);
        Get_OrderGrid().Find("Value",securitySymbol6,10).Click(10,10,skCtrl);
        
         //Générer le rapport   
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_FidessaOrderReport().Click();
        
        //Valider le message 
        aqObject.CheckProperty(Get_DlgConfirmation(), "CommentTag", cmpEqual, message); 
        
        //cliquer sur NO
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(2/3), Get_DlgConfirmation().get_ActualHeight()-45);
        
        //Vérifier que le fichier Excel généré 
        if(Sys.waitProcess("EXCEL").Exists){
          Log.Error("Le fichier Excel est ouvert")
        } 
        else{
          Log.Checkpoint("Le fichier Excel n'est pas ouvert")
        } 
        
        //Vérifier que le statut est toujours 'ouvert'
        Get_OrderGrid().Find("Value",securitySymbol,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",securitySymbol,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",securitySymbol,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 
     
        Close_Croesus_MenuBar();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); //CP : Modifié pour CO
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
      Runner.Stop(true); 
    }
 }