//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3099
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3099_SpecifySameComplementSecurity_OnMultiplePositions()
 {             
    try{  
            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "REAGAR", "username");  
        var IBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionIBM", language+client);
        var MSFT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position2523_29", language+client);
        var RON=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionRON", language+client);
        var PJC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionPJC", language+client);
        var SymbolPJCA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SymbolPJCA", language+client);
        var NBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionNBC416", language+client);     
        var percentageIBM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageIBM", language+client);
        var percentageMSFT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageMSFT", language+client);
        var percentageRON=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageRON", language+client);
        var percentagePJC=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentagePJC", language+client);
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3099", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client); 
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);     
        var account=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800207JW", language+client);  
        var TotalValuePercentageMarketNBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketNBC416_3099", language+client); 
        var BookValueACBNBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "BookValueACBNBC416_3099", language+client); 
        var DisplayQuantityNBC416=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityNBC416_3099", language+client); 
        var PositionSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var TotalValuePercentageMarketSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketSolde_3099", language+client); 
        var BookValueACBSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "BookValueACBSolde_3099", language+client); 
        var DisplayQuantitySolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantitySolde_3099", language+client);
        
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        //Libérer le compte 
        SearchModelByName("+FB_MONTAN_SUBS");
        
        Get_ModelsGrid().Find("Value","+FB_MONTAN_SUBS",10).Click();
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
        }
    
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
        
        //Ajouter une position IBM  
        AddPosition(IBM,percentageIBM,typePicker,"")   
        
        //Ajouter une position MSFT
        Get_Toolbar_BtnAdd().Click();
        AddPosition(MSFT,percentageMSFT,typePicker,"")  
        
        //Ajouter une position RON
        Get_Toolbar_BtnAdd().Click();
        AddPosition(RON,percentageRON,typePicker,"") 
        
         //Ajouter une position PJC
        Get_Toolbar_BtnAdd().Click();
        AddPosition(PJC,percentagePJC,typePicker,"") 
                                   
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(IBM); 
        CheckPresenceofPosition(MSFT); 
        CheckPresenceofPosition(RON);
        CheckPresenceofPosition(SymbolPJCA);
        
        //Ajouter Complément NBC416
        AddComplement(typePicker,IBM,"",NBC416,complement);
        AddComplement(typePicker,MSFT,"",NBC416,complement);
        AddComplement(typePicker,RON,"",NBC416,complement);
        AddComplement(typePicker,SymbolPJCA,"",NBC416,complement);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelName);        
        //assigné le compte 800207-JW au modèle
        AssociateAccountWithModel(modelName,account);
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
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",NBC416,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",NBC416,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityNBC416);     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",NBC416,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketNBC416);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",NBC416,10 ).DataContext.DataItem, "BookValueACB", cmpEqual,BookValueACBNBC416);
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10).Click();
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantitySolde);     
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "TotalValuePercentageMarket", cmpEqual,TotalValuePercentageMarketSolde);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",PositionSolde,10 ).DataContext.DataItem, "BookValueACB", cmpEqual,BookValueACBSolde);
        
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        Terminate_CroesusProcess(); //Fermer Croesus
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally { 
        Log.Message("***************************CLEANUP*************************************");
        Login(vServerModeles, user , psw ,language);
        RestoreData(modelName,account,"+FB_MONTAN_SUBS");    
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }
 

 
 function RestoreData(modelName,account,updatedModelName){
 
     Get_ModulesBar_BtnModels().Click();        
     SearchModelByName(modelName);
     if(Get_ModelsGrid().Find("Value",modelName,10).Exists){  
         Get_ModelsGrid().Find("Value",modelName,10).Click();
         if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Exists){
            Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",account,10).Click();
            Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
            /*var width = Get_DlgCroesus().Get_Width();
            Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);
         }
         //Supprimer le model 
         DeleteModelByName(modelName);
     } 
     else
         Log.Error("Le modèle "+modelName+" n'existe pas.")
     
     //Réinitialiser le modèle +FB_MONTAN_SUBS -- reassigné le compte 800207-JW au modèle +FB_MONTAN_SUBS
     Log.Message("Réinitialiser le modèle "+updatedModelName+" -- reassigné le compte 800207-JW au modèle "+updatedModelName)         
     AssociateAccountWithModel(updatedModelName,account);
 }