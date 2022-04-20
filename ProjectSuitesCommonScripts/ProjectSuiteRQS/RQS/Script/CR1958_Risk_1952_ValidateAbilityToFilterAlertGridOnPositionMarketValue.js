//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions
//USEUNIT RQS_Get_functions

/*
      Valider la capacité de filtrer la grille d'alertes sur Position market value % ( Concentration %)	
      https://jira.croesus.com/browse/RISK-1952
      
      Analyste d'assurance qualité: Taous A.
      Analyste d'automatisation: Amine A. 
      
      Version de scriptage : ref90.16-54 */ 

function CR1958_Risk_1952_ValidateAbilityToFilterAlertGridOnPositionMarketValue(){

            var userDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "username");
            var pswdDARWIC = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DARWIC", "psw"); 
            var waitTime   = 3000;
            
            Log.Warning("Ce script roule sur la version 90.17 et plus");
      try {
             
           var positionMarketValuePercentageFilter = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1952_PositionMarketValue", language + client);
           var AllOperatorValues      = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1952_AllOperatorValues", language + client);
           var OperatorExcludedValues = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1952_OperatorExcludedValues", language + client);
           var filterValue            = ReadDataFromExcelByRowIDColumnID(filePath_RQS, "CR1958.2", "Risk_1952_FilterValue", language + client);
            
//             Se connecter
              Login(vServerRQS, userDARWIC, pswdDARWIC, language);
            
            // Attendre le boutton RQS présent et actif
              WaitObject(Get_CroesusApp(), "Uid", "ToolbarButton_2005", waitTime);
              Get_Toolbar_BtnRQS().WaitProperty("Enabled", true, waitTime);                                    
              Get_Toolbar_BtnRQS().Click();
              Get_WinRQS().Parent.Maximize();
          
              // Attendre l'onglet 'Alerts' présent et actif dans la fenêtre RQS
              WaitObject(Get_CroesusApp(), "Uid", "TabItem_a70d", waitTime);
              Get_WinRQS_TabAlerts().WaitProperty("Enabled", true, waitTime)          
          
              Get_WinRQS_TabAlerts().Click();
              Get_WinRQS_TabAlerts().WaitProperty("IsSelected", true, waitTime);
             
              //Appliquer le filtre
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(positionMarketValuePercentageFilter).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", waitTime);

              //Valider que la liste des opérateurs contient les 7 valeurs
              ValidateOperatorList(AllOperatorValues, true);
              
              //Valider que "is empty" et "is not empty" ne figurent pas dans la liste 
              ValidateOperatorList(OperatorExcludedValues, false);
              Get_WinCreateFilter_BtnCancel().Click();
              
              //Mettre la configuration par défaut des colonnes
              Get_WinRQS_TabAlerts_DgvAlerts_ChTest().ClickR();
              WaitObject(Get_SubMenus(), "Uid", "MenuItem_c549", waitTime)
              Get_WinRQS_ContextualMenu_DefaultConfiguration().Click();

              //Ajouter la colonne "Position Market Value (%)"
              Get_WinRQS_TabAlerts_DgvAlerts_ChTest().ClickR();
              WaitObject(Get_SubMenus(), "Uid", "MenuItem_c549", waitTime)
              Get_WinRQS_ContextualMenu_AddColumn().OpenMenu();
              Get_WinRQS_ContextualMenu_PositionMarketValue().Click();
            
              //Appliquer respectivement tous les opérateurs et valider que la liste des résultats est bien filtrée
              TryAllOperatorValues(positionMarketValuePercentageFilter, AllOperatorValues, filterValue)            
            }
            catch(e) {
              Log.Error("Exception: " + e.message, VarToStr(e.stack));
            }
            finally {
              //Fermer Croesus
              Terminate_CroesusProcess(); 
            }
  }  
  
function ValidateOperatorList(AllOperatorValues, booleanValue){

          var dataSeparatorChar        = "|";
          var arrayOfAllOperatorValues  = (Trim(AllOperatorValues) == "")? []: AllOperatorValues.split(dataSeparatorChar);
          
          Get_WinCreateFilter_CmbOperator().DropDown();
          
          for (j=0; j< arrayOfAllOperatorValues.length; j++){
              var operatorValue = arrayOfAllOperatorValues[j];
              Log.Message(j +" : " + operatorValue);
              if(booleanValue){
                var componentObject = Get_SubMenus().FindChild("WPFControlText", operatorValue, 10);
            
                if(componentObject.Exists){
                      aqObject.CheckProperty(componentObject, "VisibleOnScreen", cmpEqual, true);               
                      aqObject.CheckProperty(componentObject, "Isvisible",       cmpEqual, true);
                      Log.Checkpoint("Le libellé : '" + operatorValue + "'   Existe dans la liste 'Operator' et visible");
                }
                else  
                      Log.Error("Le libellé : '" + operatorValue + "'  n'existe pas dans la liste 'Operator'");       
              }
              else{
                if(Get_SubMenus().FindChild("WPFControlText", operatorValue, 10).Exists && Get_SubMenus().FindChild("WPFControlText", operatorValue, 10).IsVisible)
                    Log.Error("Le libellé : '" + operatorValue + "' est inattendu dans la liste"); 
                else 
                    Log.Checkpoint("Le libellé : '" + operatorValue + "'   ne figure pas dans la liste");      
              }
            }
          Get_WinCreateFilter_CmbOperator().CloseUp();
}   
  
function TryAllOperatorValues(positionMarketValuePercentageFilter, AllOperatorValues, value){
           
        var dataSeparatorChar         = "|";
        var arrayOfAllOperatorValues  = (Trim(AllOperatorValues) == "")? []: AllOperatorValues.split(dataSeparatorChar);

        for (j=0; j< arrayOfAllOperatorValues.length; j++){
              var operatorValue = arrayOfAllOperatorValues[j];
                     
              //Appliquer le filtre
              Get_WinRQS_QuickFilterClick();
              Get_WinRQS_QuickFilter_FilterField(positionMarketValuePercentageFilter).Click();
              WaitObject(Get_CroesusApp(), "Uid", "FilterWindow_9d71", 3000);
              SelectComboBoxItem(Get_WinCreateFilter_CmbOperator(), operatorValue);
              
              if (operatorValue == "between" || operatorValue == "entre")
                    Get_WinCreateFilter_TxtAndDouble().Keys(value); //Laisser la valeur minimale à 0
              else
                    Get_WinCreateFilter_TxtValueDouble().Keys(value);
              Get_WinCreateFilter_BtnApply().Click();
              
              //Si la fenêtre de dialogue existe fermer la et enlever le filtre (résultat du filtre vide)
              if(Get_DlgWarning().Exists){
                    Get_DlgWarning().Close()
                    Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                    WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
              }
              else{ //résultat n'est pas vide
                  WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                  var nbrAlertes = Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).items.Count;
                    
                  //Valider que le résultat du filtre respecte le filtre
                  Log.Message("Valider que le résultat du filtre respecte le filtre");
                    
                  switch(operatorValue){
                    case "equal to": case "égal(e) à":
                    {                 
                        Log.Message("Operator: equal to");  
                        for (i=0; i<nbrAlertes; i++)
                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, "OleValue", cmpEqual, value);                    
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                    case "is not equal to": case "n'égal(e) pas":
                    {  
                        Log.Message("Operator: is not equal to");  
                        for (i=0; i<nbrAlertes; i++)
                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem, "MarketValuePercent", cmpNotEqual, value);
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                    case "is greater than": case "est plus grand que":
                    {  
                        Log.Message("Operator: is greater than");  
                        for (i=0; i<nbrAlertes; i++)
                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, "OleValue", cmpGreater, value);
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                    case "is greater or equal to": case "est plus grand ou égal à":
                    {  
                        Log.Message("Operator: is greater or equal to");  
                        for (i=0; i<nbrAlertes; i++)
                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, "OleValue", cmpGreaterOrEqual, value);
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }                  
                    case "is lower than": case "est plus petit que":
                    {  
                        Log.Message("Operator: is lower than");  
                        for (i=0; i<nbrAlertes; i++){
                            var displayedValue = aqConvert.StrToFloat(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent.OleValue)
                            aqObject.CompareProperty(displayedValue, cmpLess, aqConvert.StrToFloat(value));
                            }
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                    case "is lower or equal to": case "est plus petit ou égal à":
                    {  
                        Log.Message("Operator: is lower or equal to");  
                        for (i=0; i<nbrAlertes; i++){
//                            aqObject.CompareProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, cmpLessOrEqual, value);
                            var displayedValue = aqConvert.StrToFloat(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent)
                            aqObject.CompareProperty(displayedValue, cmpLessOrEqual, aqConvert.StrToFloat(value));
                            }
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                    case "between": case "entre":
                    {  
                        Log.Message("Operator: between");  
                        for (i=0; i<nbrAlertes; i++){
//                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, "OleValue", cmpLessOrEqual, value);
//                            aqObject.CheckProperty(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent, "OleValue", cmpGreaterOrEqual, 0);
                            var displayedValue = aqConvert.StrToFloat(Get_WinRQS_TabAlerts_AlertList().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.MarketValuePercent)
                            aqObject.CompareProperty(displayedValue, cmpLessOrEqual, aqConvert.StrToFloat(value));
                            aqObject.CompareProperty(displayedValue, cmpGreaterOrEqual, 0);
                            
                        }
                        Get_WinRQS_TabAlerts_ToggleItems().WPFObject("Button", "", 2).Click();
                        WaitObject(Get_CroesusApp(), "Uid", "AlertList_5770", 5000);
                        break;
                    }
                  }
            }
      }
}
function Get_WinRQS_TabAlerts_ToggleItems(){
  return Get_WinRQS_TabAlerts_AlertsControl().WPFObject("alerts").WPFObject("RecordListControl", "", 1).WPFObject("PART_QuickFiltersScrollViewer").WPFObject("ContentControl", "", 1).WPFObject("ItemsControl", "", 1).WPFObject("ToggleButton", "", 1);
}
