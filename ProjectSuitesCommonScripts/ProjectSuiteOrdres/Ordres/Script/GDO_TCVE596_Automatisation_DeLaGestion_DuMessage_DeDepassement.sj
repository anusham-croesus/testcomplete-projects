//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Ordres_Get_functions
//////USEUNIT Global_variables



/* Description : Automatisation de la gestion du message lors d'un dépassement de 100% d'un vente en bloc

    CTVE-596
 
    Analyste d'assurance qualité: Carole T.
    Analyste d'automatisation: Amine A.
    ref 90.15.86 */ 
 
 function GDO_TCVE596_Automatisation_DeLaGestion_DuMessage_DeDepassement()
 {             
    try{  
                var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
                var accountNo      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE_596_Account_800300", language+client);
                var quantity100    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE_596_Quantity_100", language+client);
                var quantity110    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE_596_Quantity_110", language+client);
                var securitySymbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE_596_SecuritySymbol_MSFT", language+client); 
                var dlgMessage     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "TCVE_596_Message", language+client);
        
                //Se connecter à croesus avec Keynej
                Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);            
                
                //Aller au module Comptes et cliquer le compte 800300-NA
                Get_ModulesBar_BtnAccounts().Click();
                Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 3000);
            
                SearchAccount(accountNo);  
                Get_RelationshipsClientsAccountsGrid().FindChild("Value", accountNo, 10).Click();  
                      
                //cliquer sur Ordres multiples en bloc 
                Log.Message("cliquer sur Ordres multiples en bloc ");  
                Get_Toolbar_BtnSwitchBlock().Click();
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
                //Ajout d'une transaction: Vente  
                Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");

                Get_WinSwitchSource_TxtQuantity().Keys(quantity100);                    
                Get_WinSwitchSource_CmbSecurity().set_IsDropDownOpen(true);
                Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ShortDefinition"], ["ComboBoxItem", "Symb."], 10).Click();
                Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbol);
                Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
                    
                Get_WinSwitchSource_btnOK().Click();
                
                //Valider que la transaction est ajoutée et visible
                var count =   Get_WinSwitchBlock_GrpTransactions().WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Count;
                aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions().WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(count-1).DataItem,"SymbolDisplay",cmpEqual,securitySymbol);
                aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions().WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).FindChild("Value", securitySymbol, 10),"VisibleOnScreen",cmpEqual,true);
                aqObject.CheckProperty(Get_WinSwitchBlock_GrpTransactions().WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1).Items.Item(count-1).DataItem,"Quantity",cmpEqual,quantity100);
                
                //Editer la transaction pour mettre la quantité à 110%
                Get_WinSwitchBlock_GrpTransactions_BtnEdit().Click();
                WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
                Get_WinSwitchSource_TxtQuantity().Keys(quantity110);
                Get_WinSwitchSource_btnOK().Click(); 
            
                //Valider le message 
                aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "DataContext", cmpEqual, dlgMessage);   
                
                //Annuler la transaction
                Get_DlgConfirmation_Btncancel().Click();
                Get_WinSwitchSource_btnCancel().Click();         
                Get_WinSwitchBlock_BtnCancel().Click();
            
                //Ajout d'une transaction Vente avec quantité = 110%
                Get_Toolbar_BtnSwitchBlock().Click();
                WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
                Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");

                Get_WinSwitchSource_TxtQuantity().Keys(quantity110);                    
                Get_WinSwitchSource_CmbSecurity().set_IsDropDownOpen(true);
                Get_CroesusApp().FindChild(["ClrClassName", "DataContext.ShortDefinition"], ["ComboBoxItem", "Symb."], 10).Click();
                Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securitySymbol);
                Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");   
                               
                Get_WinSwitchSource_btnOK().Click();
                
                //Valider le message     
                aqObject.CheckProperty(Get_DlgConfirmation_LblMessage1(), "DataContext", cmpEqual, dlgMessage);
  
                //Annuler la transaction  
                Get_DlgConfirmation_Btncancel().Click();
                Get_WinSwitchSource_btnCancel().Click();
                Get_WinSwitchBlock_BtnCancel().Click();
            
                      

    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
            Terminate_CroesusProcess(); //Fermer Croesus
    }
 }