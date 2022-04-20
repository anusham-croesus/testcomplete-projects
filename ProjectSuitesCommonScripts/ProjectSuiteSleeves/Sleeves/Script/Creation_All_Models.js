//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Creation_Test_Restriction_model
//USEUNIT Creation_TESTPOSBLOQ1_Model
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT Modeles_Get_functions

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.Analyste d'automatisation: Alhassane Diallo
 Ce cas de test regroupe la creation des tous les modeles  */


function Creation_All_Models()
{
    try{           
        
    
        var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7,logEtape8, logEtape9, logEtape10, logEtape11, logEtape12, logEtape13;
        var logEtape14,logEtape15, logEtape16, logEtape17, logEtape18, logEtape19, logEtape20;
        
        /*********************************************************Variables ***********************************************************/
        var user        = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        var modelType   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var typePicker2 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerTitre", language+client);
        var typePicker1 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerDescription", language+client);        
        var typePicker  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
      
        
        /****************************************Variables du model 800214-GT***********************************/
        var modelName800214GT = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_800214GT", language+client);
        var securityQ70791    = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "SecurityQ70791", language+client);
        var percentageQ70791  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageQ70791", language+client);
        
        
        /****************************************Variables du model BCE100***********************************/
        
        var ModelCR1452_BCE100 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_BCE100", language+client);             
        var BCE                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolBCE", language+client);
        var percentageBCE      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelBCE100Percentage", language+client);
        
        
        /****************************************Variables du model CHCAN2***********************************/ 
        var ModelCR1452_CHCAN2   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHCAN2", language+client);
        var PercentageBCE_CHCAN2 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHCAN2_BCE", language+client);
        
          
        /****************************************Variables du model CHFUND1***********************************/ 
        var ModelCR1452_CHFUND1   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND1", language+client);
        var securityFID228        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolFID228", language+client);
        var percentageFID228      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND1_FID228", language+client);
        var securityNBC100        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC100", language+client);
        var percentageNBC100      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND1_NBC100", language+client);
        var securityFID224        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolFID224", language+client);
        var percentageFID224      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND1_FID224", language+client);
        
        /****************************************Variables du model CHFUND2***********************************/ 
        var modelNameCHFUND2        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND2", language+client);
        var securityNBC566          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC566", language+client);
        var percentageCHFUND2FID228 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_FID228", language+client);
        var percentageCHFUND2NBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_NBC100", language+client);
        var percentageCHFUND2FID224 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_FID224", language+client);        
        var percentageNBC566        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_NBC566", language+client);
        
        /****************************************Variables du model NONRACHETABLE1***********************************/
        var modelNameNONRACHETABLE1  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_NONRACHETABLE1", language+client);               
        var DIS                      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var percentageNONRACHETABLE1 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "NONRACHETABLE1Percentage", language+client);
        var FTS                      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_FTS", language+client);
        
        /****************************************Variables du model NONRACHETABLE2***********************************/
        var modelNameNONRACHETABLE2  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_NONRACHETABLE2", language+client);
        var securityPOW              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_POW", language+client);
        var percentagePOW            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_POW", language+client);
        
        /****************************************Variables du model NONRACHETABLE4***********************************/
        var modelNameNONRACHETABLE4       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_NONRACHETABLE4", language+client); 
        var percentageNONRACHETABLE4_POW  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageNONRACHETABLE4_POW", language+client);
        
        /****************************************Variables du model TestRestriction***********************************/
    
        var modelNameModelTestRestriction   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelTestRestriction", language+client);
        var securityNA                      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNA", language+client);
        var valuePercentNA                  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ValuePercentNA", language+client);
        
        /*******************************************Variables du model TESTPOSBLOQ1*************************************/
        var modelNameModelCR1452_TESTP     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);
        var securityXCB                    = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client);
        var percentageXCB                  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_XCB", language+client);
        var percentageDIS                  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_DIS", language+client);
        
        /*******************************************Variables du model TESTPOSBLOQ2*************************************/
        var modelNameModelCR1452_TESTP2  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP2", language+client);
        var percentage_XCB_TESTP2        = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_XCB_TESTP2", language+client);
        var percentageNA_TESTP2          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_NA", language+client);
        
        /*******************************************Variables du model TESTPOSBLOQ3*************************************/
        var modelNameModelCR1452_TESTPOSBLOQ3  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ3", language+client);
        var percentageTESTPOSBLOQ3_XCB         = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTESTPOSBLOQ3_XCB", language+client);
        
        /*******************************************Variables du model TESTPOSBLOQ5*************************************/
        var modelNameTESTPOSBLOQ5       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ5", language+client);
		var percentageTESTPOSBLOQ5_BCE  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTESTPOSBLOQ5_BCE", language+client);
        
        /*******************************************Variables du model TESTPOSBLOQ6*************************************/
        var modelNameTESTPOSBLOQ6      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ6", language+client);
		var PercentageBCE_TESTPOSBLOQ6 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_BCE", language+client);
        var securityR32316             = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_R32316", language+client);
        var percentageR32316           = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_R32316", language+client);
        
        
        /*******************************************Variables du model TESTPOSBLOQ7*************************************/
        var modelNameTESTPOSBLOQ7      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ7", language+client); 
		var securityABX                = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolABX", language+client);
        var PercentageABX_TESTPOSBLOQ7 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_ABX", language+client);
        var percentageR32316_BLOQ7     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_R32316_BLOQ7", language+client);
        
        
        /*******************************************Variables du model TESTPOSBLOQ8*************************************/
        var modelNameTESTPOSBLOQ8   = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTPOSBLOQ8", language+client);
        var securityRY              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolRY", language+client);
        var percentageRY            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_RY", language+client);
        var securityDELL            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDELL", language+client);
        var percentageDELL          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_DELL", language+client);
        
        /*******************************************Variables des model TESTREEQ et TESTREEQ2 *************************************/
        var modelNameTESTREEQ       = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTREEQ", language+client);
		var modelNameTESTREEQ2      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        var securityAEM             = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolAEM", language+client);
        var percentage              = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTESTREEQ2", language+client);
        var SecuritySAP             = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolSAP", language+client);
        var SecuritySAPDescription  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SAP", language+client);
        
        
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec UNI00");
        Login(vServerSleeves, user, psw, language);

        //Creation_800214GT_Model
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Creation du modele 800214GT");
        Creation_Selection_Maillage_Model(modelName800214GT,modelType);
        AddPosition(securityQ70791,percentageQ70791,typePicker1,"") 
        CheckPresenceofPosition(securityQ70791);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_BCE100_Model
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Creation du modele BCE100");
        Creation_Selection_Maillage_Model(ModelCR1452_BCE100,modelType);
        AddPositionToModel(BCE,percentageBCE,typePicker,"");
        CheckPresenceofPosition(BCE);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_CHCAN2_Model
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Creation du modele CHCAN2");
        Creation_Selection_Maillage_Model(ModelCR1452_CHCAN2,modelType);
        AddPositionToModel(BCE,PercentageBCE_CHCAN2,typePicker,"");
        CheckPresenceofPosition(BCE);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_CHFUND1_model
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Creation du modele CHFUND1 avec les positions : FID228, NBC100, FID224 ");
        Creation_Selection_Maillage_Model(ModelCR1452_CHFUND1,modelType);    
        AddPositionToModel(securityFID228,percentageFID228,typePicker,"")                           
        CheckPresenceofPosition(securityFID228); 
        Get_Toolbar_BtnAdd().Click();   
        AddPosition(securityNBC100,percentageNBC100,typePicker,"")                           
        CheckPresenceofPosition(securityNBC100);  
        Get_Toolbar_BtnAdd().Click(); 
        AddPosition(securityFID224,percentageFID224,typePicker,"") 
        CheckPresenceofPosition(securityFID224)                          
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_CHFUND2_model
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Creation du modele CHFUND2 avec les positions : FID228, NBC100, FID224, NBC566 ");
        Creation_Selection_Maillage_Model(modelNameCHFUND2,modelType);    
        AddPositionToModel(securityFID228,percentageCHFUND2FID228,typePicker,"");                           
        CheckPresenceofPosition(securityFID228);  
        Get_Toolbar_BtnAdd().Click();   
        AddPosition(securityNBC100,percentageCHFUND2NBC100,typePicker,"");                           
        CheckPresenceofPosition(securityNBC100);  
        Get_Toolbar_BtnAdd().Click();  
        AddPosition(securityFID224,percentageCHFUND2FID224,typePicker,""); 
        CheckPresenceofPosition(securityFID224); 
        Get_Toolbar_BtnAdd().Click(); 
        AddPosition(securityNBC566,percentageNBC566,typePicker,"");
        CheckPresenceofPosition(securityNBC566);                      
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_NONRACHETABLE1_Model
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Creation du modele NONRACHETABLE1 avec les positions : DIS, FTS ");
        Creation_Selection_Maillage_Model(modelNameNONRACHETABLE1,modelType);    
        AddPositionToModel(DIS,percentageNONRACHETABLE1,typePicker,"");                           
        CheckPresenceofPosition(DIS); 
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(FTS,percentageNONRACHETABLE1,typePicker,"");                           
        CheckPresenceofPosition(FTS); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_NONRACHETABLE2_Model
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Creation du modele NONRACHETABLE2 avec les positions : POW ");
        Creation_Selection_Maillage_Model(modelNameNONRACHETABLE2,modelType);    
        AddPositionToModel(securityPOW,percentagePOW,typePicker,"");                           
        CheckPresenceofPosition(securityPOW); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_NONRACHETABLE4_Model
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Creation du modele NONRACHETABLE4 avec les positions : POW ");
        Creation_Selection_Maillage_Model(modelNameNONRACHETABLE4,modelType);    
        AddPositionToModel(securityPOW,percentageNONRACHETABLE4_POW,typePicker,"");                           
        CheckPresenceofPosition(securityPOW); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
       
        
        //Creation_Test_Restriction_model
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 11: Creation du modele ModelTestRestriction avec les positions : NA ");
        Creation_Selection_Maillage_Model(modelNameModelTestRestriction,modelType);    
        AddPositionToModel(securityNA,valuePercentNA,typePicker,"");                           
        CheckPresenceofPosition(securityNA); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTPOSBLOQ1_Model
        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Étape 11: Creation du modele TESTPOSBLOQ1_Model avec les positions : XCB, DIS ");
        Creation_Selection_Maillage_Model(modelNameModelCR1452_TESTP,modelType);    
        AddPosition(securityXCB,percentageXCB,typePicker,"")                            
        CheckPresenceofPosition(securityXCB); 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(DIS,percentageDIS,typePicker,"")
        CheckPresenceofPosition(DIS); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_ModelCR1452_TESTP2_Model
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: Creation du modele ModelCR1452_TESTP2 avec les positions : XCB,NA  ");
        Creation_Selection_Maillage_Model(modelNameModelCR1452_TESTP2,modelType);    
        AddPosition(securityXCB,percentage_XCB_TESTP2,typePicker,"")                            
        CheckPresenceofPosition(securityXCB); 
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityNA,percentageNA_TESTP2,typePicker,"")
        CheckPresenceofPosition(securityNA); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTPOSBLOQ3_Model
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 13: Creation du modele TESTPOSBLOQ3 avec les positions : XCB ");
        Creation_Selection_Maillage_Model(modelNameModelCR1452_TESTPOSBLOQ3,modelType);    
        AddPosition(securityXCB,percentageTESTPOSBLOQ3_XCB,typePicker,"")                            
        CheckPresenceofPosition(securityXCB); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTPOSBLOQ5_model
        Log.PopLogFolder();
        logEtape14 = Log.AppendFolder("Étape 14: Creation du modele TESTPOSBLOQ5 avec les positions : BCE ");
        Creation_Selection_Maillage_Model(modelNameTESTPOSBLOQ5,modelType);    
        AddPositionToModel(BCE,percentageTESTPOSBLOQ5_BCE,typePicker,"")                           
        CheckPresenceofPosition(BCE); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTPOSBLOQ6_Model
        Log.PopLogFolder();
        logEtape15 = Log.AppendFolder("Étape 15: Creation du modele TESTPOSBLOQ6 avec les positions : BCE, R32316 ");
        Creation_Selection_Maillage_Model(modelNameTESTPOSBLOQ6,modelType);    
        AddPositionToModel(BCE,percentageBCE,typePicker,"")                           
        CheckPresenceofPosition(BCE); 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityR32316,PercentageBCE_TESTPOSBLOQ6,typePicker2,"");
        CheckPresenceofPosition(securityR32316);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        //Creation_TESTPOSBLOQ7_Model
        Log.PopLogFolder();
        logEtape16 = Log.AppendFolder("Étape 16: Creation du modele TESTPOSBLOQ7 avec les positions : ABX, R32316 ");
        Creation_Selection_Maillage_Model(modelNameTESTPOSBLOQ7,modelType);    
        AddPositionToModel(securityABX,PercentageABX_TESTPOSBLOQ7,typePicker,"")                           
        CheckPresenceofPosition(securityABX); 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityR32316,percentageR32316_BLOQ7,typePicker2,"");
        CheckPresenceofPosition(securityR32316);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTPOSBLOQ8_Model
        Log.PopLogFolder();
        logEtape17 = Log.AppendFolder("Étape 17: Creation du modele TESTPOSBLOQ7 avec les positions : RY, DELL ");
        Creation_Selection_Maillage_Model(modelNameTESTPOSBLOQ8,modelType);    
        AddPositionToModel(securityRY,percentageRY,typePicker,"")                           
        CheckPresenceofPosition(securityRY); 
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityDELL,percentageDELL,typePicker,"");
        CheckPresenceofPosition(securityDELL);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTREEQ_model
        Log.PopLogFolder();
        logEtape18 = Log.AppendFolder("Étape 18: Creation du modele TESTREEQ avec les positions : AEM, NA, DELL ");
        Creation_Selection_Maillage_Model(modelNameTESTREEQ,modelType);    
        AddPositionToModel(securityAEM,percentage,typePicker)                           
        CheckPresenceofPosition(securityAEM); 
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityNA,percentage,typePicker);
        CheckPresenceofPosition(securityNA);
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(SecuritySAP,percentage,typePicker,SecuritySAPDescription)
        CheckPresenceofPosition(SecuritySAP);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //Creation_TESTREEQ_model
        Log.PopLogFolder();
        logEtape19 = Log.AppendFolder("Étape 19: Creation du modele TESTREEQ2 avec les positions : AEM, NA, DELL ");
        Creation_Selection_Maillage_Model(modelNameTESTREEQ2,modelType);    
        AddPositionToModel(securityAEM,percentage,typePicker)                           
        CheckPresenceofPosition(securityAEM); 
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityNA,percentage,typePicker);
        CheckPresenceofPosition(securityNA);
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(SecuritySAP,percentage,typePicker,SecuritySAPDescription)
        CheckPresenceofPosition(SecuritySAP);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves)

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

//
function Creation_Selection_Maillage_Model(modelName,modelType){
    
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,modelType)
        
         //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        Get_DlgConfirmation_btnNo().Click();

}
function AddPosition(security,percentage,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
}

 
