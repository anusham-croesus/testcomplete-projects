//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6028 
    Préconditions        :  PREF_GDO_VALIDATE_ASC_CODE = ASC Code(FBN) soit 2 pour Keynej.
                            - tous les comptes ont un code de CP non discrétionnaires
                            - au moins, un compte UMA(800280-RE) assigné à un modele Ambassadeur
                            - au moins un compte a 1 ou 2 à la 3e position et 0 à la 12e position (800280-RE)
                            - au moins un compte a U à la 10e position (800230-RE)
 
                            Note :  ceci dit, les cas Croes-6025 et Croes-6027 sont déjà exécutés
    
    Description          :  Ordres multiples avec des Comptes non disc dont ASC 3e position=1 ou 2 et 12e position égale 0 et  autres comptes dont 10e position égale U. 
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
*/


function CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6028","Lien du Cas de test sur Testlink");
    
            /*
            //Mettre la pref PREF_GDO_VALIDATE_ASC_CODE = 2 ASC Code(FBN)  pour le USer utilisé (keyneJ) Cette pref est activé avec le Dump de FBN
            Activate_Inactivate_Pref("KEYNEJ", "PREF_GDO_VALIDATE_ASC_CODE", "2", vServerOrders);
                   
            //Redemarrer les services
            RestartServices(vServerOrders);
            */
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6028 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6028", language+client);
            var account2_6028 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6028", language+client);
            var msgConfirmation_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgConfirmation_6026", language+client);
            var inclureButton_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "inclureButton_6026", language+client);
            var msgWarning_6028 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning_6028", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000); 
            
            //Selectionner les comptes 800230-RE, 800280-RE
            SelectTwoAccounts(account1_6028,account2_6028);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Vérifier le message de confirmation affiché
            aqObject.CheckProperty( Get_DlgConfirmation_LblMessage2(), "Text", cmpEqual,msgConfirmation_6026);
            Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button",inclureButton_6026],10).Click();
            
            //Vérifier le message bloquant affiché
            aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Text", cmpEqual,msgWarning_6028);
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

function SelectTwoAccounts(account1,account2){
      Search_Account(account1);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(-1, -1, skCtrl);
      Search_Account(account2);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(-1, -1, skCtrl); 
}

function Get_DlgWarning_LblMessage(){return Get_DlgWarning().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}
 