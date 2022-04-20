﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3104_OnlyReplacement_SecurityHeld_inPortfolio

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3103
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3103_ReplacementAndPrincipal_held_inPortfolio()
 {             
    try{  
    
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)                    
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                       
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3103", language+client);        
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);         
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client);
        var IVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityIVZ", language+client);
        var percentageXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentXCB_3103", language+client);
        var percentageIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentIVZ_3103", language+client);
        var OBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OBA", language+client);
        var SecurityDescriptionOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionOBA", language+client);        
        var Account800058NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800058NA", language+client);        
        var DescriptionNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNBC100", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
        var Replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Replacement", language+client);       
        
        var TotalValuePercentageMarketIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketIVZ_3101", language+client);       
        var DisplayQuantityIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityIVZ_3101", language+client);        
        var MarketValueIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueIVZ_3101", language+client);
        var TotalValuePercentageMarketXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketXCB_3101", language+client);
        var DisplayQuantityXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityXCB_3101", language+client);
        var MarketValueXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueXCB_3101", language+client);
        var TotalValuePercentageMarketOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketOBA_3101", language+client);
        var DisplayQuantityOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityOBA_3101", language+client);
        var MarketValueOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueOBA_3101", language+client);
        var TotalValuePercentageMarketSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketSolde_3101", language+client);
        var DisplayQuantitySolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantitySolde_3101", language+client);
        var MarketValueSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueSoldeSolde_3101", language+client);        
        var PositionSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        Create_Model(modelName,modelType)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //IVZ à 7%
        AddPosition(IVZ,percentageIVZ,typePicker,"")
        
        //XCB à 15% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(XCB,percentageXCB,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(IVZ); 
        CheckPresenceofPosition(XCB); 
        
        //Ajouter Replacement OBA
        AddReplacement(XCB,SecurityDescriptionOBA,OBA,Replacement)
                
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
        
        SearchPosition(PositionSolde)
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10).Click();        
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketSolde)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketSolde)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketSolde)
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketSolde); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal() 
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantitySolde);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueSolde); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueSolde)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueSolde)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueSolde)
        
        SearchPosition(XCB);            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10).Click();   
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketXCB); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketXCB)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketXCB)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketXCB)
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityXCB);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueXCB); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueXCB)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueXCB)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueXCB)
        
        SearchPosition(IVZ);            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10).Click();   
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketIVZ); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
         var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketIVZ)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketIVZ)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketIVZ)
        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityIVZ);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueIVZ); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueIVZ)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueIVZ)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueIVZ)
        
        SearchPosition(OBA);           
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10).Click();   
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketOBA); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
         var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10 ).DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
        if(detected==TotalValuePercentageMarketOBA)
            Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+TotalValuePercentageMarketOBA)
        else
            Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+TotalValuePercentageMarketOBA)
        
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityOBA);
        //aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueOBA); //EM: CO-90-07-22: modifié pour comparer les valeurs avec la foncr=tion RounDecimal()
        var detected=roundDecimal(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",OBA,10 ).DataContext.DataItem.MarketValue.OleValue,2)
        if(detected==MarketValueOBA)
            Log.Checkpoint("MarketValue detected = "+detected+" est égale a MarketValue expected = "+MarketValueOBA)
        else
            Log.Error("MarketValue detected = "+detected+" n'est pas égale a MarketValue expected) = "+MarketValueOBA)
        
            
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
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        RestoreData(modelName,Account800058NA)
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
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