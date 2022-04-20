//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT CR1709_3104_OnlyReplacement_SecurityHeld_inPortfolio

/* Description :
https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3106
 
Analyste d'assurance qualité: Manel
Analyste d'automatisation: Youlia Raisper 
La version de scriptage: ref90-04-BNC-59B-5--V9-1_8-co6x */ 
 
 function CR1709_3106_Validate_Rebalancing()
 {             
    try{  
    
        Execute_SQLQuery("update B_MODEL_TYPE_USER_RIGHT set  ALLOW_REPLACEMENT = 'Y' , ALLOW_ALTERNATIVE='Y' WHERE  USER_NUM =104", vServerModeles)            
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "modele_3106", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);  
        var XCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityXCB", language+client);
        var NA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Position2594_3", language+client);
        var percentageNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentNA_3106", language+client);
        var OBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "OBA", language+client);
        var percentageXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentXCB_3106", language+client);
        var client800058=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800058", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
        var DescriptionXCB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "DescriptionXCB", language+client);
        var Replacement=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Replacement", language+client);
        var DescriptionOBA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDescriptionOBA", language+client);
        var conflictMessage=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "conflictMessage_3106", language+client);
        var MessageP1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3106_1", language+client);
        var MessageP2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Message_3106_2", language+client);
        var property=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PropertyForDlgWarningLblMessage", language+client); 
        
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        
        Create_Model(modelName,modelType)
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        var modelNo = Get_ModelNo(modelName);
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //NA à 2.5%
        AddPositionToModel(NA,percentageNA,typePicker,"")
        
        //XCB à 3% 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(XCB,percentageXCB,typePicker,"")
                                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NA); 
        CheckPresenceofPosition(XCB); 
        
        //Ajouter Replacement XCB
        AddReplacement(NA,DescriptionXCB,XCB,Replacement)
        //Ajouter Replacement OBA
        AddReplacement(XCB,DescriptionOBA,OBA,Replacement)
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        Log.Message(Get_Portfolio_PositionsGrid().Find("Value",NA,10).DataContext.DataItem.RemplacementSecurityConflictMessage)
        if(language=="english"){
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",NA,10).DataContext.DataItem,"RemplacementSecurityConflictMessage",cmpContains,"Security ISHARES CDN DEX CP BD ETF (XCB) is:\r\n    • used as a replacement security for the main security (NATIONAL BANK OF CDA (NA)) in the model  ("+modelNo+")\r\n    • used as main security in the model  ("+modelNo+")\r\nThis creates a conflict.")
        }else{
          aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Find("Value",NA,10).DataContext.DataItem,"RemplacementSecurityConflictMessage",cmpContains,"Le titre ISHARES CDN DEX CP BD ETF (XCB) est:\r\n    • utilisé comme titre de remplacement pour le titre principal (BANQUE NATIONALE DU CDA (NA)) dans le modèle  ("+modelNo+")\r\n    • utilisé comme titre principal dans le modèle  ("+modelNo+")\r\nCette situation crée un conflit.")
        }                      
        //assigné le client 800058 au modèle
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelName);    
        AssociateClientWithModel(modelName,client800058);
        
        //rééquilibrer jusqu e etape 4
        Get_Toolbar_BtnRebalance().Click();        
        //Validation
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), property, cmpEqual, MessageP1+"\n\n"+modelName+", "+modelNo+"\n\n"+MessageP2); 

        Get_DlgWarning().Close();
        //RestoreData(modelName,client800058)
                      
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {  
        Login(vServerModeles, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnModels().Click();
        RestoreData(modelName,client800058)
        Terminate_CroesusProcess(); //Fermer Croesus
        Runner.Stop(true)
    }
 }
 
 function RestoreData(modelName,client800058){
 
     Get_ModulesBar_BtnModels().Click();        
     SearchModelByName(modelName);
        
     Get_ModelsGrid().Find("Value",modelName,10).Click();
     if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800058,10).Exists){
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",client800058,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
     }
     //Supprimer le model 
     DeleteModelByName(modelName);
 }