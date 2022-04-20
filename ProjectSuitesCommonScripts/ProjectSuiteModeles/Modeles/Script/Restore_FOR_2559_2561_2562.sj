//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT DBA
//USEUNIT ExcelUtils

 /* Description : 
 
Analyste d'automatisation: Youlia Raisper */


function Restore_FOR_2559_2561_2562()
{
    try{  
        Activate_Inactivate_Pref("KEYNEJ", "PREF_MODEL_UNIFORM_CASH_ALLOCATION", "0", vServerModeles)            
        Activate_Inactivate_Pref("KEYNEJ", "PREF_ACCOUNT_WITHDRAWAL_CASH", "NO", vServerModeles)  
                         
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "ModelFB_MONTAN_SUBS", language+client);          
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var modelAmericanEqui=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelAmericanEqui", language+client); 
        var modelsubsProrata=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "modelsubsProrata", language+client);
        var modelMoyenTerme=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelMoyenTerme", language+client);
        var modelRevenusFixes=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "modelRevenusFixes", language+client);
        var Account800049OB=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800049OB", language+client);
        var Account800245GT=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800245GT", language+client);
        var Account800285RE=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Account800285RE", language+client);
        var Client800239=ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "CR1709", "Client800239", language+client);

                            
        Login(vServerModeles, user, psw, language);         
        Get_ModulesBar_BtnModels().Click();
        Get_MainWindow().Maximize();
        
        SearchModelByName(modelRevenusFixes);
        RemoveAccountFromModel(Account800245GT,modelRevenusFixes);
        
        SearchModelByName(modelAmericanEqui);
        RemoveAccountFromModel(Account800049OB,modelAmericanEqui);
                                    
        SearchModelByName(modelMoyenTerme);
        RemoveAccountFromModel(Account800285RE,modelMoyenTerme);
        
        SearchModelByName(modelsubsProrata);
        RemoveAccountFromModel(Client800239,modelsubsProrata); 
        
        Get_ModulesBar_BtnModels().Click();     
        DeleteSubModel(modelAmericanEqui,modelRevenusFixes);
        Get_ModulesBar_BtnModels().Click();
        DeleteSubModel(modelMoyenTerme,modelRevenusFixes);
        Get_ModulesBar_BtnModels().Click();
        DeleteSubModel(modelsubsProrata,modelRevenusFixes);                     
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus 
	    Runner.Stop(true);      
    }
}

function DeleteSubModel(model,subModel){
      //Supprimer  un sous-modele
      SearchModelByName(model);
      //Sélectionner le modèle 
      Get_ModelsGrid().Find("Value",model,10).Click();
      // chainer vers le module Portefeuille,
      Drag( Get_ModelsGrid().Find("Value",model,10), Get_ModulesBar_BtnPortfolio());
      WaitObject(Get_CroesusApp(), "Uid", "DataGrid_67cd");     
      //Supprimer le sous modèle 
      
      //Get_PortfolioPlugin().Find("Value",subModel,10).Click(); //Christophe : Stabilisation MiniRegression
      if ((!Get_PortfolioPlugin().Find("Value",subModel,10).Exists || !Get_PortfolioPlugin().Find("Value",subModel,10).Visible) && Get_PortfolioGrid_GrpSummary().IsExpanded){
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(false);
        Get_PortfolioPlugin().Find("Value",subModel,10).Click();
        Get_PortfolioGrid_GrpSummary().set_IsExpanded(true);
      }
      else {
          Get_PortfolioPlugin().Find("Value",subModel,10).Click();
      }
        
      Get_Toolbar_BtnDelete().Click();   
      if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation().Parent.Close();           
        var width =Get_DlgConfirmation().Get_Width();
        Get_DlgConfirmation().Click((width*(1/3)),73); 
      }    
      //sauvgarder les modification 
      Get_PortfolioBar_BtnSave().Click();
      Get_WinWhatIfSave_BtnOK().Click()
}