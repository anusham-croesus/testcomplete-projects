//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2209_Edit_Price_UMA_Model1


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2209
Méthode rééquilibrage 2 : A partir de Pad Portefeuille
Analyste d'automatisation: Youlia Raisper */


function CR1709_2209_Edit_Price_UMA_Model2()
{
    try{
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2209","Cas de test TestLink - Méthode rééquilibrage 2 : A partir de Pad Portefeuille : Croes-2209")
        
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_REBALANCE_MANUAL", "YES", vServerModeles)// la pref doit etre activée pour permettre le rééquilibrage manuelle.             
        RestartServices(vServerModeles);
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");        
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinModelInfoGrpModel_CmbType_UMA", language+client);        
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model2Name_2209", language+client);
        var securityLB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityLB", language+client);
        var percentLB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentLB", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var client800038=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800038", language+client);
        var account800038NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800038NA", language+client);
        var newPrice=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceLB", language+client);
        var marketValue= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue2209", language+client);
        var marketValueSummary= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueSummary2209", language+client); 
        
        var columnSymbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSymbol", language+client);
        var columnPriceSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnPriceSecurityCurrency", language+client);
        var columnMarketValueSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnMarketValueSecurityCurrency", language+client);
        var fileName =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FileName", language+client);   
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
                               
        Login(vServerModeles, user, psw, language);                 
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,modelType)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //Ajouter une position LB 
        AddPositionToModel(securityLB,percentLB,typePicker,"")         
                             
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,100).DblClick();
        Get_WinPositionInfo_GrpPositionInformation_TxtMarketValue().Keys(percentLB);
        Get_WinPositionInfo_BtnOK().Click();
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
   
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityLB); 
        
        //associez Un client 
        Get_ModulesBar_BtnModels().Click();       
        AssociateClientWithModel(modelName,client800038);
        
        SearchModelByName(modelName);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
                                                                         
        //Rééquilibrer le modele 
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
        Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Click();     
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        //Rééquilibrer le modele comme suit : Etape 1 : selon la valeur au marché
        Get_WinRebalance_BtnNext().Click();      
        
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();
        var index = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).dataContext.Index;
        var cellPrice = Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).FindChild(["ClrClassName", "WPFControlOrdinalNo"],["CellValuePresenter", "4"],10);
        cellPrice.Click();
        cellPrice.WPFObject("XamNumericEditor", "", 1).Keys(newPrice);
        Get_WinEditPrices_BtnOk().Click();
        Get_WinRebalance_BtnNext().Click();  
        
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }
           
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
         /* Vérifier a Etape 4 : portefeuille projeté :
        A- onglet ordre proposé , le prix selon la devise du titre a été modifié et affiche 20*/
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).DataContext.DataItem, "Price", cmpEqual, percentLB); 

        /*cliquez sur '+' position BL et vérifier que :
        le prix selon la devise du titre, le prix selon la devise du compte (LES AJOUTER SI ELLE NE SONT PAS AFFICHER) a été modifié et affiche 20 */
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true)             
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account800038NA,10).DataContext.DataItem , "Price", cmpEqual, percentLB); 
       
        /*B- Vérifier a Etape 4 toujours : portefeuille projeté : onglet portefeuille projeté :
       -le prix selon la devise du titre a été modifié et affiche 20*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).DataContext.DataItem, "MarketPrice", cmpEqual, percentLB);
                      
        /*-la valeur au marché est recalculé selon le nouveau prix =qte*prix =52240.00*/
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValue);
       
        //-Valider que la valeur au marché du portef  dans sommaire est recalculé sur la base du nouveau prix
        var txtMarketValue=aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue().Text, " ", ""); //avant content       
        if(aqObject.CompareProperty(txtMarketValue, cmpEqual,marketValueSummary)){
           Log.Checkpoint("La valeur est bonne")
        } 
        else {
          Log.Error("La valeur n'est pas bonne")
        }
       
       /* -Cliquez sur Modifier et verifier le prix= 20*/ 
       Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityLB,10).Click();
       Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
       var marketPrice = aqString.SubString(Get_WinModifyPosition_GrpPositionInformation_TxtMarketPrice().Text, 0, 2)
       if(marketPrice==percentLB){
         Log.Checkpoint("Le prix est bon")
       } 
       else{
         Log.Error("Le prix n'est pas bon")
       } 
       Get_WinModifyPosition_BtnOK().Click();
        
       /*Passer a Etape 5 */
       Get_WinRebalance_BtnNext().Click(); 
       /* Valider le prix selon la devise du titre, le prix selon la devise du compte a été modifié et affiche 20*/ 
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityLB,10).DataContext.DataItem, "Price", cmpEqual, percentLB);
       /*-VM selon la devise du titre,VM selon la devise du compte est recalculé =52240*/
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityLB,10).DataContext.DataItem, "MarketValue", cmpEqual, -(marketValue));  
        
        /*a etape 5 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans*/
        //Avancer à l'étape suivante par la flèche en-bas à droite 
        Get_WinRebalance_BtnGenerate().Click(); 
                       
        /**************************************************2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/         
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click(); 
        Delay(15000);
                          
        
        Log.Message(FolderPath)
        
        var FileNameContains =aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-") 
        Log.Message(FileNameContains) 
        var filesArray=FindLastModifiedFilesInFolder(FolderPath,FileNameContains);
        Log.Message(filesArray);
        Log.Message(filesArray.length)
        var marketValue="-"+ marketValue;
        
        var percentLB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelNewPriceLB", language+client);
        var marketValue= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelMarketValue2209", language+client);
        
        for(j=0;j<filesArray.length;j++){
          if(aqObject.CompareProperty(filesArray[j], cmpContains, fileName ,false,0)==true){
              if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency,columnMarketValueSecurityCurrency], [securityLB,percentLB,marketValue])){
                 Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityLB +" "+ columnPriceSecurityCurrency + "="+ percentLB + " " +columnMarketValueSecurityCurrency + "=" +marketValue)
              }else{
                Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel :"+ filesArray[j]+ " " +columnSymbol+ "=" + securityLB +" "+ columnPriceSecurityCurrency + "="+ percentLB + " " +columnMarketValueSecurityCurrency + "=" +marketValue)
              } 
          } 
          else{
            if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency], [securityLB,percentLB])){
              Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityLB +" "+ columnPriceSecurityCurrency + "="+ percentLB)
            }else{
              Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityLB +" "+ columnPriceSecurityCurrency + "="+ percentLB)
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
        //ResetData(client800038,modelName,FolderPath);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
       
    }
    finally {   
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(client800038,modelName,FolderPath);
        Terminate_CroesusProcess(); //Fermer Croesus
        Delay(15000);
        //fermer les fichier excel
        while(Sys.waitProcess("EXCEL").Exists){
          Sys.Process("EXCEL").Terminate();
        }
        //Supprimer les fichiers 
        aqFileSystem.DeleteFile(FolderPath + "*.*"); 
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_REBALANCE_MANUAL", "NO", vServerModeles)
        RestartServices(vServerModeles)
        Runner.Stop(true);
    }
}



 