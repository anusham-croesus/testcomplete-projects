//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2166_Edit_Price_CP_Model


 /* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4528
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_4528_Check_GPColumn_Basket() //Scripté sur la version ref90-04-BNC-65--V9-CX_1-co6x
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)
        RestartServices(vServerModeles)                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");         
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client); 
        var client800285=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800285", language+client);
        var basket844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Basket844000", language+client);
        var realizedGainsLosses844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLosses844000", language+client);
        var realizedGainsLossesPercentage844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentage844000", language+client);
        var realizedGainsLosses844000_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLosses844000_1", language+client);
        var realizedGainsLossesPercentage844000_1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentage844000_1", language+client);
        var realizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "realizedGLNonRegt_4528", language+client);
        var unrealizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "unrealizedGLNonRegt_4528", language+client);
                                                 
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                                 
        AssociateClientWithModel(modelName, client800285);
        
        //Activer le modèle cette modification est faite le 12/02/2020 
        Log.Message("------ Activer le modèle, parfois le modèle est désactivé par un des scripts précédents ");
        ActivateDeactivateModel(modelName,true);

        //Rééquilibrer le modele
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize(); 
        //décocher lase valider les limites + Répartir la liquidité si disponible
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);    
        //Avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();      
        Get_WinRebalance_BtnNext().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
               
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Keys("8");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(basket844000);
        //Get_WinSecuritiesQuickSearch_RdoSecurity().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        Delay(2000);
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",basket844000,10).Click();
        ScrollTabProposedOrdersBlockOffDgvProposedOrders();
        //********************* gain et perte réaisé ($)=(4822,15) , gain et perte  réalisé (%)=(12.07) (identique au portefeuille)*********       
        //Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
        Log.Message("BNC-1863");
        var detected =roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",basket844000,10).DataContext.DataItem.RealizedGainsLosses,2)  
        CheckEquals(detected,realizedGainsLosses844000,"RealizedGainsLosses")   
        var detected = roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("DisplayText",basket844000,10).DataContext.DataItem.RealizedGainsLossesPercentage,2)
        CheckEquals(detected,realizedGainsLossesPercentage844000,"RealizedGainsLossesPercentage")
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd",15000);  
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(basket844000);
        Get_WinSecuritiesQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",basket844000,10).Click();
        var detected = roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",basket844000,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,2)
        CheckEquals(detected,realizedGainsLosses844000_1,"GainLossRealizedFromOpenOrder")
        var detected = roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",basket844000,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder,2) 
        CheckEquals(detected,realizedGainsLossesPercentage844000_1,"PercentGainLossRealizedFromOpenOrder")
        
        //Valider que dans etape 4 du rééquilibrage onglet portefeuille projeté section sommaire :g/perte non réalisé =15147,50, g/perte réalisé =61 482,95
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonRegt); //avant CX Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonRegt)//avant CX Content
       
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);  
        //*************************************************Réinitialiser les données*********************************************************  
        //ResetData(client800285,modelName);    
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
        ResetData(client800285,modelName);
        Terminate_CroesusProcess();
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
        RestartServices(vServerModeles)  
        //Runner.Stop(true);
    }
}

function ScrollTabProposedOrdersBlockOffDgvProposedOrders()
{
    //cliquer sur scrollbar pour faire l'entête de colonne visible
    var ControlWidth=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualWidth();
    var ControlHeight=Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().get_ActualHeight();
    Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Click(ControlWidth-180, ControlHeight-40);  
    
}

function ResetData(client,modelName){         
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);
    if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client,10).Exists){
      Log.Error("Le client est toujours associé au modèle")
    }
    else{
      Log.Checkpoint("Le client n'est plus associé au modèle")
    }
}