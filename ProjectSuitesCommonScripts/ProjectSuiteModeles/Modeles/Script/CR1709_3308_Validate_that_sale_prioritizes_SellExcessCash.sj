//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1709_3204_Release_AmountCash_in_CorrectAccounts()



/**
    Description : Valider la vente fonds mutuels dont la sous-catégo = 5790 (NBC100).
    Objectif : Valider que la vente priorise Vendre l'excédent d'encaisse
    CR1709 : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3308 
    CR1322 : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5236
    Version : ER-15
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
*/

function CR1709_3308_Validate_that_sale_prioritizes_SellExcessCash()
{
      try {
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerModeles)
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
         
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3308", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var BCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolBCE", language+client); 
        var targetBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetBCE_3308", language+client);
        var CM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CM", language+client); 
        var targetCM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetCM_3308", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client); 
        var targetBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetBMO_3308", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client); 
        var targetNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNBC100_3308", language+client);
        var client800246=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800246", language+client);
        var account800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800246GT", language+client);
        var account800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800246NA", language+client);
        var withdrawalAmount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WithdrawalAmount_3308", language+client);        
        
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);        
        /*var quantity1CAD800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800246GT_3308", language+client); 
        var VM1CAD800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800246GT_3308", language+client); 
        var marketValue1CAD800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800246GT_3308", language+client);        
        var quantity1CAD800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800246NA_3308", language+client); 
        var VM1CAD800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800246NA_3308", language+client); 
        var marketValue1CAD800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800246NA_3308", language+client);       
        var quantityBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBCE_3308", language+client); 
        var VMBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBCE_3308", language+client); 
        var marketValueBCE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueBCE_3308", language+client);       
        var BIR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBIR", language+client);
        var quantityBIR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBIR_3308", language+client); 
        var VMBIR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBIR_3308", language+client); 
        var marketValueBIR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueBIR_3308", language+client);
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_3308", language+client); 
        var VMBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBMO_3308", language+client); 
        var marketValueBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueBMO_3308", language+client);
        var quantityCM800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityCM800246GT_3308", language+client); 
        var VMCM800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMCM800246GT_3308", language+client); 
        var marketValueCM800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueCM800246GT_3308", language+client);        
        var quantityCM800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityCM800246NA_3308", language+client); 
        var VMCM800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMCM800246NA_3308", language+client); 
        var marketValueCM800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueCM800246NA_3308", language+client);        
        var quantityNBC100800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100800246GT_3308", language+client); 
        var VMNBC100800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNBC100800246GT_3308", language+client); 
        var marketValueNBC100800246GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueNBC100800246GT_3308", language+client);        
        var quantityNBC100800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100800246NA_3308", language+client); 
        var VMNBC100800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNBC100800246NA_3308", language+client); 
        var marketValueNBC100800246NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueNBC100800246NA_3308", language+client);*/
        
        var quantity1CAD800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800246GT_1_3308", language+client); 
        var VM1CAD800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800246GT_1_3308", language+client); 
        var marketValue1CAD800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800246GT_1_3308", language+client);        
        var quantity1CAD800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800246NA_1_3308", language+client); 
        var VM1CAD800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800246NA_1_3308", language+client); 
        var marketValue1CAD800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800246NA_1_3308", language+client);         
        var quantityBCE_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBCE_1_3308", language+client); 
        var VMBCE_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBCE_1_3308", language+client); 
        var marketValueBCE_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueBCE_1_3308", language+client);       
        var quantityBMO_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityBMO_1_3308", language+client); 
        var VMBMO_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMBMO_1_3308", language+client); 
        var marketValueBMO_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueBMO_1_3308", language+client);
        var quantityCM800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityCM800246GT_1_3308", language+client); 
        var VMCM800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMCM800246GT_1_3308", language+client); 
        var marketValueCM800246GT_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueCM800246GT_1_3308", language+client);        
        var quantityCM800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityCM800246NA_1_3308", language+client); 
        var VMCM800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMCM800246NA_1_3308", language+client); 
        var marketValueCM800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueCM800246NA_1_3308", language+client);
        var quantityNBC100800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100800246NA_1_3308", language+client); 
        var VMNBC100800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMNBC100800246NA_1_3308", language+client); 
        var marketValueNBC100800246NA_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueNBC100800246NA_1_3308", language+client);
                      
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5236","Cas de test TestLink : Croes-5236")
         
        //Log.AppendFolder("+++++++++++++++++++++++++++++++ 1ère partie : 'PREF_ACCOUNT_WITHDRAWAL_CASH' = NO +++++++++++++++++++++++++++++++")       
        //----------------------------------------------------------------------------------------------------------------------------------------
        /* Rép. Christine P. : IMPORTANT : NE PAS EXÉCUTER CETTE ÉTAPE (Étape 2)

        Explication : Suite au JIRA CROES-12163 (Supprimer PREF_ACCOUNT_WITHDRAWAL_CASH) corrigé sur la version 90.10.Fm-20 :

        La PREF_ACCOUNT_WITHDRAWAL_CASH a été supprimée afin que le comportement soit comme si la pref était toujours à YES.

        Donc, les tests avec 'PREF_ACCOUNT_WITHDRAWAL_CASH '=No ne sont plus pertinents car ils ne correspondent plus aux résultats attendus 
        et ne doivent plus être exécutés. */      
        
        //-----------------------------------------------------------------------------------------------------------------------------------------
        
        
        //Login
        Log.Message("***************************Login**********************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Log.Message("Création de modele "+modelName+" cp ="+codeCP);
        Create_Model(modelName,"",codeCP);
              
        //mailler vers portefeuille 
        Log.Message("mailler vers portefeuille")                    
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
       
        //Ajouter positions
        Get_Toolbar_BtnAdd().click(); 
              
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }                
        
        //BCE à 3%
        Log.Message("Ajouter la position "+BCE+" à"+targetBCE+"% au modèle "+modelName)        
        AddPositionToModel(BCE,targetBCE,typePicker,"")
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(BCE);
        
        //CM à 12%
        Log.Message("Ajouter la position "+CM+" à"+targetCM+"% au modèle "+modelName)
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(CM,targetCM,typePicker,"")        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(CM);   
        
        //BMO à 1.5%
        Log.Message("Ajouter la position "+BMO+" à"+targetBMO+"% au modèle "+modelName)
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(BMO,targetBMO,typePicker,"")        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(BMO);      
        
        //NBC100 à 0.5%
        Log.Message("Ajouter la position "+NBC100+" à"+targetNBC100+"% au modèle "+modelName)
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(NBC100,targetNBC100,typePicker,"")        
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NBC100);
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //assigné le client 800246 au modèle 
        Log.Message("assigné le client no "+client800246+" au modèle "+modelName)
        Get_ModulesBar_BtnModels().Click(); 
        AssociateClientWithModel(modelName,client800246); 
        
        //Log.AppendFolder("+++++++++++++++++++++++++++++++ 2ème partie : 'PREF_ACCOUNT_WITHDRAWAL_CASH' = YES +++++++++++++++++++++++++++++++")
        
        //Rééquilibrer le modele jusqu'a étape4
        Log.Message("Rééquilibrer le modele jusqu'a étape4")       
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
        Log.Message("--- Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.")
        if(Get_WinRebalance_TabParameters_ChkValidateTargetRange().Exists)
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().Exists)
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        if(Get_WinRebalance_TabParameters_ChkApplyAccountFees().Exists)
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);       
       
       /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse : -140000.00
        -valider la colonne Gest.encaisse la grille Compte 800246-GT = (-140000.00)*/
        Log.Message("--- A étape 2 ==> Click sur le bouton la gestion d'encaisse faire un retrait de "+withdrawalAmount+" pour le compte "+account800246GT)
        Get_WinRebalance_BtnNext().Click();         
        DepositWithdrawalAmount(account800246GT, withdrawalAmount);
        Log.Message("--- Valider le champs Gest.encaisse pour Compte "+account800246GT+" = "+withdrawalAmount)
        CheckDepositWithdrawalAmount(client800246,account800246GT,withdrawalAmount);
        
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      

        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");  
        
        Log.Message("Etape 4 portefeuille projeté : Valider les résultats") 
         //Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité + Valeur de marché + VM%
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        //1CAD - account800246GT
        VlaidatePPDataRow(position1CAD,quantity1CAD800246GT_1,marketValue1CAD800246GT_1,VM1CAD800246GT_1,account800246GT)
        //1CAD - account800246NA
        VlaidatePPDataRow(position1CAD,quantity1CAD800246NA_1,marketValue1CAD800246NA_1,VM1CAD800246NA_1,account800246NA)
        //BCE
        VlaidatePPDataRow(BCE,quantityBCE_1,marketValueBCE_1,VMBCE_1,account800246NA)
        //BMO
        VlaidatePPDataRow(BMO,quantityBMO_1,marketValueBMO_1,VMBMO_1,account800246NA)
        //CM - account800246GT
        VlaidatePPDataRow(CM,quantityCM800246GT_1,marketValueCM800246GT_1,VMCM800246GT_1,account800246GT)
        //CM - account800246NA
        VlaidatePPDataRow(CM,quantityCM800246NA_1,marketValueCM800246NA_1,VMCM800246NA_1,account800246NA)
        //NBC100 - account800246NA
        VlaidatePPDataRow(NBC100,quantityNBC100800246NA_1,marketValueNBC100800246NA_1,VMNBC100800246NA_1,account800246NA)
        
        Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.Message("*************************************************CLEANUP*********************************************************")
        /*RestoreData(modelName,client800246);
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();*/
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        
        Log.Message("*************************************************CLEANUP*********************************************************")
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,client800246);
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT",null, vServerModeles)  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH",null, vServerModeles)      
        RestartServices(vServerModeles);
        Runner.Stop(true)
        
    }
}

function RestoreData(modelName,clientNo){      
    //Supprimer le client de Modele 
    Log.Message("Supprimer le client de "+clientNo+" modèles "+modelName)
     RemoveAccountFromModel(clientNo,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
    //Supprimer le modele 
    Log.Message("Supprimer modèles "+modelName)
    DeleteModelByName(modelName)             
}

function DepositWithdrawalAmount(account, amount){
     
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    Get_WinCashManagement_DgvOverrideCashAmountData().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(account);
    Get_WinQuickSearch_BtnOK().Click();
    var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).dataContext.Index;
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    Get_WinCashManagement_BtnOk().click();
    
}

function CheckDepositWithdrawalAmount(client,account,amount){
    Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(client);
    Get_WinQuickSearch_BtnOK().Click();
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount)
    Get_WinCashManagement_BtnOk().click();
}

function VlaidatePPDataRow(symbole,quantity,marketValue,VM, account){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.MarketValue.OleValue,2)
        CheckEquals(detected,marketValue,"MarketValue");
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        CheckEquals(detected,VM,"VM (%)");
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}
