//USEUNIT CR2140_common_functions

/** 
    Ce script regroupe les scripts: CR2140_6026, CR2140_6028, CR2140_6029, CR2140_6030, CR2140_6037
    
    Les Liens dans TestLink : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6026
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6028
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6029
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6030
                              https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6037
   
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
    Regroupé par : A.A Version ref90-19-2020-09-6 
*/


function CR2140_Combinated_MessagesValidation() {
         
      try {
            //Mettre la pref PREF_TRADE_ACCOUNT_TYPES_EXCLUDED = R, Y
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TRADE_ACCOUNT_TYPES_EXCLUDED", "R,Y", vServerOrders);
            //Mettre la pref PREF_GDO_VALIDATE_ASC_CODE = 2 ASC Code(FBN)  pour le USer utilisé (keyneJ) Cette pref est activé avec le Dump de FBN
            Activate_Inactivate_Pref("KEYNEJ", "PREF_GDO_VALIDATE_ASC_CODE", "2", vServerOrders);
                   
            //Redemarrer les services
            RestartServices(vServerOrders);  
                      
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var AccountNoCroes_6025  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "AccountNoCroes_6025", language+client);
            var msgConfirmation_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgConfirmation_6026", language+client);
            var inclureButton_6026   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "inclureButton_6026", language+client);
            var transactionType_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6026  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            var quantity_6026        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6026", language+client);
            var symbol_6026          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6026", language+client);
            var USDAccount_6026      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "USDaccount_6026", language+client);
            
            var account1_6028   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6028", language+client);
            var account2_6028   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6028", language+client);
            var msgWarning_6028 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning_6028", language+client);
          
            var account_6029        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account_6029", language+client);
            var msgInformation_6029 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgInformation_6029", language+client);
            
            var account_6030        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account_6030", language+client);
            var msgInformation_6030 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgInformation_6029", language+client);
            
            var account1_6037    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6037", language+client);
            var account2_6037    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6037", language+client);
            var msgWarning1_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning1_6037", language+client);
            var msgWarning2_6037 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgWarning2_6037", language+client);
      
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);

//6026      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étapes du script 6026");      
            //Aller au module compte et sélectionner 800280-RE
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);  
            Search_Account(AccountNoCroes_6025);
            Get_RelationshipsClientsAccountsGrid().Find("Value",AccountNoCroes_6025,10).Click();
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Vérifier le message de confirmation affiché
            aqObject.CheckProperty( Get_DlgConfirmation_LblMessage2(), "Text", cmpEqual,msgConfirmation_6026);
            Get_DlgConfirmation().FindChild(["ClrClassName","WPFControlText"],["Button",inclureButton_6026],10).Click();
        
            //Mettre Transaction à Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6026],10).Click();
        
            //Ajouter : 500 Unités par compte, symbole =MSFT
            AddABuyBySymbol(quantity_6026,cmbTransaction_6026,symbol_6026);
            
            //Valider que l'ordre d'achat du titre MSFT est ajouté
            CheckABuyInGrid(quantity_6026,symbol_6026);
           
            //Cliquer sur Générer
            Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
            Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
            Get_WinSwitchBlock_BtnGenerate().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            SetAutoTimeOut();
            if(Get_WinSwitchBlock().Exists){
               Get_WinSwitchBlock_BtnGenerate().Click(); 
               WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
            }
            RestoreAutoTimeOut();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
            //Vérifier dans l'accumulateur qu'une entrée est créée, No de compte = GP1859_USD
            CheckAccountInAccumulatorBySymbol(symbol_6026,USDAccount_6026);
            
            //valider le jira BNC-2333
            Log.Message("------- Valider le jira BNC-2333 -------------");
            Get_OrderAccumulator().Find("Value",USDAccount_6026,10).DblClick();
            WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
            aqObject.CheckProperty(Get_WinOrderDetail_CmbAccount(),"Text", cmpEqual, USDAccount_6026);
            Get_WinOrderDetail_BtnCancel().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
            
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(USDAccount_6026);
            
//6028      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6028");
                  
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
//6029      
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6029");
       
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
            //Selectionner le compte 800019-HU
            Search_Account(account_6029);
            Get_RelationshipsClientsAccountsGrid().Find("Value",account_6029,10).Click();
            
            //Créer un ordre d'achat
            Get_Toolbar_BtnCreateABuyOrder().Click();
            
            //Vérifier le message d'information affiché
            aqObject.CheckProperty( Get_DlgInformation_LblMessage(), "Text", cmpEqual,msgInformation_6029);
            Get_DlgInformation_BtnOK().Click();
//6030 
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6030");
                      
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
// 6037     
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape du script 6037");
                
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

 