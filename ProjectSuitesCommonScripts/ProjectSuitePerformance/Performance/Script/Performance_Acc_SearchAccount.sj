//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions


/* Analyste d'assurance qualité:Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Acc_SearchAccount(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_SearchAccount";
//        var account = GetData(filePath_Performance, sheetName_DataBD, 2, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);

        var account        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client); 
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);

        
        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
            
        // Attend le module Comptes présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
    
        // Clique le module Comptes
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().SetText(account);
        Get_WinAccountsQuickSearch_RdoAccountNo().set_IsChecked(true);
        // Vérifie le bouton est prêt
        Get_WinQuickSearch_BtnOK().WaitProperty("Enabled", true, 15000);

        // Mesure la performance recherche de Comptes
        StopWatchObj.Start();
        Get_WinQuickSearch_BtnOK().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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