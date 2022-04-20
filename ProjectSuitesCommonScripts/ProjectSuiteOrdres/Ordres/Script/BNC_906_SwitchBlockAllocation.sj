//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT GDO_2464_Split_Of_BlockTrade


/**
        Description : 
                  
                      Faire une vente 3000$ par compte (devise compte) FIA110 comptes suivants 
                          800238-RE
                          800082-RE
                          pour un achat
                          FID281 25%
                          FID1202 25%
                          FID1504 25%
                          RON 25%

                          dans accum:
                          6000$ vente FIA110, deux comptes
                          1500$ de chaque titre (approx)
                          pour RON, j'ai 90 qté car val march ~ 16.62$
    Auteur : Sana Ayaz
    Anomalie:BNC-906
    Version de scriptage:	ref90-07-Co-6--V9-Be_1-co6x
   
*/
 function BNC_906_SwitchBlockAllocation()
 {             
    try{  
         userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         
         var SymbolFIA110BNC_906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymbolFIA110BNC_906", language+client);
         var NubAccount800238RE=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "NubAccount800238RE", language+client);
         var NubAccount800082RE=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "NubAccount800082RE", language+client);
         var ItemQuantityBNC_906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ItemQuantityBNC_906", language+client);
         var QuantityVenteBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QuantityVenteBNC906", language+client);
         var ItemSymbolSecurityBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ItemSymbolSecurityBNC906", language+client);
         var AllocationFID281BNC906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AllocationFID281BNC906", language+client);
         var SymboFID281BNC_906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymboFID281BNC_906", language+client);
         var AllocationFID1202BNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AllocationFID1202BNC906", language+client);
         var SymboFID1202BNC_906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymboFID1202BNC_906", language+client);
         var AllocationFID1504BNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AllocationFID1504BNC906", language+client);
         var SymboFID1504BNC_906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymboFID1504BNC_906", language+client);
         var AllocationRONBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AllocationRONBNC906", language+client);
         var SymboFIDRONBNC_906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymboFIDRONBNC_906", language+client);
         var TypOrdreVentBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TypOrdreVentBNC906", language+client);
         var CheckpointQuantityFIA110 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CheckpointQuantityFIA110", language+client);
         var TypOrdreAchatBNC906  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TypOrdreAchatBNC906", language+client);
         var CheckpointQuantityRON  =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CheckpointQuantityRON", language+client);
         var CheckpointQuantityFID1504=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CheckpointQuantityFID1504", language+client);
         var CheckpointQuantityFID1202=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CheckpointQuantityFID1202", language+client);
         var CheckpointQuantityFID281=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CheckpointQuantityFID281", language+client);
          
         Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
         Get_ModulesBar_BtnSecurities().Click();
         Search_SecurityBySymbol(SymbolFIA110BNC_906)
         Get_SecurityGrid().Find("Value",SymbolFIA110BNC_906,10).Click();
         //Mailler vers le module compte  
         Get_MenuBar_Modules().Click();
         Get_MenuBar_Modules_Accounts().Click();
         Get_MenuBar_Modules_Accounts_DragSelection().Click();
         Get_RelationshipsClientsAccountsGrid().FindChild("Value", NubAccount800238RE, 10).Click();
         //Sélectionner les deux comptes 
         //Maintenir la touche CTRL enfoncée
         Sys.Desktop.KeyDown(0x11);
         Get_RelationshipsClientsAccountsGrid().FindChild("Value",NubAccount800082RE, 10).Click();
         //Relâcher la touche CTRL enfoncée
         Sys.Desktop.KeyUp(0x11);
         Get_Toolbar_BtnSwitchBlock().Click();
         //Ajouter une transaction de vente
         Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click()
         Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
         Aliases.CroesusApp.subMenus.Find("WPFControlText",ItemQuantityBNC_906,10).Click();
         
         Get_WinSwitchSource_TxtQuantity().Keys(QuantityVenteBNC906);
         Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
         Get_WinSwitchSource_GrpPosition().Click();
         Aliases.CroesusApp.subMenus.Find("WPFControlText",ItemSymbolSecurityBNC906,10).Click();
         Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(SymbolFIA110BNC_906);
         Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
         Get_WinSwitchSource_btnOK().Click();
         //Ajouter la transaction d'achat: FID281 25%
         PurchasequivalentTransactAddiction(AllocationFID281BNC906,SymboFID281BNC_906);
         
         //Ajouter la transaction d'achat: FID1202 25%
         PurchasequivalentTransactAddiction(AllocationFID1202BNC906,SymboFID1202BNC_906);
         
         //Ajouter la transaction d'achat: FID1504 25%
         PurchasequivalentTransactAddiction(AllocationFID1504BNC906,SymboFID1504BNC_906);
         
           //Ajouter la transaction d'achat: RON 25%
         PurchasequivalentTransactAddiction(AllocationRONBNC906,SymboFIDRONBNC_906);
         
         WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
         Get_WinSwitchBlock_BtnPreview().Click();
         Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
         Get_WinSwitchBlock_BtnGenerate().Click();
         if (Get_WinSwitchBlock().Exists)
            Get_WinSwitchBlock_BtnGenerate().Click();        
         WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
         WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd");
         
         // les poinst de vérifications
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "DisplayQuantityStr", cmpEqual,CheckpointQuantityFIA110);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,SymbolFIA110BNC_906);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "TypeForDisplay", cmpEqual,TypOrdreVentBNC906);
            
            
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "DisplayQuantityStr", cmpEqual,CheckpointQuantityRON);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,SymboFIDRONBNC_906);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "TypeForDisplay", cmpEqual,TypOrdreAchatBNC906);
            
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "DisplayQuantityStr", cmpEqual,CheckpointQuantityFID1504);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "OrderSymbol", cmpEqual,SymboFID1504BNC_906);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(2).DataItem, "TypeForDisplay", cmpEqual,TypOrdreAchatBNC906);
            
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "DisplayQuantityStr", cmpEqual,CheckpointQuantityFID1202);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "OrderSymbol", cmpEqual,SymboFID1202BNC_906);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(3).DataItem, "TypeForDisplay", cmpEqual,TypOrdreAchatBNC906);
            
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(4).DataItem, "DisplayQuantityStr", cmpEqual,CheckpointQuantityFID281);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(4).DataItem, "OrderSymbol", cmpEqual,SymboFID281BNC_906);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(4).DataItem, "TypeForDisplay", cmpEqual,TypOrdreAchatBNC906);
              
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        Terminate_CroesusProcess();
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess();  
    }
    finally {   
        Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();
        Terminate_CroesusProcess();  
    }
 }
 
 function PurchasequivalentTransactAddiction(allocationPercen,Symbol)
 {
        var ItemSymbolSecurityBNC906=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ItemSymbolSecurityBNC906", language+client);
        var SymboFIDRONBNC_906 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymboFIDRONBNC_906", language+client);
       Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
        Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(allocationPercen);
        
        Get_WinSwitchEquivalent_CmbSecurity().Click();
        Aliases.CroesusApp.subMenus.Find("WPFControlText",ItemSymbolSecurityBNC906,10).Click();
        
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(Symbol);
        
        Get_WinSwitchEquivalent_BtnQuickSearchListPicker().Click();
        if(Symbol == SymboFIDRONBNC_906)
        {
           Aliases.CroesusApp.subMenus.Find("Text",Symbol,10).DblClick();
        }
        
        Get_WinSwitchEquivalent_btnOK().Click();
        
 
 }