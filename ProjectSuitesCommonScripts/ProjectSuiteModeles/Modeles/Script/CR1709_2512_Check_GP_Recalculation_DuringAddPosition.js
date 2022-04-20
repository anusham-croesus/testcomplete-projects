//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_2366_Check_GP_Recalculation

/*CR1709_3118_Pref_Addition
CR1709_2251_Check_Adding_Columns*/


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2512
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2512_Check_GP_Recalculation_DuringAddPosition()
{
    try{       
        Activate_Inactivate_Pref("REAGAR", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)   
        RestartServices(vServerModeles);       
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);                            
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelChRevenusFixes", language+client);   
        var positionFID294=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionFID294", language+client);
        var securityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        var quantityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantutyBMO", language+client);
        
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
        ActivateDeactivateModel(modelName,true); 
                                                                 
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
                
        //****************Sommaire g/p réalisé = 8294.41 et non réalisé=437.72 ****************************  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(), "Text", cmpEqual, summaryGPFID294);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, summaryUGPFID294);//avant content
        Log.Message("Jira: BNC-1767")
        
        //Ajouter une position BMO
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnAdd().Click();      
        Get_WinAddPosition_GrpAdd_CmbTypePicker().Click();
        Get_SubMenus().Find("Text",typePicker,10).Click();
        Get_WinAddPosition_GrpAdd_TxtQuickSearchKey().Keys(securityBMO);
        Get_WinAddPosition_GrpAdd_DlSecurityListPicker().Click();
        Get_SubMenus().Find("Value",securityBMO,10).DblClick();       
        Get_WinAddPosition_GrpPositionInformation_TxtQuantity().Keys(quantityBMO);
        Get_WinAddPosition_BtnOK().Click();
        
        if(Get_WinRebalance_PositionsGrid().Find("Value",securityBMO,10 ).Exists){
          Log.Checkpoint("La position a été ajoutée")
        }else{
          Log.Error("La position n'a pas été ajoutée")
        }
                
        //Valider que les G/P dans sommaire : aucun changement
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtRealizedGLNonReg(), "Text", cmpEqual, summaryGPFID294);//avant content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg(), "Text", cmpEqual, summaryUGPFID294);//avant contetn
                               
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


function test()
{
var securityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
     if(Get_WinRebalance_PositionsGrid().Find("Value",securityBMO,10 ).Exists){
          Log.Checkpoint("La position a été ajoutée")
     }else{
          Log.Error("La position n'a pas été ajoutée")
     }
}
