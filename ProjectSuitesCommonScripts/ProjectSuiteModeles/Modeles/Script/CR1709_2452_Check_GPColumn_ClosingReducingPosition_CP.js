//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns
//USEUNIT Creation_Test_CP

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2452
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2452_Check_GPColumn_ClosingReducingPosition_CP()
{
    try{       
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)   
        RestartServices(vServerModeles);         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestCalcul", language+client);                        
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800286RE", language+client); 
        var V61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityV61632", language+client);
        var targetV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetV61632_2452", language+client);
        
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client); 
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var CUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCUR", language+client);
        var V61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityV61632", language+client);
        var AER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAER", language+client);                   
        var XSP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXSP", language+client); 
        var XIN=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXIN", language+client); 
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client);
        
        var realizedGainsLossesNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesNBC100_2451", language+client);
        var realizedGainsLossesPercentageNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageNBC100_2451", language+client);
        var gainLossUnrealizedFromOpenOrderNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderNBC100_2451", language+client);
        var percentGainLossUnrealizedFromOpenOrderNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderNBC100_2451", language+client);
        
        var realizedGainsLossesV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesV61632_2451", language+client);
        var realizedGainsLossesPercentageV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageV61632_2451", language+client);
        var gainLossUnrealizedFromOpenOrderV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderV61632_2451", language+client);
        var percentGainLossUnrealizedFromOpenOrderV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderV61632_2451", language+client);
        
        var realizedGainsLossesXIN=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesXIN_2451", language+client);
        var realizedGainsLossesPercentageXIN=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageXIN_2451", language+client);
        var realizedGainsLossesXSP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesXSP_2451", language+client);
        var realizedGainsLossesPercentageXSP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGainsLossesPercentageXSP_2451", language+client);
         
        var gainLossUnrealizedFromOpenOrderBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderBMO_2451", language+client);
        var percentGainLossUnrealizedFromOpenOrderBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderBMO_2451", language+client);
        var gainLossUnrealizedFromOpenOrderCUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderCUR_2451", language+client);
        var percentGainLossUnrealizedFromOpenOrderCUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderCUR_2451", language+client);
        var gainLossUnrealizedFromOpenOrderAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossUnrealizedFromOpenOrderAER_2451", language+client);
        var percentGainLossUnrealizedFromOpenOrderAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGainLossUnrealizedFromOpenOrderAER_2451", language+client);
        
        var realizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLNonRegt_2452", language+client);
        var unrealizedGLNonRegt=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLNonRegt_2452", language+client);
        var targetV61632Before=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetV61632", language+client);
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                
        //Sélectionner le modèle 
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());  
        //Modifier % Cible V61632 = 3% et lui assigné compte 800286-RE
        ChangeTarget(V61632,targetV61632); 
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
               
        //assigné le compte 800286-RE au modèle
        Get_ModulesBar_BtnModels().Click();
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
        
        //Positions BMO :
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(BMO,account,0,0)        
        //Position CUR:
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(CUR,account,0,0)       
        //Position AER:
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(AER,account,0,0)       
        //position NBC100
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(NBC100,account,realizedGainsLossesNBC100,realizedGainsLossesPercentageNBC100)
        //position XIN
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(XIN,account,realizedGainsLossesXIN,realizedGainsLossesPercentageXIN)    
        //position XSP
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(XSP,account,realizedGainsLossesXSP,realizedGainsLossesPercentageXSP)        
        //position V61632
        CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(V61632,account,realizedGainsLossesV61632,realizedGainsLossesPercentageV61632)
        
        //Valider les G/P  dans etape 4  onglet portefeuille projeté.
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        //NBC100
        Log.Message("NBC100")
        CheckValuesStep4WinRebalancePositionsGrid(NBC100,realizedGainsLossesNBC100,realizedGainsLossesPercentageNBC100,gainLossUnrealizedFromOpenOrderNBC100,percentGainLossUnrealizedFromOpenOrderNBC100)
        //V61632
        Log.Message("V61632")
        CheckValuesStep4WinRebalancePositionsGrid(V61632,realizedGainsLossesV61632,realizedGainsLossesPercentageV61632,gainLossUnrealizedFromOpenOrderV61632,percentGainLossUnrealizedFromOpenOrderV61632)
        //XIN
        Log.Message("XIN")
        CheckValuesStep4WinRebalancePositionsGrid(XIN,realizedGainsLossesXIN,realizedGainsLossesPercentageXIN,0,0)
        //XSP
        Log.Message("XSP")
        CheckValuesStep4WinRebalancePositionsGrid(XSP,realizedGainsLossesXSP,realizedGainsLossesPercentageXSP,0,0)
        //BMO
        Log.Message("BMO")
        CheckValuesStep4WinRebalancePositionsGrid(BMO,0,0,gainLossUnrealizedFromOpenOrderBMO,percentGainLossUnrealizedFromOpenOrderBMO)    
        //CUR
        Log.Message("CUR")
        CheckValuesStep4WinRebalancePositionsGrid(CUR,0,0,gainLossUnrealizedFromOpenOrderCUR,percentGainLossUnrealizedFromOpenOrderCUR)    
        //AER
        Log.Message("AER")
        CheckValuesStep4WinRebalancePositionsGrid(AER,0,0,gainLossUnrealizedFromOpenOrderAER,percentGainLossUnrealizedFromOpenOrderAER)
                                  
        //Valider dans la section sommaire :
        /*'G/P réalisés' non enreg= 33 922.93
         'G/P non réalisés'non enreg= 5 596.53*/        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg() , "Text", cmpEqual, realizedGLNonRegt); //avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, unrealizedGLNonRegt); //avant content
       
        /*Passer a Etape 5 */ 
        Get_WinRebalance_BtnNext().Click();         
        //Positions BMO :
        CheckValuesStep5(BMO, account,0,0)
        //Position CUR:
        CheckValuesStep5(CUR, account,0,0)
        //Position AER:
        CheckValuesStep5(AER, account,0,0)       
        //position NBC100
        CheckValuesStep5(NBC100, account,realizedGainsLossesNBC100,realizedGainsLossesPercentageNBC100)       
        //position XIN
        CheckValuesStep5(XIN, account,realizedGainsLossesXIN,realizedGainsLossesPercentageXIN)    
        //position XSP
        CheckValuesStep5(XSP, account,realizedGainsLossesXSP,realizedGainsLossesPercentageXSP)   
        //position V61632
        CheckValuesStep5(V61632, account,realizedGainsLossesV61632,realizedGainsLossesPercentageV61632)
                  
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //*************************************************Réinitialiser les données********************************************************* 
        
        //ResetData(account,modelName,V61632,targetV61632Before);     
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
      ResetData(account,modelName,V61632,targetV61632Before);
      Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles) 
      RestartServices(vServerModeles);
	    Runner.Stop(true);      
    }
}

function CheckValuesStep5(position, account,realizedGainsLosses,realizedGainsLossesPercentage){
  var index = Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",position,10).DataContext.Index
  Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true)        
  var detected=roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem.RealizedGainsLosses,2)
  CheckEquals(detected,realizedGainsLosses,position+" RealizedGainsLosses")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi
  var detected=roundDecimal(Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().Find("Value",account,10).DataContext.DataItem.RealizedGainsLossesPercentage,2)
  CheckEquals(detected,realizedGainsLossesPercentage,position+" RealizedGainsLossesPercentage")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi
  Get_WinRebalance_TabOrdersToExecute_DgvOrdersToExecute().WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
}

function CheckValuesStep4WinRebalancePositionsGrid(position,realizedGainsLosses,realizedGainsLossesPercentage,gainLossUnrealizedFromOpenOrder,percentGainLossUnrealizedFromOpenOrder){
  var detected=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,2)
  CheckEquals(detected,realizedGainsLosses,position+" RealizedGainsLosses")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi
  var detected=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossRealizedFromOpenOrder,2)
  CheckEquals(detected,realizedGainsLossesPercentage,position+" RealizedGainsLossesPercentage")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi 
  var detected=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder,2)
  CheckEquals(detected,gainLossUnrealizedFromOpenOrder,position+" GainLossUnrealizedFromOpenOrder")
  var detected=roundDecimal(Get_WinRebalance_PositionsGrid().Find("Value",position,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder,2)
  CheckEquals(detected,percentGainLossUnrealizedFromOpenOrder,position+" PercentGainLossUnrealizedFromOpenOrder")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi 

}

function CheckValuesStep4WinRebalanceTabProposedOrdersDgvProposedOrders(position,account,realizedGainsLosses,realizedGainsLossesPercentage){
  var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.Index
  Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true) 
  var detected=roundDecimal(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem.RealizedGainsLosses,2)
  CheckEquals(detected,realizedGainsLosses,position+" RealizedGainsLosses")  //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi
  var detected=roundDecimal(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",account,10).DataContext.DataItem.RealizedGainsLossesPercentage,2)
  CheckEquals(detected,realizedGainsLossesPercentage,position+" RealizedGainsLossesPercentage") //EM : 90.08.DY-8 : Modifié à cause des problèmes d'arrondi
  Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false)
}

function ResetData(account,modelName,V61632,targetV61632Before){
    SearchModelByName(modelName);
    Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
    Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
    /*var width = Get_DlgCroesus().Get_Width();
    Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);

    //Sélectionner le modèle 
    SearchModelByName(modelName);
    Get_ModelsGrid().Find("Value",modelName,10).Click();
    // chainer vers le module Portefeuille,
    Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());  
    //Modifier % Cible V61632 = 3% et lui assigné compte 800286-RE
    ChangeTarget(V61632,targetV61632Before);         
    Get_PortfolioBar_BtnSave().Click();
    Get_WinWhatIfSave_BtnOK().Click();
}
