//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Por_ChangeCurrency() {

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Por_ChangeCurrency";
//        var posAccount = GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var currency = GetData(filePath_Performance, sheetName_DataBD, 6, language);
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var account       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client);
        var posAccount    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionAccount6", language+client);
        var currency      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CurrencyUS", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);         
   
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);


        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"]);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
//        if (DataType == "Position"){
//            //********************************** position ***************************
//            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
//  
//            // Maillage un client au module portefeuille
//            Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10), Get_ModulesBar_BtnPortfolio());
//            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
//            Get_Portfolio_PositionsGrid().WaitProperty("VisibleOnScreen", true, 15000);
//            //***********************************************************************
//        } else if (DataType == "Data"){
        
            //********************************** Data *******************************
            // Recherche de comptes
            Search_Account(account);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
  
            // Maillage un client au module portefeuille
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4");
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            //***********************************************************************
//        }
        
        // Vérifie le bouton est prêt
        Get_PortfolioGrid_BarToolBarTray_CmbCurrency().WaitProperty("Enabled", true, 15000);
        Get_PortfolioGrid_BarToolBarTray_CmbCurrency().set_IsDropDownOpen(true);
    
        // Mesure la performance modife la devise 
        StopWatchObj.Start();
        Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["ComboBoxItem", currency], 10).Click();
//        WaitObject(Get_PortfolioPlugin(), "Uid", "TextBlock_4c82", waitTimeShort);
        Get_PortfolioPlugin().FindChild("Uid", "TextBlock_4c82", 10).WaitProperty("IsVisible", true, 15000);
        StopWatchObj.Stop();

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