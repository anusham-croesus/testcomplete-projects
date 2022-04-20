//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT Performance_RCM_ActivateFiltersInAlertsTab
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_CurrentFilterEdition(){

        var StopWatchObj    = HISUtils.StopWatch;
        var SoughtForValue  = "Performance_RCM_CurrentFilterEdition";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        var filterName    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "CurrentFilter", language+client);
        var fieldValue    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "CurrentField", language+client);
        var operatorValue = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "CurrentOperator", language+client);
        var chValue       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Value02", language+client);
        var operatorStartingWith = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "NewOperator", language+client);
        
        var waitTime = 3000;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
              // Se connecte
              Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005");
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
          
              // Attendre l'onglet 'Transaction' présent et actif
              WaitObject(Get_WinRQS(), "Uid", "TabItem_c461");
              Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
              Get_WinRQS_TabTransactionBlotter().Click();
              
              WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTime);          
              Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime);
              
              //Désactiver tous les filtres appliqués s'ils existent
              var nbActiveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
              while(nbActiveFilter > 0){
//                if (Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).wState)
//                      Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).set_IsChecked(false);
                      Get_WinRQS_TabTransactionBlotter_BtnFilter(nbActiveFilter).WPFObject("Button", "", 2).Click();
                      nbActiveFilter -= 1;
              }
              
              //Créer un filtre
              CreateFilter(filterName,fieldValue,operatorValue,chValue);
              //Modifier le filtre
              Get_WinRQS_TabTransactionBlotter_BtnFilter(1).WPFObject("Button", "", 1).Click();
        
              Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
              Get_WinCRUFilter_CmbOperator(operatorStartingWith).Click();
              Get_WinCRUFilter_BtnOK().Click();
              
              // Mesurer la performance de modification du filtres 
              StopWatchObj.Start();
              WaitObject(Get_CroesusApp(), "Uid", "BlotterControl_1280", waitTimeShort);   //Attendre la grille des Transactions
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WaitProperty("VisibleOnScreen", true, 5000);
              var timeSpotted=StopWatchObj.Split()/1000 
              StopWatchObj.Stop();
        
              // Écrit le résultat dans le fichier excel
              Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
              /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
              
              var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
              
              //Supprimer le Filtre
              DeleteFilter(filterName);
              
              //fermer la fenêtre 
              Get_WinRQS().Close();
        }        
        catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {        
              //Fermer Croesus
              TerminateProcess("CroesusClient"); 
        }
}

function Get_WinRQS_TabTransactionBlotter_BtnFilter(WPFControlOrdinalNo){
        return Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", WPFControlOrdinalNo, true], 10)
}