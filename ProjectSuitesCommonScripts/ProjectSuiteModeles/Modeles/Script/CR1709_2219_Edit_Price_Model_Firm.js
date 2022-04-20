//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2219
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5217
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2219_Edit_Price_Model_Firm()
{
    try{                            
        
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "0", vServerModeles)
        RestartServices(vServerModeles);
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestFirm", language+client);  
        var account300005NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account300005NA", language+client); 
        var account300010NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account300010NA", language+client); 
        var relationshipName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RelationshipName_2219", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);   
        var securityABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityABX", language+client);  
        var targetABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetABX", language+client); 
        var VMABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMABX", language+client); 
        var securityM22762=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM22762", language+client);
        var targetM22762VM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM22762VM", language+client);
        var CP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var newPriceABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewPriceABX", language+client);
        var marketValueABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueABX", language+client);
        var marketPositiveValueABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketPositiveValueABX", language+client);
        var quantityABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityABX", language+client);
        var quantityABX1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityABX1", language+client);
        var marketPositiveValueABX2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketPositiveValueABX2", language+client);
        var quantityABX2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityABX2", language+client);
        var securityM85972=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM85972", language+client);
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue2219", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var columnSymbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSymbol", language+client);
        var columnPriceSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnPriceSecurityCurrency", language+client);
        var columnMarketValueSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnMarketValueSecurityCurrency", language+client);
        var fileName =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FileName", language+client);  
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5217","Cas de test TestLink : Croes-5217")
                                      
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnRelationships().Click();
        Get_MainWindow().Maximize();
        
        //Fermer tous les filtres s'ils existent //EM : CO-07-22 : Modification dûe a l'existance d'un filtre qui cache la relation créé  
        while(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Exists)
            Get_RelationshipsClientsAccountsGrid_BtnFilter(1).Click(Get_RelationshipsClientsAccountsGrid_BtnFilter(1).get_ActualWidth() - 17, 13);
                                    
        //Créer une relation 
        SearchRelationshipByName(relationshipName);
        var searchResult = Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10);
        if (searchResult.Exists)
            Log.Message("The relationship " + RelationshipName + " already exists.");
        else {
        Get_Toolbar_BtnAdd().Click();
        Get_Toolbar_BtnAdd_AddDropDownMenu_AddNewRelationship().Click();
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtFullName().set_Text(relationshipName);
        Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtShortName().set_Text(relationshipName);
         Get_WinDetailedInfo_TabInfo_GrpGeneral_TxtIACodeForClient().set_Text(CP);
        Get_WinDetailedInfo_BtnOK().Click();
        }
        
        //ajouter les comptes 300005-NA et 300010-NA à la relation.
        JoinAccountToRelationship(account300005NA, relationshipName);
        JoinAccountToRelationship(account300010NA, relationshipName);
        
        //Créer un Modèle
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), Get_ModulesBar_BtnPortfolio());
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewFirmModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
    
         /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73); */ //EM : Modifié depuis CO: 90-07-22
         if(Get_DlgInformation().Exists) {    
                Get_DlgInformation().Close();
        }
                
        //Modifier la valeur du titre INT-HYDRO QUE (M22762) et mettre le % VM à 2%
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DblClick();
        Get_WinPositionInfo_GrpPositionInformation_TxtTargetValue().Keys(targetABX);
        Get_WinPositionInfo_GrpPositionInformation_TxtMarketValue().Keys(VMABX)
        Get_WinPositionInfo_BtnOK().Click();
        
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityM22762,10).DblClick();
        Get_WinPositionInfo_GrpPositionInformation_TxtMarketValue().Keys(targetM22762VM);
        Get_WinPositionInfo_BtnOK().Click();

        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityM85972,10).DblClick();
        Get_WinPositionInfo_GrpPositionInformation_TxtMarketValue().Keys(targetM22762VM);
        Get_WinPositionInfo_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Associer la relation créé au modele
        Get_ModulesBar_BtnModels().Click();
        AssociateRelationshipWithModel(modelName,relationshipName)
    
        //Activer le Modèle
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);
            
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
         
        //rééquilibrer selon la valeur cible
        Get_WinRebalance_TabParameters_RdoBasedOnMarketValue().Click();       
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();  
        
        //Changer le prix
        Get_WinRebalance_TabPositionsToRebalance_BarPadHeader_BtnEditPrices().Click();
        Get_WinEditPrices().Parent.Maximize();  
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).Click();
        var index=Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.Index
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).Click();
        Get_WinEditPrices_DgvOverridePrice().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "",1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).WPFObject("XamNumericEditor", "", 1).Keys(newPriceABX);    
        Get_WinEditPrices_BtnOk().Click();
        
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click(); 
        if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        }  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //Valider qu'il y a un ordre d'achat ABX prix=20; VM -44080
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValueABX);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "Price", cmpEqual, newPriceABX);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "PriceConverted", cmpEqual, newPriceABX);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityABX);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
     
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        //valider les valeurs de ABX
         PP_Search(securityABX);
         if(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem.Symbol==securityABX){
               aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityABX1);
               aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "MarketPrice", cmpEqual, newPriceABX);
               aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "MarketValue", cmpEqual, marketPositiveValueABX);
               aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).DataContext.DataItem, "Symbol", cmpEqual, securityABX);
         } //EM : 90-08-15 : Modifié selon le nouveau CR1322_Croes5217
         
         /* -Cliquez sur Modifier et verifier le prix= 20*/ 
         Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityABX,10).Click();
         Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
         var marketPrice = aqString.SubString(Get_WinModifyPosition_GrpPositionInformation_TxtMarketPrice().Text, 0, 2)
         if(marketPrice==newPriceABX){
           Log.Checkpoint("Le prix est bon")
         } 
         else{
           Log.Error("Le prix n'est pas bon")
         } 
         Get_WinModifyPosition_BtnOK().Click();
                 
        //Valider dans la section sommaire : la valeur au marché du portef  dans sommaire est recalculé sur la base du nouveau prix =638 977.63
        // EM: 90-06-Be-17 datapool modifié - avant "638 824,34" (Apres la reponse de karima Mouzaoui)
        // EM: 90.10.Fm-2 datapool modifié - avant "638 824,33" (Apres Rép Christine P. : Nouveau comportement valide lié à la correction du JIRA : DEVPRJ-2643)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtMarketValue(), "Text", cmpEqual,marketValue);//avant content
               
         /*Passer a Etape 5 */
        Get_WinRebalance_BtnNext().Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityABX,10).DataContext.DataItem, "Price", cmpEqual, newPriceABX);
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityABX,10).DataContext.DataItem, "MarketValue", cmpEqual, marketValueABX);
        aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",securityABX,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityABX);
             
        /**************************************************2-Excel : -portefeuille projeté -Ordres individuels - Ordres groupés*/   
        /*a etape 5 du rééquilibrage valider que les colonnes G/P ne sont pas disponbles dans*/
        //Avancer à l'étape suivante par la flèche en-bas à droite 
        Get_WinRebalance_BtnGenerate().Click();       
        Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().Click();
        Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().Click();
        Get_WinGenerateOrders_BtnGenerate().Click(); 
        Delay(15000);
        
        if(Get_DlgConfirmation().Exists){   //EM : Modifié depuis CO: 90-07-22
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }                   
        
        Log.Message(FolderPath)
        var newPriceABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelNewPriceABX", language+client);
        var marketValueABX=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ExcelMarketValueABX", language+client);
        
        var FileNameContains =aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-") 
        Log.Message(FileNameContains) 
        var filesArray=FindLastModifiedFilesInFolder(FolderPath,FileNameContains);
        Log.Message(filesArray);
        Log.Message(filesArray.length)
        for(j=0;j<filesArray.length;j++){
          if(aqObject.CompareProperty(filesArray[j], cmpContains, fileName ,false,0)==true){
              if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency,columnMarketValueSecurityCurrency], [securityABX,newPriceABX,marketValueABX])){
                 Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityABX +" "+ columnPriceSecurityCurrency + "="+ newPriceABX + " " +columnMarketValueSecurityCurrency + "=" +marketValueABX)
              }else{
                Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel :"+ filesArray[j]+ " " +columnSymbol+ "=" + securityABX +" "+ columnPriceSecurityCurrency + "="+ newPriceABX + " " +columnMarketValueSecurityCurrency + "=" +marketValueABX)
              } 
          } 
          else{
            if(SearchValuesInCSVFile(filesArray[j], [columnSymbol,columnPriceSecurityCurrency], [securityABX,newPriceABX])){
              Log.Checkpoint("Les colonnes et les valeurs suivantes sont présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityABX +" "+ columnPriceSecurityCurrency + "="+ newPriceABX)
            } else{
              Log.Error("Les colonnes et les valeurs suivantes ne sont pas présentes dans le fichier Excel : "+ filesArray[j]+ " " +columnSymbol+ "=" + securityABX +" "+ columnPriceSecurityCurrency + "="+ newPriceABX)
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
       /* if(Get_DlgModel().Exists){
          var width = Get_DlgModel().Get_Width();
          Get_DlgModel().Click((width*(2/3)),73)
        }*/   //EM : Modifié depuis CO: 90-07-22
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        } 
        //ResetData(relationshipName,modelName);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(relationshipName,modelName)
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "3", vServerModeles)
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        RestartServices(vServerModeles); 
        Runner.Stop(true);
    }
}

function ResetData(relationshipName,modelName){
    Get_ModulesBar_BtnModels().Click();     
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",relationshipName,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    DeleteModelByName(modelName);
    DeleteRelationship(relationshipName);
}

