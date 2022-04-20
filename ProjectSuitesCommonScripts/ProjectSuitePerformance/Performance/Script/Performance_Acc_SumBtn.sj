//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Acc_SumBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_SumBtn";
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var accFilterValueGreat = GetData(filePath_Performance, sheetName_DataBD, 55, language);
//        var filterValue2 = GetData(filePath_Performance, sheetName_DataBD, 58, language);

        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        var filterValue2  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValueFilter2", language+client);        
        var accFilterValueGreat = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PerformanceAccountValueGreat", language+client);         
        
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
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);
        Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters() .Click();
        WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Text", " #PerformanceAccount total value > 800000", 10).Click();
        Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
        
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnSum().WaitProperty("Enabled", true, 15000);
    
        // Mesure la performance clique le boutton sommation    
        StopWatchObj.Start();
        Get_Toolbar_BtnSum().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CRMSumWindow", "CRMSumWindow_106e"], waitTimeShort);
        StopWatchObj.Stop();

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la fenêtre sommation
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["UniDialog", "com.unigiciel.components.windows.UniDialog"], waitTimeShort);
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}