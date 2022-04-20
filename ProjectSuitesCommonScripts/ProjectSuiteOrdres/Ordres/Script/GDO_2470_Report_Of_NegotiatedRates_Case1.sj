//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT DBA

/* Description :Rapport des taux négociés cas 1
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2470
 
Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
function GDO_2470_Report_Of_NegotiatedRates_Case1()
{
    try{ 
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");   
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800242GT", language+client);
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var item= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2470", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2470", language+client);
        
        if (language == "french"){
          var today = "%Y/%m/%d";
        } else {
          var today = "%m/%d/%Y";
        }
        
        Activate_Inactivate_Pref("UNI00","PREF_GDO_FX_REPORT_FILTER","1",vServerOrders);
        RestartServices(vServerOrders);
        
        Login(vServerOrders, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click();
        
        Search_Account(account);
        Get_Toolbar_BtnCreateABuyOrder().Click();        
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateEditStocksOrder("", quantity, securityDescription);
       
        //Sélectionner le bloc dans l’accumulateur 
        Get_OrderAccumulatorGrid().RecordListControl.Find("Value",securityDescription,10).Click();
        Get_OrderAccumulator_BtnVerify().Click();
         if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
          Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        //Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).set_IsChecked(true)
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
            
        //***********************************************  se connecter avec UNI00 ********************************************************
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");  
        Login(vServerOrders, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();
        
         //Choisir l'order créé aujourd’hui   
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.SecurityDesc == securityDescription){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();              
        }
        else{
          Log.Error("L’ordre n’a pas été créé");
        } 
        
        //Générer le rapport
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();  
        
         //fermer les fichiers Excel
        TerminateExcelProcess();
        
        //Validation du fichier Excel 
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath = sTempFolder+"\CroesusTemp\\";
        Log.Message(FolderPath);
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
                
        var app, rowNum;
        app = Sys.OleObject("Excel.Application");
        app.Workbooks.Open(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
        var RowCount = app.ActiveSheet.UsedRange.Rows.Count;
         
        if (RowCount == 1){
           Log.Checkpoint("Le fichier contient une seule ligne");
        } 
        else {
           Log.Error("Le fichier ne contient pas une seule ligne");
        } 
        
        app.Quit();
        
        Close_Croesus_MenuBar();
          
    }
    catch(e) {    
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Login(vServerOrders, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator();
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
      TerminateExcelProcess();
      Runner.Stop(true); 
    }
}