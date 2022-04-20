//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3104_OnlyReplacement_SecurityHeld_inPortfolio

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3183
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3183_Replacement_isNotHeld_in_Portfolio()
 {             
    try{  
    
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)                    
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                       
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3183", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);         
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client);
        var IVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityIVZ", language+client);
        var percentageXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentXCB_3183", language+client);
        var percentageIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentIVZ_3183", language+client);
        var Account800058NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800058NA", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var DescriptionNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionNBC100", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
        var Replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Replacement", language+client);
        var DisplayQuantityVariationStrXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityVariationStrXCB", language+client);
        var DisplayQuantityXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityXCB_3183", language+client);
        var BookValueACBXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "BookValueACBXCB_3183", language+client);
        var MarketValueXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueXCB_3183", language+client);        
        var DisplayQuantityVariationStrIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityVariationStrIVZ", language+client);
        var DisplayQuantityIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityIVZ_3183", language+client);
        var BookValueACBIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "BookValueACBIVZ_3183", language+client);
        var MarketValueIVZ=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "MarketValueIVZ_3183", language+client);
        
        
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
        
        //IVZ à 15%
        AddPosition(IVZ,percentageIVZ,typePicker,"")
        
        //XCB à 15% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(XCB,percentageXCB,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(IVZ); 
        CheckPresenceofPosition(XCB); 
        
        //Ajouter Replacement NBC100
        AddReplacement(XCB,DescriptionNBC100,NBC100,Replacement)
  
        
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
        
        SearchPosition(XCB);            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10).Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "DisplayQuantityVariationStr", cmpEqual,DisplayQuantityVariationStrXCB);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityXCB);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "BookValueACB", cmpEqual,BookValueACBXCB);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",XCB,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueXCB);
        
        SearchPosition(IVZ);            
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10).Click();   
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "DisplayQuantityVariationStr", cmpEqual,DisplayQuantityVariationStrIVZ);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "DisplayQuantity", cmpEqual,DisplayQuantityIVZ);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "BookValueACB", cmpEqual,BookValueACBIVZ);
        aqObject.CheckProperty(Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Find("DisplayText",IVZ,10 ).DataContext.DataItem, "MarketValue", cmpEqual,MarketValueIVZ);
        
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