//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils


/* Analyste d'assurance qualité: Christine Hechema
Analyste d'automatisation: Xian Wei */


function Performance_Mod_UMA_Rebalance(modelName,SoughtForValue,addFunction,typeModel){

        //modelName,SoughtForValue,addFunction
        var StopWatchObj = HISUtils.StopWatch;
        //var SoughtForValue = "Performance_Mod_UMA";
        //var modelName = GetData(filePath_Performance, sheetName_DataBD, 74, language);
        //var addFunction = "Cash Management";
        //var SoughtForValue = Project.TestItems.Current.ElementToBeRun.Caption.match(/Script\\([^ ]+) -/)[1];
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
        
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        
        if (typeModel == "UMA"){
            var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceModel", language+client); 
        } else if (typeModel == "IAModel"){
            var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionModelCP", language+client); 
        }
        
        try {
        
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Clique le module modeles
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "2"]);
            Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
            WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
            
            // Vérifie le bouton 'Manage Search Criteria' est prêt
            Get_Toolbar_BtnManageSearchCriteria().WaitProperty("Enabled", true, 15000);
            
            Get_Toolbar_BtnManageSearchCriteria().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
            Get_WinSearchCriteriaManager().Parent.Maximize();
            
            // Choisir un critere de recherche
            var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
            for (var i = 0; i < rowCount; i++){
                displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
                  if (displayedCriterionName == searchCriterionName){
                    Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                    Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                  break;
                  }
            }
            
            Get_WinSearchCriteriaManager_BtnRefresh().Click();
            
            Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().WaitProperty("IsChecked", true, waitTimeShort);
            WaitObject(Get_ModelsGrid(),["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1]);
            Get_ModelsGrid().Refresh();

            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Refresh();
            WaitObject(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios(),["ClrClassName","WPFControlOrdinalNo"],["DataRecordPresenter","1"]);
            
            // Search Model
            SearchModelByName(modelName);
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelName]);
            Get_ModelsGrid().Find("Value",modelName,100).Click();
            Get_ModelsGrid().Find(["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1],100).WaitProperty("IsSelected", true, 15000);
            
            // Cliquer sur le bouton reequilibrer
            Get_Toolbar_BtnRebalance().WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnRebalance().Click();          
            
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists){
                Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/4, Get_DlgWarning().get_ActualHeight()-50);
            }
            RestoreAutoTimeOut();
            
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
            // Aller l'étape 2
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "Button_2943"); 
            
            if (addFunction == "Cash Management"){
                Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
                WaitObject(Get_CroesusApp(), "Uid", "CashAmountOverrideWindow_9cd1");
                Get_WinCashManagement().Parent.Maximize();
                
                AddCashMgmt(1,500);
                AddCashMgmt(2,200);
                AddCashMgmt(3,100);
                AddCashMgmt(4,300);
                AddCashMgmt(5,400);
                AddCashMgmt(6,30);
                AddCashMgmt(7,20);
                AddCashMgmt(8,600);
                AddCashMgmt(9,700);
                AddCashMgmt(10,150);
                              
                Get_WinCashManagement_BtnOk().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "CashAmountOverrideWindow_9cd1");       
            }
            // Aller l'étape 3
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ToggleButton_155e"); 
            
            Get_WinRebalance_BtnNext().Click();
            SetAutoTimeOut();
            if (Get_WinWarningDeleteGeneratedOrders().Exists == true){
                Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();}
            RestoreAutoTimeOut();
            
            // Mesure le performance rééquilibrer
            StopWatchObj.Start(); 
            WaitObject(Get_CroesusApp(),"Uid", "Expander_0a4c", waitTimeLong);
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().WaitProperty("IsVisible", true, 15000);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists == true){
                Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-50);
            }
            
            if (Get_DlgConfirmation().Exists == true){
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
            } 
            RestoreAutoTimeOut();
            
            Get_WinRebalance_BtnClose().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1], waitTimeShort);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        

        }
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }

}


function AddCashMgmt(position,value){

      //Modification suite au CR1990 gestion d'encaisse prend la position 6 dans la grille au lieu de 5
      Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position))).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click();
      Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position))).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(value);
}




function ChangeCashMgmt(sleeveDescription,cashMgmt, module)
{
    var count= Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Count;
    var found= false;
    var position;
    for (var i = 0; i < count; i++){   
      if(module=="model") {   
           if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.SleeveName)==VarToString(sleeveDescription)){
             position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
             found=true;
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
              return;
          }
      } else{    
           if(VarToString(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Description)==VarToString(sleeveDescription)){
             position=Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItemIndex
             found=true;
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).Click()
              Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", (VarToInteger(position)+1)).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 6).WPFObject("XamNumericEditor", "", 1).Keys(cashMgmt)
              return;
           }
      }
    }
    if(found==false){
      Log.Error("Le sleeve n’est pas dans la grille ")
    }     
}
