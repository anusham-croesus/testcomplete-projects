//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tit_SearchTitre(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tit_SearchTitre";
//        var titre = GetData(filePath_Performance, sheetName_DataBD, 5, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var titre         = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityNumber", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);       

        try {
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        // Attend le module Titres présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "8"]);
        Get_ModulesBar_BtnSecurities().WaitProperty("Enabled", true, 15000);

        // Clique le module Titres
        Get_ModulesBar_BtnSecurities().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
        Get_Toolbar_BtnSearch().Click();
        Get_WinQuickSearch_TxtSearch().SetText(titre);
        Get_WinSecuritiesQuickSearch_RdoSecurity().set_IsChecked(true);
        // Vérifie le bouton est prêt
        Get_WinQuickSearch_BtnOK().WaitProperty("Enabled", true, 15000);
        Get_WinQuickSearch_BtnOK().Click();
    
        // Mesure la performance recherche de titres
        StopWatchObj.Start();
        WaitObject(Get_SecurityGrid(),["ClrClassName", "WPFControlText"], ["CellValuePresenter", titre],waitTimeShort);
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