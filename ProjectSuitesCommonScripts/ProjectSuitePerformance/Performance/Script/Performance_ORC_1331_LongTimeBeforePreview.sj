//USEUNIT Common_functions
//USEUNIT Common_Get_functions

//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Description : 
    https://jira.croesus.com/browse/TCVE-3351
    https://jira.croesus.com/browse/ORC-1331
    Analyste d'assurance qualité : 
    Analyste d'automatisation : Philippe Maurice
    Version: 2020.09-87 (environnement NFR)
    Date: 2020-12-08
*/

function Performance_ORC_1331_LongTimeBeforePreview()
{
    try {
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-3351","Lien de la story dans Jira");
           
        //-------------Declaration des Variables -------------//USEUNIT CommonCheckpoints
        var username = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "DESLAUJE", "psw");
        
        var curListCheckMarks = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "sourceTCVE3351", language+client);
        var critName          = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "criterionNameTCVE3351", language+client);
        var quantity          = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "quantitySellTCVE3351", language+client);
        var cmbTransaction    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "cmbTransactionTCVE3351", language+client);
        var btnInclude        = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "inclureButton_3351", language+client);
        var totalValue2M      = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "totalValue2M_3351", language+client);
        
        //Titres - Symboles
        var symbMSFT = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolMSFT", language+client);
        var symbBMO  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolBMO", language+client);
        var symbTD   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolTD", language+client);
        var symbXOM  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolXOM", language+client);
        var symbAAPL = ReadDataFromExcelByRowIDColumnID(filePath_Performance, "DataPerformanceNFR", "symbolAAPL", language+client);
        
        //Pour mesurer le temps
        var StopWatchObj   = HISUtils.StopWatch;
        var SoughtForValue = "Performance_TCVE_3351";
        var waitTimeShort  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client);
        
        
        //Se connecter à croesus avec DESLAUJE
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec DESLAUJE et sélectionner environ 300 comptes");
        Log.Message("Se connecter à croesus avec DESLAUJE");
        Login(vServerPerformance, username, password, language);
 
        //Préparation c'est-à-dire sélectionner 300 comptes réels
        Get_ModulesBar_BtnAccounts().Click();
        selectAccountsBySearchCriterion(totalValue2M, critName);
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "ProgressCroesusWindow_b5e1", waitTimeShort);
        
        //Ajouter transaction vente (quantité 100, Titre MSFT, OK)
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ajouter transactions de vente (Qté: 100 unités par compte, Titre: MSFT)");
        
        Get_Toolbar_BtnSwitchBlock().Click();   //Cliquer sur ordres multiples et attendre la fenêtre
        WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
        //Cliquer sur Sources et choisir Liste courante (Crochets)
        Get_WinSwitchBlock_GrpParameters_CmbSources().Click();  
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock", curListCheckMarks],10).Click();
        
        AddABuyBySymbol(quantity, cmbTransaction, symbMSFT);  //Ajouter transaction

        //Ajouter Transactions équivalentes
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Ajouter transactions équivalentes achat (Répartition = 25%, Symb = BMO, TD, XOM et ensuite AAPL)");
        Delay(2000);
        PurchasequivalentTransactAddiction("25", symbBMO);  //Répartition: 25% / Titre: BMO / OK
        PurchasequivalentTransactAddiction("25", symbTD);   //Répartition: 25% / Titre: TD / OK 
        PurchasequivalentTransactAddiction("25", symbXOM);  //Répartition: 25% / Titre: XOM / OK
        PurchasequivalentTransactAddiction("25", symbAAPL); //Répartition: 25% / Titre: AAPL / OK
        
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Cliquer sur 'Aperçu' afin de voir le temps que ça prend");
               
        Get_WinSwitchBlock_BtnPreview().Click();  //Cliquer sur Aperçu
        
        //Mesure la performance du clique sur le boutton 'Aperçue'
        StopWatchObj.Start();
        
        //Message de confirmation pour inclure les comptes (au besoin)
        if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button", btnInclude],10).Click();
        }        
        //Avertissement
        if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive){
            Get_DlgWarning().Keys("[Enter]");
        }
        //Message de confirmation pour inclure les comptes (au besoin)
        if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button", btnInclude],10).Click();
        }
        //Avertissement
        if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive){
            Get_DlgWarning().Keys("[Enter]");    
        }  
        //Attendre que le boutton 'Generate' devient actif
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("Enabled", true, waitTimeShort);
  
        //Arrêter le timer
        StopWatchObj.Stop();
        
        //Info
        if (Get_DlgInformation().Exists && Get_DlgInformation().IsActive){
            Get_DlgInformation().Keys("[Enter]");
        }
        Get_WinSwitchBlock_BtnCancel().Click();
      
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 5: Écrire les résultats dans un fichier Excel");
        // Écrire le résultat dans le fichier excel
        Log.Message(SoughtForValue + " finished. Execution time: " + StopWatchObj.ToString());   
        var row = FindExcelRow(filePath_Performance, sheetName_Performance, SoughtForValue);
        WriteExcelSheet(filePath_Performance, sheetName_Performance, row, aqConvert.StrToInt(numCell_PerformanceBD), StopWatchObj.ToString());
        
        //Cleanup (désactiver le critère de recherche et le supprimer)
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 6: Cleanup en désactivant critère de recherche et le supprimer.");
        Get_RelationshipsClientsAccountsGrid_BtnActiveCriteria_BtnRemove().Click();
        DeleteCriterion(critName);
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
}


function selectAccountsBySearchCriterion(totalValue, criterionName) {
    
    Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
    
    Get_WinAddSearchCriterion_TxtName().Clear();
    Get_WinAddSearchCriterion_TxtName().Keys(criterionName);
        
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemCalculation_ItemTotalValue().Click();
   
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemGreaterThan().Click();
    
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(totalValue +"[Enter]");
    Delay(1000);
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
    Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
    
    Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
}


function PurchasequivalentTransactAddiction(allocationPercen, symbol)
{    
    Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
    Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(allocationPercen);
        
    Get_WinSwitchEquivalent_CmbSecurity().Click();
        
    Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(symbol);  
    Get_WinSwitchEquivalent_BtnQuickSearchListPicker().Click();
    Delay(1000);
    
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", symbol, 10).DblClick();
    }
        
    Get_WinSwitchEquivalent_btnOK().Click();
 }
 
function AddABuyBySymbol(quantity, cmbTransaction, symbol)
{
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
    WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
    Get_WinSwitchSource_TxtQuantity().Keys(quantity);
    Get_WinSwitchSource_CmbQuantity().Click();
    Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem", cmbTransaction],10).Click();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", symbol, 10).DblClick();
    }
    
    Get_WinSwitchSource_btnOK().Click();
    
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
 }
 
 
function CheckABuyInGrid(quantity, symbol)
{
    if (language == "french") var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Achat", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
    else var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Buy", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
    
    aqObject.CheckProperty(item.DataItem, "Quantity", cmpEqual, quantity);
    aqObject.CheckProperty(item.DataItem, "SymbolDisplay", cmpEqual, symbol);
}