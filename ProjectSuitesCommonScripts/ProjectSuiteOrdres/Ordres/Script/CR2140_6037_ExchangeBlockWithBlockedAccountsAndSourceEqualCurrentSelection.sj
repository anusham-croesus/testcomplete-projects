//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6037 
    Description          :  Échange/bloc avec des comptes de types bloqués et source égale selection courante.
    Préconditions        :  PREF_TRADE_ACCOUNT_TYPES_EXCLUDED
                            PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
                            Aucun critere de recherche n'est actif
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  28/02/2019
    
*/


function CR2140_6037_ExchangeBlockWithBlockedAccountsAndSourceEqualCurrentSelection() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6037","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6037", language+client);
            var msgWarning1_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6037", language+client);
            var msgWarning2_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning2_6037", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner les comptes 800019-HU, 800022-HU
            SelectTwoAccounts(account1_6037,account2_6037);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Vérifier le 1er message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning1_6037);
            Get_DlgWarning().Keys("[Enter]");
            
            //Vérifier le 2eme message d'avertissement affiché
            aqObject.CheckProperty( Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning2_6037);
            Get_DlgWarning().Keys("[Enter]");
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

