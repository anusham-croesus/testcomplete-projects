//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: BNC-2234
Analyste d'automatisation: Xian Wei */

function Performance_BNC_2234_2235() {

          var StopWatchObj = HISUtils.StopWatch;
          var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
          var f1 = "#RealAccounts";
          var f2 = "#OpenAccounts";
          var f3 = "#CashAccounts";
          var f4 = "#TotalValue>0";
          var f5 = "#MarginNotn/a";
          var f6 = "#Balance>1000";
          var f7 = "#IACode0AAR";
          var f8 = "#CurrencyCAD";
          var f9 = "#NameA";
          var f10 = "#AccNo1";

          try {
                    // Se connecte
                    Login(vServerPerformance, userNamePerformance, pswPerformance, language);

                    // Attend le module Comptes présente et active
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl", waitTimeShort);
                    Get_RelationshipsClientsAccountsGrid().WaitProperty("IsInitialized", true, 15000);
                    
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

                    if (language == "french") {
                              CreateFilterAccounts(f1, "Utilisateur", "No compte", "ne contenant pas", "~");
                              CreateFilterAccounts(f2, "Utilisateur", "(Date) Date de fermeture", "est à blanc", "");
                              CreateFilterAccounts(f3, "Utilisateur", "Type", "parmi", "Comptant");
                              CreateFilterAccounts(f4, "Utilisateur", "Valeur totale", "est plus grand que", "0");
                              CreateFilterAccounts(f5, "Utilisateur", "Marge", "n'est pas à blanc", "");
                              CreateFilterAccounts(f6, "Utilisateur", "Solde", "est plus grand que", "1000");
                              CreateFilterAccounts(f7, "Utilisateur", "Code de CP", "égal(e) à", "7ZEA");
                              CreateFilterAccounts(f8, "Utilisateur", "Devise", "parmi", "CAD");
                              CreateFilterAccounts(f9, "Utilisateur", "Nom", "débutant par", "n");
                              CreateFilterAccounts(f10, "Utilisateur", "No compte", "débutant par", "1");
                    } else {
                              CreateFilterAccounts(f1, "User", "Account No.", "not containing", "~");
                              CreateFilterAccounts(f2, "User", "(Date) Closing Date", "is empty", "");
                              CreateFilterAccounts(f3, "User", "Type", "among", "Cash");
                              CreateFilterAccounts(f4, "User", "Total Value", "is greater than", "0");
                              CreateFilterAccounts(f5, "User", "Margin", "is not empty", "");
                              CreateFilterAccounts(f6, "User", "Balance", "is greater than", "1000");
                              CreateFilterAccounts(f7, "User", "IA Code", "equal to", "7ZEA");
                              CreateFilterAccounts(f8, "User", "Currency", "among", "CAD");
                              CreateFilterAccounts(f9, "User", "Name", "Starting with", "n");
                              CreateFilterAccounts(f10, "User", "Account No.", "Starting with", "1");
                    }

                    var ArrayOfFilter = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10];

                    for (var i = 0; i < ArrayOfFilter.length; i++) {
                              Log.Message("Choisir le filtre: " + ArrayOfFilter[i]);
                              // Mesure la performance clique le module Comptes
                              Get_ModulesBar_BtnAccounts().Click();
                              WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);
                              Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
                              WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);

                              Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
                              WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
                              Sys.Process("CroesusClient").WPFObject("HwndSource: QuickFilterManager").Maximize();
                              Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find(["ClrClassName", "Text"], ["XamTextEditor", ArrayOfFilter[i]], 100).Click();
                              
                              StopWatchObj.Start();
                              Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
                              WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", i + 1]);
                              StopWatchObj.Split();

                              // Écrit le résultat dans le fichier excel
                              Log.Message(ArrayOfFilter[i] + " finished. Execution time: " + StopWatchObj.ToString());
                              var row = FindExcelRow(filePath_Performance, sheetName_Performance, ArrayOfFilter[i]);
                              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
                    }
                    
                    for (var i = ArrayOfFilter.length; i > 0; i--) {
                              Log.Message("Fermer le filtre: " + ArrayOfFilter[i-1]);
                              // Mesure la performance clique le module Comptes
                              Get_ModulesBar_BtnAccounts().Click();
                              WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
                              Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

                              StopWatchObj.Start();
                              Get_RelationshipsClientsAccountsGrid_BtnFilter(i).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(i).get_ActualWidth() - 17, 13);
                              WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", i]);
                              StopWatchObj.Split();

                              // Écrit le résultat dans le fichier excel
                              Log.Message(ArrayOfFilter[i] + " finished. Execution time: " + StopWatchObj.ToString());
                              var row = FindExcelRow(filePath_Performance, sheetName_Performance, "Close_" + ArrayOfFilter[i-1]);
                              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
                    }
                    
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();

          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
          }
          finally {

                    Terminate_CroesusProcess(); //Fermer Croesus
                    Terminate_IEProcess();
          }

}

function CreateFilterAccounts(filterName, access, field, operator, value) {

          Get_ModulesBar_BtnAccounts().Click();
          WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
          Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10).WaitProperty("VisibleOnScreen", true, 15000);

          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
          WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);

          Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
          WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
          Sys.Process("CroesusClient").WPFObject("HwndSource: QuickFilterManager").Maximize();

          var filtre = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().Find(["ClrClassName", "Text"], ["XamTextEditor", filterName], 100);

          if (filtre.Exists) {

                    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
          } else {
                    Log.Message("The filter " + filterName + " was found in the filter list.");

                    Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_283f");
                    
                    Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ContextMenu", 1]);

                    Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
                    WaitObject(Get_CroesusApp(), "Uid", "QuickFilterEditionWindow_d935");

                    Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);

                    Get_WinCRUFilter_GrpDefinition_CmbAccess().Click()
                    Get_WinCRUFilter_CmbAccess(access).Click();

                    Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
                    Get_WinCRUFilter_CmbField(field).Click();

                    Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
                    Get_WinCRUFilter_CmbOperator(operator).Click();

                    if (Get_WinCRUFilter_GrpCondition_TxtValue().Visible == true) {
                              Get_WinCRUFilter_GrpCondition_TxtValue().Click();
                              Get_WinCRUFilter_GrpCondition_TxtValue().Clear();
                              Get_WinCRUFilter_GrpCondition_TxtValue().set_text(value);

                              var lettre = Get_WinCRUFilter_GrpCondition_TxtValue().Text.OleValue;
                              if (lettre == "" || lettre[lettre.length - 1] != value[value.length - 1]) {
                                        Get_WinCRUFilter_GrpCondition_TxtValue().Click();
                                        Get_WinCRUFilter_GrpCondition_TxtValue().Keys("[End]");
                                        Get_WinCRUFilter_GrpCondition_TxtValue().Keys(value[value.length - 1]);
                              }
                    }

                    if (Get_WinCRUFilter_GrpCondition_TxtValueDouble().Visible == true) {
                              Get_WinCRUFilter_GrpCondition_TxtValueDouble().Click();
                              Get_WinCRUFilter_GrpCondition_TxtValueDouble().Clear();
                              Get_WinCRUFilter_GrpCondition_TxtValueDouble().set_text(value);

                              var lettre = Get_WinCRUFilter_GrpCondition_TxtValue().Text.OleValue;
                              if (lettre == "" || lettre[lettre.length - 1] != value[value.length - 1]) {
                                        Get_WinCRUFilter_GrpCondition_TxtValueDouble().Keys("[End]");
                                        Get_WinCRUFilter_GrpCondition_TxtValueDouble().Keys(value[value.length - 1]);
                              }
                    }

                    if (Get_WinCRUFilter_GrpCondition_DgvValue().Visible == true) {
                              Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value", value, 100).Click();
                    }

                    Get_WinCRUFilter_BtnOK().Click();
                    WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo", "IsVisible"], ["ToggleButton", 1, true]);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    if (!Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists) {
                              Get_ModulesBar_BtnAccounts().Click();
                    } else {
                              Log.Message("le filtre n'est pas initialisation")
                    }
          }



}

function test(){

          var f1 = "#RealAccounts";
          var f2 = "#OpenAccounts";
          var f3 = "#CashAccounts";
          var f4 = "#TotalValue>0";
          var f5 = "#MarginNotn/a";
          var f6 = "#Balance>1000";
          var f7 = "#IACode0AAR";
          var f8 = "#CurrencyCAD";
          var f9 = "#NameA";
          var f10 = "#AccNo1";
          
    var ArrayOfFilter = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10];
    Log.Message(ArrayOfFilter.length);
}



function Get_WinCRUFilter_CmbOperator(operator)
{
  return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Description"], ["ComboBoxItem", operator], 10);
}

function Get_WinCRUFilter_CmbField(field) 
{
  return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ComboLabel"], ["ComboBoxItem", field], 10);
}

function Get_WinCRUFilter_CmbAccess(access)
{
  return Get_CroesusApp().FindChild(["ClrClassName", "DataContext.Value"], ["ComboBoxItem", access], 10);
}