//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Ordres_Get_functions
//USEUNIT GDO_2464_Split_Of_BlockTrade
//////USEUNIT Global_variables



/* Description :Ajouter des ordres pour permettre la vérification des comptes Pro dans le blotter

    CTVE-314
 
    Analyste d'assurance qualité: Carole T.
    Analyste d'automatisation: Amine A.
    ref 90.14.Lu-27 */ 
 
 function GDO_TCVE_314_AjouterOrdresSimplesPourComptesProValiderBlotter()
 {             
    try{  
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
            var accountNo1     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_800300", language+client);
            var quantity1      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_151", language+client);
            var securitySymbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "SecuritySymbol_NA", language+client);
            var accountNo2     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account_800217", language+client);
            var quantity2      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Quantity_152", language+client);
            var headerPro      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "HeaderPro", language+client);
            var valueYes       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ValueYes", language+client);
            var valueNo        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "ValueNo", language+client);
        
            //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);  
            Get_ModulesBar_BtnOrders().Click();
            DeleteAllOrdersInAccumulator()           
      
            //Créer un ordre d'achat security='NA', quantité = 151, accountNo = '800300-NA'
            CreateBuyOrder(securitySymbol, quantity1, accountNo1);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual,accountNo1);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "Quantity", cmpEqual,quantity1);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);           
            
            Get_OrderAccumulatorGrid_ChType().ClickR();
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            //Créer un ordre d'achat security='NA', quantité = 152, accountNo = '800217-RE'
            CreateBuyOrder(securitySymbol, quantity2, accountNo2);         
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual,accountNo2);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "Quantity", cmpEqual,quantity2);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,securitySymbol);
            
            //Ajouter la colonne 'Pro'
            if(!Get_OrderAccumulatorGrid_ChPro().Exists){  
                  Get_OrderAccumulatorGrid_ChType().ClickR();
                  Get_OrderAccumulatorGrid_ChType().ClickR();
                  Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
                  Delay(500)
                  Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }
            
            //Valider que la colonne 'Pro' est cochée pour la quantité 151 et n'est pas cochée pour la quantité 152
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ColumnPro(1), "Content", cmpEqual,false);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ColumnPro(2), "Content", cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ColumnPro(2).WPFObject("Image", "", 1), "VisibleOnScreen", cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid_ColumnPro(2).WPFObject("Image", "", 1), "IsVisible", cmpEqual,true);
            
            //Valider que la colonne 'Pro' est triable
            Get_OrderAccumulatorGrid_ChPro().Click();
            Get_OrderAccumulatorGrid_ChPro().Click();
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "IsProAccount", cmpEqual,true);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "IsProAccount", cmpEqual,false);
            Get_OrderAccumulatorGrid_ChPro().Click();
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "IsProAccount", cmpEqual,false);
            aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "IsProAccount", cmpEqual,true);
            
            //Faire un export vers Excel
            Get_OrderAccumulatorGrid().ClickR(100,100);
            Get_OrderAccumulatorGrid().ClickR(100,100);
            if (Get_SubMenus().Exists)
                Get_SubMenus_ExportToExcel().Click();
            
            //Vérifier que la colonne 'Pro' est exportée avec les deux valeurs
            Sys.WaitProcess("EXCEL", 10000);
        
            var sTempFolder = Sys.OSInfo.TempDirectory;
            var FolderPath= sTempFolder+"\CroesusTemp\\"
            Log.Message(FolderPath)
            var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
            Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
            var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI); 
            var countLineInMyFile=0;
       
            while(! myFile.IsEndOfFile()){    
                countLineInMyFile++;
                line = myFile.ReadLine();
                var textArr = line.split("	");       
               // Log.Message("The resulting array is: " + textArr);
                var textArrUnquote4 = aqString.Unquote(textArr[4]);
                if(countLineInMyFile == 1)
                        CheckEquals(textArrUnquote4, headerPro, "Entête de la colonne est: ");
                if(countLineInMyFile == 2)
                        CheckEquals(textArrUnquote4, valueNo, "La valeur de la colonne est: ");
                if(countLineInMyFile == 3)
                      CheckEquals(textArrUnquote4, valueYes, "La valeur de la colonne est: ");          
            } 
            myFile.Close(); 
            while(Sys.waitProcess("EXCEL").Exists){
                Sys.Process("EXCEL").Terminate();
            }
            
            //Supprimer les 2 ordres
            Get_OrderAccumulatorGrid_ColumnPro(1).Click();
            Get_OrderAccumulatorGrid_ColumnPro(2).Click(-1,-1,skCtrl);
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation_BtnDelete().Click();        
    }
    catch(e) {
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {   
            Terminate_CroesusProcess(); //Fermer Croesus
    }
 }
 
 function Get_OrderAccumulatorGrid_ColumnPro(i){
        return Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 15)}