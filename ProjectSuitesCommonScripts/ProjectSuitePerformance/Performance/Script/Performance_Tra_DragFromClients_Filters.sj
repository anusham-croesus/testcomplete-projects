//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Clients_Get_functions
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_DragFromClients_Filters(){

            var StopWatchObj = HISUtils.StopWatch;
            var SoughtForValue = "Performance_Tra_DragFromClients_Filters";
//            var criterionClientsName = GetData(filePath_Performance, sheetName_DataBD, 30, language);
//            var posClient = GetData(filePath_Performance, sheetName_DataBD, 20, language);
//            var nom = GetData(filePath_Performance, sheetName_DataBD, 11, language);
//            var posTraFilter = GetData(filePath_Performance, sheetName_DataBD, 26, language);
//            var posTransaction = GetData(filePath_Performance, sheetName_DataBD, 22, language);
//            var client = GetData(filePath_Performance, sheetName_DataBD, 3, language);
//            var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
                    
            var nom            = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "OptionFilterTrans", language+client); 
            var clientNo       = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ClientNumber", language+client);
            var posClient      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionClient4", language+client); 
            var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
            var posTraFilter   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransFilter5", language+client); 
            var posTransaction = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransaction20", language+client); 
            var criterionClientsName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceClients", language+client);  
            
            try {
    
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Clique le module Clients
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
            Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
            Delay(1000);
            Get_ModulesBar_BtnClients().Click(); 
            WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            
//            if (DataType == "Position"){
//                //******************************** position *************************
//                SelectSearchCriteria(criterionClientsName);
//            
//                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posClient], 10).Click();
//
//                // Maillage un client au module Transactions
//                Drag(Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", posClient], 10), Get_ModulesBar_BtnTransactions());
//                WaitObject(Get_CroesusApp(), ["Uid"], ["FixedColumnListView_1b3e"]);
//                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WaitProperty("VisibleOnScreen", true, 15000);
//
//                // Vérifie le bouton est prêt
//                Get_Toolbar_BtnQuickFilters().Click();
//                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);
//                Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).WaitProperty("Enabled", true, 15000);
//    
//                // Mesure la performance de filtre
//                StopWatchObj.Start();
//                //Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).Click();
//                Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).Click();
//                Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", true, waitTimeShort);
//                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("IsLoaded", true, 15000);
//                StopWatchObj.Stop();
//                //*******************************************************************
//            } else if (DataType == "Data"){
//            
                //****************************** Data *******************************
                // Recherche de clients
                Search_Client(clientNo);
                WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
                Get_RelationshipsClientsAccountsGrid().Find("Value",clientNoNo,1000).Click(); 
                Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("IsLoaded", true, 15000);
        
                // Maillage un client au module transaction
                Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",clientNoNo,1000), Get_ModulesBar_BtnTransactions());
                WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e");
                Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "2"], 10).WaitProperty("VisibleOnScreen", true, 15000);

                // Vérifie le bouton est prêt
                Get_Toolbar_BtnQuickFilters().Click();
                WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);
                Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).WaitProperty("Enabled", true, 15000);
    
                // Mesure la performance de filtre
                StopWatchObj.Start();
                Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).Click();
                //Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).Click();
                Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", true, waitTimeShort);
                StopWatchObj.Stop();
                //*******************************************************************
//            }
            
            // Écrit le résultat dans le fichier excel
            Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
            var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
            WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

            
            // Ferme la filtre de recherche
            Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("IsLoaded", true, 30000);
            Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).Click();
            Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", false, 60000);
            //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).Click();
            
            // Retourne l'état initiale
            //Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
            //Delay(10000);
            //Get_ModulesBar_BtnClients().Click(); 
            //WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
            //Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            //Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            //WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], waitTimeShort);
        
            Terminate_CroesusProcess();

            }
    
            catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
                Terminate_IEProcess();
            }
}





function Get_Toolbar_ZoneFilter(){return Get_barToolbar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClickBox", 1], 10)}


function Get_Toolbar_BtnQuickFilters_ContextMenu_Item(FilterName){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", FilterName], 10)}


function Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter() 
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< Aucun filtre >"], 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< No Filter >"], 10)}
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