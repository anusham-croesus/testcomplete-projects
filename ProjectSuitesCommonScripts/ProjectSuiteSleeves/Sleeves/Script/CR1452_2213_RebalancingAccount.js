//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2213_RebalancingAccount()
{
    try{                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelCHFUND1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND1", language+client);
        var modelCHFUND2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND2", language+client);        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800049NA", language+client);                  
        var sleeveAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_2213", language+client); 
        var sleeveAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription2CR1452_2213", language+client);         
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetModel_2213", language+client);  
        var assetAllocation=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "WinManagerSleeveCmbAssetAllocationFirm", language+client);
        var sleeveDescriptionForeignEquity= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionForeignEquity", language+client);  
        var targetForeignEquity= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetForeignEquity_2213", language+client);  
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);
        var quantityNBC100_2213=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityNBC100_2213", language+client);
        var sleeveDescriptionCash=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescriptionCash", language+client);
        var securityNBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC100", language+client);
        var quantityAdhoc1NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc1NBC100_2213", language+client);
        var securityFID228 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolFID228", language+client);
        var quantityAdhoc1FID228 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc1FID228_2213", language+client);
        var quantityAdhoc2FID228 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2FID228_2213", language+client);
        var quantityAdhoc2NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2NBC100_2213", language+client);
        var quantityAdhoc2NBC566=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAdhoc2NBC566_2213", language+client);
        var securityNBC566 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC566", language+client);
        
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Execute_SQLQuery("delete from b_or_ou where no_compte = '"+account+"'", vServerSleeves) //EM : Requête fournit par Christine H. pour régler le prob de reéquilibrage rencontré. Selon Christine H. ce problème va être reglé avec le CR2160 car on aura la possibilité de multirééquilibrage avec multiuser
        RestartServices(vServerSleeves)  
                             
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Grouper par classe d'actifs
        Get_PortfolioGrid_GrpSummary_CmbAssetAllocation().Set_Text(assetAllocation);              
        CreateSleeveByAssetClass();
                   
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                                 
        //Ajouter un segment Adhoc1
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc1,"",targetAdhoc,"","",modelCHFUND1);
        CheckThatModelBindedToSleeve( sleeveAdhoc1,modelCHFUND1)
        
        //Ajouter un segment Adhoc2
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
         if(!Get_WinEditSleeve().VisibleOnScreen){
          Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click(); 
        } 
        AddEditSleeveWinSleevesManager(sleeveAdhoc2,"",targetAdhoc,"","",modelCHFUND2);
        CheckThatModelBindedToSleeve( sleeveAdhoc2,modelCHFUND2)
       
        //Modifier la cible du segment 'Actions étrangères' à 10% 
        Get_WinManagerSleeves_GrpSleeves_DgvSleeves().Find("Value",sleeveDescriptionForeignEquity,100).Click();
        Delay(2500);
        Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click(); 
        if(!Get_WinEditSleeve().Exists){
          Get_WinManagerSleeves_GrpSleeves_BtnEdit().Click(); 
        } 
        AddEditSleeveWinSleevesManager("","",targetForeignEquity,"","","");        
        Get_WinManagerSleeves_BtnSave().Click();
                                                         
        //Rééquilibrer le compte 
        Get_Toolbar_BtnRebalance().Click();
       //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Valider le movement des liquidités
        aqObject.CompareProperty( CheckCashMovements(),cmpEqual, 0);
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
                            
        /*Validation: Dans segment 'Encaisse..': NBC100=680,010 */        
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveDescriptionCash,10).Click();         
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityNBC100_2213);
        
        /*Dans Adh1: Dans segment 'S1': NBC100 = 1702.76, FID228 = 398.38*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc1,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAdhoc1NBC100);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityFID228,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityFID228,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAdhoc1FID228);
         
        /*Dans Adh2: Dans segment 'S2': NBC100 = 4256.896, NBC566 = 357.722, FID228=199.190*/
        Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value",sleeveAdhoc2,10).Click();  
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAdhoc2NBC100);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityFID228,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityFID228,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAdhoc2FID228);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC566,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC566,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAdhoc2NBC566);
         
         
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************      
        ResetData(account);         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        ResetData(account);

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account,positionXCB){
              
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
}

function CheckCashMovements(){

  Get_WinRebalance_TabProjectedPortfolios_TabCashMovements().Click();
  var sum=0;
  var sumCalculation=false;
  var count=Get_WinRebalance_TabProjectedPortfolios_TabCashMovements_DgvCashMovements().WPFObject("RecordListControl", "", 1).Items.Count
  for(var i=0; i<count; i++){
    sum = sum + Math.round(Get_WinRebalance_TabProjectedPortfolios_TabCashMovements_DgvCashMovements().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.DisplayQuantity)
    Log.Message(Get_WinRebalance_TabProjectedPortfolios_TabCashMovements_DgvCashMovements().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.DisplayQuantity)
    sumCalculation =true;
  } 
  if(sumCalculation){
    return sum;
  }  
} 

