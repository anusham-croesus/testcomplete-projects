//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2366
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2366_Check_GP_Recalculation()
{
    try{       
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)   
        RestartServices(vServerModeles);         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);                            
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
        var positionFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionFID294", language+client);
        var gainLossFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossFID294", language+client);
        var summaryGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummaryGPFID294", language+client);
        var summaryUGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummaryUGPFID294", language+client);
        var newSummaryGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewSummaryGPFID294", language+client);
        var newSummaryUGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewSummaryUGPFID294", language+client);
                                    
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                             
       /* SearchModelByName("SUBSTITUT_MOD2"); //a partir de AT        
        RemoveAccountFromModel("800245", "SUBSTITUT_MOD2")*/ //EM : a partir de Fm-11 
        
        //assigné le compte 800245-GT au modèle
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
                
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();        
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
        WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
        Get_WinQuickSearch_TxtSearch().Clear();
        Get_WinQuickSearch_TxtSearch().Keys(positionFID294);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
        Get_WinQuickSearch_BtnOK().Click();

        //*********************FID294 g/p réalisé = 2252.36 et non réalisé=n/d ****************************   
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionFID294,10).Click();
        var croesusGainLossFID294 =aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",positionFID294,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,0,7)
        if(croesusGainLossFID294==gainLossFID294){
          Log.Checkpoint("La valeur est bonne" + croesusGainLossFID294+" = " +gainLossFID294)
        }
        else{
          Log.Error("La valeur n'est pas bonne"  + croesusGainLossFID294+" est diffèrent de" +gainLossFID294)
        }          
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",positionFID294,10 ).DataContext.DataItem, "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, null); 
        
        //****************Sommaire g/p réalisé = 8294.41 et non réalisé=437.72 ****************************  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(), "Text", cmpEqual, summaryGPFID294); //avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, summaryUGPFID294); //avant content
        Log.Message("Jira: BNC-1767")
        //Aller dans ordres proposé dégrouper et décocher la positiom FID294
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        var index= Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",positionFID294,10).DataContext.DataItemIndex
        Log.Message("La position de "+ positionFID294+ "est"+ index);
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().WPFObject("DataRecordPresenter", "", index+1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("ContentControl", "", 1).WPFObject("XamCheckEditor", "", 1).Click();          
        
        //*******************g/p =6042.45 G/P non réalisé =2 690.08**************************************** 
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click(); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(), "Text", cmpEqual, newSummaryGPFID294);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, newSummaryUGPFID294); //avant content 
                        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
             
        //*************************************************Réinitialiser les données************************ 
        //ResetData(modelName,account);     
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
        ResetData(modelName,account);
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
        RestartServices(vServerModeles);
        Runner.Stop(true);
    }
}

function ResetData(modelName,account)
{    
   SearchModelByName(modelName);
   Get_ModelsGrid().Find("Value",modelName,10).Click();
   Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
   Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
   /*var width = Get_DlgCroesus().Get_Width();
   Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
   var width = Get_DlgConfirmation().Get_Width();
   Get_DlgConfirmation().Click((width*(1/3)),73);
}