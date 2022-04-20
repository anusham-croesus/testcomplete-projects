//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Relations_Get_functions


/**
    Description : Valider le fonctionnement du bouton Sommation des relations
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-583
    Analyste d'assurance qualité : Reda Alfaiz
    Analyste d'automatisation : Christophe Paring
*/

function CR1352_0583_Rel_Validate_the_operation_of_the_Relationships_Sum_button()
{
    try {
        //Log.Warning("Script en cours de Maintenance"); //Christophe
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-583", "CR1352_0583_Rel_Validate_the_operation_of_the_Relationships_Sum_button()");
        Login(vServerRelations, userName, psw, language);
        
        Log.AppendFolder("Étape 1: Accéder le module Relations et cliquer sur le bouton Sommation.");
        
        // Ouvrir la fenêtre Sommation pour récupérer la devise par défaut et la valeurs attendues
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 100000);
        GetRegionalSettings();
        Get_Toolbar_BtnSum().Click();
        
        Log.PopLogFolder();
        Log.AppendFolder("Étape 2: Valider le nombre et la somme de relations affichées.");
        
        var sumArrayOfCurrencyNames = new Array();
        var sumArrayOfSumOfTotalValues = new Array();
        var sumArrayOfNbOfRelationships = new Array();
        var sumConvertedSumOfTotalValues = null;
        
        var sumConvertedSumOfTotalValuesCell = Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).FindChild(["ClrClassName", "Uid"], ["CellValuePresenter", "Value.SumTotalValue"], 10);
        SetAutoTimeOut();
        if (!sumConvertedSumOfTotalValuesCell.Exists)
            return Log.Error("The Sum window converted Total Sum cell was not found.");
        RestoreAutoTimeOut();
        var sumConvertedSumOfTotalValues = convertTextToNumber(VarToStr(sumConvertedSumOfTotalValuesCell.WPFControlText));
        
        var childrenCount = Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).ChildCount;
        for (var i = 0; i < childrenCount; i++){
            if (Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).get_DataItemIndex() == -1)
                break;
        
            sumArrayOfCurrencyNames.push(VarToStr(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Value.get_Currency()));
            sumArrayOfSumOfTotalValues.push(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Value.get_SumTotalValue());
            sumArrayOfNbOfRelationships.push(Get_WinRelationshipsSum_DgvDataGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Value.get_CountLink());
        }
        Get_WinRelationshipsClientsAccountsSum_BtnClose().Click();
        
        if (sumArrayOfCurrencyNames.length < 2){
            var totalLabelText = sumArrayOfCurrencyNames[0];
            //var sumConvertedSumOfTotalValues = sumArrayOfSumOfTotalValues[0];
            var sumNbOfRelationships = sumArrayOfNbOfRelationships[0];
        }
        else {
            var totalLabelText = sumArrayOfCurrencyNames.shift();
            //var sumConvertedSumOfTotalValues = sumArrayOfSumOfTotalValues.shift();
            var sumNbOfRelationships = sumArrayOfNbOfRelationships.shift();
        } 
        
        var defaultCurrency = totalLabelText.substr(aqString.Find(totalLabelText, "(") + 1, 3);
        Log.Message("The default currency is : " + defaultCurrency);
        
        //Obtenir les taux de conversion vers la devise par défaut
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 100000);
        
        Get_SecuritiesBar_BtnExchangeRate().Click();
        Get_WinExchangeRate_BtnSetup().Click();
        
        var arrayOfCurrenciesCheckboxes = Get_WinCurrencySelection().FindAllChildren(["ClrClassName", "WPFControlOrdinalNo"], ["CheckBox", 1], 10).toArray();
        for (var i = 0; i < arrayOfCurrenciesCheckboxes.length; i++)
                arrayOfCurrenciesCheckboxes[i].set_IsChecked(true);
        
        Get_WinCurrencySelection_BtnOK().Click();
        
        Get_WinExchangeRate_TabCrossRates().Click();
        
        var currenciesCount = Get_WinExchangeRate_TabCrossRates_DgvRates().WPFObject("RecordListControl", "", 1).Items.Count;
        
        var isdefaultCurrencyFound = false;
        for (var toCurrencyIndex = 2; toCurrencyIndex <= currenciesCount + 1; toCurrencyIndex++){
            toCurrency = VarToStr(Get_WinExchangeRate_TabCrossRates_DgvRates().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["HeaderLabelArea", 1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", toCurrencyIndex], 10).Content.OleValue);
            if (toCurrency == defaultCurrency){
                defaultCurrencyColumnIndex = toCurrencyIndex;
                isdefaultCurrencyFound = true;
                break;
            }
        }
        
        if (!isdefaultCurrencyFound){
            Log.Error("The default currency '" + defaultCurrency + "' was not found in the Cross Rates grid.")
            return;
        }
        
        var arrayOfDefaultCurrencyRates = new Array();
        for (var fromCurrencyIndex = 1; fromCurrencyIndex <= currenciesCount; fromCurrencyIndex++){
            var fromCurrency = VarToStr(Get_WinExchangeRate_TabCrossRates_DgvRates().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", fromCurrencyIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 1], 10).Value.OleValue);
            var currencyRate = Get_WinExchangeRate_TabCrossRates_DgvRates().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", fromCurrencyIndex], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", defaultCurrencyColumnIndex], 10).Value.OleValue;
            arrayOfDefaultCurrencyRates[fromCurrency] = ConvertToNumberStandardFormat(currencyRate);
        }
        
        Get_WinExchangeRate_BtnClose().Click();
        
        //Parcourir la grille et y récupérer les valeurs affichées    
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);
        
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
        
        var gridArrayOfCurrencyNames = new Array();
        var gridArrayOfSumOfTotalValues = new Array();
        var gridArrayOfNbOfRelationships = new Array();
        
        var arrayOfRelationshipsNo = new Array();
        var previousPageFirstRelationshipNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem.get_LinkNumber();
        var currentPageFirstRelationshipNo = null;
        while (VarToStr(previousPageFirstRelationshipNo) != VarToStr(currentPageFirstRelationshipNo)){
            var croesusPageRowCount = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.get_Count();
        
            for (var i = 0; i < croesusPageRowCount; i++){
                var gridCurrentRelationshipNo = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_LinkNumber());
            
                if (GetIndexOfItemInArray(arrayOfRelationshipsNo, gridCurrentRelationshipNo) == -1){
                    arrayOfRelationshipsNo.push(gridCurrentRelationshipNo);
                
                    gridCurrentCurrencyName = VarToStr(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_Currency());
                    gridCurrentTotalValue = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.get_TotalValue();
                
                    if (GetIndexOfItemInArray(gridArrayOfCurrencyNames, gridCurrentCurrencyName) == -1){
                        gridArrayOfCurrencyNames.push(gridCurrentCurrencyName);
                        gridArrayOfSumOfTotalValues.push(0);
                        gridArrayOfNbOfRelationships.push(0);
                    }
                
                    gridArrayOfSumOfTotalValues[GetIndexOfItemInArray(gridArrayOfCurrencyNames, gridCurrentCurrencyName)] += gridCurrentTotalValue;
                    gridArrayOfNbOfRelationships[GetIndexOfItemInArray(gridArrayOfCurrencyNames, gridCurrentCurrencyName)] += 1;
                }
            }
        
            previousPageFirstRelationshipNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem.get_LinkNumber();
            Get_RelationshipsClientsAccountsGrid().Keys("[PageDown]");
            currentPageFirstRelationshipNo = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem.get_LinkNumber();
        }
    
        var gridNbOfRelationships = 0;
        for (var i = 0; i < gridArrayOfNbOfRelationships.length; i++)
            gridNbOfRelationships += gridArrayOfNbOfRelationships[i];
    
        var gridConvertedSumOfTotalValues = 0;
        for (var j = 0; j < gridArrayOfCurrencyNames.length; j++)
            gridConvertedSumOfTotalValues += gridArrayOfSumOfTotalValues[j]*arrayOfDefaultCurrencyRates[gridArrayOfCurrencyNames[j]];
    
        //Vérifier que les résultats de la grille correspondent à ceux de la fenêtre Sommation
        Log.Message("Verify that the sum window values match those of the grid.");
        if(client == "CIBC")
            CheckEquals(sumConvertedSumOfTotalValues, gridConvertedSumOfTotalValues, "The converted sum of total values");
        else
            CheckEquals(sumConvertedSumOfTotalValues, gridConvertedSumOfTotalValues.toFixed(2), "The converted sum of total values");
        CheckEquals(sumNbOfRelationships, gridNbOfRelationships, "The total number of relationships");
    
        for (var j = 0; j < gridArrayOfCurrencyNames.length; j++)
            CheckEquals(sumArrayOfNbOfRelationships[GetIndexOfItemInArray(sumArrayOfCurrencyNames, gridArrayOfCurrencyNames[j])], gridArrayOfNbOfRelationships[GetIndexOfItemInArray(gridArrayOfCurrencyNames, gridArrayOfCurrencyNames[j])], "The number of relationships for the currency " + gridArrayOfCurrencyNames[j]);
    
        for (var j = 0; j < gridArrayOfCurrencyNames.length; j++)
            if (GetIndexOfItemInArray(sumArrayOfCurrencyNames, gridArrayOfCurrencyNames[j]) == -1)
                Log.Error("The currency '" + gridArrayOfCurrencyNames[j] + "' was in the grid but not found in the sum window.");
    
        for (var j = 0; j < sumArrayOfCurrencyNames.length; j++)
            if (GetIndexOfItemInArray(gridArrayOfCurrencyNames, sumArrayOfCurrencyNames[j]) == -1)
                Log.Error("The currency '" + sumArrayOfCurrencyNames[j] + "' was in the sum window but not found in the grid.");
    
        //Afficher juste les colonnes par défaut    
        Get_RelationshipsGrid_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        Delay(3000);
        
        Log.PopLogFolder();
        Log.AppendFolder("Étape 3: Cliquer sur le menu \"edition\" puis \"Exporter vers MS excel\".");
        
        //Cliquer sur le menu "edition" puis "Exporter vers MS Excel"
        Get_MenuBar_Edit().Click();
        Get_MenuBar_Edit_ExportToMsExcel().Click();
    
        //Fermer les fichiers Excel
        TerminateProcess("EXCEL");
        var objExcel = Sys.FindChild("ProcessName", "EXCEL");
        SetAutoTimeOut();
        if (objExcel.Exists){
            Log.Warning("Excel ne s'est pas fermé la 1ere fois");
            objExcel.Terminate();
        }
        RestoreAutoTimeOut();
        //Récupérer le chemin d'accès du dernier fichier se trouvant dans : C:\\Users\\"+user+"\\AppData\\Local\\Temp\\CroesusTemp\\
        var folderPath= Sys.OSInfo.TempDirectory + "\CroesusTemp\\";
        Log.Message("The CroesusTemp folder path is : " + folderPath);
        var fileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        var filePath = FindLastModifiedFileInFolder(folderPath, fileNameContains);
        Log.Message("The output file path is : " + filePath);
        
        Log.PopLogFolder();
        Log.AppendFolder("Étape 4: Additionner les valeurs totales du fichier excel et comparer avec la valeur totale du bouton Sommation.");
        
        //Ouvrir avec Excel le fichier généré
        var objExcel = Sys.OleObject("Excel.Application");
        var objExcelWorkbook = objExcel.Workbooks.Open(filePath);
        objExcel.Visible = true;
    
        //Récupérer les valeurs attendues pour le nombre de relations et la somme de toutes les valeurs totales des relations
        var excelArrayOfCurrencyNames = new Array();
        var excelArrayOfSumOfTotalValues = new Array();
        var excelArrayOfNbOfRelationships = new Array();
    
        var excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
        for (var i = 2; i <= excelRowCount; i++){
            var excelCurrentCurrencyName = (isJavaScript())? VarToStr(objExcel.Cells.Item(i, 5)): VarToStr(objExcel.Cells(i, 5));
            var excelCurrentTotalValue = (isJavaScript())? StrToFloat(ConvertToNumberStandardFormat(VarToStr(objExcel.Cells.Item(i, 7)))): StrToFloat(ConvertToNumberStandardFormat(VarToStr(objExcel.Cells(i, 7))));
            
            if (GetIndexOfItemInArray(excelArrayOfCurrencyNames, excelCurrentCurrencyName) == -1){
                excelArrayOfCurrencyNames.push(excelCurrentCurrencyName);
                excelArrayOfSumOfTotalValues.push(0);
                excelArrayOfNbOfRelationships.push(0);
            }
                
            excelArrayOfSumOfTotalValues[GetIndexOfItemInArray(excelArrayOfCurrencyNames, excelCurrentCurrencyName)] += excelCurrentTotalValue;
            excelArrayOfNbOfRelationships[GetIndexOfItemInArray(excelArrayOfCurrencyNames, excelCurrentCurrencyName)] += 1;
        }
        
        var excelNbOfRelationships = 0;
        for (var i = 0; i < excelArrayOfNbOfRelationships.length; i++)
            excelNbOfRelationships += excelArrayOfNbOfRelationships[i];
        
        var excelConvertedSumOfTotalValues = 0;
        for (var j = 0; j < excelArrayOfCurrencyNames.length; j++)
            excelConvertedSumOfTotalValues += excelArrayOfSumOfTotalValues[j]*arrayOfDefaultCurrencyRates[excelArrayOfCurrencyNames[j]];
        
        //Vérifier que les valeurs dans le fichier Excel correspondent à celles de la fenêtre Sommation
        Log.Message("Verify that Excel values match those of the Sum window.");
        if (client == "CIBC")
            CheckEquals(excelConvertedSumOfTotalValues, sumConvertedSumOfTotalValues, "The converted sum of total values");
        else
            CheckEquals(excelConvertedSumOfTotalValues.toFixed(2), sumConvertedSumOfTotalValues, "The converted sum of total values");
        CheckEquals(excelNbOfRelationships, sumNbOfRelationships, "The total number of relationships");
        
        for (var j = 0; j < gridArrayOfCurrencyNames.length; j++)
            CheckEquals(excelArrayOfNbOfRelationships[GetIndexOfItemInArray(excelArrayOfCurrencyNames, gridArrayOfCurrencyNames[j])], gridArrayOfNbOfRelationships[GetIndexOfItemInArray(gridArrayOfCurrencyNames, gridArrayOfCurrencyNames[j])], "The number of relationships for the currency " + gridArrayOfCurrencyNames[j]);
        
        for (var j = 0; j < gridArrayOfCurrencyNames.length; j++)
            if (GetIndexOfItemInArray(excelArrayOfCurrencyNames, gridArrayOfCurrencyNames[j]) == -1)
                Log.Error("The currency '" + gridArrayOfCurrencyNames[j] + "' was in the grid but not found in the Excel sheet.");
        
        for (var j = 0; j < excelArrayOfCurrencyNames.length; j++)
            if (GetIndexOfItemInArray(gridArrayOfCurrencyNames, excelArrayOfCurrencyNames[j]) == -1)
                Log.Error("The currency '" + excelArrayOfCurrencyNames[j] + "' was in the Excel sheet but not found in the grid.");
        
        //Fermer Excel
        objExcelWorkbook.Close(false);
        objExcel.Quit();
        
        //Fermer Croesus
        Close_Croesus_SysMenu();
        
        Log.PopLogFolder();
    }
    catch(e){
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        TerminateProcess("EXCEL");
        Terminate_CroesusProcess();
        //Log.Warning("Script en cours de Maintenance"); //Christophe
    } 
    
}
