//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2366_Check_GP_Recalculation

/*CR1709_3118_Pref_Addition
CR1709_2251_Check_Adding_Columns*/


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2511
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2511_Check_GP_Recalculation_QuantityModification()
{
    try{       
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)     
        RestartServices(vServerModeles);       
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);                            
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);
        var positionFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionFID294", language+client);
        var quantityFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityFID294", language+client);  
        var gainLossFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GainLossFID294", language+client);
        var summaryGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummaryGPFID294", language+client);
        var summaryUGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummaryUGPFID294", language+client);
        var newGainLossFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GLFID294_2511", language+client);
        var newGainLossUnrealizedFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GLUnrealizedFID294_2511", language+client);      
        var newSummaryGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewSummaryGPFID294_2511", language+client);
        var newSummaryUGPFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NewSummaryUGPFID294_2511", language+client);
                                    
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
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
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, summaryUGPFID294);//avant content
        Log.Message("Jira: BNC-1767")
        
        /*Séléctionner la position FID294 et modifier la quatité projté =2000 */
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionFID294,10).Click();
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnEdit().Click();        
        Get_WinModifyPosition_GrpPositionInformation_TxtProjectedQuantity().Keys(quantityFID294);       
        Get_WinModifyPosition_BtnOK().Click();
        
        //valider les g/p  réalisé=720.20 g/p
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionFID294,10).Click();
        var croesusGainLossFID294 =aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",positionFID294,10 ).DataContext.DataItem.GainLossRealizedFromOpenOrder,0,6)
        if(croesusGainLossFID294==newGainLossFID294){
          Log.Checkpoint("La valeur est bonne" + croesusGainLossFID294+" = " +newGainLossFID294)
        }
        else{
          Log.Error("La valeur n'est pas bonne"  + croesusGainLossFID294+" est diffèrent de" +newGainLossFID294)
        } 
        
        //NON réalisé=1532.16*/
        Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionFID294,10).Click();
        var croesusGainLossUnrealizedFID294 =aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",positionFID294,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder,0,7)
        if(croesusGainLossUnrealizedFID294==newGainLossUnrealizedFID294){
          Log.Checkpoint("La valeur est bonne" + croesusGainLossUnrealizedFID294+" = " +newGainLossUnrealizedFID294)
        }
        else{
          Log.Error("La valeur n'est pas bonne"  + croesusGainLossUnrealizedFID294+" est diffèrent de" +newGainLossUnrealizedFID294)
        } 
        
        //Valider que les G/P dans sommaire sont calculé en prenant en considération les nouvelle quantité
        //g/p réalisé=6042.45+720.20=6762.65 et g/p non réalisé =437.72+1532.16 =1969.88      
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(), "Text", cmpEqual, newSummaryGPFID294);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, newSummaryUGPFID294);//avant content    
                               
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
      Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
      Login(vServerModeles, user, psw, language);
      Get_ModulesBar_BtnModels().Click()
      Get_MainWindow().Maximize();
      ResetData(modelName,account);
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "NO", vServerModeles)
      RestartServices(vServerModeles);
	    Runner.Stop(true);
    }
}

