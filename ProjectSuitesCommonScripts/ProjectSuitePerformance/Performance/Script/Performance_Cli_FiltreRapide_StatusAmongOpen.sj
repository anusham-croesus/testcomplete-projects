//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: Karima Mehiguene
   Analyste d'automatisation: Amine A. */

function Performance_Cli_FiltreRapide_StatusAmongOpen() {

              var StopWatchObj   = HISUtils.StopWatch;
              var SoughtForValue = "Performance_Cli_FiltreRapide_StatusAmongOpen";
        
              var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
              var filterName    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "FilterName", language+client);
              var field         = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "FieldStatus", language+client);        
              var operator      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "OperatorAmong", language+client);        
              var valeurValue   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ValeurOpen", language+client);        
              
              try {
              Activate_Inactivate_PrefFirm("Firm_1", "PREF_ENABLE_CLIENT_STATUS", "1", vServerPerformance)
              RestartServices(vServerPerformance);
              
              // Se connecte
              Login(vServerPerformance, userNameSARONTAL, passwordSARONTAL, language);

              // Attend le module Clients présente et active
              WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "4"]);
              Get_ModulesBar_BtnClients().WaitProperty("Enabled", true, 15000);
              Get_ModulesBar_BtnClients().Click(); 
              WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

              Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
              Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
              WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);
        
              Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
              WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935");

              Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
                    
              Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
              Get_WinCRUFilter_CmbField(field).Click();

              Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
              Get_WinCRUFilter_CmbOperator(operator).Click();
                    
              if (Get_WinCRUFilter_GrpCondition_DgvValue().Visible == true) {
                        Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value", valeurValue, 100).Click();
              }
              Get_WinCRUFilter_BtnOK().Click();
              
              // Mesurer la performance d'activer le filtre    
              StopWatchObj.Start();
              WaitObject(Get_CroesusApp(), ["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], waitTimeShort);
              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).WaitProperty("IsChecked", true, 15000);
              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);  
              StopWatchObj.Stop();       
        
              // Écrit le résultat dans le fichier excel
              Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
              var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
              Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
              
              //Supprimer le filtre    
              Delete_FilterCriterion(filterName, vServerPerformance); 
              /*Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
              WaitObject(Get_Toolbar_BtnQuickFilters_ContextMenu(), ["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 1]);
        
              Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();              
              WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
              Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find("Text", filterName, 10).Click();
              Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
              Get_DlgConfirmation_BtnDelete().Click();
              Delay(500);
              Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
              
              }
              catch(e) {
                Log.Error("Exception: " + e.message, VarToStr(e.stack));*/
              }
            
              finally {
                  Terminate_CroesusProcess(); //Fermer Croesus
                  Activate_Inactivate_PrefFirm("Firm_1", "PREF_ENABLE_CLIENT_STATUS", null, vServerPerformance)
                  RestartServices(vServerPerformance);
                  Terminate_IEProcess();
              }

}

function Get_WinCRUFilter_CmbOperator(operator)
{
  return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", operator], 10);
}

function Get_WinCRUFilter_CmbField(field) 
{
  return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", field], 10);
}