//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6030 
    Préconditions        :  PREF_TRADE_ACCOUNT_TYPES_EXCLUDED
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
*/


function CR2140_6030_SalesOrderWithAccountBlockedByThePref() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6030","Lien du Cas de test sur Testlink");
            
            //La pref est déjà activé dans CROES-6029
            Log.Message("La Pref est déja activée dans CROES-6029");
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account_6030 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account_6030", language+client);
            var msgInformation_6030 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgInformation_6029", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner le compte 800019-HU
            Search_Account(account_6030);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account_6030,10).Click();
            
            //Créer un ordre d'achat
            Get_Toolbar_BtnCreateASellOrder().Click();
            
            //Vérifier le message d'information affiché
            aqObject.CheckProperty( Get_DlgInformation_LblMessage(), "Text", cmpEqual,msgInformation_6030);
            Get_DlgInformation_BtnOK().Click();
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

function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}