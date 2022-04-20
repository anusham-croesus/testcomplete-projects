//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Comptes_Get_functions
//USEUNIT CR1037_AP2_AP5_NonPresence_of_TabSleeve
//USEUNIT DBA
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */

function CR1037_AP8_Presence_of_TabSleeve()
{
      try{  
       
          var user=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "LOTHC", "username");
                      
          var tabDescription=ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CreationOfSleeves", "itemSleeves_AP3_AP6", language+client); 
          var account= GetData(filePath_Sleeves, "DataPool_WithoutModel", 3); 
          
          Login(vServerSleeves, user ,psw,language);
          Get_ModulesBar_BtnAccounts().Click();
                  
          //Valider la présence des segments         
          Get_ModulesBar_BtnAccounts().Click();         
          Search_Account(account);
          Get_AccountsBar_BtnInfo().Click();
         
          //Verification
          if(CheckNonPresenceOfTab(Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1) ,tabDescription)){
              Log.Checkpoint("L'onglet "+tabDescription+" est présent")
          }
          else{
              Log.Error("L'onglet "+tabDescription+" n'est pas présent")
          }
         
          Get_WinDetailedInfo().Close();
                 
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

