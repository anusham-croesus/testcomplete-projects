//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT CR1813_Ord_ValidateSupplier_OfOrderTD_NYS

/*
    Module               :  Orders
    CR                   :  1813
    TestLink             :  Croes-3207
    Description          :  Valider le fournisseur de l`ordre TD( TSE)
    Auteur               :  Abdel Matmat
    Version de scriptage :	90.08.Dy-2
    Date                 :  13/12/2018
    
*/
 
 function CR1813_Ord_ValidateSupplier_OfOrderTD_TSE()
 {             
    try{ 
        //lien pour TestLink
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-3207","Lien du Cas de test sur Testlink"); 
        //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59|BONDS>23:59|FUNDS>23:59",vServerOrders)
        //RestartServices(vServerOrders)
        
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_AccountNo", language+client);
        var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Quantity", language+client);
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Symbol", language+client);
        var market = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Market_Croes_3207", language+client);
        var supplier = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1813", "CR1813_Supplier", language+client);
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
        CreateStocksOrder(account,quantity,symbol,market);
        
        //Ajouter la colonne fournisseur (Supplier)
        AddSupplierColumn();
        
        //Verification de l'ordre dans la grille Orders
        if(CheckPresenceOrderInOrderGrid(description,quantity,symbol,market,supplier)){
            //vérifier que la valeur de la colonne fournisseur est "manuel"
            Log.Checkpoint("La valeur de la colonne Fournisseur est correcte");
        }
        else{
          Log.Error("L'ordre créé n'est pas affiché ou la valeur de la colonne fournisseur n'est pas correct");
        }
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders)//la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
        //RestartServices(vServerOrders)
        
    }
    finally {   
        //Fermer Croesus
        Terminate_CroesusProcess();
        //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders)//la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
        //RestartServices(vServerOrders)
        Terminate_IEProcess(); 
    }
 }