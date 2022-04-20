//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2210_Edit_Price_Ambassadeur_Model
//USEUNIT CR1709_2166_Edit_Price_CP_Model


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3309

Analyste d'automatisation: Youlia Raisper */

function CR1709_3309_Edit_Price_CP_Model_Panier()
{
    try{  
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3309","Cas de test TestLink : Croes-3309")
             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GOHABS", "username");     
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_3309", language+client);
        var panier=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PanierObligatio", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
        var securityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDIS", language+client);
        var percentDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentDIS_3309", language+client);
        var percentPanier=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentPanier_3309", language+client);
        var account800049NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049NA", language+client);
        var IACode=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var newPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPrice_3309", language+client);
        var marketPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketPrice_3309", language+client);
        var marketValue= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue_3309", language+client);
        var marketValueSummary=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueSummary3309", language+client); 
        var marketValue_step5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue_STEP5", language+client);
        var quantityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantutyDIS_3309", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
        var columnSymbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSymbol", language+client);
        var columnPriceSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnPriceSecurityCurrency", language+client);
        var columnMarketValueSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnMarketValueSecurityCurrency", language+client);
        var fileName =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FileName", language+client);   
        
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        
        var FileNameContains =aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-") 
        var sPath = FolderPath+"\*"+FileNameContains+"*";
        Log.Message(sPath)
        //Deletes all files created today
        aqFile.Delete(sPath);
        
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Execute_SQLQuery("delete from b_or_ou where no_compte = '"+account+"'", vServerModeles) //EM : Requête fournit par Christine H. pour régler le prob de reéquilibrage rencontré. Selon Christine H. ce problème va être reglé avec le CR2160 car on aura la possibilité de multirééquilibrage avec multiuser
        RestartServices(vServerModeles)                                  
        
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,"",IACode)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        //Ajouter une position DIS 
        Get_Toolbar_BtnAdd().Click();      
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/2.9)),73)                      
        AddPosition(securityDIS,percentDIS,typePicker,"")                                       
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Ajouter un panier 
        Get_Toolbar_BtnAdd().Click();
        AddSubModelToModel(panier,percentPanier);        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityDIS);         
        
        Get_ModulesBar_BtnModels().Click();
        //assigné le compte au modèle
        AssociateAccountWithModel(modelName,account)
        SearchModelByName(modelName);
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
                                                                                 
        //Rééquilibrer le modele 
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        } 
                                                        
        Get_WinRebalance().Parent.Maximize();    
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        //Rééquilibrer le modele comme suit : Etape 1 : selon la valeur Cible
        Get_WinRebalance_BtnNext().Click();      
        
        //Modification du prix
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();           
        var index=Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.Index
        var cellPrice = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "4"],10);
        cellPrice.Click();
        cellPrice.WPFObject("ContentControl", "", 1).WPFObject("XamNumericEditor", "", 1).Keys(newPrice);
        
        Get_WinEditPrices_BtnOk().Click();
        Get_WinRebalance_BtnNext().Click();  
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
           
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
         /* Vérifier a Etape 4 : portefeuille projeté :
        A- onglet ordre proposé , le prix selon la devise du titre a été modifié */
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "Price", cmpEqual, newPrice); 

        /*cliquez sur '+' position DIS et vérifier que :
        le prix selon la devise du titre, le prix selon la devise du compte a été modifié */
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
        
        var applicationPrice=Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account800049NA,10).DataContext.DataItem.Price            
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account800049NA,10).DataContext.DataItem , "Price", cmpEqual, newPrice);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account800049NA,10).DataContext.DataItem , "PriceConverted", cmpEqual, marketPrice); 
       
        /*B- Vérifier a Etape 4 : portefeuille projeté : onglet portefeuille projeté :
       -le prix selon la devise du titre a été modifié */
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(securityDIS);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
    
        //Market price
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "MarketPrice", cmpEqual, marketPrice);                      
        //Display quantity
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "DisplayQuantity", cmpEqual, quantityDIS); 
        /*-la valeur au marché est recalculé selon le nouveau prix =qte*prix*/
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValue);       
           
        //-Valider que la valeur au marché du portef  dans sommaire est recalculé sur la base du nouveau prix
        var txtMarketValue=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue().Text, " ", "");//avant content      
        if(aqObject.CompareProperty(txtMarketValue, cmpEqual,marketValueSummary)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
          Log.Error("Jira CROES-11666")
        }
        
         /* -Cliquez sur Modifier et verifier le prix*/ 
       Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDIS,10).Click();
       Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
       aqObject.CheckProperty(Get_WinModifyPosition_GrpPositionInformation_TxtMarketPrice(), "Value", cmpEqual, marketPrice);        
       Get_WinModifyPosition_BtnOK().Click();
                      
       /*Passer a Etape 5 */
       Get_WinRebalance_BtnNext().Click(); 
       /* Valider le prix selon la devise du titre, le prix selon la devise du compte a été modifié*/ 
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityDIS,10).DataContext.DataItem, "Price", cmpEqual, newPrice);
       /*-VM selon la devise du titre,VM selon la devise du compte est recalculé */
       var marketValue="-"+ marketValue_step5;
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityDIS,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValue);  
        
       /*a etape 5 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans*/
       //Avancer à l'étape suivante par la flèche en-bas à droite 
       Get_WinRebalance_BtnGenerate().Click(); 
                       
        /**************************************************2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/         
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click(); 
        Delay(15000);
                          
        
       Log.Message(FolderPath)
        Log.Message(FileNameContains)
        var newPrice =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelNewPrice_3309", language+client);
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelMarketValue_STEP5", language+client);
                 
        var filesArray=FindLastModifiedFilesInFolder(FolderPath,FileNameContains);
        Log.Message(filesArray);
        Log.Message(filesArray.length)
        
        for(j=0;j<filesArray.length;j++){
          if(aqObject.CompareProperty(filesArray[j], cmpContains, fileName ,false,0)==true){
            Log.Message(filesArray[j])
            Log.Message("Alhassane if")
              if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency,columnMarketValueSecurityCurrency], [securityDIS,newPrice,marketValue])){
                 Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityDIS +" "+ columnPriceSecurityCurrency + "="+ newPrice + " " +columnMarketValueSecurityCurrency + "=" +marketValue)
              }else{
                Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel :"+ filesArray[j]+ " " +columnSymbol+ "=" + securityDIS +" "+ columnPriceSecurityCurrency + "="+ newPrice + " " +columnMarketValueSecurityCurrency + "=" +marketValue)
              } 
          } 
          else{
            Log.Message(filesArray[j])
            Log.Message("Alhassane else")
            if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency], [securityDIS,newPrice])){
              Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityDIS +" "+ columnPriceSecurityCurrency + "="+ newPrice)
            }else{
              Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityDIS +" "+ columnPriceSecurityCurrency + "="+ newPrice)
            } 
          } 
        }
         
         //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }
                
        //Supprimer les fichiers 
        aqFileSystem.DeleteFile(FolderPath + "*.*"); 
             
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(account,modelName);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
    }
    finally {  
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(account,modelName)
        Terminate_CroesusProcess(); //Fermer Croesus
        Delay(15000);
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
          Sys.Process("EXCEL").Terminate();
        }
        //Supprimer les fichiers 
        aqFileSystem.DeleteFile(FolderPath + "*.*");
        Runner.Stop(true);
   }
}



function SearchValuesInCSVFile(CSVFilePath, arrayOfColumnsNames, arrayOfSearchValues, delimiterChar)
{
    if (arrayOfColumnsNames != undefined && GetVarType(arrayOfColumnsNames) != varArray && GetVarType(arrayOfColumnsNames) != varDispatch)
        arrayOfColumnsNames = new Array(arrayOfColumnsNames);
    
    if (arrayOfSearchValues != undefined && GetVarType(arrayOfSearchValues) != varArray && GetVarType(arrayOfSearchValues) != varDispatch)
        arrayOfSearchValues = new Array(arrayOfSearchValues);
    
    if (arrayOfColumnsNames.length != arrayOfSearchValues.length){
        Log.Error("The parameters arrayOfColumnsNames and arrayOfSearchValues don't contain the same number of elements.");
        return false;
    }
    
    var ANSIFileName = "ANSIFile.csv";
    var CSVFileName = aqFileSystem.GetFileName(CSVFilePath);
    var ANSIFilePath = CSVFilePath.replace(CSVFileName, ANSIFileName);
    
    var CSVFileContent = aqFile.ReadWholeTextFile(CSVFilePath, aqFile.ctANSI);//avant ctUnicode
    CreateFileAndWriteText(ANSIFilePath, CSVFileContent);
    
    if (delimiterChar == undefined || delimiterChar.toUpperCase() == "TAB" || delimiterChar == "\t")
        var CSVFormat = "Format=TabDelimited";
    else if (delimiterChar.toUpperCase() == "CSV" || delimiterChar == ",")
        var CSVFormat = "Format=CSVDelimited";
    else
        var CSVFormat = "Format=Delimited(" + delimiterChar + ")";
    
    var schemaFilePath = CSVFilePath.replace(CSVFileName, "schema.ini");
    var schemaFilelines = "[" + ANSIFileName + "]";
    schemaFilelines += "\r\n" + CSVFormat;
    schemaFilelines += "\r\n" + "CharacterSet=ANSI";
    schemaFilelines += "\r\n" + "ColNameHeader=True";
    CreateFileAndWriteText(schemaFilePath, schemaFilelines);
    
    var Driver = DDT.CSVDriver(ANSIFilePath);
    
    var arrayOfAllColumnsNames = new Array();
    for (var columnIndex = 0; columnIndex < Driver.ColumnCount; columnIndex++)
        arrayOfAllColumnsNames.push(Driver.ColumnName(columnIndex));
    Log.Message(arrayOfAllColumnsNames)
    
   
    var areAllNeededColumnNamesFound = true;
    for (var columnsNamesIndex = 0; columnsNamesIndex < arrayOfColumnsNames.length; columnsNamesIndex++)
        if (GetIndexOfItemInArray(arrayOfAllColumnsNames, arrayOfColumnsNames[columnsNamesIndex]) == -1){
            Log.Error("Column name '" + arrayOfColumnsNames[columnsNamesIndex] + "' was not found.");
            areAllNeededColumnNamesFound = false;
        }
    
    var areSearchValuesFound = false;
    if (areAllNeededColumnNamesFound){
        var rowNo = 0;
        while (! Driver.EOF()) {
            rowNo ++;
            var arrayOfCurrentValues = new Array();
            for (var i = 0; i < arrayOfColumnsNames.length; i++)
                arrayOfCurrentValues.push(Driver.Value(arrayOfColumnsNames[i]));
            
            if (arrayOfCurrentValues.toString() == arrayOfSearchValues.toString()){
                Log.Message("The search values were found at row No : " + rowNo);
                areSearchValuesFound = true;
                break;
            }
        
            Driver.Next();
        }
    
        if (!areSearchValuesFound)
            Log.Message("The search values were not found in the CSV file.");
    }
    
    DDT.CloseDriver(Driver.Name);
    aqFileSystem.DeleteFile(ANSIFilePath);
    aqFileSystem.DeleteFile(schemaFilePath);
    
    return areSearchValuesFound;
}

