//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT Modeles_Get_functions
//USEUNIT ExcelUtils

/* Analyste d'assurance qualité: Maestro CR1845
Analyste d'automatisation: Xian Wei */

function Performance_Mod_CR1845(){

        var SoughtForValue = "Performance_Mod_CR1845";
        var StopWatchObj = HISUtils.StopWatch;
//        var modelNo = GetData(filePath_Performance, sheetName_DataBD, 64, language);
//        var securityNameAdd = GetData(filePath_Performance, sheetName_DataBD, 65, language);
//        var securitySymbolAdd = GetData(filePath_Performance, sheetName_DataBD, 66, language);
//        var targetValue = GetData(filePath_Performance, sheetName_DataBD, 67, language);
//        var toleranceMin = GetData(filePath_Performance, sheetName_DataBD, 68, language);
//        var toleranceMax = GetData(filePath_Performance, sheetName_DataBD, 69, language);
//        var marketValue = GetData(filePath_Performance, sheetName_DataBD, 70, language);
//        var securitySymbolDel = GetData(filePath_Performance, sheetName_DataBD, 71, language);
//        var securityNameDel = GetData(filePath_Performance, sheetName_DataBD, 72, language);
//        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
//        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
//        var searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 36, language);
        
        var waitTimeLong  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "LongTime", language+client);
        var waitTimeShort = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ShortTime", language+client); 
        var modelNo  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ModelTAA", language+client);        
        var securityNameAdd    = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityNameAdd", language+client); 
        var securitySymbolAdd  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecuritySymbolAdd", language+client);
        var targetValue   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "TargetValue25", language+client); 
        var toleranceMin  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ToleranceMin5", language+client);        
        var toleranceMax  = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "ToleranceMax5", language+client);        
        var marketValue   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "MarketValue24", language+client);        
        var securitySymbolDel   = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecuritySymbolDel", language+client); 
        var securityNameDel     = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "SecurityNameDel", language+client);
        var searchCriterionName = ReadDataFromExcelByRowIDColumnID(filePath_Performance, sheetName_DataBD, "CriterionPerformanceModel", language+client);       

        
        if (projet == "PerformanceNFR"){
            var userNamePerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "username");
            var pswPerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "psw");
        } else {
            var userNamePerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "username");
            var pswPerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "psw");
        }
        
        try{
        
            // Se connecte
            Login(vServerPerformance, userNamePerformance, pswPerformance, language);

            // Clique le module modeles
            WaitObject(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["PadButton", "2"]);
            Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
            WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
            
            // Rechercher le mdoule
            Search_Model(modelNo);
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelNo]);
            Get_ModelsGrid().Find("Value",modelNo,100).Click();
            
            // Valider le modele activité
            Get_ModelsBar_BtnInfo().WaitProperty("Enabled", true, 15000); 
            Get_ModelsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(), "Uid", "InfoModelWindow_b101");
            
            if (Get_WinModelInfo_GrpModel_ChkActive().IsChecked == false)
            Get_WinModelInfo_GrpModel_ChkActive().Click();
            
            Get_WinModelInfo_BtnOK().Click();
            Search_Model(modelNo);
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelNo]);
            Get_ModelsGrid().Find("Value",modelNo,100).Click();
            
            //Maillage un module au portefeuille
            Drag(Get_ModelsGrid().Find("Value",modelNo,100), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
        
            // Ajoute une position a un modele
            AddPositionToModel(securitySymbolAdd,targetValue,toleranceMin,toleranceMax,marketValue,securityNameAdd);
            // Supprime une position
            DeletePosition(securitySymbolDel);
        
            // Sauvegarder positions
            Get_PortfolioBar_BtnSave().Click();
            WaitObject(Get_CroesusApp(), "Uid", "WhatIfSaveWindow_afd7", waitTimeShort);
            Get_WinWhatIfSave_BtnOK().Click();
        
            // Cliquer sur le bouton reequilibrer
            Get_Toolbar_BtnRebalance().Click();
            WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");  
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click();
            
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().WaitProperty("Enabled", true, 15000);
            if (Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().IsChecked == true)
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnSelectAll().Click();
            
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll().WaitProperty("Enabled", true, 15000);
            if (Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll().IsChecked == false)
            Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnAll().Click();
            
            Sys.Desktop.KeyDown(0x11); //Press Ctrl
            Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Find("Text",securityNameAdd,100).Click();
            Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().Find("Text",securityNameDel,100).Click();
            Sys.Desktop.KeyUp(0x11); //Release Ctrl
            
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
            
            Log.Picture(Sys.Desktop);
            Get_WinRebalance_BtnClose().Click();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["BaseWindow", 1]);
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-50);
        
            Get_MainWindow().SetFocus();
            Get_ModulesBar_BtnModels().WaitProperty("Enabled", true, 15000);
            
        }
        
        catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
        } finally {
            // retourner l'etat initiale
            
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
            Search_Model(modelNo);
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelNo]);
            Get_ModelsGrid().Find("Value",modelNo,100).Click();
            Drag(Get_ModelsGrid().Find("Value",modelNo,100), Get_ModulesBar_BtnPortfolio());
            WaitObject(Get_CroesusApp(), "Uid", "PortfolioPlugin_f3c4", waitTimeShort);
            Get_Portfolio_PositionsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).WaitProperty("VisibleOnScreen", true, 15000);
            
            // ajoute une position a un modele
            AddPositionToModel(securitySymbolDel,targetValue,toleranceMin,toleranceMax,marketValue);
            
            DeletePosition(securitySymbolAdd);
            // Sauvegarder
            Get_PortfolioBar_BtnSave().Click();
            WaitObject(Get_CroesusApp(), "Uid", "WhatIfSaveWindow_afd7", waitTimeShort);
            Get_WinWhatIfSave_BtnOK().Click();
            Delay(8000);
            
            Get_ModulesBar_BtnModels().Click(); 
            WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed");
            Search_Model(modelNo);
            WaitObject(Get_ModelsGrid(), ["ClrClassName", "value"], ["XamTextEditor", modelNo]);
            Get_ModelsGrid().Find("Value",modelNo,100).Click();
            Get_ModelsBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(), "Uid", "InfoModelWindow_b101");
            
            if (Get_WinModelInfo_GrpModel_ChkActive().IsChecked == false)
            Get_WinModelInfo_GrpModel_ChkActive().Click();
            Get_WinModelInfo_BtnOK().Click();
            
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();
        }
}


function test(){

        var SoughtForValue = "Performance_Mod_CR1845";
        var StopWatchObj = HISUtils.StopWatch;
        var modelNo = GetData(filePath_Performance, sheetName_DataBD, 64, language);
        var securityNameAdd = GetData(filePath_Performance, sheetName_DataBD, 65, language);
        var securitySymbolAdd = GetData(filePath_Performance, sheetName_DataBD, 66, language);
        var targetValue = GetData(filePath_Performance, sheetName_DataBD, 67, language);
        var toleranceMin = GetData(filePath_Performance, sheetName_DataBD, 68, language);
        var toleranceMax = GetData(filePath_Performance, sheetName_DataBD, 69, language);
        var marketValue = GetData(filePath_Performance, sheetName_DataBD, 70, language);
        var securitySymbolDel = GetData(filePath_Performance, sheetName_DataBD, 71, language);
        var securityNameDel = GetData(filePath_Performance, sheetName_DataBD, 72, language);
        var waitTimeShort = GetData(filePath_Performance, sheetName_DataBD, 45, language);
        var waitTimeLong = GetData(filePath_Performance, sheetName_DataBD, 44, language);
        var searchCriterionName = GetData(filePath_Performance, sheetName_DataBD, 36, language);
        
        var userNamePerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "username");
        var pswPerformance=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "BASTIE3", "psw");

Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(targetValue);
            Get_WinAddPositionSubmodel_TxtToleranceMinPercent().Click();
            Get_WinAddPositionSubmodel_TxtToleranceMinPercent().set_Text(toleranceMin);
            Get_WinAddPositionSubmodel_TxtToleranceMaxPercent().Click();
            Get_WinAddPositionSubmodel_TxtToleranceMaxPercent().set_Text(toleranceMax);
            Get_WinAddPositionSubmodel_TxtMarketValuePercent().Click();
            Get_WinAddPositionSubmodel_TxtMarketValuePercent().set_Text(marketValue); 
            Get_WinAddPositionSubmodel_TxtValuePercent().Click();      
            Get_WinAddPositionSubmodel_BtnOK().Click();
      
} 


function DeletePosition(securitySymbol)
{
    Log.Message("Delete position " + securitySymbol + ". The related position will be automatically deleted.");

    resultSecuritySearch = Get_Portfolio_PositionsGrid().FindChild("Value", securitySymbol, 10);
    if (resultSecuritySearch.Exists == true){
        Get_Portfolio_PositionsGrid().FindChild("Value", securitySymbol, 10).Click();
        Get_Toolbar_BtnDelete().Click();
        WaitObject(Get_CroesusApp(),"ClrFullClassName", "Croesus.ClientFoundations.CustomWidgets.CommonWindows.BaseWindow");
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, 70);
    }
        
    else {
        Log.Message("The position " + securitySymbol + " does not exist.");
    }
}


function AddPositionToModel(securitySymbol,targetValue,toleranceMin,toleranceMax,marketValue,securityName){
        
        Log.Message("Add position " + securitySymbol + ". The related position will be automatically added.");
        
        resultSecuritySearch = Get_Portfolio_PositionsGrid().FindChild("Value", securitySymbol, 10);
        if (resultSecuritySearch.Exists == false){
            Get_Toolbar_BtnAdd().WaitProperty("Enabled", true, 15000);
            Get_Toolbar_BtnAdd().Click();
        
            if (Get_DlgConfirmation().Exists == true){
                Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()*(2/3), 70);
            } 
        
            WaitObject(Get_CroesusApp(), "Uid", "AddPositionForModel_f7dd");
        
            Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().SetText(".");
            Delay(200);
            Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().SetText(securitySymbol);
            Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
            if(Get_SubMenus().Exists == true){
                Get_SubMenus().Find("Value",securityName,10).DblClick();
            }         
        
            Get_WinAddPositionSubmodel_TxtValuePercent().set_Text(targetValue);
            Get_WinAddPositionSubmodel_TxtToleranceMinPercent().Click();
            Get_WinAddPositionSubmodel_TxtToleranceMinPercent().set_Text(toleranceMin);
            Get_WinAddPositionSubmodel_TxtToleranceMaxPercent().Click();
            Get_WinAddPositionSubmodel_TxtToleranceMaxPercent().set_Text(toleranceMax);
            Get_WinAddPositionSubmodel_TxtMarketValuePercent().Click();
            Get_WinAddPositionSubmodel_TxtMarketValuePercent().set_Text(marketValue); 
            Get_WinAddPositionSubmodel_TxtValuePercent().Click();      
            Get_WinAddPositionSubmodel_BtnOK().Click();
        }
        
        else {
        Log.Message("The position " + securitySymbol + " exist.");
    }
} 

/**
    Description : Sélectionne un ou plusieurs positions
    Paramètre : arrayOfPositionsSymbolToBeSelected (tableau contenant les numéros de comptes à sélectionner)
    Résultat : Positions sélectionnés
*/
function SelectPositions(arrayOfPositionsSymbolToBeSelected)
{
    if (GetVarType(arrayOfPositionsSymbolToBeSelected) != varArray && GetVarType(arrayOfPositionsSymbolToBeSelected) != varDispatch)
        arrayOfPositionsSymbolToBeSelected = new Array(arrayOfPositionsSymbolToBeSelected);
        
    Get_WinRebalance_TabPositionsToRebalance_DgvPositionsToRebalance().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(false);
    
    positionsTotalCount = Get_WinAccountsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
    Log.Message("The positions total count is : " + positionsTotalCount);
    Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
    
    Sys.Desktop.KeyDown(0x11); //Press Ctrl
    nbOfSelectedPositions = 0;
    arrayOfAllPositionsSymbol = new Array();
    
    while (arrayOfAllPositionsSymbol.length < positionsTotalCount){
        accountsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (i = 0; i < accountsPageCount; i++){
            displayedAccountNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_AccountNumber());
            isFound = false;
            for (j = 0; j < arrayOfAllAccountsNumbers.length; j++){
                if (displayedAccountNumber == arrayOfAllAccountsNumbers[j]){ 
                    isFound = true;
                    break;
                }
            }
			
            if (!isFound){
                arrayOfAllAccountsNumbers.push(displayedAccountNumber);
                
                for (k = 0; k < arrayOfAccountsNumbersToBeSelected.length; k++){
                    if (displayedAccountNumber == arrayOfAccountsNumbersToBeSelected[k]){
                        Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).set_IsSelected(true);
                        nbOfSelectedAccounts ++;
                        break;
                    }
                }  
			}
        }
        
        if (nbOfSelectedAccounts == arrayOfAccountsNumbersToBeSelected.length)
            break;

        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
    
    }
    
    Sys.Desktop.KeyUp(0x11); //Release Ctrl
    
    if (nbOfSelectedAccounts < arrayOfAccountsNumbersToBeSelected.length)
        Log.Warning("Only " + nbOfSelectedAccounts + " out of " + arrayOfAccountsNumbersToBeSelected.length + " accounts have been selected!");
}

function Get_WinAddPositionSubmodel_TxtToleranceMinPercent(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_0a82", 10)}

function Get_WinAddPositionSubmodel_TxtToleranceMaxPercent(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_70fc", 10)}

function Get_WinAddPositionSubmodel_TxtMarketValuePercent(){return Get_WinAddPositionSubmodel().FindChild("Uid", "DoubleTextBox_e49f", 10)}

