//USEUNIT CR2309_Common_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT Ordres_Get_functions
//USEUNIT DBA

/* https://jira.croesus.com/browse/TCVE-1179

Analyste d'assurance qualité: Karima M
Analyste d'automatisation: Alhassane Diallo */ 

 function CR2309_TCVE1179_ConsultationOrder_HavingMultipleREP_ID_And_ValidatePositions_InThe_Intraday()
 {             
    try{  
    
           
          
           
           //Mettre la pref PREF_INTRADAY_ENABLED = 2 
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_ENABLED","2",vServerOrders);
           Activate_Inactivate_PrefFirm("FIRM_1","PREF_INTRADAY_STATUS","10,20,40,50,70,72,130,160",vServerOrders);
           
            //Executer le fichier SQL
           ExecuteSQLFile(folderPath_Data + "ordres_CP_new.sql", vServerOrders)
           ExecuteSQLFile(folderPath_Data + "tcve2309.sql", vServerOrders)
          
         
           //Redemarrer les service
           RestartServices(vServerOrders);
    
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1179"," Lien du Cas de test sur Jira"); 
           
           
           //Variables
           var userNameUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
           var passwordUNI00  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw"); 

           var userNameLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "username");
           var passwordLINCOA  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "LINCOA", "psw"); 
           
           var userNameCOPERN  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
           var passwordCOPERN  = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw"); 
           
           
           var account300014NA   = "300014-NA" //ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "Account300014NA", language+client);
           var account800002NA   = "800002-NA" //ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "Account800002NA", language+client);
           var account800001OB   = "800001-OB" //ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "Account800001OB", language+client);      
           var orderNo_1         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_1", language+client);
           var orderNo_2         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_2", language+client);
           var orderNo_3         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_3", language+client); 
           var orderNo_4         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_4", language+client);
           var orderNo_5         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_5", language+client);
           var orderNo_6         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_6", language+client); 
           var orderNo_7         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_7", language+client);
           var orderNo_8         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "OrderNum_8", language+client);
           var quantityNA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "QuantityNA", language+client);
           var symbolNA          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2309", "SecuritySymbolNA", language+client);

         
//Étape1
Log.Message( "***************Étape1****************"); 
           //Se connecter à croesus avec UNI0
            Log.Message("Se connecter à croesus avec UNI00");
            Login(vServerOrders, userNameUNI00, passwordUNI00, language);
            Get_MainWindow().Maximize();           
      
            
            
            //Acceder au Module Ordres
            Log.Message("Acceder au Module Ordres");
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
            
            
            
            //Aller dans l'Accumulateur et click droit pour ajouter la colonne numéro d'ordre 
             addColumn_ChOrderNo();
           
            //Valider que les ordres de 10001 a 10008 sont visible 
            Log.Message("Valider que les ordres de 10001 a 10008 sont visible");
            Get_OrderAccumulatorGrid_ChOrderNo().Click();
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd", maxWaitTime);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderId", cmpEqual,orderNo_1);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderId", cmpEqual,orderNo_2);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "OrderId", cmpEqual,orderNo_3);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "OrderId", cmpEqual,orderNo_4);  
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(4).DataItem, "OrderId", cmpEqual,orderNo_5);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(5).DataItem, "OrderId", cmpEqual,orderNo_6);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(6).DataItem, "OrderId", cmpEqual,orderNo_7);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(7).DataItem, "OrderId", cmpEqual,orderNo_8);  
            
//Étape2
Log.Message( "************Étape2*********************"); 
            
            //Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide le comptes 300014-NA 800002-NA 300001-OB 
            Log.Message("Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide le comptes 300014-NA 800002-NA 300001-OB ");
            selectAndopen_Order1006(orderNo_6)

            
            
           var grid = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1)
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account300014NA);
           aqObject.CheckProperty(grid.Items.Item(1).DataItem, "AccountNumber", cmpEqual,account800002NA);
           aqObject.CheckProperty(grid.Items.Item(2).DataItem, "AccountNumber", cmpEqual,account800001OB); 
           
           //fermer la fenetre info ordre
           Log.Message("Fermer la fenetre info ordre");
           Get_WinOrderDetail().Close();

           
//Étape3
Log.Message( "***************Étape3*****************");
             
           //Retourner au module Comptes, puis mailler 300014-NA dans Portefeuille et activer le mode Intraday, valider la presence du  titre NA et sa quantité(400)
           Log.Message("Retourner au module Comptes, puis mailler 300014-NA dans Portefeuille et activer le mode Intraday, valider la presence du  titre NA et sa quantité(400)")
          
            //Fermer Croesus
            Terminate_CroesusProcess(); 
            
//Étape4
Log.Message( "******************Étape4******************");
            
            //Se connecter à croesus avec LINCOA
            Log.Message("Se connecter à croesus avec LINCOA");
            Login(vServerOrders, userNameLINCOA, passwordLINCOA, language);
            Get_MainWindow().Maximize();           
      
                       
            //Acceder au Module Ordres
            Log.Message("Acceder au Module Ordres");
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
            
            //Aller dans l'Accumulateur et click droit pour ajouter la colonne numéro d'ordre 
            addColumn_ChOrderNo();
            if(!Get_OrderAccumulatorGrid_ChOrderNo().Exists){
               
               Get_OrderAccumulatorGrid_ChAccountName().Click();
               Get_OrderAccumulatorGrid_ChAccountName().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlOrdinalNo"], ["MenuItem", 3], 10).Click();
               WaitObject(Get_OrderAccumulatorGrid(),["ClrClassName", "WPFControlOrdinalNo"],["LabelPresenter", "16"],10);
              
            }  
            
            
            //Valider que les ordres de 10001, 1002,1003, 1005,1006 et 10007 sont visibles
            Log.Message("Valider que les ordres de 10001, 1002,1003, 1005,1006 et 10007 sont visibles");
            Get_OrderAccumulatorGrid_ChOrderNo().Click();
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd", maxWaitTime);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderId", cmpEqual,orderNo_1);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderId", cmpEqual,orderNo_2);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "OrderId", cmpEqual,orderNo_3);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(4).DataItem, "OrderId", cmpEqual,orderNo_5);  
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(5).DataItem, "OrderId", cmpEqual,orderNo_6);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(6).DataItem, "OrderId", cmpEqual,orderNo_7);

            
//Étape5
Log.Message( "*************Étape5*******************");
                        
            //Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide les comptes 300014-NA 800002-NA 300001-OB 
            Log.Message("Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide les comptes 800002-NA 300001-OB ");
            selectAndopen_Order1006(orderNo_6)

            
            //Valide le comptes  800002-NA 300001-OB sont visibles 
           var grid = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1)
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account800002NA);
           aqObject.CheckProperty(grid.Items.Item(1).DataItem, "AccountNumber", cmpEqual,account800001OB); 
           
           //fermer la fenetre info ordre
           Log.Message("Fermer la fenetre info ordre");
           Get_WinOrderDetail().Close();

            //Fermer Croesus
            Terminate_CroesusProcess(); 
            
            
//Étape6
Log.Message( "**************Étape6*******************");
               
            
            //Se connecter à croesus avec Copern
            Log.Message("Se connecter à croesus avec Copern");
            Login(vServerOrders, userNameCOPERN, passwordCOPERN, language);
            Get_MainWindow().Maximize();  
            
            
            //Acceder au Module Ordres
            Log.Message("Acceder au Module Ordres");
            Get_ModulesBar_BtnOrders().Click();
            Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
            
            //Aller dans l'Accumulateur et click droit pour ajouter la colonne numéro d'ordre 
            addColumn_ChOrderNo();
            
            
            //Valider que les ordres de 1002, 1003,1004, 1006,1007 et 1008 sont visibles
            Log.Message("Valider que les ordres de 1002, 1003,1004, 1006,1007 et 1008 sont visibles");
            Get_OrderAccumulatorGrid_ChOrderNo().Click();
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd", maxWaitTime);
           
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderId", cmpEqual,orderNo_2);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "OrderId", cmpEqual,orderNo_3);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "OrderId", cmpEqual,orderNo_4);  
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(5).DataItem, "OrderId", cmpEqual,orderNo_6);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(6).DataItem, "OrderId", cmpEqual,orderNo_7);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(7).DataItem, "OrderId", cmpEqual,orderNo_8);
         
            
//Étape7
Log.Message( "*************Étape7*******************");
   
           //Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide le comptes 300014-NA 
           Log.Message("Aller dans l'accumulateur, selectionner l'ordre 10006 et cliquer sur modifier puis valide le comptes 300014-NA  ");
          
           //Selectionner et ouvrir l'ordre numero 1006
           selectAndopen_Order1006(orderNo_6);
            
           //Valide seul le comptes 300014-NA 800002-NA est visibles
           Log.Message("Valide seul le comptes 300014-NA est visibles")                       
           var grid = Get_WinOrderDetail_TabUnderlyingAccounts_DataGrid().WPFObject("RecordListControl", "", 1)
           aqObject.CheckProperty(grid.Items.Item(0).DataItem, "AccountNumber", cmpEqual,account300014NA);
            
           //fermer la fenetre info ordre
           Log.Message("Fermer la fenetre info ordre");
           Get_WinOrderDetail().Close(); 
           

            
//Étape8
Log.Message( "**************Étape8*****************");
   
           //Retourner au module Comptes, puis mailler 300014-NA dans Portefeuille et activer le mode Intraday, valider la presence du  titre NA et sa quantité(400)
           Log.Message("Retourner au module Comptes, puis mailler 300014-NA dans Portefeuille et activer le mode Intraday, valider la presence du  titre NA et sa quantité(400)")
           validateQuantityNA_PadPortefolio(account300014NA, symbolNA,quantityNA); 
         
           
            
            
//Étape9
Log.Message( "****************Étape9******************");

           //Executer le fichier SQL
           ExecuteSQLFile(folderPath_Data + "restoredata1179.sql", vServerOrders)
   
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {  
       
      Terminate_CroesusProcess(); //Fermer Croesus
       
    }
 }

 
 

 
