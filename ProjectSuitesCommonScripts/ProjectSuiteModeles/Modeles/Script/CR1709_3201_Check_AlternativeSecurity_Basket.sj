//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3201

Analyste d'assurance qualité: Manel 
Analyste d'automatisation: Youlia Raisper
La version de scriptage: ref90-04-BNC-59B-11--V9-1_8-co6x  */


function CR1709_3201_Check_AlternativeSecurity_Basket()
{
    try{  
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
        Execute_SQLQuery("update B_MODEL_TYPE set  ALLOW_REPLACEMENT = 'Y', ALLOW_ALTERNATIVE='Y'", vServerModeles)
                                  
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var securityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var targetNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNBC100_3201", language+client);      
        var modelPanierObligation=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPanierObligatio", language+client);
        var targetPanierObligation=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetPanierObligatio_3201", language+client);
        var securityBNS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBNS", language+client);
        var newModel=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3201", language+client); 
        var codeCP=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "CPBD88", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var securityBankOfNovaScotia=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBankOfNovaScotia", language+client); 
        var panier=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PanierObligCorpor", language+client); 
        var account800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800285RE", language+client); 
        var positionSNC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSNC", language+client); 
        var buy=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Buy", language+client); 
        var quantityNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "QuantityNBC100", language+client); 
        var marketValueNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueNBC100", language+client);
        var message=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3201", language+client);        
        var displayQuantityNBS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_NBS", language+client);
        var modelTargetPercentNBS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_NBS", language+client);  
        var Basket844000=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Basket844000", language+client);
        var displayQuantityBasket=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_Basket", language+client);
        var modelTargetPercentBasket=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_Basket", language+client);
        var displayQuantitySNC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_SNC", language+client);
        var modelTargetPercentSNC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_SNC", language+client);
        var positionCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCVE", language+client); 
        var displayQuantityCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_CVE", language+client);
        var modelTargetPercentCVE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_CVE", language+client); 
        var modelTargetPercentNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_NBC100", language+client); 
        var positionECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityECA", language+client); 
        var displayQuantityECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity_ECA", language+client);
        var modelTargetPercentECA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelTargetPercent_ECA", language+client); 
                                
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        Create_Model(newModel,"",codeCP)
      
        SearchModelByName(newModel);
        Get_ModelsGrid().Find("Value",newModel,10).Click();
        Drag(Get_ModelsGrid().Find("Value",newModel,10), Get_ModulesBar_BtnPortfolio()); 
        
        //Ajouter une position NBC100
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        AddPosition(securityNBC100,targetNBC100,typePicker,"") 
       
        //Ajouter un sous-modele  
        Get_Toolbar_BtnAdd().Click();               
        Get_WinAddPositionSubmodel_TxtSubmodel().Click();
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys(modelPanierObligation);
        Get_WinAddPositionSubmodel_TxtSubmodel().Keys("[Enter]")
        if(Get_SubMenus().Exists){
          Get_SubMenus().Find("Value",modelPanierObligation,10).DblClick();
        } 
        Get_WinAddPositionSubmodel_TxtValuePercent().Keys(targetPanierObligation);

        Get_WinAddPositionSubmodel_GrpSubstitutionSecurities_BtnEdit().Click();
        Get_WinSubstitutionSecurities_BtnAdd().Click();
        Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityBankOfNovaScotia);
        Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");

        aqObject.CheckProperty(Get_WinReplacement_GrpSubstitutionType_RdoFallbackSecurity(), "IsChecked", cmpEqual,true);
        
        Get_WinReplacement_BtnOK().Click();
        Get_WinSubstitutionSecurities_BtnOK().Click();
        Get_WinAddPositionSubmodel_BtnOK().Click();
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
               
        CheckPresenceofPosition(securityNBC100); 
        CheckPresenceofPosition(panier);
        
        /*
        Mailler compte 800285-RE dans portef ==> séléctionner position SNC ==> double clickez => cocher position bloqué % détenu = 2.806
        assigné le compte 800285-RE au modele créé dans 1
        la Composition du  portefeuille 800285-RE dans la version de scriptage: ref90-04-BNC-59B-11--V9-1_8-co6x est :
        cash	-1,912% 
        PANIER OBLIG	8,686% 
        SNC (bloqué)	2,806%
        CVENon rachetable	1,005
        ECV Non rachetable	1,375
        Assigné compte au modele créé
        */
        Get_ModulesBar_BtnAccounts().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        Search_Account(account800285RE);
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800285RE,10), Get_ModulesBar_BtnPortfolio());
        Search_Position(positionSNC)
        Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionSNC),10).ClickR();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
        Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_LockPosition().Click();
        
        //Valider que les positions sont bloquées   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSNC,10).DataContext.DataItem, "IsBlocked", cmpEqual,true); //Avant IsLegacy 
        
        //Assoccié compte 800285-RE 
        Get_ModulesBar_BtnModels().Click();
        AssociateAccountWithModel(newModel,account800285RE);
        
        //Rééquilibrer le modele créé jusqu'a étape 4 et valider les ordres Achat/ventes dans onglet ordres proposés
        Get_Toolbar_BtnRebalance().Click();
        
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnRebalance().Click();
          numberOftries++;
        }                                                 
        Get_WinRebalance().Parent.Maximize();  
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click(); 
        Get_WinRebalance_BtnNext().Click();  
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",buy,10).DataContext.DataItem , "SecuritySymbol", cmpEqual, securityNBC100); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",buy,10).DataContext.DataItem , "DisplayQuantityStr", cmpEqual, quantityNBC100); 
        aqObject.CheckProperty(Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Find("Value",buy,10).DataContext.DataItem , "MarketValue", cmpEqual, marketValueNBC100); 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProposedOrders_GrpRebalancingMessages_LblConflictsMsg() ,"Text",cmpEqual,message) 

        
        /*A l'étape  4  toujours onglet portefeuille projeté valider les quntité et % détenu des positions 
        Panier + titre de rechange BNS
        le Bns, est utulisé pour atteindre la cible du panier*/
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        
        Search(securityBNS);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBNS,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantityNBS); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityBNS,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentNBS, 0, 4),true,3)        

        Search(Basket844000);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantityBasket); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("DisplayText",Basket844000,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentBasket, 0, 4),true,3)
        
        Search(positionSNC);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSNC,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantitySNC); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSNC,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentSNC, 0, 4),true,3)
        
        Search(positionCVE);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantityCVE); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionCVE,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentCVE, 0, 4),true,3)
        
        Search(securityNBC100);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantityNBC100); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityNBC100,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentNBC100, 0, 4),true,3)
        
        Search(positionECA);               
        aqObject.CheckProperty(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem, "DisplayQuantityStr", cmpEqual, displayQuantityECA); 
        aqObject.CompareProperty(aqString.SubString(Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionECA,10).DataContext.DataItem.ModelTargetPercent,0,4),cmpEqual,aqString.SubString(modelTargetPercentECA, 0, 4),true,3)
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        
        //***************************RestoreData**********************************
        //RestoreData(newModel,account800285RE,positionSNC)
                  
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
          Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
          Login(vServerModeles, user, psw, language);         
          Get_ModulesBar_BtnModels().Click();
          Get_MainWindow().Maximize(); 
        
          RestoreData(newModel,account800285RE,positionSNC)
          Terminate_CroesusProcess(); //Fermer Croesus 
          Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
          Runner.Stop(true);      
    }
}

function Search(security){
    Get_WinRebalance_PositionsGrid().WPFObject("RecordListControl", "", 1).Keys("F");
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(security);
    Get_WinQuickSearch_RdoSymbol().Set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click();
}


function RestoreData(newModel,account800285RE,positionSNC){
  //Remove account from the model
  SearchModelByName(newModel);
  Get_ModelsGrid().Find("Value",newModel,10).Click();
  Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account800285RE,10).Click();
  Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
  /*var width = Get_DlgCroesus().Get_Width();
  Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
  var width = Get_DlgConfirmation().Get_Width();
  Get_DlgConfirmation().Click((width*(1/3)),73);
        
  aqObject.CheckProperty(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Items , "Count", cmpEqual, 0); 
  //Supprimer le model
  DeleteModelByName(newModel);
  
  //Debloquer une position
  Get_ModulesBar_BtnAccounts().Click();
  Search_Account(account800285RE);
  Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",account800285RE,10), Get_ModulesBar_BtnPortfolio());
  Search_Position(positionSNC)
  Get_Portfolio_AssetClassesGrid().Find("Value",VarToString(positionSNC),10).ClickR();
  Get_PortfolioGrid_ContextualMenu_ManageLockedPositions().Click();
  Get_PortfolioGrid_ContextualMenu_ManageLockedPositions_UnlockPosition().Click();
        
  //Valider que les positions sont bloquées   
  aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",positionSNC,10).DataContext.DataItem, "IsBlocked", cmpEqual,false); // Avant IsLegacy
  
}