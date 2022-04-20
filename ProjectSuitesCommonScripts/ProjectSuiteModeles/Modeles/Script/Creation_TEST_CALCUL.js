//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : 
Analyste d'automatisation: Youlia Raisper */


function Creation_TEST_CALCUL()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");          
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelName_TestCalcul", language+client);
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);
        var securityTypePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "TypePickerTitre", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client); 
        var targetBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetBMO", language+client);       
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var targetNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetNBC100", language+client);
        var CUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityCUR", language+client);
        var targetCUR=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetCUR", language+client);
        var V61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityV61632", language+client);
        var targetV61632=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetV61632", language+client);
        var AER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityAER", language+client); 
        var targetAER=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "TestCalculTargetAER", language+client);        
        
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
        
        //Ajouter une position BMO    
        AddPositionToModel(BMO,targetBMO,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(BMO); 
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position NBC100    
        AddPosition(NBC100,targetNBC100,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NBC100);
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position CUR  
        AddPosition(CUR,targetCUR,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(CUR); 
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position V61632  
        AddPosition(V61632,targetV61632,securityTypePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(V61632); 
        
         Get_Toolbar_BtnAdd().Click();
        //Ajouter une position AER  
        AddPositionToModel(AER,targetAER,typePicker,"")                           
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(AER);    
                         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	    Runner.Stop(true);
    }
}