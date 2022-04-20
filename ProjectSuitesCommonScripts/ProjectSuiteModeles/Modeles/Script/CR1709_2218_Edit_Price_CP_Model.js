//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2218
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2218_Edit_Price_CP_Model()
{
    try{                            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestCP", language+client);
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800214GT", language+client); 
        var securityQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityQ69694", language+client);
        var quantityQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityQ69694", language+client);
        var priceQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PriceQ69694", language+client);         
        var securityQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityQ70791", language+client);
        var quantityQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityQ70791", language+client);
        var priceQ70791=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PriceQ70791", language+client); 
        var securityGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityGGF593", language+client);
        var quantityGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityGGF593", language+client);
        var priceGGF593=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PriceGGF593", language+client); 
        var securityBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBBDB", language+client);
        var quantityBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBBDB", language+client);
        var priceBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PriceBBDB", language+client);            
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client); 
        
        var newPriceQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceQ69694", language+client); 
        var newQuantityQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewQuantityQ69694", language+client);
        var newMarketValueQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewMarketValueQ69694", language+client);
        var newPriceBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceBBDB", language+client);
        var newQuantityBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewQuantityBBDB", language+client);
        var newMarketValueBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewMarketValueBBDB", language+client);
              
        var etape5QuantityQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Etape5QuantityQ69694", language+client);
        var etape5MarketValueQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Etape5MarketValueQ69694", language+client);        
        var etape5QuantityBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Etape5QuantityBBDB", language+client);
        var etape5MarketValueBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Etape5MarketValueBBDB", language+client);
        
        var columnSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSecurity", language+client);
        var columnSymbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSymbol", language+client);
        var columnPriceSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnPriceSecurityCurrency", language+client);
        var columnMarketValueSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnMarketValueSecurityCurrency", language+client);
        var fileName =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FileName", language+client);  
        
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
                                      
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                            
        //assigné le compte 800214-JW au modèle 
        AssociateAccountWithModel(modelName,account)
                                                                 
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
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //Valider qu'il y a un ordre d'achat GGF593 668.276
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityGGF593,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityGGF593);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityGGF593,10).DataContext.DataItem, "Price", cmpEqual, priceGGF593);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityGGF593,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        //Valider qu'il y a un ordre d'achat BBD.B 2236 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityBBDB);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "Price", cmpEqual, priceBBDB);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        //Valider qu'il y a un ordre de vente Q69694 (7800) 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityQ69694);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "Price", cmpEqual, priceQ69694);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //Valider qu'il y a un ordre de vente Q70791 (5800) 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityQ70791);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "Price", cmpEqual, priceQ70791);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityQ70791,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        
        //Retourner a étape3 pour modifier le prix (cliquez sur le bouton modifier le prix) du titre Q69694 Mettre a 80 et bbd.b=10
        Get_WinRebalance_BtnPrevious().Click();
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
        var index=Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.Index
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("ContentControl", "", 1).WPFObject("XamNumericEditor", "", 1).Click();
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "",1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("XamNumericEditor", "", 1).Keys(newPriceQ69694);
        
        var index=Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.Index
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "",1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("ContentControl", "", 1).WPFObject("XamNumericEditor", "", 1).Click();
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "",1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("XamNumericEditor", "", 1).Keys(newPriceBBDB);
        
        Get_WinEditPrices_BtnOk().Click();
        Get_WinRebalance_BtnNext().Click();  
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }            
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        /* Vérifier a Etape 4 toujours : portefeuille projeté : onglet portefeuille projeté :
        -le prix selon la devise du titre a été modifié 
        -la valeur au marché est recalculé selon le nouveau prix*/        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //Q69694 prix 10 Valeur de marché 11280 quantité 14100
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, newQuantityQ69694);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "MarketPrice", cmpEqual, newPriceQ69694);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityQ69694,10).DataContext.DataItem, "MarketValue", cmpEqual, newMarketValueQ69694);
        //BBD.B prix 80 Valeur de marché 11320 quantité 1132
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, newQuantityBBDB);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "MarketPrice", cmpEqual, newPriceBBDB);
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBBDB,10).DataContext.DataItem, "MarketValue", cmpEqual, newMarketValueBBDB);
        
         /*Passer a Etape 5 */
        Get_WinRebalance_BtnNext().Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityQ69694,10).DataContext.DataItem, "Price", cmpEqual, newPriceQ69694);
        var detected=roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityQ69694,10).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==etape5MarketValueQ69694)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a marketValue expected = "+etape5MarketValueQ69694)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a marketValue expected) = "+etape5MarketValueQ69694) 
        //aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityQ69694,10).DataContext.DataItem, "MarketValue", cmpEqual, etape5MarketValueQ69694); //EM: 90-06-Be-26: Enlevé pour comparer les chiffres en utilisant la fonction roundDecimal()
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityQ69694,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, etape5QuantityQ69694);
       
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityBBDB,10).DataContext.DataItem, "Price", cmpEqual, newPriceBBDB);
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityBBDB,10).DataContext.DataItem, "MarketValue", cmpEqual, etape5MarketValueBBDB);
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityBBDB,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, etape5QuantityBBDB);
             
        /**************************************************2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/   
        /*a etape 5 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans*/
        //Avancer à l'étape suivante par la flèche en-bas à droite 
        Get_WinRebalance_BtnGenerate().Click();       
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click(); 
        Delay(15000);
                          
       
        Log.Message(FolderPath)
        
        var newPriceBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelNewPriceBBDB", language+client);
        var etape5MarketValueBBDB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelEtape5MarketValueBBDB", language+client);
        var newPriceQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelNewPriceQ69694", language+client);
        var etape5MarketValueQ69694=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelEtape5MarketValueQ69694", language+client); 
        
        var FileNameContains =aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-") 
        Log.Message(FileNameContains) 
        var filesArray=FindLastModifiedFilesInFolder(FolderPath,FileNameContains);
        Log.Message(filesArray);
        Log.Message(filesArray.length)
        for(j=0;j<filesArray.length;j++){
          if(aqObject.CompareProperty(filesArray[j], cmpContains, fileName ,false,0)==true){
              if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency,columnMarketValueSecurityCurrency], [securityBBDB,newPriceBBDB,etape5MarketValueBBDB])){
                 Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityBBDB +" "+ columnPriceSecurityCurrency + "="+ newPriceBBDB + " " +columnMarketValueSecurityCurrency + "=" +etape5MarketValueBBDB)
              }else{
                Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel :"+ filesArray[j]+ " " +columnSymbol+ "=" + securityBBDB +" "+ columnPriceSecurityCurrency + "="+ newPriceBBDB + " " +columnMarketValueSecurityCurrency + "=" +etape5MarketValueBBDB)
              } 
                if(SearchValuesInCSVFile(filesArray[j], [columnSecurity,columnPriceSecurityCurrency,columnMarketValueSecurityCurrency], [securityQ69694,newPriceQ69694,etape5MarketValueQ69694])){
                 Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSecurity+ "=" + securityQ69694 +" "+ columnPriceSecurityCurrency + "="+ newPriceQ69694 + " " +columnMarketValueSecurityCurrency + "=" +etape5MarketValueQ69694) //EM: 90-06-Be-26: columnSymbol Remplacé par columnSecurity car securityQ69694 n'a pas de symbole
              }else{
                Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel :"+ filesArray[j]+ " " +columnSecurity+ "=" + securityQ69694 +" "+ columnPriceSecurityCurrency + "="+ newPriceQ69694 + " " +columnMarketValueSecurityCurrency + "=" +etape5MarketValueQ69694) //EM: 90-06-Be-26: columnSymbol Remplacé par columnSecurity car securityQ69694 n'a pas de symbole
              }
          } 
          else{
            if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency], [securityBBDB,newPriceBBDB])){
              Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityBBDB +" "+ columnPriceSecurityCurrency + "="+ newPriceBBDB)
            } else{
              Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityBBDB +" "+ columnPriceSecurityCurrency + "="+ newPriceBBDB)
            }
             if(SearchValuesInCSVFile(filesArray[j], [columnSecurity,columnPriceSecurityCurrency], [securityQ69694,newPriceQ69694])){
              Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSecurity+ "=" + securityQ69694 +" "+ columnPriceSecurityCurrency + "="+ newPriceQ69694) //EM: 90-06-Be-26: columnSymbol Remplacé par columnSecurity car securityQ69694 n'a pas de symbole
            } else{
              Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSecurity+ "=" + securityQ69694 +" "+ columnPriceSecurityCurrency + "="+ newPriceQ69694) //EM: 90-06-Be-26: columnSymbol Remplacé par columnSecurity car securityQ69694 n'a pas de symbole
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
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
          Sys.Process("EXCEL").Terminate();
        }                      
        //Supprimer les fichiers 
        aqFileSystem.DeleteFile(FolderPath + "*.*");
        Runner.Stop(true); 
    }
}

function ResetData(account,modelName){
    Get_ModulesBar_BtnModels().Click();     
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
}
function Test(){
    Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
}