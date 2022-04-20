//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3814_CheckRebalancing_withBlockedComplement

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3104
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3104_OnlyReplacement_SecurityHeld_inPortfolio()
 {             
    try{  
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)
            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3104", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);         
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client); 
        var IVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityIVZ", language+client);
        var percentageNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "percentageNA", language+client);  
        var percentageIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "percentageIVZ", language+client); 
        var DescriptionXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXCB", language+client);
        var Replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Replacement", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var Account800058NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800058NA", language+client);
        var PositionSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var displayQuantitySolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantitySolde_3104", language+client);
        var TotalValuePercentageMarketSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketSolde_3104", language+client);
        var MarketValueSolde_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueSolde_3104", language+client);
        var DisplayQuantityXCB_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityXCB_3104", language+client);
        var TotalValuePercentageMarketXBC_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketXBC_3104", language+client);
        var MarketValueXCB_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueXCB_3104", language+client);
        var DisplayQuantityIVZ_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityIVZ_3104", language+client);
        var TotalValuePercentageMarketIVZ_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketIVZ_3104", language+client);
        var MarketValueIVZ_3104=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueIVZ_3104", language+client);
        
        Login(vServerModeles, user, psw, language);            
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,modelType)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //NA à 12%
        AddPositionToModel(NA,percentageNA,typePicker,"")
        
        //IVZ à 7% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(IVZ,percentageIVZ,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NA); 
        CheckPresenceofPosition(IVZ); 
        
        //Ajouter Replacement XCB
        AddReplacement(NA,DescriptionXCB,XCB,Replacement)
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        //assigné le compte 800058-NA au modèle
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelName);    
        AssociateAccountWithModel(modelName,Account800058NA);
        
        //rééquilibrer jusqu e etape 4
        Get_Toolbar_BtnRebalance().Click(); 
        //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){
            Get_Toolbar_BtnRebalance().Click(); 
            numberOftries++;
        }
        Get_WinRebalance().Parent.Maximize();       
        Get_WinRebalance_BtnNext().Click();     
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd",15000); 
        
        SearchPosition(PositionSolde);            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10).Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,displayQuantitySolde);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketSolde);
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketSolde)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketSolde)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketSolde)
       //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueSolde_3104);     
         var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueSolde_3104)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueSolde_3104)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueSolde_3104)
               
        SearchPosition(XCB);
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10).Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityXCB_3104);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketXBC_3104);
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketXBC_3104)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketXBC_3104)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketXBC_3104)
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueXCB_3104);
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueXCB_3104)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueXCB_3104)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueXCB_3104)
                
        SearchPosition(IVZ);
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10).Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityIVZ_3104);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketIVZ_3104);
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketIVZ_3104)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketIVZ_3104)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketIVZ_3104)
        
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueIVZ_3104);
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueIVZ_3104)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueIVZ_3104)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueIVZ_3104)
               
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //RestoreData(modelName,Account800058NA)
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {  
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        RestoreData(modelName,Account800058NA)
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }
 

 function AddReplacement(position,securityDescription,securitySymbol,Replacement){
 
     Get_Portfolio_PositionsGrid().Find("Value",position,10).Click();
     Get_PortfolioBar_BtnInfo().Click();
     Get_WinPositionInfo_GrpSubstitutionSecurities_BtnEdit().Click();
     Get_WinSubstitutionSecurities_BtnAdd().Click();
     Get_WinReplacement().Parent.Position(400, 100, Get_WinReplacement().Width, Get_WinReplacement().Height);//Christophe: Stabilisation
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys(securityDescription);
     Get_WinReplacement_GrpSubstitutionSecurity_TxtSecurity().Keys("[Tab]");
     Get_WinReplacement_GrpSubstitutionType_RdoReplacementSecurity().set_IsChecked(true);       
     Get_WinReplacement_BtnOK().Click();
     aqObject.CheckProperty(Get_WinSubstitutionSecurities_DgvSubstitutions().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, Replacement)
     Get_WinSubstitutionSecurities_BtnOK().Click();     
     aqObject.CheckProperty(Get_WinPositionInfo_GrpSubstitutionSecurities_DgSubstitutionSecurities().Find("Value",securitySymbol,10).DataContext.DataItem,"SubstituteType",cmpEqual, Replacement)
     Get_WinPositionInfo_BtnOK().Click(); 
 }
 
 function RestoreData(modelName,Account800058NA){
 
     Get_ModulesBar_BtnModels().Click();        
     SearchModelByName(modelName);
        
     Get_ModelsGrid().Find("Value",modelName,10).Click();
     if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",Account800058NA,10).Exists){
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",Account800058NA,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
     }
     //Supprimer le model 
     DeleteModelByName(modelName);
 }