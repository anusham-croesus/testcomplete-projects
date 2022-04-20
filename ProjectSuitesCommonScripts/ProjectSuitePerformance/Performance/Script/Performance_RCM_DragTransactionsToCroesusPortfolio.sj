//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_DragTransactionsToCroesusPortfolio(){
  
//        DragTransactionsToCroesusModule(Get_ModulesBar_BtnPortfolio(),"Performance_RCM_DragTransactionsToCroesusPortfolio","PortfolioPlugin_f3c4",);
//}
//function DragTransactionsToCroesusModule(moduleCible,SoughtForValue,waitObjectUid){
  
        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_RCM_DragTransactionsToCroesusPortfolio";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        var waitTime = 3000;
        //Nombre de transaction à selectionner
        var nbTansaction = 20;
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue);
        
        try {
          // Se connecte
          Login(vServerPerformance, userNamePerformance, pswPerformance, language);
          Get_MainWindow().Maximize();
            
          // Attendre le boutton RQS présent et actif
          WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
          Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
          Get_Toolbar_BtnRQS().Click();
          
          // Attendre l'onglet 'Transactions' présent et actif dans la fenêtre RQS
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("Enabled", true, waitTime)          
          
          Get_WinRQS_TabTransactionBlotter().Click();
          WaitObject(Get_CroesusApp(), "Uid", "TabItem_c461", waitTime);
          Get_WinRQS_TabTransactionBlotter().WaitProperty("IsSelected", true, waitTime) 
          
          //Changer la dimension et la position de la fenêtre RQS
          if(Get_WinRQS().WindowState == "Maximized")
               Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").SystemMenu.Click("Restore");
          
          Get_WinRQS().Set_Width(1100);
          Get_WinRQS().Set_Height(1030);
          
          //Deplacer vers la droite
          winRQSLeft = Get_WinRQS().get_Left();
          winRQSTop  = Get_WinRQS().get_Top();         
          Aliases.CroesusApp.WPFObject("HwndSource: _activityBlotterManagerWindow").Drag(100,8,-winRQSLeft+800,-winRQSTop);
          
          //Désactiver tout les filtres appliqués s'ils existent
          var nbActiveFilter = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
          while(nbActiveFilter > 0){
                  if (Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).wState)
                      Get_WinRQS_TabTransactionBlotter_BtnToggleFilter(nbActiveFilter).set_IsChecked(false);
                  nbActiveFilter -= 1;
          }
                  
          //Selectionner les 20 premières transactions
          for (i=0; i<nbTansaction; i++)
              Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true); 

          //Identifier le premier Numero de client de la liste 
          var clientNumber = Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.ClientNumber.OleValue;
          Log.Message(clientNumber);
          
          // Mesurer la performance du maillage     
          StopWatchObj.Start();
          //Mailler vers 'Portefeuille'
          Drag(Get_WinRQS_TabTransactionBlotter_BlotterControl().WPFObject("_transactionList").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild("Value",clientNumber,10), Get_ModulesBar_BtnPortfolio());
          //WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
          //Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, waitTime);         
          Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, waitTime);
          var timeSpotted=StopWatchObj.Split()/1000 
          StopWatchObj.Stop();
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
          /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
          
          var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);   
        }        
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {        
          //Fermer Croesus
          TerminateProcess("CroesusClient"); 

        }
}