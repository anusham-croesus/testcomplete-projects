//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCM_ActivateFiltersInAlertsTab

/*
      Ligne 31 et 32 du fichier Performance N°26 et 27
      
      Analyste d'automatisation: Amine A. */


function Performance_RCM_TransactionFilterAndColunmSort(){
          
            var StopWatchObj  = HISUtils.StopWatch;           
            var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);  
//            var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
            
            var fieldTradeTrailers = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "FieldTradeTrailers", language+client); 
            var nameTradeTrailers  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "NameTradeTrailers", language+client);
            var valueCommonStock   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "ValueCommonStock", language+client);
            var operatorContaining = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "OperatorContaining", language+client);
                   
            var waitTime = 3000;
            
            var SoughtForValue1 = "Performance_RCM_TransactionFilterAndColunmSort_01";
            var SoughtForValue2 = "Performance_RCM_TransactionFilterAndColunmSort_02";
            var column          = FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue1);
                  
        try {
/*--------------------------------------------------------------------------------------------------------------------------------------------              
                    NOM DU CAS LIGNE 31 DU FICHIER PERFORMANCE  : Activer les filtres dans l'onglet Transaction Blotter 
----------------------------------------------------------------------------------------------------------------------------------------------*/
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
            // Attendre le boutton RQS présent et actif
            WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005",waitTime);
            Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
            Get_Toolbar_BtnRQS().Click();
          
            // Attendre l'onglet 'Transaction' présent et actif
            WaitObject(Get_WinRQS(), "Uid", "TabItem_c461",waitTime);
            Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)                    
            Get_WinRQS_TabTransactionBlotter().Click();

            //Fermer tous les filtres appliqués
            var nbActiveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ItemsControl", 1], 10).DataContext.NbConditionInList;            
            Log.Message(nbActiveFilter)
            while(nbActiveFilter > 0){
              if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                  Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).WPFObject("Button", "", 2).Click();
              nbActiveFilter -= 1;
            }
            //Créer le filtre Trade trailers containing "COMMON STOCK"
            CreateFilter(nameTradeTrailers, fieldTradeTrailers, operatorContaining, valueCommonStock);
        
            //Mesurer la performance de génération du résultat
            StopWatchObj.Start();
            WaitObject(Get_WinRQS_TabTransactionBlotter_BlotterControl(), ["ClrClassName", "DataContext.FilterDescription", "VisibleOnScreen"], ["ToggleButton", nameTradeTrailers, true], waitTimeShort);
            var timeSpotted=StopWatchObj.Split()/1000
            StopWatchObj.Stop();
                
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue1 + " finished. Execution time: " + StopWatchObj.ToString());           
            var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue1);
            WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
          
            //Fermer le filtre
            Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(1).WPFObject("Button", "", 2).Click();
            
            //Supprimer les Filtres
            DeleteFilter(nameTradeTrailers);
            
/*--------------------------------------------------------------------------------------------------------------------------------------------              
                          NOM DU CAS LIGNE 32 DU FICHIER PERFORMANCE : Trier la colonne IA name dans l'onglet Transaction Blotter
----------------------------------------------------------------------------------------------------------------------------------------------*/
          
            Get_WinRQS_TabTransactionBlotter_ColumnHeader("IA code").Click();
            Get_WinRQS_TabTransactionBlotter_ColumnHeader("IA name").Click();
            if(Get_WinRQS_TabTransactionBlotter_ColumnHeader("IA name").SortStatus == "Ascending"){
                // Mesurer la performance
                StopWatchObj.Start();
                Get_WinRQS_TabTransactionBlotter_ColumnHeader("IA name").Click();
                WaitObject(Get_WinRQS_TabTransactionBlotter_BlotterControl(), ["WPFControlName", "ClrClassName", "VisibleOnScreen"], ["_transactionList", "TransactionList", true], waitTimeShort);
                var timeSpotted=StopWatchObj.Split()/1000
                StopWatchObj.Stop();
            }  
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue2 + " finished. Execution time: " + StopWatchObj.ToString());           
            var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue2);
            WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);  
            
            //Fermer RQS et Croesus
            Get_WinRQS().Close();                     
            Close_Croesus_MenuBar();                                                    
        }
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            //Fermer Croesus
            TerminateProcess("CroesusClient");
        }
}