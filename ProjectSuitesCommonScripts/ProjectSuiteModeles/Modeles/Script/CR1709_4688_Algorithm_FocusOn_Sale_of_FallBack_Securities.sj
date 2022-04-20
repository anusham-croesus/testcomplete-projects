//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA



/**
    Description : Valider le rééquilibrage si le remplacement est une position bloquée
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4688
    CR1322 : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5235
    Version : CO-9
    Analyste d'assurance qualité : Manel
    Analyste d'automatisation : Emna IHM
*/

function CR1709_4688_Algorithm_FocusOn_Sale_of_FallBack_Securities()
{
    try {
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles) 
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_ACCOUNT_CASH_MANAGEMENT", "1", vServerModeles)         
        RestartServices(vServerModeles);
        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_4688", language+client);
        //var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var XBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XBB", language+client); 
        var targetXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetXBB_4688", language+client);
        var descriptionTitreRechange=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionTitreRechange_4688", language+client);
        var account800292JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800292JW", language+client);
        var withdrawalAmount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WithdrawalAmount_4688", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OrderTypeSell", language+client);
        var SubstituteType=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SubstituteTypeAlternative", language+client);
        var position1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var M02899=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "M02899", language+client);
        var quantity1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Quantity1CAD_4688", language+client); 
        var quantityXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityXBB_4688", language+client);        
        var quantityM02899=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityM02899_4688", language+client);
        var VM1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VM1CAD_4688", language+client); 
        var VMXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMXBB_4688", language+client);
        var VMM02899=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "VMM02899_4688", language+client);  
        var marketValue1CAD=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValue1CAD_4688", language+client);
        var marketValueXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueXBB_4688", language+client);
        var marketValueM02899=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueM20899_4688", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_4688", language+client);
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4688","Cas de test TestLink : Croes-4688")
                
        //Login
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        Create_Model(modelName,"",codeCP);
       
        //mailler vers portefeuille
        SearchModelByName(modelName);
        Drag(Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
       
       //ajouter une position XBB
        Get_Toolbar_BtnAdd().click();
        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        AddPosition(XBB,targetXBB,typePicker,"");
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Valider que la position a été ajoutée  
        CheckPresenceofPosition(XBB); 
        
        //Séléctionner la position XBB
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",XBB,10).Click();
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_BtnEdit().click();        
        //Ajouter Titre de rechange 
        Get_WinSubstitutionSecurities_BtnAdd().click();       
        AddSubstitutionSecuritiesByType(typePicker,descriptionTitreRechange,"",SubstituteType);
        
        //Valider que le titre de substitution Rechange a été ajouté
        aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",descriptionTitreRechange,10).DataContext.DataItem,"SubstituteType",cmpEqual, SubstituteType);
        Get_WinPositionInfo_BtnOK().Click(); 
            
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //assigné le compte 800292-JW au modèle
        Get_ModulesBar_BtnModels().Click();  
        AssociateAccountWithModel(modelName,account800292JW);       
        
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
       
       /*cliquez sur next pour allez a etape 2 == Cliquez sur bouton Gestion encaisse ==> colonne gestion encaisse : -2500
        -valider la colonne Gest.encaisse la grille Client 800292-JW = (-2500)*/
        Get_WinRebalance_BtnNext().Click(); 
        DepositWithdrawalAmount(account800292JW, withdrawalAmount);
        CheckDepositWithdrawalAmount(account800292JW,withdrawalAmount);
        
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.        
        Get_WinRebalance_BtnNext().Click();      
        
        //Avancer à l'étape 4 par la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        //valider les ordres  générés dans onglet ordre proposé : Valider que aucun ordre généré sur  XBB -- un ordre de vente sur le titre de rechange -- Message affiché dans section en bas Messages de rééquilibrage
        //XBB
        if(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",XBB,10).Exists)
            Log.Error("Il existe un ordre proposé sur XBB!");
        else
            Log.Checkpoint("Aucun ordre proposé sur XBB.");        
        //M02899 : un ordre de vente sur titre de rechange
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",M02899,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        //Message
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,message)
        
        //Valider Onglets Portefeuille projeté - Les colonnes : Quantité + Valeur de marché + VM%
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        //1CAD
        VlaidatePPData(position1CAD,quantity1CAD,marketValue1CAD,VM1CAD)
        //XBB
        VlaidatePPData(XBB,quantityXBB,marketValueXBB,VMXBB)   
        //M02899
        VlaidatePPData(M02899,quantityM02899,marketValueM02899,VMM02899)
                    
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //*************************************************Réinitialiser les données*********************************************************  
        /*RestoreData(modelName,account800292JW);
        
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
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        RestoreData(modelName,account800292JW);
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT =null , ALLOW_ALTERNATIVE=null WHERE  USER_NUM =104", vServerModeles)
        Runner.Stop(true)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        
    }
}

function DepositWithdrawalAmount(account, amount){
    
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "6"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    Get_WinCashManagement_BtnOk().click();
    
}
function CheckDepositWithdrawalAmount(account,amount){
    aqObject.CheckProperty(Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount)
}


function RestoreData(modelName,accountNo){      
    //Supprimer le compte de Modele 
     RemoveAccountFromModel(accountNo,modelName)
     aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0);
        
    //Supprimer le modele 
     DeleteModelByName(modelName)             
        
  
}
function VlaidatePPData(symbole,quantity,marketValue,VM){
    PP_Search(symbole);
    aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
    var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem.MarketValue.OleValue,2)
    if(FloatToStr(detected)==marketValue)
        Log.Checkpoint("MarketValue detected = "+detected+" est égale a marketValue expected = "+marketValue)
    else
        Log.Error("MarketValue detected = "+detected+" n'est pas égale a marketValue expected) = "+marketValue)        
       
    var detected=roundDecimal(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",symbole,10).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
    if(FloatToStr(detected)==VM)
        Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM)
    else
        Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM)
}


function Test(){
    var account800292JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800292JW", language+client);
    var withdrawalAmount=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WithdrawalAmount_4688", language+client);
    DepositWithdrawalAmount(account800292JW, withdrawalAmount);
    CheckDepositWithdrawalAmount(account800292JW,withdrawalAmount);
    
    /*Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10).Click();
    var caseGest = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
    var a = caseGest.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10)
    
    Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10).Keys(StrToFloat("14"));*/
}
