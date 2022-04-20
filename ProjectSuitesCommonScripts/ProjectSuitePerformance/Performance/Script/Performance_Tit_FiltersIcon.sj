//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Titres_Get_functions

/* Analyste d'assurance qualité: Isabelle Gaudreault
Analyste d'automatisation: Xian Wei */

function Performance_Tit_FiltersIcon(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Tit_FiltersIcon";
//        var posTitFilter = GetData(filePath_Performance, sheetName_DataBD, 27, language);
//        var filter = GetData(filePath_Performance, sheetName_DataBD, 10, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        
        var filter        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityFilter", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        var posTitFilter  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "PositionSecuritiesFilter5", language+client); 
                   
        try { 
        // Se connecte
        Login(vServerPerformance, userNamePerformance, pswPerformance, language);

        // Attend le module Titres présente et active
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "8"], 30000);
        Get_ModulesBar_BtnSecurities().WaitProperty("Enabled", true, 15000);

        // Clique le module Titres
        Get_ModulesBar_BtnSecurities().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_865b", 30000);
        Get_SecurityGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "25"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
        //if (DataType == "Position"){
            // ****************************** position ******************************
            // Vérifie le bouton est prêt
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_MoreFilter().Click();
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", 1]);
            Get_WinDetailedInfo().WPFObject("UniList", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["ListBoxItem", filter] , 10).Click();
            
             // Mesure la performance le bouton filtre
            StopWatchObj.Start();
            Get_WinDetailedInfo_BtnOK().Click();
            Get_Toolbar_ZoneFilter().WaitProperty("IsChecked", true, waitTimeShort);
            StopWatchObj.Stop();
            //***********************************************************************
        /*} else if (DataType == "Data"){
        
            //******************************** Data *********************************
            // Vérifie le bouton est prêt
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click();
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Currencies().WaitProperty("Enabled", true, 240000);

             // Mesure la performance le bouton filtre
            StopWatchObj.Start();
            Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_Currencies().Click();
            Get_Toolbar_ZoneFilter().WaitProperty("IsChecked", true, waitTimeShort);
            StopWatchObj.Stop();
            //***********************************************************************
        }*/
      
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        // Ferme la filtre de recherche
        Get_Toolbar_ZoneFilter().Click();
        Get_Toolbar_ZoneFilter().WaitProperty("IsChecked", false, waitTimeShort);
    
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
            finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}



function Get_Toolbar_ZoneFilter(){return Get_barToolbar().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ClickBox", 1], 10)}

function Get_WinQuickFiltersManager(){return Aliases.CroesusApp.winQuickFiltersManager};

function Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu_MoreFilter() //no uid
{
  if (language == "french"){return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Autres filtres..."] , 10)}
  else {return Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders_ContextMenu().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "More Filters..."] , 10)}
}

