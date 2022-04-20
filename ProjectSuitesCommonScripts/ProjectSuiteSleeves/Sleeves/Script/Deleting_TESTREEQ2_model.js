//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA
//USEUNIT Deleting_Test_Restriction_model

 /* Description : 
Analyste d'automatisation: Youlia Raisper */


function Deleting_TESTREEQ2_model()
{
    try{             
        var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelCR1075_TESTREEQ2", language+client);
        DeleteModel(modelName)              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}
