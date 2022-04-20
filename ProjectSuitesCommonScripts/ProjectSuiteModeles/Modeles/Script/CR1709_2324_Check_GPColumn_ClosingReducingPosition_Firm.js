//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2324
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2324_Check_GPColumn_ClosingReducingPosition_Firm()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles) 
        Activate_Inactivate_PrefFirm("Firm_1","PREF_ENABLE_MODEL_PROJECTED_PF_BY_ACCOUNT","NO",vServerModeles); 
        RestartServices(vServerModeles);          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestCalcul", language+client);                        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800033RE", language+client);  
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderType", language+client);
        var orderTypeSell=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "OrderTypeSell", language+client);         
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client); 
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);    
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var CUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCUR", language+client);
        var V61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityV61632", language+client);
        var AER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAER", language+client);                   
        var CTM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCTM", language+client);          
        var realizedGainsLossesAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesAER", language+client);  
        var realizedGainsLossesPercentageAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageAER", language+client);    
        var gainLossUnrealizedFromOpenOrderAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderAER", language+client); 
        var percentGainLossUnrealizedFromOpenOrderAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderAER", language+client);         
        var realizedGainsLossesCTM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesCTM", language+client);  
        var realizedGainsLossesPercentageCTM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageCTM", language+client);                     
        var gainLossUnrealizedFromOpenOrderNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderNBC100", language+client); 
        var percentGainLossUnrealizedFromOpenOrderNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderNBC100", language+client); 
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client);
        var realizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLNonRegt", language+client);
        var unrealizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLNonRegt", language+client);
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                      
        //assigné le compte 800033-RE au modèle
        AssociateAccountWithModel(modelName,account)
                                                                 
        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();               
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
        numberOftries++;}                                                  
        Get_WinRebalance().Parent.Maximize();  
              
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        //Avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
        Get_WinRebalance_BtnNext().Click();  
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
                
        //Valider dans l'onglet ordre proposé : 3 ordres achats des positions NBC100,BMO,et V61632 sont générés 2 ordres de ventes , CTM et AER sont générés
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",NBC100,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",V61632,10).DataContext.DataItem, "OrderType", cmpEqual, orderType);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",CTM,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AER,10).DataContext.DataItem, "OrderType", cmpEqual, orderTypeSell);
        
        
        //-positions BMO :  gain et perte réalisés (%)= n/d ,  gain et perte réalisés ($)= n/d --  positions  v61632 gain et perte réalisés (%)= n/d ,  gain et perte réalisés ($)= n/d 
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",BMO,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, null);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLossesPercentage", cmpEqual, null); 
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
        
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",V61632,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, null);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLossesPercentage", cmpEqual, null); 
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
        
        //Valider les colonnes g/p réalisé lors de la réduction de position : gp réalisé  position AER=(8143.78) % GP réalisé =-32.80
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",AER,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, realizedGainsLossesAER);        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem , "RealizedGainsLossesPercentage", cmpEqual, realizedGainsLossesPercentageAER); 
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
        
     
        //Valider les G/P  dans etape 4  onglet portefeuille projeté.
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //AER
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",AER,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, realizedGainsLossesAER);
        var PercentGainLossRealizedFromOpenOrder =Get_WinRebalance_PositionsGrid().Find("Value",AER,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder
        aqObject.CompareProperty(aqString.SubString(PercentGainLossRealizedFromOpenOrder,0,10),cmpEqual,aqString.SubString(realizedGainsLossesPercentageAER, 0, 10),true,3)
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",AER,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, gainLossUnrealizedFromOpenOrderAER);  
        var PercentGainLossUnrealizedFromOpenOrder=Get_WinRebalance_PositionsGrid().Find("Value",AER,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder
        aqObject.CompareProperty(aqString.SubString(PercentGainLossUnrealizedFromOpenOrder,0,10),cmpEqual,aqString.SubString(percentGainLossUnrealizedFromOpenOrderAER, 0, 10),true,3)
        //CTM
        var detected=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",CTM,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder.OleValue,2)
        CheckEquals(detected,realizedGainsLossesCTM,"RealizedGainsLosses CTM")
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",CTM,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, realizedGainsLossesPercentageCTM);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",CTM,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, null);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",CTM,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, null); 
        //NBC100
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",NBC100,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, null);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",NBC100,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, null);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",NBC100,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, gainLossUnrealizedFromOpenOrderNBC100);  
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",NBC100,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, percentGainLossUnrealizedFromOpenOrderNBC100);
        
        //Valider dans la section sommaire :
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonReg().Click();        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLReg() , "Text", cmpEqual, ndText); //Avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg() , "Text", cmpEqual, ndText); //Avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLRegCalculated() , "Text", cmpEqual, ndText);//Avant Content
        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonRegt);//Avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonRegt);//Avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonRegCalculated() , "Text", cmpEqual, ndText); //Avant Content
        
        /*Passer a Etape 5 */
        /*G/P réalisés position AER  =(8143.78) GP %=(-32.80) G/P réalisés position ctm  =6.88 GP %=0)*/
       Get_WinRebalance_BtnNext().Click(); 
       var index = Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",AER,10).DataContext.Index
       Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, realizedGainsLossesAER);        
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem , "RealizedGainsLossesPercentage", cmpEqual, realizedGainsLossesPercentageAER); 
       Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false) 
       
       var index = Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",CTM,10).DataContext.Index     
       Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
       var detected=roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem.RealizedGainsLosses.OleValue,2)
       CheckEquals(detected,realizedGainsLossesCTM,"RealizedGainsLosses CTM")
       aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem , "RealizedGainsLossesPercentage", cmpEqual, realizedGainsLossesPercentageCTM); 
       Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false) 
                               
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
             
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(account,modelName);     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
            

    }
    finally {  
        Terminate_CroesusProcess(); //Fermer Croesus
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        Login(vServerModeles, user, psw, language);   
        Get_ModulesBar_BtnModels().Click()
        Get_MainWindow().Maximize();
        ResetData(account,modelName)
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles) 
        RestartServices(vServerModeles);
        Runner.Stop(true);      
    }
}

function ResetData(account,modelName){
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
}