//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA


 /* Description : 
Analyste d'automatisation: Youlia Raisper */


function Deleting_Test_Restriction_model()
{
    try{             
       var modelName=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR1452", "ModelTestRestriction", language+client);
       DeleteModel(modelName); 
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));

    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
    }
}

function DeleteModel(modelName)
{
      var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "UNI00", "username");          
      Login(vServerSleeves, user, psw, language);      
      DeleteModelByName(modelName)                                     
      //Fermer l'application
      Close_Croesus_MenuBar();
      if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      }
} 
