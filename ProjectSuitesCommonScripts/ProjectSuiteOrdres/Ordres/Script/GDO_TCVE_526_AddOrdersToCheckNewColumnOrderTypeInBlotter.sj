//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
    Module               :  Orders
    Jira                 :  TCVE-526
    Description          :  GDO :Ajouter des ordres pour la vérification de la nouvelle colonne 'Type d'ordre' dans le blotter
    Préconditions        : 
    
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.15.2020.3-21
    Date                 :  05/03/2020 
    
*/

function GDO_TCVE_526_AddOrdersToCheckNewColumnOrderTypeInBlotter() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-526","Cas de test Xray");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
            
            var account800300NA         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800300NA", language+client);
            var quantity_1              = 203;//ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_1", language+client);
            var symbol_TCVE526          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE526", language+client);
            var description_TCVE526     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "description_TCVE526", language+client);
            var orderType_1             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderType_1", language+client);
            var orderPrice_Limit_1      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderPrice_Limit_1", language+client);
            
            var account800217RE         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800217RE", language+client);
            var quantity_2              = 204;//ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_2", language+client);
            var orderType_2             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderType_2", language+client);
            var orderPrice_Limit_2      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderPrice_Limit_2", language+client);
            var orderPrice_StopLimit_2  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderPrice_StopLimit_2", language+client);
            
            var account800218GT         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "account800218GT", language+client);
            var quantity_3              = 205;//ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_3", language+client);
            var orderType_3             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderType_3", language+client);
            var orderPrice_Limit_3      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "orderPrice_Limit_3", language+client);
                                      
            //Se connecter à croesus
            Log.Message("Se connecter à croesus")
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            // Aller dans le module comptes et sélectionner le compte 800300-NA
            Get_ModulesBar_BtnAccounts().Click();
            SearchAccount(account800300NA);
                        
            //Créer un ordre d'achat avec le bouton bleu et choisir Actions
            CreateBuyOrderStocks(quantity_1, symbol_TCVE526, description_TCVE526, orderType_1, orderPrice_Limit_1)
            Delay(5000);                                        
            //L'ordre d'achat est créée dans le Botter et la colonne Type d'ordre = Cours limite"
            Log.Message("Valider que l'ordre d'achat est créée dans le Blotter et la colonne Type d'ordre = Cours limite ");
            Get_OrderGrid().waitproperty("IsLoaded", true);
            var object = Get_OrderGrid().Find("Value", quantity_1, 10);
            aqObject.CheckProperty(object.DataContext.DataItem, "DisplayOrderTypeDescription", cmpEqual, orderType_1);
            
            // Aller dans le module comptes et sélectionner le compte 800217-RE
            Get_ModulesBar_BtnAccounts().Click();
            SearchAccount(account800217RE);
                        
            //Créer un ordre d'achat avec le bouton bleu et choisir Actions
            CreateBuyOrderStocks(quantity_2, symbol_TCVE526, description_TCVE526, orderType_2, orderPrice_Limit_2, orderPrice_StopLimit_2);
            Delay(5000);                                        
            //L'ordre d'achat est créée dans le Botter et la colonne Type d'ordre = Cours limite"
            Log.Message("Valider que l'ordre d'achat est créée dans le Blotter et la colonne Type d'ordre = Cours limite ");
            Get_OrderGrid().waitproperty("IsLoaded", true);
            var object = Get_OrderGrid().Find("Value",quantity_2, 10);
            aqObject.CheckProperty(object.DataContext.DataItem, "DisplayOrderTypeDescription", cmpEqual,orderType_2);
            
            // Aller dans le module comptes et sélectionner le compte 800218-GT
            Get_ModulesBar_BtnAccounts().Click();
            SearchAccount(account800218GT);
                        
            //Créer un ordre d'achat avec le bouton bleu et choisir Actions
            CreateBuyOrderStocks(quantity_3, symbol_TCVE526, description_TCVE526, orderType_3, orderPrice_Limit_3);
            Delay(5000);                                        
            //L'ordre d'achat est créée dans le Botter et la colonne Type d'ordre = Cours limite"
            Log.Message("Valider que l'ordre d'achat est créée dans le Blotter et la colonne Type d'ordre = Cours limite ");
            Get_OrderGrid().waitproperty("IsLoaded", true);
            var object = Get_OrderGrid().Find("Value",quantity_3, 10);
            aqObject.CheckProperty(object.DataContext.DataItem, "DisplayOrderTypeDescription", cmpEqual,orderType_3);                                    
      }
      catch (e) {
                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                              
      }
      finally {
            Terminate_CroesusProcess(); //Fermer Croesus
            Terminate_IEProcess();  //Fermer IE               
        }
}

function CreateBuyOrderStocks(quantity, symbol, description, orderType, orderPriceLimit, orderPriceStop){
            //Créer un ordre d'achat avec le bouton bleue et choisir Actions
            Log.Message("Créer un ordre d'achat avec le bouton bleu et choisir Actions")
            Get_Toolbar_BtnCreateABuyOrder().Click();
            Get_WinFinancialInstrumentSelector_RdoStocks().Click();
            Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
            Get_WinFinancialInstrumentSelector_BtnOK().Click();
            
            //Creation d'ordre 
            Log.Message("Creation d'ordre:Quantité = "+quantity+"; Symb.= '"+symbol+"'; Type d'ordre = "+orderType+" et prix de l'ordre = "+orderPriceLimit);             
            Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);              
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbol);
            Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
            if (Get_SubMenus().Exists)
                Get_SubMenus().Find("Value", description,10).DblClick();
            Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
            if (Get_SubMenus().Exists)
                Get_SubMenus().Find("Text", orderType, 10).Click();
            if (orderType == "Stop avec limite"/*Stop-limit*/){
               Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice().Set_Text(orderPriceLimit);
               Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Set_Text(orderPriceStop);
            }else            
               Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit().Set_Text(orderPriceLimit);
                       
            Log.Message("Vérifier...");
            Get_WinOrderDetail_BtnVerify().Click();
            Log.Message("Soumettre...");
            Get_WinOrderDetail_BtnVerify().Click();  
}

