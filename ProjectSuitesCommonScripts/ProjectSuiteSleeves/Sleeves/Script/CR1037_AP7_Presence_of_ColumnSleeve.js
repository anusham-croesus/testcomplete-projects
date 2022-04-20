//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT CR1037_AP1_AP4_NonPresence_of_ColumnSleeve
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP7_Presence_of_ColumnSleeve()
{
      try{   
          
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");

          //var account= GetData(filePath_Sleeves, "DataPool_WithoutModel", 3);              
          var sleeveItem=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "sleeveItem_AP1_AP4", language+client); 
         
          Login(vServerSleeves, user ,psw,language);
          Get_ModulesBar_BtnAccounts().Click();
                          
          //Verification
          if(CheckNonPresenceOfColumnToAdd(sleeveItem)){
            Log.Checkpoint("L'item "+sleeveItem+" est présent")
          }
          else{
            Log.Error("L'item "+sleeveItem+" n'est pas présent")
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
