//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6027 
    Préconditions        :  PREF_GDO_VALIDATE_ASC_CODE = ASC Code(FBN) soit 2 pour Keynej.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  27/02/2019
    
*/


function CR2140_6027_MultipleOrdersOnNonDiscAccountsIncludingASC10thPositionIsU() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6027","Lien du Cas de test sur Testlink");
    
            /*
            //Mettre la pref PREF_GDO_VALIDATE_ASC_CODE = 2 ASC Code(FBN)  pour le USer utilisé (keyneJ) Cette pref est activé avec le Dump de FBN
            Activate_Inactivate_Pref("KEYNEJ", "PREF_GDO_VALIDATE_ASC_CODE", "2", vServerOrders);
            
            //valider que les comptes en gestion unifiés(UMA et GP1859) sont configurés dans B_GDO_AVGCOST_ACCOUNT. exécuter la requête :  
            //select * from b_gdo_avgcost_account where CODE_TYPE  = 'A'

            //sinon,  insérer les comptes inventaires
            Execute_SQLQuery("insert into dbo.B_GDO_AVGCOST_ACCOUNT ( CODE_TYPE, CODE, REP_ID, CURRENCY, ACCOUNT_NUMBER ) values ( 'A', 'GP1859', -1, 'CAD', 'GP1859_CAD' )", vServerOrders);
            Execute_SQLQuery("insert into dbo.B_GDO_AVGCOST_ACCOUNT ( CODE_TYPE, CODE, REP_ID, CURRENCY, ACCOUNT_NUMBER ) values ( 'A', 'GP1859', -1, 'USD', 'GP1859_USD' ) ", vServerOrders);
            Execute_SQLQuery("insert into dbo.B_GDO_AVGCOST_ACCOUNT ( CODE_TYPE, CODE,REP_ID, CURRENCY, ACCOUNT_NUMBER ) values ( 'A', 'UMA', -1, 'CAD', 'UMA_CAD' )", vServerOrders);
            Execute_SQLQuery("insert into dbo.B_GDO_AVGCOST_ACCOUNT ( CODE_TYPE, CODE, REP_ID, CURRENCY, ACCOUNT_NUMBER ) values ( 'A', 'UMA',-1,  'USD', 'UMA_USD' )", vServerOrders);

            //valider ques ces 3 comptes 800216-OB , 800230-FS , 800230-RE ont U à la 10e position du chmaps type2, exécuter la requête suivante: 
            //Select no_compte, type2 from b_compte  where no_compte in ('800216-OB', '800230-FS', '800230-RE')

            //sinon, exécuter ses requêtes :
            Execute_SQLQuery("update b_compte set TYPE2='112577689U07' where NO_COMPTE = '800216-OB'", vServerOrders);
            Execute_SQLQuery("update b_compte set TYPE2='111577689U07' where NO_COMPTE = '800230-FS'", vServerOrders);
            Execute_SQLQuery("update b_compte set TYPE2='114577689U09' where NO_COMPTE = '800230-RE'", vServerOrders);
                   
            //Redemarrer les services
            RestartServices(vServerOrders);
            */
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var account1_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account1_6027", language+client);
            var account2_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account2_6027", language+client);
            var account3_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "account3_6027", language+client);
            var transactionType_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6027", language+client);
            var quantity_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6027", language+client);
            var symbol_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6027", language+client);
            var USDAccount_6027 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "USDAccount_6027", language+client);
            
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Aller au module compte 
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000); 
            
            //Selectionner les comptes 800216-OB, 800230-FS, 800230-RE
            SelectThreeAccounts(account1_6027,account2_6027,account3_6027);
            
            //Acceder à Ordres multiples
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            //Mettre Transaction à Achat
            Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",transactionType_6026],10).Click();
        
            //Ajouter : 400 $ par compte (devise du compte), symbole =MAN
            AddABuyBySymbol(quantity_6027,cmbTransaction_6027,symbol_6027)
            
            //Valider que l'ordre d'achat du titre MAN est ajouté
            CheckABuyInGrid(quantity_6027,symbol_6027)
            
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
            CheckAccountInAccumulatorBySymbol(symbol_6027,USDAccount_6027);
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            DeleteOrderInAcumulator(USDAccount_6027);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

function SelectThreeAccounts(account1,account2,account3){
      Search_Account(account1);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account1,10).Click(-1, -1, skCtrl);
      Search_Account(account2);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account2,10).Click(-1, -1, skCtrl);
      Search_Account(account3);
      Get_RelationshipsClientsAccountsGrid().Find("Value",account3,10).Click(-1, -1, skCtrl);
}
 