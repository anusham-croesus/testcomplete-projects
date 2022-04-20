//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : 
Analyste d'automatisation: Youlia Raisper */


function Creation_Discounted_Sec()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_DiscountedSec", language+client);
        var securityR46004=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityR46004", language+client);        
        var targetR46004=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetR46004DisSec", language+client);
        var securityM85393=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionM85393", language+client);
        var targetM85393=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM85393DisSec", language+client);
        var PositionM87864=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PositionM87864", language+client);
        var targetM87864=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM87864", language+client);
                
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);       
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);         
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
         
        
        Login(vServerModeles, user, psw, language);
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
        
        //Ajouter une position M85393   
        AddPosition(securityM85393,targetM85393,typePickerSecurity,"")   
        
        //Ajouter une position R46004
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityR46004,targetR46004,typePickerSecurity,"")  
        
        //Ajouter une position M87864
        Get_Toolbar_BtnAdd().Click();
        AddPosition(PositionM87864,targetM87864,typePickerSecurity,"") 
                                   
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityM85393); 
        CheckPresenceofPosition(securityR46004); 
        CheckPresenceofPosition(PositionM87864);                             
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);
    }
}