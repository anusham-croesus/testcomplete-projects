//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider le rééquilibrage si le remplacement est une position bloquée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3549
    Version : DY-6
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
*/

function CR1709_3549_ValidateNonRedeemableSecurityRebalancingAnd_CashManagement()
{
      try {
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "YES", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "0", vServerModeles)  
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChBonds", language+client);
        var client800008=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800008", language+client);
        var withdrawalAmount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WithdrawalAmount_3549", language+client);
        var account800008OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800008OB", language+client);
        var account800008NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800008NA", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client);
        var B55410=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionB55410", language+client);
        var N49627=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionN49627", language+client);
        var targetN49627 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "targetN49627_3549", language+client);
        var targetB55410 = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "targetB55410_3549", language+client);        
        var CVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client);
        var ECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client);     
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderTypeSell", language+client);        
        var position1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position1USD", language+client);
        var quantity1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1USD_3549", language+client); 
        var marketValue1USD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1USD_3549", language+client);       
        var SummarytBalanceAccount800008OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummarytBalanceAccount800008OB_3549", language+client)
       
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3549","Cas de test TestLink : Croes-3549")
                
        //Login
        Log.Message("***************************Login**********************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        //Valider la précondition: Modele= CH Bonds dont la composition = TITRE N49627=20% + B55410 30%
        Log.Message("Valider la précondition: Modele= "+modelName+" dont la composition = TITRE "+N49627+" = "+targetN49627+"% + "+B55410+" = "+targetB55410+"%")
        var percentValues = new Array (targetN49627,targetB55410);
        var securities = new Array (N49627,B55410);
        Check_ModelPrecondition(modelName,securities,percentValues);
                
        //assigné le client 800008 au modèle CH BONDS
        Log.Message("assigné le client no "+client800008+" au modèle "+modelName)
        Get_ModulesBar_BtnModels().Click(); 
        AssociateClientWithModel(modelName,client800008);       
        
        //Mailler client 800008 vers portefeuille et valider que Les titres CVE + ECA sont non rachetable
        Log.Message("Mailler client no "+client800008+" vers portefeuille et valider que Les titres "+CVE+" et "+ECA+" sont non rachetables.")
        Drag(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800008,10), Get_ModulesBar_BtnPortfolio());
        Log.Message("--- Valider que le titre "+CVE+" est non rachetable.")
        CheckNonRedeemableSecurity(CVE);
        Log.Message("--- Valider que le titre "+ECA+" est non rachetable.")
        CheckNonRedeemableSecurity(ECA);
        
       //Rééquilibrer le modele jusqu'a étape4
       Log.Message("Rééquilibrer le modele jusqu'a étape4")
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
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
       
       /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse : -789000.00
        -valider la colonne Gest.encaisse la grille Compte 800008-OB = (-789000.00)*/
        Log.Message("--- A étape 2 ==> Click sur le bouton la gestion d'encaisse faire un retrait de "+withdrawalAmount+" pour le compte "+account800008OB)
        Get_WinRebalance_BtnNext().Click();         
        DepositWithdrawalAmount(account800008OB, withdrawalAmount);
        Log.Message("--- Valider le champs Gest.encaisse pour Compte "+account800008OB+" = "+withdrawalAmount)
        CheckDepositWithdrawalAmount(client800008,account800008OB,withdrawalAmount);
        
        Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      

        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'         
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");         
        
        Log.Message("Valider les resultats") 
        CheckInProjectedPortfolios(client800008,account800008OB,account800008NA,withdrawalAmount,position1USD,quantity1USD,marketValue1USD,orderTypeSell,CVE,ECA,SummarytBalanceAccount800008OB)
        
        Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
         
        Log.Message("*************************************************CLEANUP*********************************************************")
        /*RestoreData(modelName,client800008);
        
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
        RestoreData(modelName,client800008);
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT",null, vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", null, vServerModeles)         
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "1", vServerModeles)       
        RestartServices(vServerModeles);
        Runner.Stop(true)
        
    }
}


function RestoreData(modelName,clientNo){      
    //Supprimer le client 800008 de Modele 
    Log.Message("Supprimer le client no "+clientNo+" de Modele "+modelName)
    RemoveAccountFromModel(clientNo,modelName)
    aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
}

function Check_ModelPrecondition(modelName,securities,values){
   SearchModelByName(modelName);
   //Mailler le model vers portefeuille et valider que Les titres 
   Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
   //N49627=20% + B55410 30%
   for(i=0; i<securities.length && i<values.length; i++){
       var positionExistence=Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securities[i],100).Exists       
       if(positionExistence==true){
            Log.Checkpoint("La position "+securities[i]+" existe.")
            aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",securities[i],100).dataContext.dataItem, "ModelTargetPercent",cmpEqual, values[i]);
       }
       else{
            Log.Error("La position "+securities[i]+" n'existe pas.")
            return;            
       } 
   }  
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

function CheckInProjectedPortfolios(Client,AccountOB,AccountNA,DepositWithdrawalAmount,symbole,quantity,marketValue, orderType,CVE,ECA,SummarytBalance)
{
    Scroll();
    var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",Client,10).dataContext.Index;
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
    
    //Aucun ordre de vente sur CVE ECA pour le compte 800008-NA -- Vérification demandé par Karima Mo.    
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",AccountNA,10).Click();
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
    Log.Message("--- TabProposedOrders : valider Aucun ordre de vente sur "+CVE+" pour le compte "+AccountNA+" -- Vérification demandé par Karima Mo.")
    PO_Search(CVE)
    if(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",CVE,10).Exists)
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",CVE,10).DataContext.DataItem, "OrderType", cmpNotEqual, orderType);
    else
        Log.Checkpoint("Aucun ordre de vente sur CVE pour le compte 800008-NA");
    
    Log.Message("--- Valider Aucun ordre de vente sur "+ECA+" pour le compte "+AccountNA+" -- Vérification demandé par Karima Mo.") 
    PO_Search(ECA)
    if(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",ECA,10).Exists)
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",ECA,10).DataContext.DataItem, "OrderType", cmpNotEqual, orderType);
    else
        Log.Checkpoint("Aucun ordre de vente sur ECA pour le compte 800008-NA");
        
    //valider la colonne Gest.encaisse la grille Compte 800008-OB = (-789000.00)
    Log.Message("--- Valider le champs Gest.encaisse pour Compte "+AccountOB+" = "+DepositWithdrawalAmount)	
    Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",AccountOB,10).Click();     
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",AccountOB,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,DepositWithdrawalAmount);
   
   //Ventes de toutes les positions du compte 800008-OB 
   Log.Message("--- Valider Ventes de toutes les positions du compte "+AccountOB)
   Get_WinRebalance_TabProposedOrders_DgvProposedOrders().click();   
   var lines = Get_Grid_VisibleLines (Get_WinRebalance_TabProposedOrders_DgvProposedOrders());    
   for(n = 0; n < lines.length; n++) // Iterate through grid rows
       aqObject.CheckProperty(lines[n].DataContext.DataItem, "OrderType", cmpEqual, orderType);   
   
   Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
   //valider que le compte 800008-OB a un Solde= 921.03>0
   Log.Message("--- TabProjectedPortfolios : valider que le compte "+AccountOB+" a un Solde = "+quantity+">0")
   aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtBalance(),"Text",cmpEqual,SummarytBalance);
   aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem, "Symbol", cmpEqual, symbole);
   aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem, "AccountNumber", cmpEqual, AccountOB);
   aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
   var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem.MarketValue.OleValue,2)
   if(FloatToStr(detected)==marketValue)
        Log.Checkpoint("MarketValue detected = "+detected+" est égale a marketValue expected = "+marketValue)
   else
        Log.Error("MarketValue detected = "+detected+" n'est pas égale a marketValue expected) = "+marketValue)       
   
}

function Scroll(){
  var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
  var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-49);
}
