//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1813_Ord_ValidateSupplier_OfOrderTD_NYS

/*
    Module               :  Orders
    CR                   :  1813
    TestLink             :  Croes-3217
    Description          :  Vérifier le Fournisseur de l`ordre sur CNQ apres changement de compte coup moyen
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  14/12/2018
    
*/
 
 function CR1813_Ord_VerifySupplier_OrderCNQ_AfterChange_AccountMoyenCost()
 {             
    try{ 
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3217","Lien du Cas de test sur Testlink"); 
        //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59|BONDS>23:59|FUNDS>23:59",vServerOrders)
        //RestartServices(vServerOrders)
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_AccountNo_3217", language+client);
        var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Quantity_3217", language+client);
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Symbol_3217", language+client);
        var marketNYS = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_MarketNYS_3217", language+client);
        var marketTSE = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_MarketTSE_3217", language+client);
        var messageInfo = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_MsgInfo_3217", language+client);
        var USDaccount = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_USDAccount_3217", language+client);
        var CADaccount = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_CADAccount_3217", language+client);
        var supplier = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Supplier", language+client);
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        
        Search_Account(account);
        
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName","Text"],["XamTextEditor",account],10).Click();
       
        //Acceder à Ordres multiples
        Get_Toolbar_BtnSwitchBlock().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
        //Mettre Transaction à Achat
        Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Cmb_Buy_3217", language+client)],10).Click();
        
        //Ajouter : 400 Unités par compte, symbole =CNQ, Bourse = NYS
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        Get_WinSwitchSource_CmbSecurity().Click();
        Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
                    
        Get_WinSwitchSource_TxtQuantity().Keys(quantity);
        Get_WinSwitchSource_CmbQuantity().Click();
        Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["ComboBoxItem",ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Cmb_Units_3217", language+client)],10).Click();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(".");
        Get_WinSwitchSource_GrpPosition_TxtSecurity().set_SelectedText(symbol);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
        
        var Grid = Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1)
        var NbrItem=Grid.ChildCount;
        for (i=1;i<NbrItem;i++)
        {
            if (Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.MarketName == marketNYS && Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.Symbol == symbol)
            {
                Grid.WPFObject("DataRecordPresenter", "", i).DblClick();
                break;
            }
        }
        Get_WinSwitchSource_btnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        
        //Cliquer sur Aperçu puis Générer
        Get_WinSwitchBlock_BtnPreview().Click();
        Delay(2500);
        Get_WinSwitchBlock_BtnGenerate().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
        //Vérifier que l'ordre est en USD dans l'accumulateur
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
            Log.Message("Valider que le compte cout moyen est en USD");
            aqObject.CheckProperty(Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(i).DataItem,"AccountNumber",cmpEqual,USDaccount);
        }else
            Log.Error("L,ordre n'existe pas dans l'accumulateur");
        
        
        //Double Cliquer sur l'ordre créé dans l'accumulateur
        Get_OrderAccumulator().FindChild(["ClrClassName","Text"],["XamTextEditor",symbol],10).DblClick();
        WaitObject(Get_CroesusApp(),"Uid","OrderDetails_d698");
        
        //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
        Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
        Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
        
        //Changer la bourse de l'ordre à TSE
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(".");
    
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(symbol);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        var Grid = Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1)
        var NbrItem=Grid.ChildCount;
        for (i=1;i<NbrItem;i++)
        {
            if (Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.MarketName == marketTSE && Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.Symbol == symbol)
            {
                Grid.WPFObject("DataRecordPresenter", "", i).DblClick();
                break;
            }
        }
        
        //Vérifier le message d'information
        //aqObject.CheckProperty(Get_DlgInformation_LblMessage(), "WPFControlText", cmpEqual,messageInfo);
        aqObject.CheckProperty(Get_DlgInformation(), "CommentTag", cmpEqual,messageInfo);
        //Get_DlgInformation().Find(["ClrClassName","WPFControlText"],["Button","OK"],100).Click();
        Get_DlgInformation().Close();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlText"],["BaseWindow","Information"],500);
        
        //Cliquer sur vérifier puis soumettre
        Get_WinOrderDetail_BtnVerify().Click();
        if (language == "french") WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Soumettre"]);
        else WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Submit"]);
        Get_WinOrderDetail_BtnVerify().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
        
        //Ajouter la colonne fournisseur (Supplier)
        AddSupplierColumn();
        
        //Vérifier l'ordre créé dans la grille ordres
        CheckOrderInOrderGrid(symbol,quantity,marketTSE,supplier,CADaccount);
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));     
    }
    finally { 
        
        //Fermer Croesus
        Terminate_CroesusProcess();
        //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders)//la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
        //RestartServices(vServerOrders)
        Terminate_IEProcess(); 
    }
 }
 
 function CheckOrderInOrderGrid(symbol,quantity,market,supplier,account)
{
  var count=Get_OrderGrid().RecordListControl.Items.Count;
  for(var i=0;i<count;i++){
    if(VarToString(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol)== VarToString(symbol))
    {
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity);
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "ExchangeName", cmpEqual,market);
      Log.Message("Valider que le compte cout moyen passe à CAD");
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "AccountNumber", cmpEqual,account);
      Log.Message("Valider la valeur de la colonne Fournisseur");
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "SupplierName", cmpEqual,supplier);
      break;
    }
  }
}

function Get_DlgInformation_LblMessage(){return Get_DlgInformation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBlock", 1], 10)}
function test(){
     WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlText"],["BaseWindow","Information"]);
}



function WaitUntilObjectDisappears1(parentObject, properties, propertiesValues, maxWaitTime, showWaitTime)
{
    if (maxWaitTime == undefined)
        maxWaitTime = 30000;
    
    var timer1 = HISUtils.StopWatch;
    var waitTime1 = 0;
    
    do {
        timer1.Start();
        Delay(10000);
        var foundObject = parentObject.FindChild(properties, propertiesValues, 3);
        var waitTime1 = timer1.Stop();
        Log.Message(waitTime1);
        

    } while (foundObject.Exists && waitTime1 < maxWaitTime)
    
    timer1.Reset();
    
    isFound = foundObject.Exists;
    if (showWaitTime || showWaitTime == undefined){
      if (isFound)
          Log.Message("Object did not disappear after " + waitTime1 + " ms.");
      else
          Log.Message("Object disappeared after " + waitTime1 + " ms.");
    }
    
    return !isFound;
}
