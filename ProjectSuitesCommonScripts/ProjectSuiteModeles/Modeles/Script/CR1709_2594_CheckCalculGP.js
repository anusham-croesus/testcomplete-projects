//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2594
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2594_CheckCalculGP()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)
        RestartServices(vServerModeles);            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800251GT", language+client);                      
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_Global", language+client); 
        var AAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAAPL", language+client); 
        var realizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLNonRegt_2523", language+client); 
        var unrealizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLNonRegt_2523", language+client); 
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                      
        //assigné le compte 800251-GT au modèle
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
        Get_WinQuickSearch_TxtSearch().Keys(AAPL);
        Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);      
        Get_WinQuickSearch_BtnOK().Click()
        
        /* -Cliquez sur Modifier*/ 
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();
        Get_WinModifyPosition_GrpPositionInformation_TxtQtyVariation().Keys("0");
        Get_WinModifyPosition_BtnOK().Click();
        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_BtnReassess().Click();
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        
         for(i=1;i<19;i++){       
          var position=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position2594_"+i, language+client)
          
          if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).DataContext.DataItem.RealizedGainsLossesPercentage==null){             
            Log.Message(position)             
            CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(position,null,null)                     
          }else{
            var realizedGainsLosses=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLosses_"+i, language+client)
            var realizedGainsLossesPercentage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentage_"+i, language+client)
            Log.Message(position)          
            CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(position,realizedGainsLosses,realizedGainsLossesPercentage)
          }                   
        }
               
        
        //Valider les G/P  dans etape 4  onglet portefeuille projeté.
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        for(i=1;i<21;i++){
        
          var position=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPosition_"+i, language+client)

          Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
          WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
          Get_WinQuickSearch_TxtSearch().Clear();
          Get_WinQuickSearch_TxtSearch().Keys(position);
          Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);      
          Get_WinQuickSearch_BtnOK().Click()
          Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).Click(); 

          if(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder==null){     
            var gainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedGainLossUnrealizedFromOpenOrder_"+i, language+client)
            var percentGainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPercentGainLossUnrealizedFromOpenOrder_"+i, language+client)             
            Log.Message(position) 
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, null);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, null); 
            var AppGainLossUnrealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder,2)
            Log.Message("Jira: BNC-1767")
            aqObject.CompareProperty(AppGainLossUnrealizedFromOpenOrder,cmpEqual,gainLossUnrealizedFromOpenOrder,true,3) 
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, gainLossUnrealizedFromOpenOrder);  
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, percentGainLossUnrealizedFromOpenOrder); 
            var AppPercentGainLossUnrealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppPercentGainLossUnrealizedFromOpenOrder,cmpEqual,percentGainLossUnrealizedFromOpenOrder,true,3)            
          }else if(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder== null){
            Log.Message(position)  
            Log.Message("Jira: BNC-1767")
            var gainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedGainLossRealizedFromOpenOrder_"+i, language+client)
            var percentGainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPercentGainLossRealizedFromOpenOrder_"+i, language+client)
            var AppGainLossRealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppGainLossRealizedFromOpenOrder,cmpEqual,gainLossRealizedFromOpenOrder,true,3)        
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, gainLossRealizedFromOpenOrder);  
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, percentGainLossRealizedFromOpenOrder);  
            var AppPercentGainLossRealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppPercentGainLossRealizedFromOpenOrder,cmpEqual,percentGainLossRealizedFromOpenOrder,true,3)
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, null);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, null);
          }
          else{
            Log.Message(position) 
            var gainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedGainLossUnrealizedFromOpenOrder_"+i, language+client)
            var percentGainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPercentGainLossUnrealizedFromOpenOrder_"+i, language+client) 
            var gainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedGainLossRealizedFromOpenOrder_"+i, language+client)
            var percentGainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPercentGainLossRealizedFromOpenOrder_"+i, language+client)        
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, gainLossRealizedFromOpenOrder);  
            var AppGainLossRealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppGainLossRealizedFromOpenOrder,cmpEqual,gainLossRealizedFromOpenOrder,true,3)
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, percentGainLossRealizedFromOpenOrder);  
            var AppPercentGainLossRealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppPercentGainLossRealizedFromOpenOrder,cmpEqual,percentGainLossRealizedFromOpenOrder,true,3)
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, gainLossUnrealizedFromOpenOrder);  
            var AppGainLossUnrealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppGainLossUnrealizedFromOpenOrder,cmpEqual,gainLossUnrealizedFromOpenOrder,true,3) 
            //aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, percentGainLossUnrealizedFromOpenOrder);
            var AppPercentGainLossUnrealizedFromOpenOrder=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder,2)
            aqObject.CompareProperty(AppPercentGainLossUnrealizedFromOpenOrder,cmpEqual,percentGainLossUnrealizedFromOpenOrder,true,3)
          }
                   
        }
               
        //Valider dans la section sommaire :
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonRegt);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonRegt);//avant contetnt 
        
         /*Passer a Etape 5 */ 
        Get_WinRebalance_BtnNext().Click();
        for(i=2;i<21;i++){
          if(i==8){
            i++
          }
          var position=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPosition_"+i, language+client)
          if(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem.RealizedGainsLosses==null){                 
            Log.Message(position) 
            aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, null);        
            aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem, "RealizedGainsLossesPercentage", cmpEqual, null); 
                        
          }else{
            Log.Message(position) 
            var gainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedGainLossRealizedFromOpenOrder_"+i, language+client)
            var percentGainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ProjectedPercentGainLossRealizedFromOpenOrder_"+i, language+client)   
            var detected = roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem.RealizedGainsLosses,2)
            CheckEquals(detected,gainLossRealizedFromOpenOrder,position+" RealizedGainsLosses");
            //aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem , "RealizedGainsLosses", cmpEqual, gainLossRealizedFromOpenOrder);        
            //aqObject.CheckProperty(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem, "RealizedGainsLossesPercentage", cmpEqual, percentGainLossRealizedFromOpenOrder); 
            var detected = roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.DataItem.RealizedGainsLossesPercentage,2)
            CheckEquals(detected,percentGainLossRealizedFromOpenOrder,position+" RealizedGainsLossesPercentage");
          }                   
        }
                                              
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

function CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(position,realizedGainsLosses,realizedGainsLossesPercentage){
  Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).Click();
  if(realizedGainsLossesPercentage == null)
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).DataContext.DataItem, "RealizedGainsLossesPercentage", cmpEqual,realizedGainsLossesPercentage) 
  else{
    var detected = roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).DataContext.DataItem.RealizedGainsLossesPercentage,2);
    CheckEquals(detected,realizedGainsLossesPercentage,position+" realizedGainsLossesPercentage");
  }
  
  if(realizedGainsLosses == null)
    aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).DataContext.DataItem, "RealizedGainsLosses", cmpEqual,realizedGainsLosses)
  else{
    var detected = roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_DgvProposedOrders().Find("Value",position,10).DataContext.DataItem.RealizedGainsLosses,2);
    CheckEquals(detected,realizedGainsLosses,position+" realizedGainsLosses")
  }
}

