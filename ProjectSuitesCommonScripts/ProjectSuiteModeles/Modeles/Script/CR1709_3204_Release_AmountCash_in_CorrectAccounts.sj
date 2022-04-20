//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider le rééquilibrage si le remplacement est une position bloquée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3204
    CR1322 : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5234
    Version : CO-9
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
    Adapté par Abdel le 12/02/2020
*/

function CR1709_3204_Release_AmountCash_in_CorrectAccounts()
{
    try {
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerModeles)         
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client);
        var client800008=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800008", language+client);
        var withdrawalAmount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WithdrawalAmount_3204", language+client);
        var account800008OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800008OB", language+client);
        var account800008NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800008NA", language+client);
        var account800008JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800008JW", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client);
        var B55410=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionB55410", language+client);
        var N49627=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionN49627", language+client);
        var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
        var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);     
        var orderTypeBuy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderType", language+client);
        
        var quantity1CAD800008NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800008NA_3204", language+client); 
        var VM1CAD800008NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800008NA_3204", language+client); 
        var marketValue1CAD800008NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800008NA_3204", language+client);        
        var quantity1CAD800008JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD800008JW_3204", language+client); 
        var VM1CAD800008JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD800008JW_3204", language+client); 
        var marketValue1CAD800008JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD800008JW_3204", language+client);        
        var quantity1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1USD_3204", language+client); 
        var VM1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1USD_3204", language+client); 
        var marketValue1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1USD_3204", language+client);       
        var quantityB55410=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityB55410_3204", language+client); 
        var VMB55410=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMB55410_3204", language+client); 
        var marketValueB55410=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueB55410_3204", language+client); 
        var quantityN49627=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityN49627_3204", language+client); 
        var VMN49627=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMN49627_3204", language+client); 
        var marketValueN49627=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueN49627_3204", language+client);         
        var quantityCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityCVE_3204", language+client); 
        var VMCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMCVE_3204", language+client); 
        var marketValueCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueCVE_3204", language+client);        
        var quantityECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityECA_3204", language+client); 
        var VMECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMECA_3204", language+client); 
        var marketValueECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueECA_3204", language+client);
        var SubModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelGROWTHBASKET", language+client);
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3204","Cas de test TestLink : Croes-3204")
                
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        //Enlever le client 800008 du modèle CH BONDS (résultat d'autres scripts non identifié), supprimer le sous modèle s'il existe et activer le modèle
        Log.Message("Cette modification est faite suite à l'adaptation des scripts de modèles");
        Log.Message("Vérifier et supprimer s'il ya un sous modèle 'PANIER CROISSANCE'");
        RestoreData1(modelName, SubModel);
        
        Log.Message("Enlever le client 800008 du modèle CH BONDS qui est créé par l'un des scripts précédents qui n'est pas identifié");
        RemoveClientFromModel(client800008, modelName);
        
        Log.Message("Activer le modèle CH BONDS puisqu'il est désactivé par l'un des scripts précédents");
        ActivateDeactivateModel(modelName,true);
                
        //assigné le client 800008 au modèle CH BONDS 
        AssociateClientWithModel(modelName,client800008);       
        
       //Rééquilibrer le modele jusqu'a étape4
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
        
        //Décocher les cases , valider les limites , Répartir la liquidité, Appliquer les frais.
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
       
       /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse : -789000.00
        -valider la colonne Gest.encaisse la grille Compte 800008-OB = (-789000.00)*/
        Get_WinRebalance_BtnNext().Click(); 
        DepositWithdrawalAmount(account800008OB, withdrawalAmount);
        CheckDepositWithdrawalAmount(client800008,account800008OB,withdrawalAmount);
        
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      
        
        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //valider les ordres  générés dans onglet ordre proposé : Valider qu'il y a un ordre d'achat sur B55410 compte 800008-NA
        //B55410 : ordre d'achat
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",B55410,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeBuy);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",N49627,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeBuy);
        
        //Valider Onglets Portefeuille projeté - Les colonnes : Symbole - Compte - Quantité + Valeur de marché + VM%
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        //1CAD
        VlaidatePPDataRow(position1CAD,quantity1CAD800008NA,marketValue1CAD800008NA,VM1CAD800008NA,account800008NA)
        //1CAD
        VlaidatePPDataRow(position1CAD,quantity1CAD800008JW,marketValue1CAD800008JW,VM1CAD800008JW,account800008JW)
        //1USD
        VlaidatePPDataRow(position1USD,quantity1USD,marketValue1USD,VM1USD,account800008OB)
        //B55410
        VlaidatePPDataRow(B55410,quantityB55410,marketValueB55410,VMB55410,account800008NA)   
        //N49627
        VlaidatePPDataRow(N49627,quantityN49627,marketValueN49627,VMN49627,account800008NA)
        //CVE
        VlaidatePPDataRow(CVE,quantityCVE,marketValueCVE,VMCVE,account800008NA)
        //ECA
        VlaidatePPDataRow(ECA,quantityECA,marketValueECA,VMECA,account800008NA)
                            
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //*************************************************Réinitialiser les données*********************************************************  
        /*RestoreData(modelName,client800008);
        
        //Fermer Croesus
        Close_Croesus_X();*/
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
        
    }
    finally {
      //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,client800008);
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();      
		    Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerModeles)         
        RestartServices(vServerModeles);
        //Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        
    }
}

function DepositWithdrawalAmount(account, amount){
     
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    Get_WinCashManagement_DgvOverrideCashAmountData().Keys("8");
    Get_WinQuickSearch_TxtSearch().setText(account);
    Get_WinQuickSearch_BtnOK().Click();
    var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",account,10).dataContext.Index;
    //var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
    //Cette ligne a été modifié suite au CR1990 (Ajout de la colonne solde %) la colonne Gestion d'encaisse passe de la position 5 à la position 6
    Log.Message("Cette ligne a été modifié suite au CR1990 (Ajout de la colonne solde %) la colonne Gestion d'encaisse passe de la position 5 à la position 6");
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


function RestoreData(modelName,accountNo){      
    //Supprimer le client 800008 de Modele 
     RemoveAccountFromModel(accountNo,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
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
        if(FloatToStr(detected)==marketValue)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a marketValue expected = "+marketValue)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a marketValue expected) = "+marketValue)        
       
        var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(FloatToStr(detected)==VM)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM)
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}

function RemoveClientFromModel(clientNo, modelName)
{
    Get_ModulesBar_BtnModels().Click();
    SearchModelByName(modelName);
    if(Get_ModelsGrid().FindChild("Value", modelName, 10).Exists){
            
          Get_ModelsGrid().FindChild("Value", modelName, 10).Click();
          FindResult = Get_Models_Details_DgvDetails().FindChild("Value", clientNo, 10);
          if (FindResult.Exists == true){
              Get_Models_Details_DgvDetails().FindChild("Value", clientNo, 10).Click();
              Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
              //Get_DlgCroesus().Click(150, 70); //EM : Modifié depuis CO: 90-07-22-Be-1
                if(Get_DlgConfirmation().Exists){
                    var width = Get_DlgConfirmation().Get_Width();
                    Get_DlgConfirmation().Click((width*(1/3)),73);
                }
          }
          else  Log.Message("Client No " + clientNo + " not assigned to model No " + modelName);      
    }
    else Log.Error("Le modèle no "+modelName+" n'existe pas.");
}

function RestoreData1(modelName, SubModel)
{
    SearchModelByName(modelName);
    Get_ModelsGrid().Find("Value",modelName,10).Click();
    Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio()); 
    //Supprimer le sous modèle 
    if(Get_PortfolioPlugin().Find("Value",SubModel,10).Exists){
        Get_PortfolioPlugin().Find("Value",SubModel,10).Click();
        Get_Toolbar_BtnDelete().Click(); 
              
        var width =Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        if(Get_DlgConfirmation().Exists) {
          Get_DlgConfirmation().Click((width*(1/3)),73);
       }
        //sauvgarder les modification 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
    }    
}