//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Portefeuille_Get_functions

/* Analyste d'assurance qualité: Karima Me
Analyste d'automatisation: Alhassane Diallo */

function Performance_Por_Drag_FromAccounts_With_140(){

        var StopWatchObj   = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Por_Drag_FromAccounts_With_140";
     
        var account        = "414165611C"// ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "AccountNumberFullname414165611C", language+client);
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
       
        try {
        
           // Se connecte
           Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        
           // Clique le module Comptes
           WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
           Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
           Get_ModulesBar_BtnAccounts().Click();
           WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"]);
      

        
            //********************************** Data *******************************
            // Recherche de comptes et selectionner le compte
            Search_Account(account);
            WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
  
            // Maillage un compte au module portefeuille
            StopWatchObj.Start();
            Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            StopWatchObj.Stop();
            //**********************************************Performance_Por_Drag_FromAccounts_With_140*************************

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        // Retourne l'état initiale
        Get_ModulesBar_BtnAccounts().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
//        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}

