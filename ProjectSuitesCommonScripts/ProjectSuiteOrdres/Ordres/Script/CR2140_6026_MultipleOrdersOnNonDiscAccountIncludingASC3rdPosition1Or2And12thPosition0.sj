//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    CR                   :  2140
    TestLink             :  Croes-6026 
    Préconditions        :  PREF_GDO_VALIDATE_ASC_CODE = ASC Code(FBN) soit 2 pour Keynej.
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.10-7
    Date                 :  26/02/2019
    
*/


function CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6026","Lien du Cas de test sur Testlink");
    
            //Mettre la pref PREF_GDO_VALIDATE_ASC_CODE = 2 ASC Code(FBN)  pour le USer utilisé (keyneJ) Cette pref est activé avec le Dump de FBN
            Activate_Inactivate_Pref("KEYNEJ", "PREF_GDO_VALIDATE_ASC_CODE", "2", vServerOrders);
            
            //Redemarrer les services
            RestartServices(vServerOrders);
            
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var AccountNoCroes_6025 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "AccountNoCroes_6025", language+client);
            var msgConfirmation_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "msgConfirmation_6026", language+client);
            var inclureButton_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "inclureButton_6026", language+client);
            var transactionType_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "transactionType_6026", language+client);
            var cmbTransaction_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "cmbTransaction_6026", language+client);
            var quantity_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "quantity_6026", language+client);
            var symbol_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "symbol_6026", language+client);
            var USDAccount_6026 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2140", "USDaccount_6026", language+client);
            
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
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
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
      }
      finally {
            //Supprimer l'ordre généré
            Log.m
            DeleteOrderInAcumulator(USDAccount_6026);
            
            //Fermer l'application
            Terminate_CroesusProcess();
            Terminate_IEProcess();                 
        }
}

 function AddABuyBySymbol(quantity,cmbTransaction,symbol){
            Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
            
            //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
            Get_WinSwitchSource_CmbSecurity().Click();
            Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
            
            Get_WinSwitchSource_TxtQuantity().Keys(quantity);
            Get_WinSwitchSource_CmbQuantity().Click();
            Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransaction],10).Click();
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
            Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
            Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
            if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",symbol,10).DblClick();
            }
            Get_WinSwitchSource_btnOK().Click();
            WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
 }
 
 function CheckABuyInGrid(quantity,symbol){
        if (language == "french") var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Achat", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            else var item = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Buy", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(0);
            aqObject.CheckProperty(item.DataItem, "Quantity", cmpEqual,quantity);
            aqObject.CheckProperty(item.DataItem, "SymbolDisplay", cmpEqual,symbol);
 }
 
 function CheckAccountInAccumulatorBySymbol(symbol,USDAccount){
        var NbrItem = Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Count;
            var find = false;
            for (i=0;i<NbrItem;i++)
            {
              Get_OrderAccumulator().FindChild(["ClrClassName","XamTextEditor"],["Text",symbol],10);
              find = true;
              break;
            }
            if (find) 
            {
              Log.Message("Valider que le No de compte = " +USDAccount);
              aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(i).DataItem,"AccountNumber",cmpEqual,USDAccount);
            }else
              Log.Error("L'ordre n'existe pas dans l'accumulateur");  
 }