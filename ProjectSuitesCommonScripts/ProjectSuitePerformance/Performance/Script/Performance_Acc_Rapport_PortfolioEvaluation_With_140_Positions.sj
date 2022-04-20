//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Karima Me
Analyste d'automatisation: Alhassane Diallo */

function Performance_Acc_Rapport_PortfolioEvaluation_With_140_Positions(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_Rapport_PortfolioEvaluation_With_140_Positions";        
        var account       = "414165611C"//ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "AccountNumber", language+client); 
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client); 
        var typeReport    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "TypePortfolioEvaluation", language+client); 
       
        try {
          
        
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
        
        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        

         // Recherche de comptes
         Search_Account(account);
         WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
         Get_RelationshipsClientsAccountsGrid().Find("Value",account,1000).Click();
           
        
        Get_Toolbar_BtnReportsAndGraphs().Click();
        WaitObject(Get_CroesusApp(), ["ClrFullClassName", "WPFControlOrdinalNo"], ["com.unigiciel.components.windows.UniDialog", "1"]);
        Get_WinReports().WaitProperty("VisibleOnScreen", true, 15000);
    
        // Évaluation du portefeuille (avancé)
        Select_Report_Performance(typeReport);
        WaitObject(Get_WinReports(), ["ClrClassName", "WPFControlText"], ["ListBoxItem", typeReport]);
        if (language == 'french'){
            Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Rapports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).WaitProperty("VisibleOnScreen", true, 30000); 
        } else if (language == 'english'){
            Aliases.CroesusApp.winReports.WPFObject("UniGroupBox", "Reports", 1).WPFObject("UniList", "", 1).WPFObject("ListBoxItem", "", 1).WaitProperty("VisibleOnScreen", true, 30000);  
        }  
        Get_WinReports_BtnOK().WaitProperty("Enabled", true, 15000);
         
        
        StopWatchObj.Start();
        Get_WinReports_BtnOK().Click();
        Sys.WaitProcess(GetAcrobatProcessName(), waitTimeLong, 1); //2021-12-24: MAJ par Christophe Paring pour récupérer le bon nom de processus Acrobat (64 bits versus 32 bits)
        Sys.FindChild("WndClass","AcrobatSDIWindow",10).WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();

                
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        TerminateAcrobatProcess(); //2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits

        
        // Retourne l'état initiale
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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
















