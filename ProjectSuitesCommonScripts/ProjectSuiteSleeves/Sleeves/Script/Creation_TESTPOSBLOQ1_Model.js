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


function Creation_TESTPOSBLOQ1_Model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1452_TESTP", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        
        var securityXCB = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolXCB", language+client);
        var percentageXCB=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_XCB", language+client);
        var securityDIS = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_SymbolDIS", language+client);
        var percentageDIS=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Percentage_DIS", language+client);
        
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
        
        //Ajouter une position XCB      
        AddPosition(securityXCB,percentageXCB,typePicker,"")      
        
        //Ajouter une position NA  
        Get_Toolbar_BtnAdd().Click();     
        AddPosition(securityDIS,percentageDIS,typePicker,"")
                     
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityXCB); 
        CheckPresenceofPosition(securityDIS); 
               
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

function AddPosition(security,percentage,typePicker,securityDescription){

  Get_WinAddPositionSubmodel_GrpAdd_CmbSecurityPicker().Click();
  Get_SubMenus().Find("Text",typePicker,10).Click();
  Get_WinAddPositionSubmodel_GrpAdd_TxtSecurityPicker().Keys(security);
  Get_WinAddPositionSubmodel_GrpAdd_DlSecurityListPicker().Click();
  Get_WinAddPositionSubmodel_TxtValuePercent().Keys(percentage);
  Get_WinAddPositionSubmodel_BtnOK().Click();
  
}

 