//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0
//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade

/**
    Module               :  Orders
    Jira                 :  TCVE-324
    Description          :  GDO Ajouter des ordres en bloc pour valider les comptes Pro dans le Blotter 
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-47
  
    
*/


function GDO_TCVE324_ProAccount_Blotter() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-324");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            var acc800300NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800300NA", language+client);
            var acc800301NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800301NA", language+client);
            var cmbTransactionType_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE312", language+client);
            var quantity_TCVE324=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE324", language+client);
            var symbol_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE312", language+client);
            var cmbTransaction_TCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE312", language+client); 
            var descLB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descLB", language+client); 
            var acc800202NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800202NA", language+client);
            var acc800203FS=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Acc800203FS", language+client);
            var quantity1_TCVE324=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity1_TCVE324", language+client);
            Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
            //Se connecter à croesus
            Log.Message("Se connecter à croesus");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            DeleteAllOrdersInAccumulator();  
            
            //Les étapes 1 à 4 
            CreateOrdre(acc800300NA,acc800301NA,quantity_TCVE324,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312,descLB);
            CreateOrdre(acc800202NA,acc800203FS,quantity1_TCVE324,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312,descLB);           
                        
            //Les étapes 5 à 6 
            CheckProInBlotter(quantity_TCVE324,symbol_TCVE312);
            CheckProInBlotter(quantity1_TCVE324,symbol_TCVE312);
            
            /*Dans le blotter ajouter la colonne Pro*/
            Log.Message("Dans le blotter ajouter la colonne Pro");
            SetAutoTimeOut();
            if(!Get_OrderGrid_ChPro().Exists){
               Get_OrderGrid_ChAccountNo().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }
                                   
            if (!(Get_OrderGrid_ChPro().Exists)){
             Log.Error("la colonne 'Pro' field not displayed . This is not expected.");
            }else{       
             Log.Checkpoint("la colonne 'Pro' field displayed.");
             aqObject.CheckProperty(Get_OrderGrid_ChPro(), "VisibleOnScreen", cmpEqual, true);
            }
            RestoreAutoTimeOut();
            
                       
            Log.Message("Trier la colonne Pro. Valider que la colonne est triable");
            Get_OrderGrid_ChPro().Click();
            if(Get_OrderGrid_ChPro().SortStatus!="Ascending"){
              Get_OrderGrid_ChPro().Click();
            }
            var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
            SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem,"IsProAccount",cmpEqual,false);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(1).DataItem,"IsProAccount",cmpEqual,false);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(2).DataItem,"IsProAccount",cmpEqual,false);
            
            Get_OrderGrid_ChPro().Click();
            if(Get_OrderGrid_ChPro().SortStatus!="Descending"){
              Get_OrderGrid_ChPro().Click();
            }
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(0).DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(1).DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(2).DataItem,"IsProAccount",cmpEqual,false); 
            
            /*Dans le blotter sélectionner l'ordre qui a la quantité = 142 et cliquer sur le bouton Excécutions...*/
            Log.Message("Dans le blotter sélectionner l'ordre qui a la quantité = 142 et cliquer sur le bouton Excécutions...");
            Get_OrderGrid().Find("Value",aqConvert.StrToInt(quantity_TCVE324)*2,10).Click();
            SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
            Get_OrdersBar_BtnFills().Click();
            WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["AllocationWindow_48f4", true]);
            
            /*Dans la fenêtre Excécutions de l'ordre, section Répartition ajouter la colonne Pro */
            Log.Message("Dans la fenêtre Excécutions de l'ordre, section Répartition ajouter la colonne Pro");
            SetAutoTimeOut();
            if(!Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPro().Exists){
               Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChAccountNo().ClickR();
               Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
               Get_GridHeader_ContextualMenu_AddColumn_Pro().Click();
            }  
            
            if (!(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPro().Exists)){
             Log.Error("la colonne 'Pro' field not displayed . This is not expected.");
            }else{
             Log.Checkpoint("la colonne 'Pro' field displayed.");
             aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts_ChPro(), "VisibleOnScreen", cmpEqual, true);
            }                                   
            RestoreAutoTimeOut();   
            
            /*La colonne et ajoutée et les deux comptes (800300-NA et 800301-NA) ont la colonne cochée*/
            Log.Message("La colonne et ajoutée et les deux comptes (800300-NA et 800301-NA) ont la colonne cochée");
            aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild("Value",acc800300NA,10).DataContext.DataItem,"IsProAccount",cmpEqual,true);
            aqObject.CheckProperty(Get_WinOrderFills_GrpAllocationExpander_DgvUnderlyingAccounts().FindChild("Value",acc800301NA,10).DataContext.DataItem,"IsProAccount",cmpEqual,true); 
            Get_WinOrderFills().Close();
           
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
            
      }
      finally {
	        //Se connecter à croesus
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language); 
            Get_ModulesBar_BtnOrders().Click();
            //Supprimer l'ordre généré
            DeleteAllOrdersInAccumulator(); 
            Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
            //Fermer l'application
            Terminate_CroesusProcess();                       
        }
}


function CreateOrdre(acc1,acc2,quantity,cmbTransaction_TCVE312,cmbTransactionType_TCVE312,symbol_TCVE312,descLB){
      //Aller au module compte 
      Get_ModulesBar_BtnAccounts().Click();
      Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
      Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            
      /*Sélectionner les comptes*/+ acc1 /* et */ +acc2 /*.Cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)*/
      Log.Message("Sélectionner les comptes" +acc1+" et " + acc2+ ".Cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
      SelectTwoAccounts(acc1,acc2);
                        
      //cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)   
      Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
      Get_Toolbar_BtnSwitchBlock().Click();
      WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
      /*Dans la fenêtre choisir. Transactions = Achat + Ajouter .Quantité =*/ + quantity+ /*. Unités par compte. Symbole = LB (BANQUE LAURENTIENNE CDA). Cliquer sur Générer*/
      Log.message("Dans la fenêtre choisir. Transactions = Achat + Ajouter .Quantité = 71. Unités par compte. Symbole = LB (BANQUE LAURENTIENNE CDA). Cliquer sur Générer");
      Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
      Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",cmbTransactionType_TCVE312],10).Click();
      AddABuyBySymbol(quantity,cmbTransaction_TCVE312,symbol_TCVE312);                             
      Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
      Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,30000);
      Get_WinSwitchBlock_BtnGenerate().Click(); 
      if (Get_WinSwitchBlock().Exists)
        Get_WinSwitchBlock_BtnGenerate().Click();      
      WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
      
      WaitObject(Get_CroesusApp(),"Uid","DataGrid_66bd");      
      Log.Message("Valider que l'ordre est envoyée dans l'accumulateur");
      aqObject.CheckProperty(Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity)*2,10).DataContext.DataItem, "SecurityDesc", cmpEqual,descLB );
}


function CheckProInBlotter(quantity,symbol){
      /*Dans l'accumulateur faire une double click sur le compte CAD-ACCOUNT  avec la quantité =*/ + quantity 
      Log.Message("Dans l'accumulateur faire une double click sur le compte CAD-ACCOUNT  avec la quantité ="+ quantity);
      Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity)*2,10).DblClick();
            
      /*Cliquer sur le bouton Vérifier.Cliquer sur le bouton Soumettre*/
      Log.Message("Vérifier");
      Get_WinOrderDetail_BtnVerify().Click();
      Log.Message("Soumettre");
      Get_WinOrderDetail_BtnVerify().Click();
           
      /*Valider que l'ordre est envoyé dans le Blotter*/
      Log.Message("Valider que l'ordre est envoyé dans le Blotter");
      var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
      SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
      aqObject.CheckProperty(Get_OrderGrid().Find("Value",aqConvert.StrToInt(quantity)*2,10).DataContext.DataItem, "OrderSymbol", cmpEqual,symbol);
      
      /*La colonne Pro estcochée pour le (CAD_ACCOUNT) quantité 144*/
      Log.Message("La colonne Pro estcochée pour le (CAD_ACCOUNT) quantité" +quantity);
      aqObject.CheckProperty(Get_OrderGrid().Find("Value",symbol,10).DataContext.DataItem, "IsProAccount", cmpEqual,true);
      SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
}


 /**
    Auteur : Christophe Paring
*/
function SetIsExpandedForAccumulatorAndLogExpanders(newStateAccumulatorExpander, newStateLogExpander)
{
    var executeSysRefresh = false;
    
    if (newStateAccumulatorExpander != undefined && newStateAccumulatorExpander != Get_OrderAccumulator().IsExpanded){
        Get_OrderAccumulator().set_IsExpanded(newStateAccumulatorExpander);
        executeSysRefresh = true;
    }
    
    if (newStateLogExpander != undefined && newStateLogExpander != Get_OrderLogExpander().IsExpanded){
        Get_OrderLogExpander().set_IsExpanded(newStateLogExpander);
        executeSysRefresh = true;
    }
    
    if (executeSysRefresh)
        Sys.Refresh();
}