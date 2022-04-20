//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA


/*
    Module               :  Orders
    CR                   :  1813
    TestLink             :  Croes-3206, Croes-3207
    Description          :  Valider le fournisseur de l`ordre TD( NYS/TSE )
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  13/12/2018
    
    Liens                : https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3206
                           https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3207
    Regroupé  : A.A
    Version   : 90.19.20209.6
*/
 
 function CR1813_Ord_ValidateSupplierOfOrderTD_NYS_TSE()
 {             
    try{ 
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3206","Lien du Cas de test sur Testlink"); 
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        
        var account     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_AccountNo", language+client);
        var quantity    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Quantity", language+client);
        var symbol      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Symbol", language+client);
        var marketNYS   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Market_Croes_3206", language+client);
        var marketTSE   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Market_Croes_3207", language+client);
        var supplier    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Supplier", language+client);
        var description = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Description", language+client);
               
        
        Login(vServerOrders, user , psw ,language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateStocksOrder(account,quantity,symbol,marketNYS);
        
        //Ajouter la colonne fournisseur (Supplier)
        AddSupplierColumn();
        
        //Verification de l'ordre dans la grille Orders
        if(CheckPresenceOrderInOrderGrid(description,quantity,symbol,marketNYS,supplier)){
            //vérifier que la valeur de la colonne fournisseur est "manuel"
            Log.Checkpoint("La valeur de la colonne Fournisseur est correcte");
        }
        else{
          Log.Error("L'ordre créé n'est pas affiché ou la valeur de la colonne fournisseur n'est pas correct");
        }
        

//        Get_ModulesBar_BtnOrders().Click();
//        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);  
//        Get_MainWindow().Maximize();
        
        Get_Toolbar_BtnCreateABuyOrder().Click();
        
        //Selectioner 'Stoks'
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
               
        //Creation d'ordre 
        CreateStocksOrder(account, quantity, symbol, marketTSE);
        
        //Ajouter la colonne fournisseur (Supplier)
        AddSupplierColumn();
        
        //Verification de l'ordre dans la grille Orders
        if(CheckPresenceOrderInOrderGrid(description, quantity, symbol, marketTSE, supplier)){
            //vérifier que la valeur de la colonne fournisseur est "manuel"
            Log.Checkpoint("La valeur de la colonne Fournisseur est correcte");
        }
        else{
          Log.Error("L'ordre créé n'est pas affiché ou la valeur de la colonne fournisseur n'est pas correct");
        }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
      
    }
    finally {   
        //Fermer Croesus
        Terminate_CroesusProcess();
        Terminate_IEProcess();
        
    }
 }

function CheckPresenceOrderInOrderGrid(description,quantity,symbol,market,supplier)
{
  var count=Get_OrderGrid().RecordListControl.Items.Count
  var found=false;
  for(var i=0;i<count;i++){
    if(VarToString(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.SecurityDesc)==VarToString(description))
    {
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Quantity", cmpEqual,quantity);
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "OrderSymbol", cmpEqual,symbol);
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "ExchangeName", cmpEqual,market);
      Log.Message("Valider la valeur de la colonne Fournisseur");
      aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "SupplierName", cmpEqual,supplier);
      found=true;
      break;
    }
  }
  return found;
}


function CreateStocksOrder(account,quantity,symbol,market){
 
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
    
    //Creation d'ordre 
    if (Trim(VarToStr(account))!== ""){     
      Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    }
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
    if (Trim(VarToStr(quantity))!== ""){  
      Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    }
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Clear();
    
    if (Trim(VarToStr(symbol))!== ""){  
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(".");
    
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(symbol);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
        var Grid = Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1);
        var NbrItem=Grid.ChildCount;
        for (i=1;i<NbrItem;i++)
        {
            if (Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.MarketName == market && Grid.WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.Symbol == symbol)
            {
                Grid.WPFObject("DataRecordPresenter", "", i).DblClick();
                break;
            }
        }
    }       
    Get_WinOrderDetail_BtnVerify().Click();
    if (language == "french") WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Soumettre"]);
    else WaitObject(Get_WinOrderDetail(),["ClrClassName", "WPFControlText"],["Button","Submit"]);
    Get_WinOrderDetail_BtnVerify().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","OrderDetails_d698");
 }
 
 function AddSupplierColumn(){
     if (!Get_OrderGrid_ChSupplier().Exists )
     {
        Get_OrderGrid_ChPrice().ClickR();
        Get_OrderGrid_ChPrice().ClickR();
        Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
        Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).FindChild(["ClrClassName","WPFControlText"],["MenuItem","Field: SupplierName"],10).Click();
     }   
 }