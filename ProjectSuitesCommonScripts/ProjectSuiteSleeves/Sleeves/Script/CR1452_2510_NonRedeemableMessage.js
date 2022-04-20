//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Un message doit s'afficher si le rééquilibrage sur un compte UMA contient des titres non rachetables.
Scénario 4 : Rééquilibrer le modèle qui détient un segment qui a un titre non rachetable
Analyste d'automatisation: Youlia Raisper */


function CR1452_2510_NonRedeemableMessage()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var model=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelLongTerm", language+client);
        var account= GetData(filePath_Sleeves, "DataPool_WithModel", 8); //800040-RE
        var columnLockedPosition= ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinRebalance_TabPortfoliosToRebalance_ChLockedPosition", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Message_CR1452_2510", language+client);
        var sleeveLongTerm = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "ItemSleeveLongTerm", language+client);
        var assetAllocation = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client);    
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        Get_ModelsGrid().Find("Value",model,10).Click()
                                    
        // cliquer sur 'Rééquilibrer' 
        Get_Toolbar_BtnRebalance().Click();
        //Dans le cas, si le click ne fonctionne pas         
        if(!Get_WinRebalance().Exists){
           Get_Toolbar_BtnRebalance().Click();
        }
        
        Get_WinRebalance().Parent.Maximize();        
        // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click();   
        Get_WinRebalance_TabPortfoliosToRebalance_BarPadHeader_BtnSelectAll().Click(); 
        
        Get_WinRebalance_TabPortfoliosToRebalance_DvgAccounts().Find("Value",account,10).Click(); 
        Get_WinRebalance_BtnNext().Click();  
        // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();   
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); //Christophe : Ajout du dernier paramètre pour stabilisation 
        
        //Validation du message 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblZeroMarketValueMsg(), "Text", cmpEqual, message);
        //Validation du (infobulle)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_PnlBrowser().Find(["ClrClassName","WPFControlOrdinalNo"],["CellValuePresenter","2"],10).DataContext.DataItem, "RebalanceMessage", cmpEqual, message);
        
        Get_WinRebalance_BtnClose().Click();  
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        //var width = Get_DlgWarning().Get_Width(); //CP : Changé pour CO
        //Get_DlgWarning().Click((width*(1/3)),73); //CP : Changé pour CO
                    
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}