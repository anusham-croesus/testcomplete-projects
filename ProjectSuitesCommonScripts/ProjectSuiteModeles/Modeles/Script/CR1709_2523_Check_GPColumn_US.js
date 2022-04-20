//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2523
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2523_Check_GPColumn_US()
{
    try{       
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)  
        RestartServices(vServerModeles);          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049OB", language+client);                      
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "modelUSEQUI", language+client); 
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client);        
        var realizedGLNonReg=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLNonReg", language+client);
        var unrealizedGLNonReg=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLNonReg", language+client);
        var YTDCumulatedGLNonReg=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "YTDCumulatedGLNonReg", language+client);
        var position940108=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position940108 ", language+client);
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                      
        //assigné le compte 800049-OB au modèle
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
        
        //Valider les G/P  dans etape 4  onglet portefeuille projeté.
        for(i=1;i<40;i++){
        
          var position=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position2523_"+i, language+client)
          var gainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossRealizedFromOpenOrder_"+i, language+client)
          var percentGainLossRealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossRealizedFromOpenOrder_"+i, language+client)
          var gainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrder", language+client)
          var percentGainLossUnrealizedFromOpenOrder=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrder", language+client)
      
          Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
          WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
          Get_WinQuickSearch_TxtSearch().Clear();
          Get_WinQuickSearch_TxtSearch().Keys(position);
          Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);      
          Get_WinQuickSearch_BtnOK().Click();
          
          if(position =="940108"){
              position =position940108
          }
                  
          if(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder==null){          
            Log.Message(position)            
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossRealizedFromOpenOrder", cmpEqual, null);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossRealizedFromOpenOrder", cmpEqual, null);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, gainLossUnrealizedFromOpenOrder);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, percentGainLossUnrealizedFromOpenOrder); 
                        
          }else{
            Log.Message(position)
            var AppGainLossRealizedFromOpenOrder=Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder          
            aqObject.CompareProperty(aqString.SubString(AppGainLossRealizedFromOpenOrder,0,5),cmpEqual,aqString.SubString(gainLossRealizedFromOpenOrder, 0, 5),true,3)  
            var AppPercentGainLossRealizedFromOpenOrder=Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder
            aqObject.CompareProperty(aqString.SubString(AppPercentGainLossRealizedFromOpenOrder,0,5),cmpEqual,aqString.SubString(percentGainLossRealizedFromOpenOrder, 0, 5),true,3) 
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "GainLossUnrealizedFromOpenOrder", cmpEqual, null);  
            aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem , "PercentGainLossUnrealizedFromOpenOrder", cmpEqual, null);
          }
                   
        }
               
        //Valider dans la section sommaire :
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonReg().Click();        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLReg() , "Text", cmpEqual, ndText);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg() , "Text", cmpEqual, ndText);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLRegCalculated() , "Text", cmpEqual, ndText);//avant content
        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonReg);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonReg);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonRegCalculated() , "Text", cmpEqual, YTDCumulatedGLNonReg); //avant content
        
                               
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
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
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

function Test(){
     //Valider dans la section sommaire :
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtYTDCumulatedGLNonReg().Click();        
        
}