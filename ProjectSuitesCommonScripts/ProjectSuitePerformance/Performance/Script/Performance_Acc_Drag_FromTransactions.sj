//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Acc_Drag_FromTransactions(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_Drag_FromTransactions";
//        var posTransaction = GetData(filePath_Performance, sheetName_DataBD, 22, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var account        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client); 
        var posTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransaction20", language+client);
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

    
        Get_ModulesBar_BtnAccounts().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().WaitProperty("IsVisible", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

        // Attend le module Transactions présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
        Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);

        // Clique le module Transactions
        Get_ModulesBar_BtnTransactions().Click(); 
        WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"]);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], 10).WaitProperty("VisibleOnScreen", true, 15000);

        
        //if (DataType == "Position"){
            //********************************** position ***************************
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).Click();
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10).WaitProperty("IsSelected", true, 15000);
        
            // Maillage un transactions au module comptes
            StopWatchObj.Start();
            Drag(Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", posTransaction], 10), Get_ModulesBar_BtnAccounts());
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1],waitTimeShort);
            StopWatchObj.Stop();
            //***********************************************************************
        /*} else if (DataType == "Data"){
            //********************************* Data ********************************
            // Recherche de transactions
            Search_Transactions_Account(account);
            WaitObject(Get_Transactions_ListView(), ["ClrClassName", "WPFControlOrdinalNo"], ["BrowserCellTemplateSimple", "2"]);
            WaitObject(Get_CroesusApp(), ["ClrClassName", "Text"], ["BrowserCellTemplateSimple", account]);
            Get_Transactions_ListView().Find("Text",account,100).WaitProperty("IsVisible", true, 15000);
            Get_Transactions_ListView().Find("Text",account,100).Click(); 
            Get_Transactions_ListView().Find("Text",account,100).WaitProperty("IsLoaded", true, 15000);
    
            // Maillage un transactions au module comptes
            StopWatchObj.Start();
            Drag(Get_Transactions_ListView().Find("Text",account,1000), Get_ModulesBar_BtnAccounts());
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            StopWatchObj.Stop();
            //***********************************************************************
        }*/
        
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}