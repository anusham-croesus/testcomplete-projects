//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-2307
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2307_Check_GPColumn_ExistingPosition()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles) 
        RestartServices(vServerModeles);           
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                  
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800204JW", language+client);                    
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_2307", language+client); 
        var percentGPTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentGPTHI", language+client); 
        var THI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionTHI", language+client); 
        var GPTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "GPTHI", language+client);
        var ndText=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "NDText", language+client);   
        var summaryGPTHI=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SummaryGPTHI", language+client);
                   
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnAccounts().Click();
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        //chainer vers le module Portefeuille,
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Créer un Modèle
        Get_PortfolioBar_BtnWhatIf().Click();    
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");      
        Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["VirtualizingDataRecordCellPanel", "1"], 10).WaitProperty("VisibleOnScreen", true, 30000);    
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_GrpAccountInformation_RdoNewModel().Click();
        Get_WinWhatIfSave_GrpAccountInformation_TxtShortName().set_Text(modelName);
        Get_WinWhatIfSave_BtnOK().Click();
    
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/2)),73); */ //EM : Modifié depuis CO: 90-07-22-Be-1
         if(Get_DlgInformation().Exists) {    
                Get_DlgInformation().Close();
        }
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelName);
        ActivateDeactivateModel(modelName,true);
               
        //assigné le compte 800204-JW au modèle
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
        
        SetAutoTimeOut();
         if(Get_WinWarningDeleteGeneratedOrders().Exists) {
           Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
        } 
        RestoreAutoTimeOut();        
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42"); 
        
        /*Valider que dans etape 4 du rééquilibrage onglet portefeuille projeté :position THI , gain et perte non nréalisé ($)=(80,00) , gain et perte non réalisé (%)=(1.30) (identique au portefeuille)*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        ScrollPositionsGrid(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent());
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent() , "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL() , "VisibleOnScreen", cmpEqual, true);
        
        var croesuspercentGPTHI=aqString.SubString(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem.PercentGainLossUnrealizedFromOpenOrder,0,4)
        var croesusGPTHI=Math.floor(Get_WinRebalance_PositionsGrid().Find("Value",THI,10 ).DataContext.DataItem.GainLossUnrealizedFromOpenOrder)
        Log.Message(croesusGPTHI)
        Log.Message(croesuspercentGPTHI)
        if(croesuspercentGPTHI==(-percentGPTHI)){
          Log.Checkpoint("La valeur est bonne")
        }
        else{
          Log.Error("La valeur n'est pas bonne")
        }
               
        if(croesusGPTHI==(-GPTHI)){
          Log.Checkpoint("La valeur est bonne")
        }
        else{
          Log.Error("La valeur n'est pas bonne")
        }
        
        /*Valider que dans etape 4 du rééquilibrage onglet portefeuille projeté section sommaire :g/perte non réalisé =(80,00) , g/perte réalisé =n/d*/
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLReg() , "Text", cmpEqual, ndText); //Avant Content
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_TxtUnrealizedGLNonReg() , "Text", cmpEqual, summaryGPTHI); //Avant Content
                
                          
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

