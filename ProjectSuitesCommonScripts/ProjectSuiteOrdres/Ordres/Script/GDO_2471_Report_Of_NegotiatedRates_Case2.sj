//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2453_Create_BuyOrder_Stocks
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT DBA

/* Description :Rapport des taux négociés cas 2
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2471

Analyste d'assurance qualité: Reda Alfaiz
Analyste d'automatisation: Youlia Raisper */ 
 
function GDO_2471_Report_Of_NegotiatedRates_Case2()
{
    try{
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");   
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "AccountNo800279RE", language+client);
        var cmbTypesymbol=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinOrderDetailGrpAccountCmbTypePickerSymbol", language+client); 
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TypeForDisplay_2453", language+client);
        var item= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "WinSwitchSourceCmbQuantityUnitsPerAccount", language+client);
        var quantity=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_2470", language+client);
        var securityDescription=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecurityDescription_2471", language+client);
        var statusOpen=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Status_2477", language+client);
        var quantityFillOrder=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityFillOrder_2471", language+client);
        var price=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Price_2471", language+client);
        var market=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Market_2471", language+client);
        var rateOrigin=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "RateOrigin_2471", language+client);
        var exchangeRate=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ExchangeRate_2471", language+client);
        var statusPartialFill=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusPartialFill_2482", language+client);
        var checkExchangeRate= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CheckExchangeRate", language+client);
        
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
        Get_RelationshipsClientsAccountsGrid().Find("Value",account,10).Click();
             
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled", true, 1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
        
        //Creation d'ordre 
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securityDescription);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        if(Get_SubMenus().Exists){  
          Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
        }
        Get_WinOrderDetail_BtnVerify().Click();
        //Soumettre
        Get_WinOrderDetail_BtnVerify().WaitProperty("IsEnabled", true, 5000);
        Get_WinOrderDetail_BtnVerify().Click();
       
        //***************************************************  se connecter avec UNI00  ************************************************
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        Login(vServerOrders, user, psw, language);
        Get_ModulesBar_BtnOrders().Click();
        
         //Choisir l'order créé aujourd’hui   
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.SecurityDesc==securityDescription){
          Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();              
        }
        else {
          Log.Error("L’ordre n’a pas été créé");
        } 
        
        Get_OrdersBar_BtnView().Click();
        Get_WinOrderDetail_BtnApprove().Click();
        
        //Vérifier le changement du statut 
        Get_OrderGrid().Find("Value",securityDescription,10).Click()
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",securityDescription,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",securityDescription,10).DataContext.DataItem, "Status", cmpEqual,statusOpen); 
        
        
        Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();
        Get_OrdersBar_BtnFills().Click();

        Get_WinOrderFills_GrpFills_BtnAdd().Click();                 
        Get_WinAddOrderFill_TxtQuantity().set_Value(quantityFillOrder);
        Get_WinAddOrderFill_TxtClientPrice().Keys(price);
        Get_WinAddOrderFill_CmbMarket().set_Text(market);      
        Get_WinAddOrderFill_BtnOK().Click();            
        
        Get_WinOrderFills_GrpFills_CmbRateOriginForBond().Keys(rateOrigin);
        Get_WinOrderFills_GrpFills_TxtExchangeRateForBond().Keys(exchangeRate);
        if(client!="RJ"){
          Get_WinOrderFills_GrpFills_LblInternalNumberForBond().Keys("qwerty");
        }
        Get_WinOrderFills_BtnSave().Click();
                
        //Vérifier le changement du statut 
        Get_OrderGrid().Find("Value",securityDescription,10).Click();
        var date= aqConvert.DateTimeToFormatStr(Get_OrderGrid().Find("Value",securityDescription,10).DataContext.DataItem.LastUpdateTimestamp,"%m/%d/%y")
        aqObject.CompareProperty(date,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y"));  
        aqObject.CheckProperty(Get_OrderGrid().Find("Value",securityDescription,10).DataContext.DataItem, "Status", cmpEqual,statusPartialFill); 
        
        Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();
        
        
        //Générer le rapport
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();  

        
        //****************************************************************Validation du fichier Excel************************************************************
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\";
        Log.Message(FolderPath);
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
       
        var app, rowNum;
        app = Sys.OleObject("Excel.Application");
        app.Workbooks.Open(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
        var RowCount = app.ActiveSheet.UsedRange.Rows.Count;
        app.Quit();
       
        //Valider que dans le fichier Excel il y a 3 lignes 
        if (RowCount == 2){
         Log.Checkpoint("Le fichier contient 2 lignes. Les entêtes et 1 titres");
        }
        else {
         Log.Error("Le fichier ne contient pas 2 lignes. Les entêtes et 1 titres");
        } 
        
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);       
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier 
        while (! myFile.IsEndOfFile()){    
          countLineInMyFile++;
          line = myFile.ReadLine();
          // Split at each space character.
          var textArr = line.split("	");       
          if (countLineInMyFile == 2){//vérification des entètes
              var textArrUnquote4=aqString.Unquote(VarToString(textArr[4]));
              var textArrUnquote9=aqString.Unquote(VarToString(textArr[9]));
              Log.Message("CROES-8572")
              aqObject.CompareProperty(VarToString(checkExchangeRate),cmpEqual, textArrUnquote4,true,lmError);
              aqObject.CompareProperty(VarToString(checkExchangeRate),cmpEqual, textArrUnquote9,true,lmError);
          }
        }  
        // Closes the file
        myFile.Close();      
        
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      TerminateExcelProcess(); //fermer les fichiers excel
      Terminate_CroesusProcess(); //Fermer Croesus
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
      Runner.Stop(true); 
    }
}
