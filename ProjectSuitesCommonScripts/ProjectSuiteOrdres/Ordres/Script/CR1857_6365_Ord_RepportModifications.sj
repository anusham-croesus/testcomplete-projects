//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade


/**
    Description : valider le contenu Rapport de taux de change selon PREF_GDO_FX_REPORT_FILTER égale 1 ou 2

         1 – Le Rapport de taux de change affiche seulement les ordres avec un taux de change négocié.                
         2 – Le Rapport de taux de change affiche les ordres avec ou sans un taux de change négocié.   Valider la possibilité de configurer plusieurs produits en meme temps
 
    - Se connecter avec KEYNEJ, ouvrir Croesus:                   
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6365   
    Analyste d'assurance qualité : mamoudoud
    Analyste d'automatisation : Amine Alaoui
    
    Version de scriptage: FM-7
*/

function CR1857_6365_Ord_RepportModifications(){
    try {
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6365");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
        var accountBuy  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "accountBuy800049", language+client);
        var quantityBuy = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "QuantityBuy", language+client);
        var symbolBuy = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "SymbolBuy", language+client);
        var accountSell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "accountSell800302", language+client);
        var quantitySell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "QuantitySell", language+client);
        var symbolSell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "SymbolSell", language+client);
        var valSell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "ValSell", language+client);
        var priceSell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "PriceSell", language+client);
        var valBuy  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "ValBuy", language+client);
        var priceBuy  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "PriceBuy", language+client);
        var exchangeRate  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "ExchangeRate", language+client);
        var internalNumber  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "InternalNumber", language+client);
        var letterSell  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "LetterSell", language+client);
        var letterBuy  =  ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1857", "LetterBuy", language+client);       
     
        Log.Message("**************************************Login*********************************************")
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
        
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
        DeleteAllOrdersInAccumulator(); 
                
        //Créer un ordre d'achat
        Get_Toolbar_BtnCreateABuyOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        //Remplir les details de l'ordre
        
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountBuy)
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityBuy);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolBuy)
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
        //Vérifier et sauvgarder
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnSave().Click();
        
        //Créer un ordre de vente
        Get_Toolbar_BtnCreateASellOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
                
        //Remplir les details de l'ordre
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountSell)
        Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
        Get_WinStocksOrderDetail_TxtQuantity().Keys(quantitySell);
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbolSell)
        Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Enter]");
        
        //Sélectionner le symbol NA dans la liste
        if(Get_SubMenus().Exists)
            Aliases.CroesusApp.subMenus.Find("Value",symbolSell,10).DblClick();
        //Vérifier et sauvgarder
        Get_WinOrderDetail_BtnVerify().Click();
        Get_WinOrderDetail_BtnSave().Click();               
        
        //Vérification que les ordres s'affichent dans l'accumulateur     
        var item = Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(1);
        aqObject.CheckProperty(item.DataItem,"AccountNumber",cmpEqual,accountBuy);
        aqObject.CheckProperty(item.DataItem,"Quantity",cmpEqual,quantityBuy);
        aqObject.CheckProperty(item.DataItem,"OrderSymbol",cmpEqual,symbolBuy);
        
        item = Get_OrderAccumulator().accumulatorGrid.RecordListControl.Items.Item(0);
        aqObject.CheckProperty(item.DataItem,"AccountNumber",cmpEqual,accountSell);
        aqObject.CheckProperty(item.DataItem,"Quantity",cmpEqual,quantitySell);
        aqObject.CheckProperty(item.DataItem,"OrderSymbol",cmpEqual,symbolSell);
        
         if(language=="french"){
          var today="%Y/%m/%d"
        } else{
          var today="%m/%d/%Y"
        }
        
        //Passer les ordres dans le blotter
        Get_OrderAccumulator().Find("Value",accountBuy,10).Click();
        Get_OrderAccumulator_BtnVerify().Click();
        Get_WinAccumulator().FindChild("Uid","IncludedKey",10).set_IsSelected(true);
        Get_WinAccumulator().FindChild("Uid","IncludedKey",10).Click();
        Get_WinAccumulator_BtnSubmit().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "BatchOrderVerificationWindow_342c");
        
        //Vérifier le changement du statut 
        Log.Message("Vérifier le changement du statut ") ;
        
        var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
        var previousStateOfOrderLogExpander = Get_OrderLogExpander().IsExpanded; //Christophe : Stabilisation
        SetIsExpandedForAccumulatorAndLogExpanders(false, false); //Christophe : Stabilisation
        
        if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem.OrderSymbol==symbolBuy){
          
              Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).Click();  
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem,"Status",cmpEqual,"Pending_Approval"); 
              SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, previousStateOfOrderLogExpander); //Christophe : Stabilisation
            
              Log.Message("Approuver les ordres") ;
              Get_OrdersBar_BtnView().Click();
              Get_WinOrderDetail_BtnApprove().Click();  
              
              //Vérifier que l'état dans le blotter est Ouvert
              Log.Message("Vérifier que l'état dans le blotter est Ouvert") ; 
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10).DataContext.DataItem,"Status",cmpEqual,"Open");   
              
              //Faire l'exécution des ordres   
              Log.Message("Faire l'exécution des ordres") ;     
              Get_OrdersBar_BtnFills().Click();
              Get_WinOrderFills_GrpFills_BtnAdd().Click();        
              Get_WinAddOrderFill_TxtQuantity().Keys(valBuy);
              Get_WinAddOrderFill_TxtClientPrice().Keys(priceBuy);       
              Get_WinAddOrderFill_CmbMarket().Click();
              Get_WinAddOrderFill_CmbMarket_ChBource().Click();
              Get_WinAddOrderFill_CmbOurRole().Click();
              Get_WinAddOrderFill_CmbOurRole_ChAgent().Click();
              Get_WinAddOrderFill_BtnOK().Click();
              Get_WinOrderFills_BtnSave().Click(); 
                
        } else{
          Log.Error("L'ordre "+symbolBuy + " " +aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today) + " n'est pas dans le Blotter")
          SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, previousStateOfOrderLogExpander); //Christophe : Stabilisation
        }
                
        Get_OrderAccumulator().Find("Value",accountSell,10).Click();
        Get_OrderAccumulator_BtnVerify().Click();
        Get_WinAccumulator().FindChild("Uid","IncludedKey",10).Click();
        Get_WinAccumulator_BtnSubmit().Click(); 
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "BatchOrderVerificationWindow_342c");
        
        //Vérifier le changement du statut 
        Log.Message("Vérifier le changement du statut ") ;
        //if(Get_OrderGrid().Find("Text",aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today),10)OrderSymbol==symbolSell){

        var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
        SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
        
        if(aqString.Trim(Get_OrderGrid().Find("Text",symbolSell,10).DataContext.DataItem.Quantity)==quantitySell){
              Get_OrderGrid().Find("Text",symbolSell,10).Click();   
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",symbolSell,10).DataContext.DataItem,"Status",cmpEqual,"Pending_Approval"); 
              SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
              
              Log.Message("Approuver les ordres") ;
              Get_OrdersBar_BtnView().Click();
              Get_WinOrderDetail_BtnApprove().Click();   
              
              //Vérifier que l'état dans le blotter est Ouvert
              Log.Message("Vérifier que l'état dans le blotter est Ouvert") ;
              aqObject.CheckProperty(Get_OrderGrid().Find("Text",symbolSell,10).DataContext.DataItem,"Status",cmpEqual,"Open"); 
               
              //Faire l'exécution des ordres 
              Log.Message("Faire l'exécution des ordres") ; 
              Get_OrdersBar_BtnFills().Click();
              Get_WinOrderFills_GrpFills_BtnAdd().Click();        
              Get_WinAddOrderFill_TxtQuantity().Keys(valSell);
              Get_WinAddOrderFill_TxtClientPrice().Keys(priceSell);       
              Get_WinAddOrderFill_CmbMarket().Click();
              Get_WinAddOrderFill_CmbMarket_ChBource().Click();
              Get_WinAddOrderFill_CmbOurRole().Click();
              Get_WinAddOrderFill_CmbOurRole_ChAgent().Click();
              Get_WinAddOrderFill_BtnOK().Click();
        
              Get_WinOrderFills_GrpFills_CmbRateOriginForBond().Click();
              Get_WinOrderFills_GrpFills_CmbRateOriginForBond_ChNegociatedRate().Click();
              Get_WinOrderFills_GrpFills_TxtExchangeRateForBond().Keys(exchangeRate);
              Get_WinOrderFills_GrpFills_LblInternalNumberForBond().Keys(internalNumber);
              Get_WinOrderFills_BtnSave().Click();
         
        } else{
          Log.Error("L'ordre "+symbolSell + " " +aqConvert.DateTimeToFormatStr(aqDateTime.Now(), today) + " n'est pas dans le Blotter")
          SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
        }
                
        //Vérifier que l'état dans le blotter est En approbation 
        if(!Get_OrderGrid_ChLastModification().Exists){
              var previousStateOfOrderLogExpander = Get_OrderLogExpander().IsExpanded; //Christophe : Stabilisation
              SetIsExpandedForAccumulatorAndLogExpanders(null, false); //Christophe : Stabilisation
              Get_OrderGrid_ChDescription().ClickR();
              Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
              SetIsExpandedForAccumulatorAndLogExpanders(null, previousStateOfOrderLogExpander); //Christophe : Stabilisation
        }
        
        var keysCountLeft = 25; //Christophe : Stabilisation
        while((--keysCountLeft) > 0 && (!Get_OrderGrid_ChLastModification().Exists || Get_OrderGrid_ChLastModification().VisibleOnScreen == false)){
                  Get_OrderGrid().Keys("[Right][Right]");
                  Sys.Refresh();
        }
        
        Get_OrderGrid_ChLastModification().DblClick(); 
        Terminate_CroesusProcess();
        
        //Modifier la PREF_GDO_FX_REPORT_FILTER=2        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_FX_REPORT_FILTER",2,vServerOrders);
        RestartServices(vServerOrders);
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();
        
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
        Sys.Process("EXCEL").Terminate();
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
                    
        var countLineInFile=0; // les lignes dans le fichier 
        var textArr = new Array();
        while(! myFile.IsEndOfFile()){    
              line = myFile.ReadLine();
              var textArr = line.split("	");                  
              countLineInFile++;
              if(countLineInFile == 2){                 
                  CheckEquals(aqString.Unquote(textArr[1]),letterBuy,"Ordre Achat ")
                  CheckEquals(aqString.Unquote(textArr[3]),symbolBuy, "Symbole achat ")  
              }
              if(countLineInFile == 3){
                  CheckEquals(aqString.Unquote(textArr[1]),letterSell, "Ordre vente")
                  CheckEquals(aqString.Unquote(textArr[3]),symbolSell,"Symbole vente")
              }
         }    
        Terminate_CroesusProcess();
        
        //Modifier la PREF_GDO_FX_REPORT_FILTER=1        
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_FX_REPORT_FILTER",1,vServerOrders);               
        RestartServices(vServerOrders);
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 10000);
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_ExchangeRateReport().Click();
        
        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains));
        Sys.Process("EXCEL").Terminate();
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
                    
       var countLineInFile=0; // les lignes dans le fichier 
       var textArr = new Array();
       while(! myFile.IsEndOfFile()){    
              line = myFile.ReadLine();
              var textArr = line.split("	");                  
              countLineInFile++;
              Log.Message("The resulting Array : " + textArr)
              if(countLineInFile == 2){
                  CheckEquals(aqString.Unquote(textArr[1]),letterSell, "Ordre vente")
                  CheckEquals(aqString.Unquote(textArr[3]),symbolSell,"Symbole vente")
                  CheckEquals(aqString.Unquote(textArr[4]),exchangeRate,"Taux négocié")
              }
        }           
    }
    catch(e) {
         Log.Error("Exception: " + e.message, VarToStr(e.stack));          
    }
    finally {
	    Terminate_CroesusProcess();
      Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders);
      Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_FX_REPORT_FILTER",2,vServerOrders);  // 2020.07-21 le pref est a 2              
      RestartServices(vServerOrders);      
    }
}



function Get_OrderGrid_ChLastModification1()
{
  if (language=="french"){return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Dernière modification"], 15)}
  else {return Get_OrderGrid().FindChild(["ClrClassName", "WPFControlText"], ["LabelPresenter", "Last Modification"], 15)}
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