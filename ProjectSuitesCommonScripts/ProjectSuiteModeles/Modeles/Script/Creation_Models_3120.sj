//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT DBA
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : Creation des modeles pour le cas Croes-3120
Analyste d'automatisation: Youlia Raisper */


function Creation_Models_3120()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");  
        
        var model1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelPrincipal_3120", language+client);
        var model2=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent1_3120", language+client);
        var model3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent2_3120", language+client);
        var model4=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelParent3_3120", language+client);
        var DIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityDIS", language+client);
        var BMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityBMO", language+client);
        var NBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC100", language+client);
        var percentDIS=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentDIS_3120", language+client);
        var percentBMO=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentBMO_3120", language+client);
        var percentNBC100=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentNBC100_3120", language+client); 
        var IACode=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "IACode_3120", language+client);
        var percent=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Percent", language+client);
        var percent1=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Percent1", language+client);
        var NBC020=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecutityNBC020", language+client);
        var percentNBC020=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentNBC020", language+client);
        var NBC471=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "SecurityNBC471", language+client);
        var percentNBC471=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentNBC471", language+client);
        var percentBMOPar3=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "PercentBMOPar3", language+client);
                
        var modelType=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinModelInfoGrpModel_CmbType_ModelFirm", language+client);       
        var typePicker=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Symb", language+client);         
        var typePickerSecurity=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "WinAddPositionGrpSecurityInformation_CmbTypePicker_Security", language+client);
         
        
        Login(vServerModeles, user, psw, language);
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
                        
        Create_Model(model1, "", IACode);//Modèle principal  
        Create_Model(model2, "", IACode); //Modèle parent 1 
        Create_Model(model3, "", IACode); //Modèle parent 2
        Create_Model(model4, "", IACode); //Modèle parent 4
        
        //**********************************************Modele principal ***************************************** 
        SearchModelByName(model1);
        Get_ModelsGrid().Find("Value",model1,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",model1,10), Get_ModulesBar_BtnPortfolio());
        
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73)
        
        //Ajouter une position BMO    
        AddPositionToModel(BMO,percentBMO,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(BMO); 
        
        Get_Toolbar_BtnAdd().Click();
        //Ajouter une position NBC100    
        AddPosition(NBC100,percentNBC100,typePicker,"")                           
        //Valider que la position a été ajoutée
        CheckPresenceofPosition(NBC100);
                
        //Ajouter une position DIS  
        Get_Toolbar_BtnAdd().Click(); 
        AddPosition(DIS,percentDIS,typePicker,"")   
        CheckPresenceofPosition(DIS);                                 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //*********************************************Modele Parent1 ************************************
        Get_ModulesBar_BtnModels().Click();
        //Sélectionner le modèle 
        SearchModelByName(model2);
        Get_ModelsGrid().Find("Value",model2,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",model2,10), Get_ModulesBar_BtnPortfolio());
       
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73) 
        
        AddSubModelToModel(model1,percent,"");
        //Ajouter une position NBC020  
        Get_Toolbar_BtnAdd().Click(); 
        AddPosition(NBC020,percentNBC020,typePicker,"")     
        
        //Valider que le sous-modele et la position ont été ajoutés
        CheckPresenceofPosition(model1);
        CheckPresenceofPosition(NBC020); 
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //*****************************************Modele Parent2***************************************
         Get_ModulesBar_BtnModels().Click();
        //Sélectionner le modèle 
        SearchModelByName(model3);
        Get_ModelsGrid().Find("Value",model3,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",model3,10), Get_ModulesBar_BtnPortfolio());
       
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73) 
        
        AddSubModelToModel(model1,percent,"");
         //Ajouter une position NBC471  
        Get_Toolbar_BtnAdd().Click(); 
        AddPosition(NBC471,percentNBC471,typePicker,"")  
        
        //Valider que le sous-modele et la position ont été ajoutés
        CheckPresenceofPosition(model1);
        CheckPresenceofPosition(NBC471);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        //*****************************************Modele Parent3***************************************
         Get_ModulesBar_BtnModels().Click();
        //Sélectionner le modèle 
        SearchModelByName(model4);
        Get_ModelsGrid().Find("Value",model4,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",model4,10), Get_ModulesBar_BtnPortfolio());
       
        Get_Toolbar_BtnAdd().Click();
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(2/3)),73) 
        
        AddSubModelToModel(model1,percent1,"");
         //Ajouter une position BMO 
        Get_Toolbar_BtnAdd().Click(); 
        AddPositionToModel(BMO,percentBMOPar3,typePicker,"")  
        
        //Valider que le sous-modele et la position ont été ajoutés
        CheckPresenceofPosition(model1);
        CheckPresenceofPosition(BMO);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        Get_ModulesBar_BtnModels().Click();        
                           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
	  Runner.Stop(true);	  
    }
}