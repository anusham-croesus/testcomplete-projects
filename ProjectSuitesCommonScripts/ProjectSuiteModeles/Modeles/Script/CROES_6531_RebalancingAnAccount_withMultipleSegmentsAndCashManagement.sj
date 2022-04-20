//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Correspond au jira CROES-5449 Ne pas rééquilibrer le compte de son client (les autres utilisateurs peuvent)
    Ce cas de test valide qu'il n'y a pas de message de compte bloqué après deux manipulations des gestion de l'encaisse sur des segments. 
    
    Lien sur TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6531
    Lien sur Jira : https://jira.croesus.com/browse/CROES-5449
    Analyste d'assurance qualité : carolet
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	90.10.Fm-19
*/

function CROES_6531_RebalancingAnAccount_withMultipleSegmentsAndCashManagement()
{
    try {
                
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var account800001NA = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Account800001NA", language+client);        
        var sleeveMediumTerm =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ItemSleeveMediumTerm", language+client);
        var sleeveCanadianActions =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ItemSleeveCanadianEquity", language+client);
        var sleeveAmericanActions =ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ItemSleeveAmericanEquity", language+client);
        var modeleMoyenTerme = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleMoyenTerme", language+client);
        var modeleCanadianEquity = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleCanadianEquity", language+client);
        var modeleAmericanEquity = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "ModeleAmericanEquity", language+client);
        var withdrawalAmount1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WithdrawalAmount1_6531", language+client);
        var withdrawalAmount2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "WithdrawalAmount2_6531", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "Anomalies", "Message_6531", language+client);
        
              
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6531","Cas de test TestLink : Croes-6531")
        Log.Link("https://jira.croesus.com/browse/CROES-5449","Lien sur Jira : CROES-5449")
               
        //Login
        Log.Message("************************************** Login *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
        //Mailler le compte 800001-NA vers module Portefeuille 
        Log.Message("** Mailler le compte "+account800001NA+" vers module Portefeuille") 
        Search_Account(account800001NA);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800001NA,10), Get_ModulesBar_BtnPortfolio());
        
        Log.Message("** Cliquer sur Par classe d'actifs")
        Get_PortfolioGrid_BarToggleButtonToolBar_BtnByAssetClass().click();
        
        Log.Message("** Taper Ctrl-A pour  tout sélectionner. Faire un clic droit et sélectionner Créer des segments dans le menu contextuel")
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Keys("^a"); 
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).ClickR();         
        Get_PortfolioGrid_ContextualMenu_CreateSleeves().Click();
        
        //Ajouter les segments et leurs associer les modèles
        AssociateModelsToSleeves(sleeveMediumTerm,modeleMoyenTerme)
        AssociateModelsToSleeves(sleeveCanadianActions,modeleCanadianEquity)
        AssociateModelsToSleeves(sleeveAmericanActions,modeleAmericanEquity)        
        //Sauvegarder
        Get_WinManagerSleeves_BtnSave().Click(); 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");
        
        //Rééquilibrer jusqu'a étape 3
        /*À l'Étape 2 : Cliquez sur bouton Gestion encaisse ==> sélectionner Actions canadiennes et sous la colonne gestion encaisse : 2000.00
        -valider la colonne Gest.encaisse la grille segment Actions canadiennes = 2000.00*/
        Rebalancing(sleeveCanadianActions, withdrawalAmount1, message)        
        
        Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //***********
        
        //Rééquilibrer jusqu'a étape 3
        /*À l'Étape 2 : Cliquez sur bouton Gestion encaisse ==> sélectionner Actions américaines et sous la colonne gestion encaisse : 3000.00
        -valider la colonne Gest.encaisse la grille segment Actions américaines = 3000.00*/
        Rebalancing(sleeveAmericanActions, withdrawalAmount2, message)
        
        //Aller dans la section de gauche et explosé par le petit +, Valider la colonne Gest. encaisse de la grille pour le segment Actions américaines = 3000.00
        Log.Message("** Aller dans la section de gauche et explosé par le petit +, Valider le champs Gest.encaisse pour segment "+sleeveAmericanActions+" = "+withdrawalAmount2)	
        searchAccount = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account800001NA,10)
        if(!searchAccount.Exists)
            Scroll(searchAccount)
        var index = Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",account800001NA,10).dataContext.Index;
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
                
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",sleeveAmericanActions,10).Click();     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Find("Value",sleeveAmericanActions,10).DataContext.DataItem,"DepositWithdrawalAmount",cmpEqual,withdrawalAmount2);
        
        
        Log.Message("Fermer la fenêtre Rééquilibrer")                   
        Get_WinRebalance_BtnClose().Click();  
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        Log.Message("************************************** CLEANUP *********************************************")
        //**Supprimer les segments  
        RestoreData(account800001NA)
        
                
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
		    //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Log.Message("************************************** CLEANUP *********************************************")
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");                
        RestoreData(account800001NA)
        
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();  
        //Lorsqu'on fait reéquilibrage,Pour débloquer un compte 
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Runner.Stop(true)
    }
}

function AssociateModelsToSleeves(sleeve, modelName){
  Log.Message("** Sélectionner le segment "+sleeve+" et cliquer sur Modifier. Ajouter le modèle "+modelName+". Cliquer OK")
  Get_WinManagerSleeves().Parent.Maximize();
  SelectSleeveWinSleevesManager(sleeve);
  Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click();
  AddEditSleeveWinSleevesManager(sleeve,"","","","",modelName)
  
}
function DepositWithdrawalAmount(sleeve, amount){
     
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
     var index = Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",sleeve,10).dataContext.Index;
    var cellCashMgmt = Get_WinCashManagement_DgvOverrideCashAmountData().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", index+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", "5"], 10)
    cellCashMgmt.Click();
    var cashMgmtTxt = cellCashMgmt.FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["XamNumericEditor", 1], 10);    
    cashMgmtTxt.Keys(StrToFloat(amount));    
    Get_WinCashManagement_BtnOk().click();
    
}
function CheckDepositWithdrawalAmount(sleeve,amount){
    Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnCashManagement().Click();
    aqObject.CheckProperty(Get_WinCashManagement_DgvOverrideCashAmountData().WPFObject("RecordListControl", "", 1).Find("Value",sleeve,10).DataContext.DataItem ,"DepositWithdrawalAmount",cmpEqual,amount)
    Get_WinCashManagement_BtnOk().click();
}

function Scroll(searchValueObject){
 
  Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Click();
   if(searchValueObject == undefined){
        //cliquer sur scrollbar pour faire l'entête de colonne visible
        var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualWidth()
        var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).get_ActualHeight()  
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).Click(ControlWidth-40, ControlHeight-10);
    }   
    else if(!searchValueObject.Exists || !searchValueObject.VisibleOnScreen){
        var nbMaxOfRightKey = 10;
        var nbRightKey = 0;
        do {
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().Keys("[Right][Right][Right][Right]");
        } while ((!searchValueObject.Exists || !searchValueObject.VisibleOnScreen) && ++nbRightKey < nbMaxOfRightKey)           
    }
}

function Rebalancing(sleeve, withdrawalAmount, message){
    
    Log.Message("** Cliquer sur Rééquilibrer et cocher Rééquilibrer tous les segments -- Rééquilibrer jusqu'a étape 2")       
    Get_Toolbar_BtnRebalance().Click();               
    var numberOftries=0;  
    while ( numberOftries < 5 && !Get_WinRebalancingMethod().Exists){//Dans le cas, si le click ne fonctionne pas 
      Get_Toolbar_BtnRebalance().Click();
    numberOftries++;}   
    //Cocher Rééquilibrer tous les segments
    Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true);              
    Get_WinRebalancingMethod_BtnOK().Click();         
    WaitObject(Get_CroesusApp(), "Uid", "ResynchronizeParameterWindow_678f");                                                      
    Get_WinRebalance().Parent.Maximize();        
    //Avancer à l'étape suivante par la flèche en-bas à droite
    Get_WinRebalance_BtnNext().Click(); 
    
    Log.Message("** A étape 2 ==> Cliquez sur bouton Gestion encaisse sélectionner "+sleeve+" et sous la colonne Gest. encaisse mettre le montant "+withdrawalAmount)                 
    DepositWithdrawalAmount(sleeve, withdrawalAmount);
    Log.Message("** Valider le champs Gest.encaisse pour segment "+sleeve+" = "+withdrawalAmount)
    CheckDepositWithdrawalAmount(sleeve,withdrawalAmount);
        
    Log.Message("** Poursuivre le rééquilibrage jusqu'à l'étape 3")
    Get_WinRebalance_BtnNext().Click();      
        
    if(Get_WinWarningDeleteGeneratedOrders().Exists) {
       Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
    }           
    WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
    Log.Message("** Dans la section Message(s) de rééquilibrage, valider message = "+message)
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,message)
}

function RestoreData(account){
  Get_ModulesBar_BtnAccounts().Click();
  Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 15000);
  WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
  //Mailler le compte 800001-NA vers module Portefeuille 
  Log.Message("Mailler le compte "+account+" vers module Portefeuille") 
  Search_Account(account);
  Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
    
  Log.Message("Supprimer les segments crées pour compte "+account)
  Delete_AllSleeves_WinSleevesManager();
}

