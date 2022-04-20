//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3118_Pref_Addition
//USEUNIT CR1709_2251_Check_Adding_Columns


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3118
 
Analyste d'automatisation: Youlia Raisper */


function CR1709_2251_Check_Adding_Columns()
{
    try{       
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ENABLE_SYNC_GL_COLUMN", "YES", vServerModeles)   
        RestartServices(vServerModeles);         
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var account= ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800002NA", language+client);               
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_2251", language+client);                 
        var realizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGL", language+client);
        var realizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "RealizedGLPercent", language+client);
        var unrealizedGL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGL", language+client);
        var unrealizedGLPercent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "UnrealizedGLPercent", language+client);
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Buy", language+client);  
        var sell=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Sell", language+client);  
        var message="Message";
                           
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
        
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",buy,10).Click();
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",buy,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", message], 10).ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        ScrollTabProposedOrdersBlockOnDgvProposedOrders(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_ChrealizedGLPercent());
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", realizedGL], 10) , "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", realizedGLPercent], 10) , "VisibleOnScreen", cmpEqual, true); 
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false);            

        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",sell,10).Click();
        var index = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",sell,10).DataContext.Index
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(true);
        ScrollTabProposedOrdersBlockOnDgvProposedOrders(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_ChrealizedGLPercent());
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", realizedGL], 10) , "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", realizedGLPercent], 10) , "VisibleOnScreen", cmpEqual, true);
        Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", index+1).set_IsExpanded(false);
        
        //Dégrouper 
        Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChInclude().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();   
        ScrollTabProposedOrdersBlockOffDgvProposedOrders(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent());
        
        if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL().VisibleOnScreen){
          Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL().ClickR();
          Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        }
        if(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent().VisibleOnScreen){
          Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent().ClickR();
          Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        }
               
        //*********************************click droit sur la barre --> Ajouter une colonne        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if(FindColumnIn(realizedGL)){
          Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        if(FindColumnIn(realizedGLPercent)){
         Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
                
        //*********************************click droit sur la barre --> Remplacer par        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();
        if(FindColumnIn(realizedGL)){
          Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_ReplaceColumnWith().OpenMenu();
        if(FindColumnIn(realizedGLPercent)){
         Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
        //********************************click droit sur la barre --> Insérer un champ 
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_InsertField().OpenMenu();
        if(FindColumnIn(realizedGL)){
          Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_InsertField().OpenMenu();
        if(FindColumnIn(realizedGLPercent)){
         Log.Checkpoint("La colonne présente");
        } else{
          Log.Error("La colonne ne présente pas ");
        } 
        
        //valider que les colonnes triables: Gains et pertes réalisés ($) Gains et pertes réalisés (%)        
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChName().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        ScrollTabProposedOrdersBlockOffDgvProposedOrders(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent());
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL() , "SortStatus", cmpNotEqual, "NotSorted");
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGL().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent().Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent() , "SortStatus", cmpNotEqual, "NotSorted");
        Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChRealizedGLPercent().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
                
        /***********************************************Onglet portefeuille projeté****************************************************************************************/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();                
        ScrollPositionsGrid(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent());
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent() , "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL() , "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent() , "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL() , "VisibleOnScreen", cmpEqual, true);
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL().ClickR();
        Get_GridHeader_ContextualMenu_RemoveThisColumn().Click();
        
        //valider que les colonnes sont rajoutées par défaut :
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChQuantity().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        ScrollPositionsGrid(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent());
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGLPercent() , "VisibleOnScreen", cmpEqual, true); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChRealizedGL() , "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGLPercent() , "VisibleOnScreen", cmpEqual, true);  
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_ChUnrealizedGL() , "VisibleOnScreen", cmpEqual, true);
        
        /*3-sommaire du portefeuille dans Onglet portefeuille projeté*/
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbRealizedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbUnrealizedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio_GrpSummary_LlbYTDCumulatedGLNonReg() , "VisibleOnScreen", cmpEqual, true);
                          
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