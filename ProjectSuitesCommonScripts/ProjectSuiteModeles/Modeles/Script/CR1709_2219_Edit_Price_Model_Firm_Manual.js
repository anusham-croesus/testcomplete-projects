//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2219_Edit_Price_Model_Firm


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'. 2.Manuelle
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2219
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2219_Edit_Price_Model_Firm_Manual()
{
    try{ 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_REBALANCE_MANUAL", "YES", vServerModeles)// la pref doit etre activée pour permettre le rééquilibrage manuelle.                           
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
        var marketPositiveValueABX2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketPositiveValueABX2", language+client);
        var quantityABX2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityABX2", language+client);
        var securityM85972=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM85972", language+client);
        var marketValue=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue2219", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var columnSymbol=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnSymbol", language+client);
        var columnPriceSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnPriceSecurityCurrency", language+client);
        var columnMarketValueSecurityCurrency=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ColumnMarketValueSecurityCurrency", language+client);
        var fileName =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "FileName", language+client);  
                                      
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
            Log.Message("The relationship " + relationshipName + " already exists.");
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
        if(Get_PortfolioBar_BtnIntraday().Exists ==true &&  Get_PortfolioBar_BtnIntraday().VisibleOnScreen==true){
            if(Get_PortfolioBar_BtnIntraday().IsChecked==true){
              Get_PortfolioBar_BtnIntraday().Click();
            }
        }
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
        
        //Mailler la relation vers portefeuillele
        Get_ModulesBar_BtnRelationships().Click();
        Drag(Get_RelationshipsClientsAccountsGrid().FindChild("Value", relationshipName, 10), Get_ModulesBar_BtnPortfolio());
        if(Get_PortfolioBar_BtnIntraday().Exists ==true &&  Get_PortfolioBar_BtnIntraday().VisibleOnScreen==true){
            if(Get_PortfolioBar_BtnIntraday().IsChecked==true){
              Get_PortfolioBar_BtnIntraday().Click();
            }
        }    
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalancingMethod().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        } 
        
        Get_WinRebalancingMethod_RdoManually().Click();
        Get_WinRebalancingMethod_BtnOK().Click(); 
        
        /*if(Get_DlgWarning().Exists){
            var width = Get_DlgWarning().Get_Width();
            Get_DlgWarning().Click((width*(1/5)),80);*/         //EM : Modifié depuis CO: 90-07-22-Be-1
         if(Get_DlgConfirmation().Exists){
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/5)),80);   
         }
         
            //Vérifier si le message d'erreur apparaît
            maxWaitTime = 10000;
            waitTime = 0;
            errorDialogBoxDisplayed = Get_DlgError().Exists;
            while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
                Delay(1000);
                waitTime += 1000;
                errorDialogBoxDisplayed = Get_DlgError().Exists;
            }
        
            Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
            if (errorDialogBoxDisplayed){
                Log.Error("Croesus crashed")
                Log.Error("Selon Mamoudou aucun client a la pref PREF_ENABLE_REBALANCE_MANUAL,donc le crash n’a pas été rapporté.   ");
                //Get_DlgError_BtnOK().Click(); //EM : Modifié depuis CO: 90-07-22
                var width = Get_DlgError().Get_Width();
                Get_DlgError().Click((width*(1/2)),73)
               
                
                //*************************************************Réinitialiser les données*********************************************************
                Login(vServerModeles, user, psw, language);
                Get_ModulesBar_BtnModels().Click()
                Get_MainWindow().Maximize();
                ResetData(relationshipName,modelName)
                                
            }
            else {
                Log.Checkpoint("No crash detected.");                
                WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
                aqObject.CheckProperty(Get_WinRebalance(), "Exists", cmpEqual, true);
                
                //*************************************************Réinitialiser les données********************************************************* 
               Get_WinRebalance_BtnClose().Click();   
               /*if(Get_DlgWarning().Exists){
                  var width = Get_DlgWarning().Get_Width();
                  Get_DlgWarning().Click((width*(1/3)),73)
               }*/   //EM : Modifié depuis CO: 90-07-22
                if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);                      
                }                
                //ResetData(relationshipName,modelName);                
            }              
                                 
         
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
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_REBALANCE_MANUAL", "NO", vServerModeles)
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        RestartServices(vServerModeles);
        Runner.Stop(true);
    }
}


