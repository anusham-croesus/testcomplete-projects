//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3099_SpecifySameComplementSecurity_OnMultiplePositions

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3814
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5375

Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3814_CheckRebalancing_withBlockedComplement()
 {             
    try{  
            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Model_3814", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);         
        var COMS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "COMS", language+client);
        var percentageCOSM=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageCOSM", language+client);        
        var XBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XBB", language+client);
        var percentageXBB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageXBB", language+client);
        var XRE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XRE", language+client);
        var percentageXRE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentageXRE", language+client);
        var XIU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "XIU", language+client);
        var Client800228=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800228", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
        var complement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Complement", language+client);
        var DescriptionXIU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXIU", language+client);
        var PositionSolde=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionSolde", language+client);
        var DisplayQuantity800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity800228FS", language+client);
        var DisplayAcc800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayAcc800228FS", language+client);
        var DisplayOriginalQuantityVariationStr800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayOriginalQuantityVariationStr800228FS", language+client);
        var DisplayAcc800228RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800228RE", language+client);
        var DisplayQuantity800228RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity800228RE", language+client);
        var DisplayOriginalQuantityVariationStr800228RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayOriginalQuantityVariationStr800228RE", language+client);
        var DisplayAcc800228JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800228JW", language+client);
        var DisplayQuantity800228JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantity800228JW", language+client);
        var DisplayOriginalQuantityVariationStr800228JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayOriginalQuantityVariationStr800228JW", language+client);

        var TotalValuePercentageMarketCOMS800228RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketCOMS800228RE", language+client);
        var DisplayQuantityCOMS800228RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityCOMS800228RE", language+client);
        var TotalValuePercentageMarketCOMS800228JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketCOMS800228JW", language+client);
        var DisplayQuantityCOMS800228JW=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityCOMS800228JW", language+client);
        var TotalValuePercentageMarketCOMS800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketCOMS800228FS", language+client);
        var DisplayQuantityCOMS800228FS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityCOMS800228FS", language+client);
        var DisplayQuantityXIU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DisplayQuantityXIU", language+client);
        var TotalValuePercentageMarketXIU=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TotalValuePercentageMarketXIU", language+client);
        
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=croes-5375","Cas de test TestLink : Croes-5375")
        
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
        
        //COMS à 95%
        AddPosition(COMS,percentageCOSM,typePicker,"")
        
        //XBB à 1% avec XIU comme complément
        Get_Toolbar_BtnAdd().Click();
        AddPosition(XBB,percentageXBB,typePicker,"")
        
        //XRE à 1% avec XIU comme complément
        Get_Toolbar_BtnAdd().Click();
        AddPosition(XRE,percentageXRE,typePicker,"")
                                   
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(COMS); 
        CheckPresenceofPosition(XRE); 
        CheckPresenceofPosition(XBB);
        
        //Ajouter Complément XIU
        AddComplement(typePicker,XBB,DescriptionXIU,XIU,complement);
        AddComplement(typePicker,XRE,DescriptionXIU,XIU,complement); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();        
        
        //assigné le client 800228 au modèle
        Get_ModulesBar_BtnModels().Click();  
        AssociateClientWithModel(modelName,Client800228);
        
         //Sélectionner Client 800228
        Get_ModulesBar_BtnClients().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Search_Client(Client800228);
        
        //mailler vers portefeuille
        Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",Client800228,10), Get_ModulesBar_BtnPortfolio());
        
        //bloquer position XIU
        Search_Position(XIU);
        Get_PortfolioBar_BtnInfo().click();
        Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(true);
        Get_WinPositionInfo_BtnOK().click();
        
        //Valider que la position XIU est bloquée   
        aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",XIU,10).DataContext.DataItem, "IsBlocked", cmpEqual,true);
        
         Get_ModulesBar_BtnModels().Click();
         SearchModelByName(modelName);
        
        //rééquilibrer jusqu e etape 4
        Get_Toolbar_BtnRebalance().Click(); 
        //Dans le cas, si le click ne fonctionne pas  
        var numberOftries=0;  
        while ( numberOftries < 5 && !Get_WinRebalance().Exists){
            Get_Toolbar_BtnRebalance().Click(); 
            numberOftries++;
        }
        Get_WinRebalance().Parent.Maximize();       
        Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
        Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);  
        Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);  
        Get_WinRebalance_BtnNext().Click();     
        Get_WinRebalance_BtnNext().Click();
        Get_WinRebalance_BtnNext().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42");
        
        Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolio().Click();
        WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd",15000); 
        
        
        Log.Message("EM: 90-08-15: Modifié suite a la réponse de Karima. Datapool + script ont été changées suite au CR1322 et au Jira CROES-10173. Voir TestLink Croes-5375")
        //PositionSolde - DisplayAcc800228FS
        VlaidatePPDataRow(PositionSolde,DisplayAcc800228FS,DisplayQuantity800228FS,DisplayOriginalQuantityVariationStr800228FS)
        //PositionSolde - DisplayAcc800228JW
        VlaidatePPDataRow(PositionSolde,DisplayAcc800228JW,DisplayQuantity800228JW,DisplayOriginalQuantityVariationStr800228JW)
       //PositionSolde - DisplayAcc800228RE
        VlaidatePPDataRow(PositionSolde,DisplayAcc800228RE,DisplayQuantity800228RE,DisplayOriginalQuantityVariationStr800228RE)
        //COMS - DisplayAcc800228FS
        VlaidatePPDataRow(COMS,DisplayAcc800228FS,DisplayQuantityCOMS800228FS,"",TotalValuePercentageMarketCOMS800228FS,false)       
        //COMS - DisplayAcc800228RE
        VlaidatePPDataRow(COMS,DisplayAcc800228RE,DisplayQuantityCOMS800228RE,"",TotalValuePercentageMarketCOMS800228RE,false)
        //XIU - DisplayAcc800228FS
        VlaidatePPDataRow(XIU,DisplayAcc800228FS,DisplayQuantityXIU,0,TotalValuePercentageMarketXIU,true)
       
               
        Get_WinRebalance_BtnClose().Click();  
        /*var width = Get_DlgWarning().Get_Width();
        Get_DlgWarning().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        //RestoreData(modelName,Client800228,XIU)
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        

    }
    finally { 
        Login(vServerModeles, user , psw ,language);
        Get_ModulesBar_BtnModels().Click();
        RestoreData(modelName,Client800228,XIU)
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }
 
 function SearchPosition(position){
    Get_WinRebalance_TabProjectedPortfolios_TabProjectedPortfolioBtnGroupByAssetClassOff_DgvProjectedPortfolio().Keys("F");
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73", 15000);
    Get_WinQuickSearch_TxtSearch().Clear();
    Get_WinQuickSearch_TxtSearch().Keys(position);
    Get_WinSecuritiesQuickSearch_RdoSymbol().Set_IsChecked(true);
    Get_WinQuickSearch_BtnOK().Click(); 
 }
 
 function VlaidatePPDataRow(symbole,account,quantity,quantityVariation,VM, isBlocked){
    PP_Search(symbole);
    Values = new Array (account,symbole);
    var rowContent=FindRowByMultipleValues(Get_WinRebalance_PositionsGrid(), Values);
    if(rowContent != -1){
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "Symbol", cmpEqual, symbole);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "AccountNumber", cmpEqual, account);
        aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayQuantityStr", cmpEqual, quantity);
        if(quantityVariation != undefined && Trim(VarToStr(quantityVariation)) != "")
            aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "DisplayOriginalQuantityVariationStr", cmpEqual, quantityVariation);
                    
        if(VM != undefined && Trim(VarToStr(VM)) != ""){
            var detected=roundDecimal(rowContent.row.DataContext.DataItem.TotalValuePercentageMarket.OleValue,3)
            if(FloatToStr(detected)==VM)
                Log.Checkpoint("VM (%) detected = "+detected+" est égale a VM (%) expected = "+VM)
            else
                Log.Error("VM (%) detected = "+detected+" n'est pas égale a VM (%) expected) = "+VM)
        }
        if(isBlocked != undefined && Trim(VarToStr(isBlocked)) != "")
            aqObject.CheckProperty(rowContent.row.DataContext.DataItem, "IsBlocked", cmpEqual, isBlocked); //EM: CO-07-22 avant IsLegacy
    } 
    else Log.Error("Aucun portefeuille projeté pour compte = "+account+" et symbole = "+symbole);
}
 
 
 function RestoreData(modelName,Client800228, position){
 
     Get_ModulesBar_BtnModels().Click();        
     SearchModelByName(modelName);
        
     Get_ModelsGrid().Find("Value",modelName,10).Click();
     if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",Client800228,10).Exists){
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",Client800228,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
     }
     //Supprimer le model 
     DeleteModelByName(modelName);
     
     //Sélectionner Client 800228
     Get_ModulesBar_BtnClients().Click();
     Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
     Search_Client(Client800228);
        
     //mailler vers portefeuille
     Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",Client800228,10), Get_ModulesBar_BtnPortfolio());
        
     //Débloquer la position XIU
     Search_Position(position);
     Get_PortfolioBar_BtnInfo().click();
     Get_WinPositionInfo_GrpExclusion_ChkLockedPosition().Set_IsChecked(false);
        
     //Valider que la position XIU est débloquée   
     Get_WinPositionInfo_BtnOK().click();
     aqObject.CheckProperty(Get_Portfolio_AssetClassesGrid().WPFObject("RecordListControl", "", 1).Find("Value",position,10).DataContext.DataItem, "IsBlocked", cmpEqual,false);
        

 }