//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA

/*   
//https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6281

Analyste d'assurance qualité: Mamoudou Diaby
Analyste d'automatisation: Alhassane Diallo */ 

 function CR2080_Croes_6281_Extract_IF_PREF_TRADE_ALLOCATION_EXTRACT_5()
 {             
    try{  
      
    
           //Mettre la pref PREF_TRADE_ALLOCATION_EXTRACT = 5 
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_TRADE_ALLOCATION_EXTRACT","5",vServerOrders);
         
         
           //Redemarrer les service
           RestartServices(vServerOrders);
    
           //Lien de la story dans Jira
           Log.Link("//https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6281"," Lien du Cas de test sur Testlink");
    
           //Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
       
           var account800216OB       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Account800216OB", language+client);
           var quantity_1700         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Quantity_1", language+client);
           var securitySymbolMMM     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "SecurityMMM", language+client);
           var statusPending_1       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Status_1", language+client);
           var statusOpen_2          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Status_2", language+client);
           var statusExecuted_3      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Status_3", language+client);
           var priceBuyMMM           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Price6281", language+client);
           var bourse                = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "Bourse6821", language+client);
           var typeBuy               = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "TypeBuy", language+client);
         
//Étape1
     
           //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_MainWindow().Maximize();           
      
            //Créer un ordre d'achat security='MMM', quantité = 1700, accountNo = '800216-OB'
            Log.Message("Créer un ordre d'achat security='MMM', quantité = 1700, accountNo = '800216-OB'");
            
            //Acceder au Module Compte 
            Log.Message("Acceder au Module Compte");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
            
            //Selectionner le compte 800216-OB
            Log.Message("Selectionner le compte 800216-OB");
            SearchAccount(account800216OB);
                        
            //Ajouter un ordre d'achat (Action)
            Log.Message("Ajouter un ordre d'achat (Action)");
            Get_Toolbar_BtnCreateABuyOrder().Click();
            Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Saisir comme quantité = 1700 et Selectionner le titre MMM
            Log.Message("Saisir comme quantité = 1700 et Selectionner le titre MMM");
            Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity_1700)
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
            Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(securitySymbolMMM)
            Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
            Get_WinOrderDetail_BtnSave().Click();

//Étape 2            
              //Aller dans l'accumulateur, selectionner l'ordre créé puis cliquer sur Verifier
            Log.Message("Aller dans l'accumulateur, selectionner l'ordre créé puis cliquer sur Verifier");
            var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
            for(var i = 0; i<nbr; i++) {
               if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbolMMM 
                  && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity_1700
                  && Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.Type == typeBuy){
                    var pos = i+1;
                                       
                }                
            
            }
                        
            
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", pos).Click();           
            Get_OrderAccumulator_BtnVerify().Click();
           
            
            //Cocher la case inclure puis soumettre l'ordre
            Log.Message("Cocher la case inclure puis soumettre l'ordre");
            var width=Get_WinAccumulator().get_ActualWidth()
            var height=Get_WinAccumulator().get_ActualHeight()
            Get_WinAccumulator().Click(width/25,height-335);
            //Get_WinAccumulator().FindChild("Uid", "IncludedKey", 10).WPFObject("XamCheckEditor", "", 1).set_IsChecked(true);//Coche la case a causée mais n'active pas le bouton soumettre
            Get_WinAccumulator_BtnSubmit().Click();
            WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true); 
            
           
            //Valider L'ordre se dépace dans le Blotter et obtient le statut En approbation
            Log.Message("Valider L'ordre se dépace dans le Blotter et obtient le statut En approbation");
            var nbr = Get_OrderGrid().RecordListControl.Items.Count;
            for(var i = 0; i<nbr; i++) {
                if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbolMMM 
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity_1700
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Type == typeBuy){
                   aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statusPending_1);
                }                          
            }  
//Étape 3 
            
            //Aller dans la section du haut (Blotter), sélectionner l'ordre de MMM  puis cliquer sur Consulter et Aprrouver.
           Log.Message("Aller dans la section du haut (Blotter), sélectionner l'ordre de MMM  puis cliquer sur Consulter et Aprrouver.");
           var nbr = Get_OrderGrid().RecordListControl.Items.Count;
           for(var i = 0; i<nbr; i++) {
              if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbolMMM 
                  && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity_1700
                  && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Type == typeBuy){
                    var pos = i+1;
                                       
                }                
           }
            
           Get_OrderGrid().RecordListControl.WPFObject("DataRecordPresenter", "", pos).Click();
           Get_OrdersBar_BtnView().Click();
           Get_WinOrderDetail_BtnApprove().Click();
           
           //Valider que l'ordre obtient le statut Ouvert
           Log.Message("Valider que l'ordre obtient le statut Ouvert");
           var nbr = Get_OrderGrid().RecordListControl.Items.Count;
            for(var i = 0; i<nbr; i++) {
                if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbolMMM 
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity_1700
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Type == typeBuy){
                   aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statusOpen_2)
                }                          
            }               
         
          
//Étape4   
         
          //Sélectionner l`ordre sur MMM et cliquer sur Exécutions 
          Log.Message("Sélectionner l`ordre sur MMM et cliquer sur Exécutions");
          Get_OrdersBar_BtnFills().Click();
         
          //Dans la section Exécutions cliquer sur Ajouter : quantité = 1700, prix = 60, Bourse = NU - New York puis sauvegarder
          Log.Message("Dans la section Exécutions cliquer sur Ajouter : quantité = 1700, prix = 60, Bourse = NU - New York puis sauvegarder");
          Get_WinOrderFills_GrpFills_BtnAdd().Click();
         
         //Saisir la quantité le prix et selectionner la bourse
          Log.Message("Saisir la quantité, le prix et selectionner la bourse");
          Get_WinAddOrderFill_TxtQuantity().Keys(quantity_1700);
          Get_WinAddOrderFill_TxtClientPrice().Keys(priceBuyMMM);
          Get_WinAddOrderFill_CmbMarket().Click();
          if(Get_SubMenus().Exists)
          Get_SubMenus().Find("Text",bourse,10).Click();          
          Get_WinAddOrderFill_BtnOK().Click();
          Get_WinOrderFills_BtnSave().Click();  
          
          
          //Valider que l'ordre obtient le statut Éxécuté
           Log.Message("Valider que l'ordre obtient le statut Éxécuté");
           var nbr = Get_OrderGrid().RecordListControl.Items.Count;
            for(var i = 0; i<nbr; i++) {
                if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == securitySymbolMMM 
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity_1700
                   && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Type == typeBuy){
                   aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,statusExecuted_3);
                }                          
            }          
         
//Étape 5            
          
           //se connecter au Vserver en SSH(root, qa) et exécuter la commande:
           Log.Message("se connecter au Vserver en SSH(root, qa) et exécuter la commande:");
           ExecuteSSHCommandCFLoader("CR2080", vServerOrders, "cfLoader -PhaseOneGenerator -Firm=FIRM_1", "alhassaned");
           
           
           var vserverCommand = vServerOrders;
           var resultServerFilePath = "/home/alhassaned"+generatedFileName;
            //Copier le fichier en local
           Log.Message("-- Copy Result File From Vserver.")   
           if (!CopyFileFromVserverThroughWinSCP(vserverCommand, resultServerFilePath, resultLocalFilePath))
              Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand3);
     

         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
      Terminate_CroesusProcess(); //Fermer Croesus
       
    }
 }
 

