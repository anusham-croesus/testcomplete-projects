//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
 
Analyste d'automatisation: Youlia Raisper */


function Preparation_FOR_2559_2561_2562()
{
    try{  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "0", vServerModeles)            
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerModeles)  
        Execute_SQLQuery("update b_compte set lock_id = null", vServerModeles)
        RestartServices(vServerModeles) 
                         
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelFB_MONTAN_SUBS", language+client);          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client); 
        var modelsubsProrata=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "modelsubsProrata", language+client);
        var modelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
        var modelRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelRevenusFixes", language+client);
        var Account800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049OB", language+client);
        var Account800245GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);
        var Account800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800285RE", language+client);
        var Account800223RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800223RE", language+client);
        var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800239", language+client);
        var Client800239RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800239RE", language+client);
        var target20=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target20", language+client);
        var target10=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target10", language+client);
        var target5=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Target5", language+client);
                                    
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize(); 
        
        //Le changement de la BD dans AT
        Get_ModulesBar_BtnModels().Click();    
        SearchModelByName("SUBSTITUT_MOD2");
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800245",10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800245",10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
        }
        //Le changement de la BD dans AT
        SearchModelByName("RECHANGE_PANIER");
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800285",10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800285",10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
          Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(1/3)),73);
        }
                
        SearchModelByName(modelName);
        Get_ModelsGrid().Find("Value",modelName,10).Click();
        Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value",Client800239RE,10).Click();
        Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
        /*var width = Get_DlgCroesus().Get_Width();
        Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
        var width = Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73);
        
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().WPFObject("RecordListControl", "", 1).Find("Value",Client800239RE,10).Exists){
          Log.Error("Le client n'a pas été enlevé")
        }else{
          Log.Checkpoint("Le client a été enlevé")
        }
                     
        SearchModelByName(modelRevenusFixes);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelRevenusFixes,10).Click();
        AssociateAccountWithModel(modelRevenusFixes,Account800245GT)
        
         SearchModelByName(modelAmericanEqui);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelAmericanEqui,10).Click();
        AssociateAccountWithModel(modelAmericanEqui,Account800049OB)
        
        SearchModelByName(modelMoyenTerme);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelMoyenTerme,10).Click();
        AssociateAccountWithModel(modelMoyenTerme,Account800285RE)
        
        SearchModelByName(modelsubsProrata);
        RemoveAccountFromModel(Account800223RE,modelsubsProrata);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelsubsProrata,10).Click();
        AssociateClientWithModel(modelsubsProrata,Client800239)
         
        
        //Ajouter un sous-modele
        SearchModelByName(modelAmericanEqui);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelAmericanEqui,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelAmericanEqui,10), Get_ModulesBar_BtnPortfolio());
          
        //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click();        
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        
        AddSubModelToModel(modelRevenusFixes,target20);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        if(Get_DlgInformation().Exists)
          Get_DlgInformation().Close(); 
         
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelMoyenTerme);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelMoyenTerme,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelMoyenTerme,10), Get_ModulesBar_BtnPortfolio());
          
        //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        AddSubModelToModel(modelRevenusFixes,target5);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
         
        Get_ModulesBar_BtnModels().Click();
        SearchModelByName(modelsubsProrata);
        //Sélectionner le modèle 
        Get_ModelsGrid().Find("Value",modelsubsProrata,10).Click();
        // chainer vers le module Portefeuille,
        Drag( Get_ModelsGrid().Find("Value",modelsubsProrata,10), Get_ModulesBar_BtnPortfolio());
          
        //Ajouter un sous-modele
        Get_Toolbar_BtnAdd().Click();
        if(Get_DlgConfirmation().Exists){
          var width = Get_DlgConfirmation().Get_Width();
          Get_DlgConfirmation().Click((width*(2/3)),73) 
        }
        AddSubModelToModel(modelRevenusFixes,target10);
        Get_PortfolioBar_BtnSave().Click();
        Get_WinWhatIfSave_BtnOK().Click();
        
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelAmericanEqui);
        ActivateDeactivateModel(modelAmericanEqui,true);  
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelMoyenTerme);
        ActivateDeactivateModel(modelMoyenTerme,true);  
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelsubsProrata);
        ActivateDeactivateModel(modelsubsProrata,true);  
        
        //Activer le Modèle
        Get_ModulesBar_BtnModels().Click();
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click()
        SearchModelByName(modelRevenusFixes);
        ActivateDeactivateModel(modelRevenusFixes,true);  
                      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
	    Runner.Stop(true);      
    }
}