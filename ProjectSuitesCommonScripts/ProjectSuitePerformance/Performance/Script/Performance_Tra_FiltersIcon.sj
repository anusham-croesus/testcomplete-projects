//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Transactions_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tra_FiltersIcon(){

    var StopWatchObj = HISUtils.StopWatch;
    var SoughtForValue = "Performance_Tra_FiltersIcon";
//    var posTraFilter = GetData(filePath_Performance, sheetName_DataBD, 26, language);
//    var nom = GetData(filePath_Performance, sheetName_DataBD, 11, language);
//    var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//    var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
    
    var nom           = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "OptionFilterTrans", language+client); 
    var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
    var posTraFilter  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionTransFilter5", language+client);
    
   
    try {
         
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);
    
        // Attend le module Transactions présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "7"]);
        Get_ModulesBar_BtnTransactions().WaitProperty("Enabled", true, 15000);
        
        // Clique le module Transactions
        Get_ModulesBar_BtnTransactions().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e"); 
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], waitTimeShort);
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "12"], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnQuickFilters().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);
        //Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).WaitProperty("Enabled", true, 15000);
        Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).WaitProperty("Enabled", true, 15000);
        
        // Mesure la performance de filtre
        StopWatchObj.Start();
        Get_Toolbar_BtnQuickFilters_ContextMenu_Item(nom).Click();
        //Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["UniCheckMenu", posTraFilter], 10).Click();
        Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", true, waitTimeShort);
//      Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", "TRANSACTION cURRENCY", 1)
        Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);
        StopWatchObj.Stop();

        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la filtre de recherche
        //Get_Toolbar_BtnQuickFilters().Click();
        //Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter().Click();
        Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", "1"], 10).WaitProperty("IsLoaded", true, 15000);
        Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).Click();
        Aliases.CroesusApp.winMain.barToolbar.WPFObject("QuickFilterWidgetContainer").WPFObject("ClickBox", nom, 1).WaitProperty("IsChecked", false);
        //Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
    
        Terminate_CroesusProcess();
        // Déconnecte
        //Get_MainWindow().SetFocus();
        //Close_Croesus_MenuBar();
        //Terminate_IEProcess();
    }
    
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {

        Terminate_IEProcess();
    }
}


function Get_Toolbar_BtnQuickFilters_ContextMenu_Item(FilterName){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", FilterName], 10)}



function Get_Toolbar_BtnQuickFilters_ContextMenu_NoFilter() 
{
  if (language == "french"){return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< Aucun filtre >"], 10)}
  else {return Get_Toolbar_BtnQuickFilters_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["UniCheckMenu", "< No Filter >"], 10)}
}

function CreateFilterTransactions(filterName, posField)
{
    // Clique le module Transactions
    Get_ModulesBar_BtnTransactions().Click(); 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
    Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);
    
    // ajoute un filtre
    Get_Toolbar_BtnQuickFilters().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1], 30000);
    Get_WinAddFilter_TxtName().set_Text(filterName);
    Get_WinAddFilter_GrpCondition_CmbField().WaitProperty("Enabled", true, 15000);
    Get_WinAddFilter_GrpCondition_CmbField().set_IsDropDownOpen(true);  
    Get_SubMenus().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBoxItem", posField], 10).Click();
    Delay(1000);
    Get_WinAddFilter_BtnOK().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
    Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);
    
}

function DeleteFilterTransactions(filterName)
{
    // Clique le module Transactions
    Get_ModulesBar_BtnTransactions().Click(); 
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
    Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);

    // supprime un filtre
    Get_Toolbar_BtnQuickFilters().Click();
    Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"], 30000);
    Get_WinQuickFiltersManager_LstFilters().FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", filterName], 10).Click();
    Get_WinQuickFiltersManager_PadHeaderBar_BtnDelete().Click();
    Delay(2000);
    Get_DlgConfirmAction_BtnYes().Click();
    Delay(2000);
    Get_WinQuickFiltersManager_BtnClose().Click();
    WaitObject(Get_CroesusApp(), "Uid", "FixedColumnListView_1b3e", 30000); 
    Get_Transactions_ListView().WaitProperty("VisibleOnScreen", true, 15000);
       
}