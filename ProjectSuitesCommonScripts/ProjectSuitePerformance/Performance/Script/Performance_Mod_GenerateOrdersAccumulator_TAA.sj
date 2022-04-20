//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils


/* Analyste d'assurance qualité: Christine Hechema
Analyste d'automatisation: Xian Wei */


function Performance_Mod_GenerateOrdersAccumulator_TAA(){

        //modelName,SoughtForValue,addFunction
        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Mod_GenerateOrdersAccumulator_TAA";
//        searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 36, language);
//        var modelName = GetData(filePath_Performance, sheetName_DataBD, 74, language);
        //var addFunction = "Cash Management";
        //var SoughtForValue = Project.TestItems.Current.ElementToBeRun.Caption.match(/Script\\([^ ]+) -/)[1];
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
        
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceModel", language+client);
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelUMA25", language+client);
        
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
            
            // Aller l'étape 3
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ToggleButton_155e"); 
            
            // Aller l'étape 4
            Get_WinRebalance_BtnNext().Click();
            SetAutoTimeOut();
            if (Get_WinWarningDeleteGeneratedOrders().Exists == true){
                Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();}
            RestoreAutoTimeOut();
            
            WaitObject(Get_CroesusApp(),"Uid", "Expander_0a4c", waitTimeLong);
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().WaitProperty("IsVisible", true, 15000);
            
            SetAutoTimeOut();
            if (Get_DlgWarning().Exists == true){
                Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/2, Get_DlgWarning().get_ActualHeight()-50);
            }
            
            if (Get_DlgConfirmation().Exists == true){
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
            } 
            RestoreAutoTimeOut();
            
            // Aller l'étape 5
//            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_WinRebalance(),["Uid", "VisibleOnScreen"], ["Expander_0a4c", true],waitTimeShort);
            
//          Delay(10000);
//            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(),["Uid", "Enabled"], ["Button_021a", true],waitTimeShort);
            
            Get_WinRebalance_BtnNext().Click();
          WaitObject(Get_WinRebalance(),["Uid", "IsLoaded"], ["DataGrid_6f42", true],waitTimeShort);
//            WaitObject(Get_WinRebalance_TabProposedOrders_DgvProposedOrders(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"]);
//            Get_WinRebalance_TabProposedOrders_DgvProposedOrders().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "3"], 10).WaitProperty("VisibleOnScreen", true, 15000);
//            Get_WinRebalance_TabProposedOrders_DgvProposedOrders().Click();
//            
//            Get_WinRebalance_BtnNext().WaitProperty("Enabled", true, waitTimeLong);
//            
//            Get_WinRebalance_BtnNext().WaitProperty("VisibleOnScreen", true, waitTimeLong);
//           
	          Get_WinRebalance_BtnGenerate().Click();
            WaitObject(Get_CroesusApp(),"Uid", "GenerateOrdersWindow_c7ad",waitTimeShort);
            
            StopWatchObj.Start(); 
            Get_WinGenerateOrders_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid", "GenerateOrdersWindow_c7ad");
            WaitObject(Get_CroesusApp(),["Uid", "VisibleOnScreen"], ["DataGrid_66bd", true], waitTimeLong);
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

function test()
{
             Get_WinRebalance_BtnGenerate().Click();
        }