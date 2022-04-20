//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR1483_Tran_Common_Functions


/*
  Description : Vérifier qu'après la modification de la pref "Pref_max_workas_elements" à une valeur et essayer de selectionner un nombre de succursales 
  plus grand que la valeur de la pref on reçoit un message d'erreur.
  
  Regrouper les scripts suivants:  
  CR1483_Tran_CheckErrorMsgPrefMaxWorkAs_TabUsers
  CR1483_Tran_CheckErrorMsgPrefMaxWorkAs_TabIACodes
  CR1483_Tran_CheckErrorMsgPrefMaxWorkAs
   
  
  Analyste d'assurance qualité : Karima Me
  Analyste d'automatisation    : Philippe Maurice 
  Version de scriptage         : ref90.22.2020.12-56
*/


function CR1483_Opti_Tran_CheckErrorMsgPrefMaxWorkAs() 
{
    //lien pour TestLink
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3358","Lien du Cas de test sur Testlink");

    try
    {
        var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
        var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");
      
        //Mettre la pref "PREF_MAX_WORKAS_ELEMENTS" à la valeur 4
        Log.Message("Activation de la pred PREF_MAX_WORKAS_ELEMENTS");
        Activate_Inactivate_PrefFirm("FIRM_1", "PREF_MAX_WORKAS_ELEMENTS", "4", vServerTransactions);
        RestartServices(vServerTransactions);
           
        Login(vServerTransactions, userNameUNI00, passwordUNI00, language);
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        WaitObject(Get_CroesusApp(),"Uid", "FixedColumnListView_1b3e");
    
    
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        Log.Message("Branch Tab");
        CR1483_CheckErrorMsgPrefMaxWorkAs(vServerTransactions, Get_ModulesBar_BtnTransactions(), "Branches",filePath_Transactions,"CR1483_WinSelection_TabBranches_ErrorMsg");  
            
        //Appel à la fonction Commune dans CR1483_Common_Functions
        Log.Message("IA Code Tab");
        CR1483_CheckErrorMsgPrefMaxWorkAs(vServerTransactions ,Get_ModulesBar_BtnTransactions(),"IACodes",filePath_Transactions,"CR1483_WinSelection_TabIACodes_ErrorMsg" ); 
        
        //Appel à la fonction Commune dans CR1483_Commun_Functions
        Log.Message("Users Tab");
        CR1483_CheckErrorMsgPrefMaxWorkAs(vServerTransactions ,Get_ModulesBar_BtnTransactions(),"Users",filePath_Transactions,"CR1483_WinSelection_TabUsers_ErrorMsg" );   
        
    }
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
    }        
    finally {         
        // Close Croesus 
        Terminate_CroesusProcess();
        Terminate_IEProcess();
                    
        //Remise de la pref par défaut
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_MAX_WORKAS_ELEMENTS","30",vServerTransactions);
        RestartServices(vServerTransactions);
    }
}
