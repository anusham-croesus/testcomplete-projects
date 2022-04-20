//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_2416_RebalancingAccount_BlockedPosition
//USEUNIT CR1452_2429_RebalancingAccount_WithModel
//USEUNIT CR1452_2811_CashManagement_USAccount

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2212_TwoSleevesThatWanBuySameSecurity()
{
    try{                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelUSEQUI=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelUSEQUI", language+client);
        var modelAMERICANEQUI=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client);;
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800049OB", language+client);                        
        var sleeveAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_2212", language+client); 
        var sleeveAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription2CR1452_2212", language+client);                 
        var targetAdhoc1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc1", language+client);  
        var targetAdhoc2=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TargetAdhoc2", language+client);  
        var unallocated=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveUnallocated", language+client); 
        var positionDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var quantityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityDIS_2212", language+client);
        var positionAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolAAPL", language+client); 
        var quantityAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityAAPL_2212", language+client); 
        var positionMSFT=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolMSFT", language+client); 
        var quantityMSFT=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "QuantityMSFT_2212", language+client); 
        var balance=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Balance_USD", language+client);                        
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);        
        var solde=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Solde1_2811", language+client);   
                    
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
                    
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                                 
        //Ajouter un segment Adhoc1
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc1,"",targetAdhoc1,"","",modelAMERICANEQUI)
        
         //Ajouter un segment Adhoc2
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc2,"",targetAdhoc2,"","",modelUSEQUI)       

        //diviser le solde entre les 2 segments
        DivideBalance(unallocated,balance,solde,sleeveAdhoc1)               
        DivideBalance(unallocated,balance,solde,sleeveAdhoc2)
        Get_WinManagerSleeves_BtnSave().Click();  
                                                      
        //Rééquilibrer les segments 
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalancingMethod().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAllSleeves().set_IsChecked(true)
        Get_WinRebalancingMethod_BtnOK().Click();
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();       
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Transaction attendue: 84 Dis, 6 Apple, 70 MSFT
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionAAPL,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityAAPL);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionDIS,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityDIS);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",positionMSFT,10).DataContext.DataItem, "EditableQuantity", cmpEqual, quantityMSFT);
                  
        Get_WinRebalance_BtnClose().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************      
        //Supprimer des segments 
        Get_ModulesBar_BtnPortfolio().Click()
        Delete_AllSleeves_WinSleevesManager();
        //Fermer l'application
        Close_Croesus_MenuBar();      
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
        //Supprimer des segments 
        Get_ModulesBar_BtnPortfolio().Click()
        Delete_AllSleeves_WinSleevesManager();
        //Fermer l'application
        Close_Croesus_MenuBar();

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function ResetData(account){              
      //Supprimer des segments 
      Get_ModulesBar_BtnPortfolio().Click()
      Delete_AllSleeves_WinSleevesManager();
}