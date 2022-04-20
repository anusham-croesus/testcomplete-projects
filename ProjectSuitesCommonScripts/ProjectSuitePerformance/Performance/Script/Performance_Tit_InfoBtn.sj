//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tit_InfoBtn(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tit_InfoBtn";
//        var posTitre = GetData(filePath_Performance, sheetName_DataBD, 23, language);
//        var titre = GetData(filePath_Performance, sheetName_DataBD, 5, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var titre         = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityNumber", language+client);
        var posTitre      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionPortfolio1", language+client);
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
    
        //if (DataType == "Position"){
            //********************************* position ****************************
            Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posTitre], 10).Click();
            Get_SecuritiesBar_BtnInfo().WaitProperty("Enabled", true, 15000);
            //***********************************************************************
        /*} else if (DataType == "Data"){ 
        //******************************* Data **********************************
            // Recherche de titres
            Search_Security(titre);
            WaitObject(Get_SecurityGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
            Get_SecurityGrid().Find("Value",titre,1000).Click();
            Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
            //***********************************************************************
        }*/
        
        // Mesure la performance boutton info
        StopWatchObj.Start();
        Get_SecuritiesBar_BtnInfo().Click();
        WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448", waitTimeShort);
        StopWatchObj.Stop();
      
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
    
        // Ferme la fenetre
        Get_WinInfoSecurity_BtnCancel().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448", waitTimeShort);

        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}