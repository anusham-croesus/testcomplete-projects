//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Ordres_Get_functions
//////USEUNIT Global_variables



/* Le but de ce cas est de conserver le changement de bourse dans l'ordre dasn l'onglet Historique sous Message.

    CTVE-610
 
    Analyste d'assurance qualité: Carole T.
    Analyste d'automatisation: Alhassane Diallo.
    ref 90.15.86 */ 
 
 function GDO_TCVE610_ValidateMessage_from_OrderLog()
 {             
    try{  
           
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-610","Lien de la story dans Jira");
    
           //Declaration des Variables
           var userNameKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ         = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");          
           var account800300NA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_800300NA", language+client);
           var quantity               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_100", language+client);
           var securitySymbol         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_RY", language+client);
           var exchangeNameTSE        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ExchangeName_TSE", language+client);
           var exchangeNameNYS        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ExchangeName_NYS", language+client);
           var validateMessageTSE     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Validate_Message_TSE", language+client);
           var validateMessageNYS_1   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Validate_Message_NYS_1", language+client); 
           var validateMessageNYS_2   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Validate_Message_NYS_2", language+client);   
//Étape1
     
           //Se connecter à croesus avec Keynej
           Log.Message("Se connecter à croesus avec Keynej");
           Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
           Get_MainWindow().Maximize();           
      
            //Créer un ordre d'achat security='RY', quantité = 100, accountNo = '800300-NA'
            Log.Message("Créer un ordre d'achat security='RY', quantité = 100, accountNo = '800300-NA'");
            
            //Acceder au Module Compte
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner le compte 800300-NA
            Log.Message("Selectionner le compte 800300-NA");
            SearchAccount(account800300NA);
            
            //Selectionner le compte 80030-NA
            Log.Message("Selectionner le compte 80030-NA");
            SearchAccount(account800300NA);
                        
            //Ajouter un ordre d'achat (Action)
            Log.Message("Ajouter un ordre d'achat (Action)");
            Get_Toolbar_BtnCreateABuyOrder().Click();
            Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
//Étappe2

            //Selectionner security='RY'dont la bourse est TSE, quantité = 100, 
            Log.Message("Selectionner security='RY'dont la bourse est TSE, quantité = 100")
            Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
            if (Trim(VarToStr(securitySymbol))!== ""){  
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(securitySymbol);
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
            }
            if(Get_SubMenus().Exists){  
            Aliases.CroesusApp.subMenus.Find("Value",securitySymbol,10).DblClick();
            }
            Get_WinOrderDetail_BtnSave().Click();

//Étape3            
            //Aller dans l'accumulateur, selectionner l'ordre créé puis cliquer sur modifier
            Log.Message("Aller dans l'accumulateur, selectionner l'ordre créé puis cliquer sur modifier");
            var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
            for(var i = 0; i<nbr; i++) {
               if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbol 
                  && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.ExchangeName == exchangeNameTSE){
                    pos = i+1;
                                       
                }                
            
            }
                        
            
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", pos).Click()
           
            Get_OrderAccumulator_BtnEdit().Click();
            Get_WinOrderDetail_TabOrderLog().Click();  
//Étape4        
            //- Aller dans l'onglet Historique 2ième ligne  valider le message
             Log.Message("Aller dans l'onglet Historique 2ième ligne  valider le message");
             aqObject.CheckProperty(Get_WinOrderDetail_OrdersLogGrid().Items.Item(1).DataItem, "Message", cmpEqual,validateMessageTSE);  
                                   
// Étape5

             Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
             if(Get_SubMenus().Exists){  
              Aliases.CroesusApp.subMenus.Find("Value",exchangeNameNYS,10).DblClick();
              }                 
               
              Get_WinOrderDetail_BtnSave().Click();      
              
              
              Log.Message("Aller dans l'accumulateur, selectionner l'ordre créé puis cliquer sur modifier");
              var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
              for(var i = 0; i<nbr; i++) {
                 if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbol 
                    && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.ExchangeName == exchangeNameNYS){
                     pos = i+1;
                                       
                   }                
            
             }
                        
             
             Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", pos).Click();
             Get_OrderAccumulator_BtnEdit().Click();
             Get_WinOrderDetail_TabOrderLog().Click();
             
             
             //- Aller dans l'onglet Historique 1 ere ligne  valider le message
             Log.Message("Aller dans l'onglet Historique 1 ere ligne  valider le message");
    /*         var message = Get_WinOrderDetail_OrdersLogGrid().Items.Item(0).DataItem.Message 
             Log.Message(message)
             
             var messNYS1 = aqString.SubString(message, 0, 22)
             var messNYS2 = aqString.SubString(message, 25, 72)
             var MessageActuel = aqString.Concat(messNYS1, messNYS2)            
             CheckEquals(MessageActuel, validateMessageNYS);
     */      
             //Modifier par A.A TCVE-4638   
             aqObject.CheckProperty(Get_WinOrderDetail_OrdersLogGrid().Items.Item(0).DataItem, "Message", cmpContains, validateMessageNYS_1);  
             aqObject.CheckProperty(Get_WinOrderDetail_OrdersLogGrid().Items.Item(0).DataItem, "Message", cmpContains, validateMessageNYS_2);
             
             Get_WinOrderDetail_BtnCancel().Click();
           
    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally { 
      
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation_BtnDelete().Click();
            Terminate_CroesusProcess(); //Fermer Croesus
    }
 }
 
function  Get_WinOrderDetail_OrdersLogGrid(){return Get_WinOrderDetail().WPFObject("_tabControl").WPFObject("_activities").WPFObject("_orderLogGrid").WPFObject("RecordListControl", "", 1)};


