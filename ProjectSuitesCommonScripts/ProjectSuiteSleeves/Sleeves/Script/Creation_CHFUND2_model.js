//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Creation_Test_Restriction_model
//USEUNIT Creation_TESTPOSBLOQ1_Model
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function Creation_CHFUND2_model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_CHFUND2", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
        var securityFID228 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolFID228", language+client);
        var percentageFID228=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_FID228", language+client);
        var securityNBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC100", language+client);
        var percentageNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_NBC100", language+client);
        var securityFID224 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolFID224", language+client);
        var percentageFID224=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_FID224", language+client);        
        var securityNBC566 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNBC566", language+client);
        var percentageNBC566=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageCHFUND2_NBC566", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
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
        
        //Ajouter une position FID228     
        AddPositionToModel(securityFID228,percentageFID228,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityFID228); 
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position NBC100    
        AddPosition(securityNBC100,percentageNBC100,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityNBC100);
        
         Get_Toolbar_BtnAdd().Click();
        //Ajouter une position NBC566   
        AddPosition(securityNBC566,percentageNBC566,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityNBC566);
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position FID224   
        AddPosition(securityFID224,percentageFID224,typePicker,"")                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityFID224);
               
        //Fermer l'application
        Close_Croesus_MenuBar();
        if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }         
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