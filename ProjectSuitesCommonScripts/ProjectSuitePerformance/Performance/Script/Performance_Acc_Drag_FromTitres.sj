﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Titres_Get_functions
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Acc_Drag_FromTitres() {

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Acc_Drag_FromTitres";
//            var criterionSecuritiesName = GetData(filePath_Performance, sheetName_DataBD, 32, language);
//            var posTitre = GetData(filePath_Performance, sheetName_DataBD, 23, language);
//            var titre = GetData(filePath_Performance, sheetName_DataBD, 5, language);
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);

            var titre         = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityNumber", language+client);
            var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  
            var posTitre      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionPortfolio1", language+client);      
            var criterionSecuritiesName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceSecurities", language+client);
            
        try {
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);


            Get_ModulesBar_BtnAccounts().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            Get_RelationshipsClientsAccountsGrid().WaitProperty("IsVisible", true, 15000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

            // Attend le module Titres présente et active
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "8"]);
            Get_ModulesBar_BtnSecurities().WaitProperty("Enabled", true, 15000);

            // Clique le module Titres
            Get_ModulesBar_BtnSecurities().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
            Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
//            
//            if (DataType == "Position"){
//                //********************************* position*************************
//                SelectSearchCriteria(criterionSecuritiesName);
//                Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posTitre], 10).Click();
//                Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posTitre], 10).WaitProperty("IsLoaded", true, 15000);
//            
//                // Maillage un titre au module comptes
//                StopWatchObj.Start();
//                Drag(Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posTitre], 10), Get_ModulesBar_BtnAccounts());
//                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1],waitTimeShort);
//                StopWatchObj.Stop();
//                //*****************************************************************
//            } else if (DataType == "Data"){
                //*********************************** Data **************************
                // Recherche de titres
                Search_Security(titre);
                WaitObject(Get_SecurityGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
                Get_SecurityGrid().Find("Value",titre,1000).Click();
                Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
    
                // Maillage un titre au module comptes
                StopWatchObj.Start();
                Drag(Get_SecurityGrid().Find("Value",titre,1000), Get_ModulesBar_BtnAccounts());
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1],waitTimeShort);
                StopWatchObj.Stop();
                //*******************************************************************
//            }
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            // Retourne l'état initiale
            Get_ModulesBar_BtnSecurities().Click(); 
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b");
            Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
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




function SelectSearchCriteria(criterion){
    
    // Clique le bouton gérer les critères de recherche
    Get_Toolbar_BtnManageSearchCriteria().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"], 30000);
    Get_WinSearchCriteriaManager().Parent.Maximize();
        
    // Clique le critère de recherche
    var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
    for (var i = 0; i < rowCount; i++){
        displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
          if (displayedCriterionName == criterion){
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
            Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
            break;
          }
    }
    
    Get_WinSearchCriteriaManager_BtnRefresh().Click();
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, 15000);
}




