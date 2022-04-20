//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : 
Analyste d'automatisation: Youlia Raisper */


function Creation_800214GT_Model()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_Global", language+client);
        
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);       
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerTitre", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client); 
        //var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerDescription", language+client);          
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
         
        var securityAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAAPL", language+client);
        var targertAAPL=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetAAPL", language+client);
        var securityBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        var targetBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetBMO", language+client);
        var securityNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNA", language+client);
        var targetNA=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetNA", language+client);
        var securityM84819=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM84819", language+client);
        var targetM84819=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM84819", language+client);
        var securityM86293=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM86293", language+client);
        var targetM86293=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM86293", language+client);
        var securityM22358=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityM22358", language+client);
        var targetM22358=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetM22358 ", language+client);
        var securityFID224=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityFID224", language+client);
        var targetFID224=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetFID224", language+client);
        var securityAGF681=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAGF681", language+client);
        var targetAGF681=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetAGF681 ", language+client);
        var securityR46004=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityR46004", language+client);
        var targetR46004=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetR46004", language+client);
        var securityDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDIS", language+client);
        var targetDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TargetDIS", language+client);
        
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
        
        //Ajouter une position AAPL    
        AddPosition(securityAAPL,targertAAPL,typePicker,"")   
        
        //Ajouter une position BMO
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityBMO,targetBMO,typePicker,"")  
        
        //Ajouter une position DIS
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityDIS,targetDIS,typePicker,"") 
        
        //Ajouter une position NA
        Get_Toolbar_BtnAdd().Click();
        AddPositionToModel(securityNA,targetNA,typePicker,"") 
        
        //Ajouter une position M84819
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityM84819,targetM84819,typePickerSecurity,"")  
        
        //Ajouter une position M86293
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityM86293,targetM86293,typePickerSecurity,"")  
        
        //Ajouter une position M22358
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityM22358,targetM22358,typePickerSecurity,"") 
        
        //Ajouter une position FID224
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityFID224,targetFID224,typePicker,"") 
        
        //Ajouter une position AGF681
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityAGF681,targetAGF681,typePicker,"") 
        
        //Ajouter une position R46004
        Get_Toolbar_BtnAdd().Click();
        AddPosition(securityR46004,targetR46004,typePickerSecurity,"") 
                             
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();

        //Valider que la position a été ajoutée
        CheckPresenceofPosition(securityAAPL); 
        CheckPresenceofPosition(securityBMO); 
        CheckPresenceofPosition(securityDIS); 
        CheckPresenceofPosition(securityNA); 
        CheckPresenceofPosition(securityM84819); 
        CheckPresenceofPosition(securityM86293); 
        CheckPresenceofPosition(securityM22358);         
        CheckPresenceofPosition(securityFID224); 
        CheckPresenceofPosition(securityAGF681); 
        CheckPresenceofPosition(securityR46004); 
               
        //Fermer l'application
        Close_Croesus_MenuBar();
        SetAutoTimeOut();
        if (Get_DlgConfirmation().Exists)
            Get_DlgConfirmation_BtnYes().Click();         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);
    }
}