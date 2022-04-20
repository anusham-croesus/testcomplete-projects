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

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function CR1452_2427_RebalancingAccount()
{
    try{  
    
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","YES",vServerSleeves)   
        RestartServices(vServerSleeves)
                        
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelTESTPOSBLOQ1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Account800247NA", language+client);                          
        var sleeveAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SleeveDescription1CR1452_2427", language+client); 
        var targetAdhoc=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Target2427", language+client); 
        var positionXCB=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client); 
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_2427", language+client); 
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnAccounts().Click()
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio());
        
        //Sélectionner la position 'XCB' et mettre comme position bloquée dans Info Portefeuille et OK
        Search_Position(positionXCB)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionXCB),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que la position est bloquée  
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionXCB,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
                    
        //convertir le compte en UMA 
        Get_PortfolioBar_BtnSleeves().Click();
        Get_WinManagerSleeves().Parent.Maximize();                                 
        //Ajouter un segment Adhoc
        Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
        AddEditSleeveWinSleevesManager(sleeveAdhoc,"",targetAdhoc,"","",modelTESTPOSBLOQ1)
        
        //Transférer toutes les positions du compte du segment Non-attribués vers le segment Adhoc
        Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().Keys("^a"); 
        Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();              
        Get_WinMoveSecurities_CmbToSleeve().Keys(sleeveAdhoc);
        Get_WinMoveSecurities_BtnOk().Click();
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
        
        //Validation du message 
        var message = aqString.Replace(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg().Text,Chr(160),"")       
        if(aqObject.CompareProperty(message,cmpContains, message)){
          Log.Checkpoint("Les valeurs sont bonnes ")
        } 
        else{
          Log.Error("Les valeurs ne sont pas bonnes ")
        }
                  
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
               
        //*************************************************Réinitialiser les donnée*********************************************************     
        ResetData(account,positionXCB);        
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
        ResetData(account,positionXCB);

    }
    finally {   
        Terminate_CroesusProcess(); //Fermer Croesus
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_LOCKED_POSITIONS_MESSAGE","NO",vServerSleeves)   
        RestartServices(vServerSleeves)
    }
}