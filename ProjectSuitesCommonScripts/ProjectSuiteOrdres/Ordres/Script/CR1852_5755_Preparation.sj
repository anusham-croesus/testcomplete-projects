//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Extract des Taux suivi du 1er et 2e fichier phase pour PTF et NAVex
                    Preparation : UI: Étapes 1- 10
    
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5755
    Analyste d'assurance qualité : mamoudoud
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	Er-1
*/

function CR1872_5755_Preparation()
{
    try {
                
        Activate_Inactivate_PrefFirm("FIRM_1","GDO_ETF_MARKET","GDO_MFP_MARKET_NAS, PTF, MARKET_CODE = Q, SECURITY_TYPE = 3308001 | 3308000 ; GDO_MFP_MARKET_TSE, NAVex, MARKET_CODE = T, SECURITY_TYPE = 3308001 | 3308000",vServerOrders)
        //Pour que les machés soient toujours ouverts        
        Activate_Inactivate_Pref("KEYNEJ","PREF_FIDESSA_SESSION_TIME","0:00|0:00",vServerOrders);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_OPEN_TIME","STOCKS>0:0:0|BONDS>0:0:0|FUNDS>0:0:0",vServerOrders);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59:59|BONDS>23:59:59|FUNDS>23:59:59",vServerOrders);
        Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_SKIP_HOLIDAY_CHECK","YES",vServerOrders);
        
        RestartServices(vServerOrders)
               
        var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");                 
        var account800067RE = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "Account800067RE", language+client);
        var account300002OB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "Account300002OB", language+client);
        var account300001NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "Account300001NA", language+client);
        var account300006OB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "Account300006OB", language+client);
        var ELUXY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "ELUXY", language+client);
        var AIGDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "AIGDotUN", language+client);
        var CFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "CFRUY", language+client);
        var CBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "CBKDotUN", language+client);
        var quantityELUXY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityELUXY_5755", language+client);
        var quantityAIGDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityAIGDotUN_5755", language+client);        
        var quantityCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityCFRUY_5755", language+client);
        var quantityFillCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityFillCFRUY_5755", language+client);
        var priceCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "PriceCFRUY_5755", language+client);
        var marketCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "MarketCFRUY_5755", language+client);
        var rateOriginCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "RateOriginCFRUY_5755", language+client);        
        var exchangeRateCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "ExchangeRateCFRUY_5755", language+client);
        var interneNoCFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "InterneNoCFRUY_5755", language+client);
        
        var quantityCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityCBKDotUN_5755", language+client);
        var quantityFillCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "QuantityFillCBKDotUN_5755", language+client);
        var priceCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "PriceCBKDotUN_5755", language+client);
        var marketCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "MarketCBKDotUN_5755", language+client);
        var roleCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "RoleCBKDotUN_5755", language+client);        
        var rateOriginCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "RateOriginCBKDotUN_5755", language+client);        
        var exchangeRateCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "ExchangeRateCBKDotUN_5755", language+client);
        var interneNoCBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "InterneNoCBKDotUN_5755", language+client);
        
        var statusOpen = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "OpenStatus", language+client);
        var statusExecuted = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "StatusExecuted", language+client);
        var statusPartialFill = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "StatusPartialFill", language+client);
        var financialInstrument=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "FinancialInstrumentStocks", language+client);
        var orderType=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "BuyTypeForDisplay", language+client);
        
        //Format date
         if (language == "french")
            var dateFormat = "%Y/%m/%d";
         else
            var dateFormat = "%m/%d/%Y";
               
        //Afficher le lien de cas de test
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5755","Cas de test TestLink : Croes-5755")
                
        //Login
        Log.Message("**************************************Login*********************************************")
        Login(vServerOrders, user, psw, language);
        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnSecurities().Click();
        Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 15000);
        Log.Message("Cliquer sur le bouton RedisplayAllAndRemoveCheckmarks")
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_865b", true]); 
       
        //créer ordre : quantité=500, symbole = ELUXY(Bourse=NAS), compte = 800067-RE
        Log.Message("1. Créer un ordre d'Achat d'action quantité = "+quantityELUXY+" symbole = "+ELUXY+" compte = "+account800067RE);
        OpenStatusOrderPreparation(ELUXY, quantityELUXY, account800067RE, financialInstrument, orderType, statusOpen, dateFormat)
         
         //créer ordre : quantité=200, symbole = AIG.UN(Bourse=TSE NAVex), compte = 300002-OB
        Log.Message("2. Créer un ordre d'Achat d'action quantité = "+quantityAIGDotUN+" symbole = "+AIGDotUN+" compte = "+account300002OB);
        OpenStatusOrderPreparation(AIGDotUN, quantityAIGDotUN, account300002OB, financialInstrument, orderType, statusOpen, dateFormat)
        
        //créer ordre : quantité=100, symbole = CFRUY, compte = 300001-NA
        Log.Message("3. Créer un ordre d'Achat d'action quantité = "+quantityCFRUY+" symbole = "+CFRUY+" compte = "+account300001NA);
        OpenStatusOrderPreparation(CFRUY, quantityCFRUY, account300001NA, financialInstrument, orderType, statusOpen, dateFormat)
        
        //Exécutions.../quantité=100,prix=80,Bourse=NU/OK/Origine du taux =Taux négocié,Taux de change=1,02222/No.Interne=CR1872/Sauvegarder
        // ===> Status = exécuté
        Log.Message("Ordre "+CFRUY+"/Exécutions.../quantité= "+quantityFillCFRUY+", prix= "+priceCFRUY+", Bourse= "+marketCFRUY+"/OK/Origine du taux = "+rateOriginCFRUY
        +",Taux de change= "+exchangeRateCFRUY+"No.Interne="+interneNoCFRUY+"/Sauvegarder// ===> Status = "+statusExecuted)
        EditOrderStatusToExecuted(dateFormat, statusExecuted, CFRUY, quantityFillCFRUY, priceCFRUY, marketCFRUY, rateOriginCFRUY, exchangeRateCFRUY, interneNoCFRUY)
        
        //créer ordre : quantité=100, symbole = CBK.UN, compte = 300006-OB
        Log.Message("4. Créer un ordre d'Achat d'action quantité = "+quantityCBKDotUN+" symbole = "+CBKDotUN+" compte = "+account300006OB);
        OpenStatusOrderPreparation(CBKDotUN, quantityCBKDotUN, account300006OB, financialInstrument, orderType, statusOpen, dateFormat)
        
        //Exécutions.../quantité=50,prix=65, Bourse=TF,Notre role=T/OK/Origine du taux =Taux négocié,Taux de change=1,00999/No.Interne=CR1872/Sauvegarder 
        //===> Status = exécuté partiellement
        Log.Message("Ordre "+CBKDotUN+"/Exécutions.../quantité= "+quantityFillCBKDotUN+", prix= "+priceCBKDotUN+", Bourse= "+marketCBKDotUN+"/OK/Origine du taux = "+rateOriginCBKDotUN
        +",Taux de change= "+exchangeRateCBKDotUN+"No.Interne="+interneNoCBKDotUN+"/Role= "+roleCBKDotUN+" /Sauvegarder// ===> Status = "+statusPartialFill)
        EditOrderStatusToExecuted(dateFormat, statusPartialFill, CBKDotUN, quantityFillCBKDotUN, priceCBKDotUN, marketCBKDotUN, rateOriginCBKDotUN, exchangeRateCBKDotUN, interneNoCBKDotUN, roleCBKDotUN)
        
        //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
    }
    catch(e) {
  		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();  
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Runner.Stop(true)
    }
}

function OpenStatusOrderPreparation(securitySymbol, quantity, account, financialInstrument, orderType, status, dateFormat){

    CreateBuyOrder(securitySymbol, quantity, account)
    Log.Message("Valider l'existance de l'ordre créé dans l'accumulateur");
    if(CheckPresenceOrderInAccumulator(account,quantity,securitySymbol,financialInstrument,orderType)){
        Log.Message("Vérifier et soumettre l'ordre crée");
        VerifySubmitOrder(account);
    }         
    else
        Log.Error("Un ordre créé ne s'affiché pas en bas dans Accumulateur")
        
    Log.Message("sélectionner ordre symbole = "+securitySymbol+"/ cliquer sur Consulter.../Approuver ==> Valider Status = "+status) 
    ApproveCheckOrderStatus(securitySymbol, status, dateFormat)

}
         

function Test(){

}

