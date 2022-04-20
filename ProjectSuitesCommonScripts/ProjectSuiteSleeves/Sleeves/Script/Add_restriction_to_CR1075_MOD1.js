//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT CR1452_211_Rebalancing_Account
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel
//USEUNIT CR1452_264_BlockedRestriction
//USEUNIT CR1452_271_Rebalance_Account_WithInactiveModel

 /* Description : Fichier Excel 'Cas de test du CR1452 à automatiser'.

Analyste d'automatisation: Youlia Raisper */


function Add_restriction_to_CR1075_MOD1()
{
    try{             
        var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "GP1859", "username");  
        
        var modelCR1075_MOD1=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_MOD1", language+client);
        var security = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "Security_MSFT", language+client);
        var percentageOfTotalValueMin=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValueMSFTMin", language+client);
        var percentageOfTotalValueMax=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "PercentageOfTotalValueMSFTMAx", language+client);
           
        Login(vServerSleeves, user, psw, language);      
        Get_ModulesBar_BtnModels().Click();
        
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


        //Le changement de la BD dans AT  
        SearchModelByName("SUBSTITUT_MOD2");
        if(Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800245",10).Exists){
          Get_Models_Details_TabAssignedPortfolios_DgvAssignedPortfolios().Find("Value","800245",10).Click();
          Get_Models_Details_TabAssignedPortfolios_BtnRemove().Click();
          /*var width = Get_DlgCroesus().Get_Width();
            Get_DlgCroesus().Click((width*(1/3)),73);*/ //EM : Modifié depuis CO: 90-07-22-Be-1
            var width = Get_DlgConfirmation().Get_Width();
            Get_DlgConfirmation().Click((width*(1/3)),73);
        }
                
        SearchModelByName(modelCR1075_MOD1);           
        ActivateDeactivateModel(modelCR1075_MOD1,true)
        
        //ajouter une restriction 
        Get_ModelsBar_BtnRestrictions().Click();
        AddRestriction(security,percentageOfTotalValueMin,percentageOfTotalValueMax)
                             
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


