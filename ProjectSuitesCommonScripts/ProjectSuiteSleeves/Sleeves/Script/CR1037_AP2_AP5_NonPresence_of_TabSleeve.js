//USEUNIT Common_functions
//USEUNIT Comptes_Get_functions
//USEUNIT Common_Get_functions
//USEUNIT EnvironmentPreparation_CR1037_WithoutModel
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT DBA

 /* Description : Fichier Excel CR1037 Cas de tests auto sleeve_vs2.

Analyste d'automatisation: Youlia Raisper */


function CR1037_AP2_AP5_NonPresence_of_TabSleeve()
{
      try{   
      
         Log.Message("****************Le cas AP2 avec FERMIE*****************")
         var user1=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "FERMIE", "username");
         var account1= GetData(filePath_Sleeves, "DataPool_WithoutModel", 6);   
         NonPresence_of_TabSleeve(user1,account1)
         
         Log.Message("****************Le cas AP5 avec JEFFET*****************")
         var user2=ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "JEFFET", "username");
         var account2= GetData(filePath_Sleeves, "DataPool_WithoutModel", 5);   
         NonPresence_of_TabSleeve(user2,account2)         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Débloquer le rééquilibrage
        Execute_SQLQuery("update b_compte set lock_id = null", vServerSleeves) 
    }
    finally {    
      Terminate_CroesusProcess(); //Fermer Croesus
      Activate_Inactivate_Pref(user1,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
      Activate_Inactivate_Pref(user2,"PREF_ENABLE_SLEEVES","YES",vServerSleeves);
    }
}

//Le script
function NonPresence_of_TabSleeve(user,account)
{
    Activate_Inactivate_Pref(user,"PREF_ENABLE_SLEEVES","NO",vServerSleeves);
                      
    var tabDescription=GetData(filePath_Sleeves, "CreationOfSleeves", 123, language);
         
    Login(vServerSleeves, user ,psw,language);
    Get_ModulesBar_BtnAccounts().Click();
                  
    //Valider la présence des segments         
    Get_ModulesBar_BtnAccounts().Click();         
    Search_Account(account);
    Get_AccountsBar_BtnInfo().Click();
         
    //Verification
    if(CheckNonPresenceOfTab(Get_WinDetailedInfo().WPFObject("ClassicTabControl", "", 1) ,tabDescription)){
      Log.Error("L'onglet "+tabDescription+" est présent")
    }
    else{
      Log.Checkpoint("L'onglet "+tabDescription+" n'est pas présent")
    }
         
    Get_WinDetailedInfo().Close();
         
    //Fermer l'application
    Close_Croesus_MenuBar(); 
}

