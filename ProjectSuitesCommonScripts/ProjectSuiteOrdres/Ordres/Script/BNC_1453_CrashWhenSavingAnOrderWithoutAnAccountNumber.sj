//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT GDO_2510_Checkbox_AllOrNon_CAD
//USEUNIT GDO_2464_Split_Of_BlockTrade
/**
        Description : 
                  
                      Bouton Ordre d'achat à partir de l’accumulateur 
                      Ordre sera créer (sans # de compte) 
                      ajouter une quantité de 1 pour le titre symbole "NA" et sauvegarder l'ordre 
                      CRASH applicatif lorsque aucun # de compte est entré et qu’on tente de sauvegardé le ticket d’ordre. 
    Auteur : Sana Ayaz
    Anomalie:BNC-1453
    Version de scriptage:	ref90-04-BNC-28
   
*/
 function BNC_1453_CrashWhenSavingAnOrderWithoutAnAccountNumber()
 {             
    try{  
         userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
         passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         var QuantityBNC_1453=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QuantityBNC_1453", language+client);
         var SymbolSecurityOrdrBNC_1453=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SymbolSecurityOrdrBNC_1453", language+client);
         var DesciptionTitreWinOrdreBNC_1453=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "DesciptionTitreWinOrdreBNC_1453", language+client);
       
         Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
         Get_ModulesBar_BtnOrders().Click();
         Get_Toolbar_BtnCreateABuyOrder().Click();
         Get_WinFinancialInstrumentSelector_RdoStocks().Click();
         Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
         Get_WinFinancialInstrumentSelector_BtnOK().Click();
       
         Get_WinStocksOrderDetail_TxtQuantity().Keys(QuantityBNC_1453);
         SelectItemInCmb(SymbolSecurityOrdrBNC_1453)
         Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(DesciptionTitreWinOrdreBNC_1453);
         Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
         Aliases.CroesusApp.subMenus.Find("Value",DesciptionTitreWinOrdreBNC_1453,10).DblClick();
         Get_WinOrderDetail_BtnSave().Click();
        //Vérifier si le message d'erreur apparaît
//        maxWaitTime = 10000;
//        waitTime = 0;
        errorDialogBoxDisplayed = Get_DlgError().Exists;
//        while (!errorDialogBoxDisplayed && waitTime < maxWaitTime){
//            Delay(1000);
//            waitTime += 1000;
//            errorDialogBoxDisplayed = Get_DlgError().Exists;
//        }
        
//        Log.Message("Waited for the Error dialog box during " + waitTime + " ms.");
        
        if (errorDialogBoxDisplayed){
            Log.Error("Croesus crashed.")
            Log.Error("Bug BNC-1453");
            Get_DlgError_BtnOK().Click();
        }
        else
            Log.Checkpoint("No crash detected.")
               
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack)); 
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
    }
    finally {   
       Terminate_CroesusProcess(); //Fermer Croesus
        Login(vServerOrders, userNameKEYNEJ , passwordKEYNEJ ,language);
        Get_ModulesBar_BtnOrders().Click(); 
        DeleteAllOrdersInAccumulator();  
    }
 }
 
 