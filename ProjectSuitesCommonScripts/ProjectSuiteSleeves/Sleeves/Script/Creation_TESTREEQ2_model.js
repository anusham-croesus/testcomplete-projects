//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT Creation_Test_Restriction_model


 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.
Analyste d'automatisation: Youlia Raisper */


function Creation_TESTREEQ2_model()
{
  var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
  CreationTESTREEQ(modelName);
}

function CreationTESTREEQ(modelName){
      try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
        var securityAEM = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolAEM", language+client);
        var percentage=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageTESTREEQ2", language+client);
        var SecuritySAP = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolSAP", language+client);
        var SecuritySAPDescription = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SAP", language+client);
        var securityNA = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolNA", language+client);
        
        Login(vServerSleeves, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(modelName,modelType,"")
        
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelName,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //Ajouter une position AEM       
        AddPositionToModel(securityAEM,percentage,typePicker)      
        
        //Ajouter une position NA  
        Get_Toolbar_BtnAdd().Click();     
        AddPositionToModel(securityNA,percentage,typePicker)
              
        //Ajouter une position SAP 
        Get_Toolbar_BtnAdd().Click();      
        AddPositionToModel(SecuritySAP,percentage,typePicker,SecuritySAPDescription)
        
        
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityNA); 
        CheckPresenceofPosition(securityAEM); 
        CheckPresenceofPosition(SecuritySAP); 
               
        //Fermer l'application
        Close_Croesus_MenuBar();
        if(Get_DlgConfirmation().Exists){
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
        }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
} 
