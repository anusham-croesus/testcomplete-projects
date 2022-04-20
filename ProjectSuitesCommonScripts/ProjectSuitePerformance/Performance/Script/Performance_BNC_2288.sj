//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils


/* Analyste d'assurance qualité: BNC-2288
Analyste d'automatisation: Xian Wei */



function Performance_BNC_2288(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_BNC_2288";
        var modelNo = "~M-0AJLN-0";
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
        
             
        try {
        
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Clique le module modeles
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "2"]);
            Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
            WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
        
            
            // Search Model
            Search_Model(modelNo)
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelNo]);
            Get_ModelsGrid().Find("Value",modelNo,100).Click();
            
            // Cliquer sur le bouton reequilibrer
            Get_Toolbar_BtnRebalance().WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnRebalance().Click();          
            
            if (Get_DlgWarning().Exists){
                Get_DlgWarning().Click(Get_DlgWarning().get_ActualWidth()/4, Get_DlgWarning().get_ActualHeight()-50);
            }
            
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
            Get_WinRebalance().set_IsMaximizable(true);
            
            // Aller l'étape 2
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "Button_2943"); 
            
            // Aller l'étape 3
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ToggleButton_155e"); 
            
            // Aller l'étape 4
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(),"Uid", "TabControl_5bbf", waitTimeShort);
            
            if (Get_DlgCroesus().Exists){
                Get_DlgCroesus().Click(Get_DlgCroesus().get_ActualWidth()/2, Get_DlgCroesus().get_ActualHeight()-50)
            }
            
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().WaitProperty("IsEnabled", true, 15000);
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
            
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().WaitProperty("IsEnabled", true, 60000);
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Click();
            WaitObject(Get_CroesusApp(), "Uid", "AddPosition_0910");
                       
            // Mesure le performance rééquilibrer
            StopWatchObj.Start(); 
            Get_WinAddPosition_GrpSecurityInformation_DlListPicker().Click(); 
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"],["PopupRoot", 1],waitTimeShort);
            StopWatchObj.Stop();
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
            Get_WinAddPosition_GrpSecurityInformation_TxtQuickSearchKey().Click();
            Get_WinAddPosition_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "AddPosition_0910");
            
            Get_WinRebalance_BtnClose().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1], waitTimeShort);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(1/3), 70);
        

        }
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }

}

