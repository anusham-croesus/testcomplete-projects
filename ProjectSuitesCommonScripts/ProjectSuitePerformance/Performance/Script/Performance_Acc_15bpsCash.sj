//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Comptes_Get_functions

/* Analyste d'assurance qualité: karima.mehiguene
Analyste d'automatisation: Xian Wei */

function Performance_Acc_15bpsCash(){

        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_15bpsCash";
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var criterionAccounts15bps = GetData(filePath_Performance, sheetName_DataBD, 54, language);
        
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);        
        var criterionAccounts15bps = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionAccounts15bps", language+client);         
        
        var criterionValue1 = "0.15";
        var criterionValue2 = "0";
        var criterionValue3 = "1CAD";
        
        try {
        // Se connecte
        Login(vServerPerformance, userPerformanceBELAIRA, pswPerformanceBELAIRA, language);

        // Clique le module Comptes
        WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "5"]);
        Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
        Get_ModulesBar_BtnAccounts().Click();
        WaitObject(Get_RelationshipsClientsAccountsPlugin(), "ClrFullClassName", "Infragistics.Windows.DataPresenter.RecordListControl");
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "21"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        // Vérifie le bouton est prêt
        Get_Toolbar_BtnManageSearchCriteria().WaitProperty("Enabled", true, 15000);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Get_Toolbar_BtnManageSearchCriteria().Click();
        Sys.Process("CroesusClient").WPFObject("HwndSource: CriteriaManagerWindow").Maximize();
        var count = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Count
        var findFilter = false;
            for (i = 0; i <= count - 1; i++) {
                        if (Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description() == criterionAccounts15bps) {
                                  findFilter = true;
                                  break;
                        }
            }
            
        if (findFilter == false) {

                Get_WinSearchCriteriaManager_BtnClose().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_efa9");
                
                Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
                Get_WinAddSearchCriterion_TxtName().Clear();
                Get_WinAddSearchCriterion_TxtName().Keys(criterionAccounts15bps);
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859_ItemAdministration().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemProfil_ItemPrivateWealth1859_ItemAdministration_Partnership().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemDiscretionaryBG().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2().Click()
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHoldingSecurities().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_2().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemPercentAccountTotalValue().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Click();
                Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2().Keys(criterionValue1);

                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_3().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHoldingSecurities().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_3().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemPercentAccountTotalValue().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_3().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterOrEqualTo().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_3().Click();
                Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_3().Keys(criterionValue2);
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_3().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_4().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemWith().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_4().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSymbol().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_4().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        
                Get_WinAddSearchCriterion_LvwDefinition_TxtEqualToValue_4().Click();
                Get_WinAddSearchCriterion_LvwDefinition_TxtEqualToValue_4().Keys(criterionValue3);
        
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_4().Click();
                Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        
                Get_WinAddSearchCriterion_BtnSave().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "CriteriaWindow_9bb5");
                Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        }else{
                Get_WinSearchCriteriaManager_BtnClose().Click();
                WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ManagerWindow_efa9");
        }
        
        
        Get_MenuBar_Users().Click();
        if (Get_MenuBar_Users_Firm().IsChecked == false){
              Get_MenuBar_Users_Firm().Click();
        } else {
              Get_MenuBar_Users().Click();
        }
        
        // Clique le bouton gérer les critères de recherche
        Get_Toolbar_BtnManageSearchCriteria().Click();
        WaitObject(Get_CroesusApp(), ["ClrClassName", "Uid"], ["CriteriaManagerWindow", "ManagerWindow_efa9"]);
        Get_WinSearchCriteriaManager().Parent.Maximize();
        
        // Clique le critère de recherche
        var rowCount = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.get_Count();
        for (var i = 0; i < rowCount; i++){
            displayedCriterionName = Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_Description();
              if (displayedCriterionName == criterionAccounts15bps){
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                Get_WinSearchCriteriaManager_DgvCriteria().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsActive(true);
                break;
              }
        }
    
        // Mesuse la performance le critère de recherche
        StopWatchObj.Start();
        Get_WinSearchCriteriaManager_BtnRefresh().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", waitTimeLong);
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);
        StopWatchObj.Stop();
    
        // Écrit le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());  
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());

        //Fermer le critère de recherche     
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1], waitTimeShort);
        
        }
        catch(e) {
          Log.Error("Exception: " + e.message, VarToStr(e.stack));
        }
        finally {
        
        Terminate_CroesusProcess(); //Fermer Croesus
        Terminate_IEProcess();
        }

}

function test(){
  
        var StopWatchObj = HISUtils.StopWatch;
        var SoughtForValue = "Performance_Acc_15bpsCash";
        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
        var searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 29, language);
        var criterionAccounts15bps = GetData(filePath_Performance, sheetName_DataBD, 54, language);
        var criterionValue1 = "0.15";
        var criterionValue2 = "0";
        var criterionValue3 = "1CAD";
        
       Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        




}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSymbol() {
          if (language == "french") {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "symbole"], 10)
          } else {
                    return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "symbol"], 10)
          }
}



function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemWith()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "avec"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "with"], 10)}
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_4() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_4() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_4() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtEqualToValue_4() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)
          }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_4() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 4], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)
          }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_3() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_3() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_3() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_3() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_3() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 3], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)
          }
}



function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verbe>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Verb>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbField_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Champ>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Field>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Opérateur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Operator>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Suivant>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Next>"], 10)
          }
}

function Get_WinAddSearchCriterion_LvwDefinition_TxtGreaterThanValue_2() {
          if (language == "french") {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Valeur>"], 10)
          } else {
                    return Get_WinAddSearchCriterion_LvwDefinition().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ListBoxItem", 2], 10).FindChild(["ClrClassName", "DataContext.SelectedValue"], ["PartControl", "<Value>"], 10)
          }
}



function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemLowerThan() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "inférieur(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "lower than"], 10)
          }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterOrEqualTo() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "supérieur(e) ou égal(e) à"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "greater or equal to"], 10)
          }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemPercentAccountTotalValue()
{
  if (language == "french"){return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "pourcentage de la valeur totale du compte"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "percent of account total value"], 10)}
}



function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHoldingSecurities()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "détenant des titres (qté <> 0) ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "holding securities (qty <> 0) having"], 10)}
}



function Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemAnd() {
          if (language == "french") {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "et"], 10)
          } else {
                    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "and"], 10)
          }
}
