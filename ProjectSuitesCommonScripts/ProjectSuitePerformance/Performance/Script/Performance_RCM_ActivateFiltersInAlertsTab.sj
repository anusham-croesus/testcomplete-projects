//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions
//USEUNIT Performance_RCMBtn

/*
      Analyste d'assurance qualité: Carole T.
      Analyste d'automatisation: Amine A. */

function Performance_RCM_ActivateFiltersInAlertsTab(){

        var StopWatchObj    = HISUtils.StopWatch;
        var SoughtForValue  = "Performance_RCM_ActivateFiltersInAlertsTab";
        var SoughtForValue2 = "Performance_RCM_DesactivateFiltersInAlertsTab";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        var filterName01 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Filter01", language+client);
        var filterName02 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Filter02", language+client);
        var filterName03 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Filter03", language+client);
        
        var fieldValue01 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Field01", language+client);
        var fieldValue02 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Field02", language+client);
        var fieldValue03 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Field03", language+client);
        
        var operatorValue01 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Operator01", language+client);
        var operatorValue02 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Operator02", language+client);
        var operatorValue03 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Operator03", language+client);
        
        var chValue01 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Value01", language+client);
        var chValue02 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Value02", language+client);
        var chValue03 = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD_RCM, "Value03", language+client);
        
        var waitTime = 5000;
        var alertStatusDate = "2019";
        
        var column=FindColumn(filePath_Performance_simulateur,sheetName_Performance,SoughtForValue+"_01")
        

        try {
              Activate_Inactivate_PrefFirm("FIRM_1", "PREF_BULK_VALIDATION_REMINDER", "", vServerPerformance);
              
              // Se connecte
              Login(vServerPerformance, userNamePerformance, pswPerformance, language);
            
              // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005");
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
                                     
              // Attendre l'onglet 'Alerts' présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
              Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)          
          
              Get_WinRQS_TabAlerts().Click(); 
              //Fermer la fenêtre de dialogue
              SetAutoTimeOut();
              if(Get_DlgWarning().Exists){
                   Get_DlgWarning_BtnOK().Click();} 
              RestoreAutoTimeOut();
              
              WaitObject(Get_CroesusApp(), "Uid", "AlertsControl_53a1", waitTime);
              Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
              
              /* Changer la date du filte à 2019
              Get_WinRQS_TabAlerts_CmbAlertStatusDatePicker().Click();
              if(Get_SubMenus().Exists){
                  Get_SubMenus().Find("Text",alertStatusDate,10).Click();}
              WaitObject(Get_CroesusApp(), "Uid", "AlertsControl_53a1", waitTime);*/
              
              //Adaptation des scripts cas le filter 2019 n'existe plus 
              var dateFrom ="";
              var dateTo ="";
              if(language=="french"){
                dateFrom="20190101";
                dateTo ="20191231";
              }else{
                dateFrom="01012019";
                dateTo ="12312019";
              };
              ChangeDateOfLastAlertStatus(dateFrom,dateTo);
              
             //Enlever tout les filtres appliqués
              var nbActiveFilter = Get_WinRQS_TabAlerts_AlertsControl().WPFObject("alerts").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
              while(nbActiveFilter > 0){
                  if (Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).wState)
                      Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).WPFObject("Button", "", 2).Click();
                  nbActiveFilter -= 1;
              }
              //Créer les 3 filtres
              CreateFilter(filterName01,fieldValue01,operatorValue01,chValue01);
              CreateFilter(filterName02,fieldValue02,operatorValue02,chValue02);
              CreateFilter(filterName03,fieldValue03,operatorValue03,chValue03);
              
              //Enlever tout les filtres appliqués
              var nbActiveFilter = Get_WinRQS_TabAlerts_AlertsControl().WPFObject("alerts").WPFObject("RecordListControl", "", 1).WPFObject("ItemsControl", "", 1).DataContext.NbConditionInList             
              while(nbActiveFilter > 0){
                  if (Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).wState)
                      Get_WinRQS_TabAlerts_BtnFilter(nbActiveFilter).WPFObject("Button", "", 2).Click();
                  nbActiveFilter -= 1;
              }              
              
              // Mesurer la performance d'activation des 3 filtres 
              PerformanceFilterActivate(filterName01,SoughtForValue + "_01",waitTimeShort,filePath_Performance_simulateur,column);
              PerformanceFilterActivate(filterName02,SoughtForValue + "_02",waitTimeShort,filePath_Performance_simulateur,column);
              PerformanceFilterActivate(filterName03,SoughtForValue + "_03",waitTimeShort,filePath_Performance_simulateur,column);
              
              // Mesurer la performance de desactivation des 3 filtres 
              PerformanceFilterDesactivate(filterName01,SoughtForValue2 + "_01",waitTimeShort,filePath_Performance_simulateur,column);
              PerformanceFilterDesactivate(filterName02,SoughtForValue2 + "_02",waitTimeShort,filePath_Performance_simulateur,column);
              PerformanceFilterDesactivate(filterName03,SoughtForValue2 + "_03",waitTimeShort,filePath_Performance_simulateur,column);
              
               //fermer la fenêtre 
              Get_WinRQS().Close();
              
              //Supprimer les Filtres
              DeleteFilter(filterName01);
              DeleteFilter(filterName02);
              DeleteFilter(filterName03);              
             
        }        
        catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {        
            //Fermer Croesus
           TerminateProcess("CroesusClient"); 
        }
}

function PerformanceFilterActivate(filterName, SoughtForValue,waitTimeShort,filePath_Performance_simulateur,column){
              var StopWatchObj = HISUtils.StopWatch;
              
              Log.Message("Mesure de performance du filtre :"+filterName)
              Get_WinRQS_QuickFilterClick(); 
              Get_SubMenus_ByDescription(filterName).Click();
              
              // Mesurer la performance d'activer le filtre    
              StopWatchObj.Start();
              WaitObject(Get_CroesusApp(), ["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], waitTimeShort);
              //Get_WinRQS_TabAlerts_BtnFilterByDescription(filterName).WaitProperty("VisibleOnScreen", true, waitTimeShort);
              //Get_WinRQS_TabAlerts_BtnFilterByDescription(filterName).WaitProperty("IsChecked", true, waitTimeShort);
              var timeSpotted=StopWatchObj.Split()/1000
              StopWatchObj.Stop();
        
              // Écrit le résultat dans le fichier excel
              Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
              /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
              
              var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);

}

function PerformanceFilterDesactivate(filterName, SoughtForValue,waitTimeShort,filePath_Performance_simulateur,column){
              var StopWatchObj = HISUtils.StopWatch;
//              var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
              
              Get_WinRQS_TabAlerts_BtnFilterByDescription(filterName).WPFObject("PART_Text").Click();  
              
              // Mesurer la performance de désactiver le filtre    
              StopWatchObj.Start();
              //WaitObject(Get_CroesusApp(), ["ClrClassName", "DataContext.FilterDescription"], ["ToggleButton", filterName], waitTimeShort);
              Get_WinRQS_TabAlerts_BtnFilterByDescription(filterName).WaitProperty("IsChecked", false, waitTimeShort);
              var timeSpotted=StopWatchObj.Split()/1000
              StopWatchObj.Stop();
        
              // Écrit le résultat dans le fichier excel
              Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());
              /*var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), timeSpotted);*/
              
              var Newrow = FindRow(filePath_Performance_simulateur, sheetName_Performance, SoughtForValue);
              WriteExcelSheet(filePath_Performance_simulateur, sheetName_Performance, Newrow, column+1, timeSpotted);
}

function CreateFilter(filterName,fieldValue,operatorValue,chValue){
                            
              var addFilter = "Add a Filter...";
              if (language == "french")
                    addFilter = "Ajouter un filtre...";
                            
              Get_WinRQS_QuickFilterClick();
              WaitObject(Get_CroesusApp(), ["ClrClassName", "ClrFullClassName"], ["MenuItem", "System.Windows.Controls.MenuItem"], 3000);
              Get_SubMenus().WaitProperty("VisibleOnScreen", true, 3000);  

              //Choisir le sous-menu 'Ajouter Filtre' 
              Log.Message("Créer le Filte: "+ filterName)
              Get_SubMenus_ByDescription(addFilter).Click();
              WaitObject(Get_CroesusApp(), "Uid", "Button_ed99", 5000);
              Get_WinCRUFilter_BtnOK().WaitProperty("VisibleOnScreen", true, 3000);

              Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);
     
              Get_WinCRUFilter_GrpCondition_CmbField().DropDown();
              Get_WinCRUFilter_CmbField(fieldValue).Click();

              Get_WinCRUFilter_GrpCondition_CmbOperator().DropDown();
              Get_WinCRUFilter_CmbOperator(operatorValue).Click();
  
              if (Get_WinCRUFilter_GrpCondition_DgvValue().Visible == true) 
                   Get_WinCRUFilter_GrpCondition_DgvValue().Find("Value", chValue, 100).Click();                               
              else 
                    if (Get_WinCRUFilter_GrpCondition_TxtValue().Visible == true) {
                        Get_WinCRUFilter_GrpCondition_TxtValue().Click();
                        Get_WinCRUFilter_GrpCondition_TxtValue().Clear();
                        Get_WinCRUFilter_GrpCondition_TxtValue().set_text(chValue);
                    }
                                            
              Get_WinCRUFilter_BtnOK().Click();
}

function DeleteFilter(filterName){
  Delete_FilterCriterion(filterName, vServerPerformance)
}


function DeleteFilter1(filterName){
  
            var manageFilter = "Manage Filters...";
                  if (language == "french")
                        manageFilter = "Gérer les filtres...";
          
            Log.Message("Supprimer le Filte: "+ filterName)            
            Get_WinRQS_QuickFilterClick();
            //Choisir le sous-menu 'Gerer Filtre' 
            Get_SubMenus_ByDescription(manageFilter).Click();
            WaitObject(Get_CroesusApp(), "Uid", "ManagerWindow_283f",3000);
            Get_WinUserMultiSelection_Win_ManageFilter().Maximize(); 
            
            Get_WinUserMultiSelection_Win_ManageFilter().Click(200,200);
            Get_WinUserMultiSelection_Win_ManageFilter().MouseWheel(-10);
            Get_WinUserMultiSelection_Win_ManageFilter().MouseWheel(10);
            
            var width  = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().get_Width();
            var height = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().get_Height();
            
            var isFilterExists  = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Value"], ["CellValuePresenter", filterName], 10).Exists;
            while(!isFilterExists){
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Click(width-22,height - 95);
                isFilterExists = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Value"], ["CellValuePresenter", filterName], 10).Exists;
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Click(width-22,height - 95);
                }
                
            var isFilterVisible = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Value"], ["CellValuePresenter", filterName], 10).get_IsVisible();
  
  
            while(!isFilterVisible){
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Click(width-22,height - 95);
                isFilterVisible = Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Value"], ["CellValuePresenter", filterName], 10).get_IsVisible();
                Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Click(width-22,height - 95);
                }
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild(["ClrClassName", "Value"], ["CellValuePresenter", filterName], 10).Click();
                          
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().FindChild(["ClrClassName", "DisplayText"], ["XamTextEditor", filterName], 10).Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
            Get_DlgConfirmation_BtnDelete().Click();
            Delay(3000);
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnClose().Click();
}
function  Get_WinRQS_QuickFilterClick(){
          Get_WinRQS().Click(7,100);
}


