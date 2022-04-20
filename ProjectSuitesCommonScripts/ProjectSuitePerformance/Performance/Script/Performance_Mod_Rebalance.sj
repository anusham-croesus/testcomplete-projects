//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils

/* Analyste d'assurance qualité: Julie Lamarche
Analyste d'automatisation: Xian Wei */

function Performance_Mod_Rebalance(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Mod_Rebalance";
//        var posModele = GetData(filePath_Performance, sheetName_DataBD, 28, language);
        var posAccount = 1; //GetData(filePath_Performance, sheetName_DataBD, 21, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
        
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        var posModele  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionModele2", language+client); 
        
        try {
           // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Clique le module modeles
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "2"]);
            Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
      
            Get_ModelsGrid().RecordListControl.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posModele], 100).Click();
            //NameMapping.Sys.CroesusClient.HwndSource_MainWindow.MainWindow.contentContainer.tabControl.ModelsPlugin.modelListView.RecordListControl.WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "Modèle Firme", 6).WPFObject("XamTextEditor", "", 1).Click();
            Get_ModelsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posModele], 10).WaitProperty("IsActive", true, 15000);
        
            // Clique la section portefeuille assignes
            Get_Models_Details_TabAssignedPortfolios().Click();      
            Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
            Get_Models_Details_TabAssignedPortfolios_DdlAssign_Accounts().Click();
        
            // Selectionner un compte
            WaitObject(Get_CroesusApp(), "Uid", "PickerBase_dcbf", 30000);
            Get_WinPickerWindow().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posAccount], 10).Click();
            var numAccount = Get_WinPickerWindow_DgvElements().WPFObject("RecordListControl", "", 1).Items.Item(posAccount-1).DataItem.get_AccountNumber();
            Log.Message(numAccount);
        
            Get_WinPickerWindow_BtnOK().Click();
            WaitObject(Get_CroesusApp(), "Uid", "AssignToModelWindow_c8c3");
            Get_WinAssignToModel_BtnYes().WaitProperty("Enabled", true, 15000);
            Get_WinAssignToModel_BtnYes().Click();
        
            // Cliquer sur le bouton reequilibrer
            Get_Toolbar_BtnRebalance().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");
            Get_WinRebalance().Parent.Maximize();
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
      
            // Mesure le performance rééquilibrer
            StopWatchObj.Start(); 
            Get_WinRebalance_BtnNext().Click();
            WaitObject(Get_CroesusApp(),"Uid", "Expander_0a4c", waitTimeLong);
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages().WaitProperty("Visible", true, 15000);
            StopWatchObj.Stop();
        
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            //-------------------------------------------------------------------------------------------------------------------------------
            //----------------------------------------------------- TVCE-4629 ----------------------------------------------------------------
            /*
            En tant que TCVE
            Je veux automatiser le jira MOD-446 pour l'inclure aux tests de performance du modèles sur NFR
            
            Jira: https://jira.croesus.com/browse/TCVE-4629
            Cas : https://jira.croesus.com/browse/MOD-446
            
            Analyste d'automatisation: A.A
            Version: ref90-24-2021-04-33--V9-croesus-co7x-2_1_779
            */
            //----------------------------------------------------------------------------------------------------------------------------------
            
            //Performance du passage de l'onglet Ordres Proposés à Portefeuille projetés 
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click(); 
            PerformanceRecorder(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio(), "From_ProposedOrdersTab_To_ProjectedPortfolioTab", "DataGrid_67cd");
      
            //Performance du passage de l'onglet Portefeuille projetés à Ordres Proposés  
            PerformanceRecorder(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders(), "From_ProjectedPortfolioTab_To_ProposedOrdersTab", "DataGrid_6f42");
    
            //Performance du click sur l'assigné 1
            Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();      
            PerformanceRecorder(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator_LineNo(1), "Assigned_1", "DataGrid_67cd");
      
            //Performance du click sur l'assigné 2
            PerformanceRecorder(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator_LineNo(2), "Assigned_2", "DataGrid_67cd");
      
            //Performance du click sur l'assigné 3
            PerformanceRecorder(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator_LineNo(3), "Assigned_3", "DataGrid_67cd"); 

            //----------------------------------------------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------------------------------------------
                      
            Get_WinRebalance_BtnClose().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1], 3000);

            if(Get_DlgConfirmation().Exists)
                  Get_DlgConfirmation_BtnContinue().Click();
                   
            Get_MainWindow().SetFocus();
            Get_ModulesBar_BtnModels().WaitProperty("VisibleOnScreen", true, 15000);        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
            // retourner l'etat initiale
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
            
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value", VarToStr(numAccount),100).Click();
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value", VarToStr(numAccount),100).ClickR();
            WaitObject(Get_CroesusApp(), "Uid", "ContextMenu_1179"); 
             
            Get_CroesusApp().FindChild("Uid", "MenuItem_898c", 100).Click();
            if(Get_DlgConfirmation().Exists)
                  Get_DlgConfirmation_BtnRemoveSelection().Click();
                  
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }
}

function Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator_LineNo(n){
  
    return Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", n).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10);
}

function PerformanceRecorder(objectClick, SoughtForValue, waitForObjectUid){
  
          var StopWatchObj = HISUtils.StopWatch;
          var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
          
          // Mesure le performance
          StopWatchObj.Start(); 
          objectClick.Click();          
          WaitObject(Get_WinRebalance(),["Uid", "IsLoaded"], [waitForObjectUid, true],waitTimeShort);
          StopWatchObj.Stop(); 
        
          // Écrit le résultat dans le fichier excel
          Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
          var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
          WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString()); 
}