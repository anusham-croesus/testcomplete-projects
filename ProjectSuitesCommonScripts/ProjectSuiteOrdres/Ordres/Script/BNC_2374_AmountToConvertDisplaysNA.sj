//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**
      1.Pour KEYNEJ, PREF_TRADER_ACCESS=STOCKS,OPTIONS,BONDS,FUNDS
      2.se connecter avec KEYNEJ
      3.du module titre, sélectionner MFC281 et cliquer sur Créer un ordre d`Achat
      4.compte=300002-OB, quantité=9753,951(Montant$)
      Dans Onglet Taux de change: Origine du taux=Taux négocié,Taux de change=1,02333, No Interne=X12345
      5.Vérifier puis soumettre
      6.sélectionner l`ordre de statut en 'approbation(négociateur)/Rapports/Rapports de fonds d`invest.
      7.consulter l`ordre de statut 'Éxécuté'
      8.valider que le Total à convertir n`est pas perdue, c`est à dire différent N/A
      
    Auteur : Sana Ayaz
    Anomalie:BNC-2374
    Version de scriptage:	90-07-23
*/

function BNC_2374_AmountToConvertDisplaysNA() {

          
          try {
                    Activate_Inactivate_Pref("KEYNEJ","PREF_TRADER_ACCESS","STOCKS,OPTIONS,BONDS,FUNDS",vServerOrders);
                    //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>23:59|BONDS>23:59|FUNDS>23:59",vServerOrders)
                    RestartServices(vServerOrders)
          
                    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
                    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                    
                    var SecuritySymbolBNC2374=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SecuritySymbolBNC2374", language+client);
                    var accountBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "accountBNC2374", language+client);
                    var quantityBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "quantityBNC2374", language+client);
                    var itemQuantityBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "itemQuantityBNC2374", language+client);
                    var itemOrigneExchangRatBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "itemOrigneExchangRatBNC2374", language+client);
                    var exchangeRateBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "exchangeRateBNC2374", language+client);
                    var InternNumber2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "InternNumber2374", language+client);
                    var rateOriginBNC2374 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "rateOriginBNC2374", language+client);
                    var totalToConvertBNC2374= ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "totalToConvertBNC2374", language+client);
                   
          
                    Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
                    Get_ModulesBar_BtnSecurities().Click();
                    //3.du module titre, sélectionner MFC281 et cliquer sur Créer un ordre d`Achat
                    Search_SecurityBySymbol(SecuritySymbolBNC2374);
                    Get_SecurityGrid().Find("Value",SecuritySymbolBNC2374,10).Click();
                    Get_Toolbar_BtnCreateABuyOrder().Click();
                    /*4.compte=300002-OB, quantité=9753,951(Montant$)
                    Dans Onglet Taux de change: Origine du taux=Taux négocié,Taux de change=1,02333, No Interne=X12345*/
                    
                    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(accountBNC2374)
                    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    
                    Get_WinMutualFundsOrderDetail_CmbQuantityType().Click();
                    Aliases.CroesusApp.subMenus.Find("WPFControlText",itemQuantityBNC2374,10).Click();
                    Get_WinMutualFundsOrderDetail_TxtQuantity().Keys(quantityBNC2374);
    
                   Get_WinOrderDetail_TabExchangeRate().Click();
    
    
                  Get_WinOrderDetail_TabExchangeRate_GrpRate_CmbRateOrigin().Click()
                  Aliases.CroesusApp.subMenus.Find("WPFControlText",itemOrigneExchangRatBNC2374,10).Click();
                    Get_WinOrderDetail_TabExchangeRate_GrpRate_CmbRateOrigin().set_Text(rateOriginBNC2374);
     
                    Get_WinOrderDetail_TabExchangeRate_GrpRate_TxtExchangeRate().Keys(exchangeRateBNC2374);
      
                    Get_WinOrderDetail_TabExchangeRate_GrpRate_LblInternalNumber().Keys(InternNumber2374);
                    //5.Vérifier puis soumettre
                    Get_WinOrderDetail_BtnVerify().Click();
                    //soumettre
                    Get_WinOrderDetail_BtnVerify().Click();
                    //6.sélectionner l`ordre de statut en 'approbation(négociateur)/Rapports/Rapports de fonds d`invest.
                    var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
                    SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
                     Get_OrderGrid().Find("Value",SecuritySymbolBNC2374,10).Click();
                    SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
                     Get_MenuBar_Reports().Click();
                     Get_MenuBar_Reports_MutualFundsOrderReport().Click();
                     
                     // 7.consulter l`ordre de statut 'Éxécuté'
                    var previousStateOfOrderAccumulator = Get_OrderAccumulator().IsExpanded; //Christophe : Stabilisation
                    SetIsExpandedForAccumulatorAndLogExpanders(false, null); //Christophe : Stabilisation
                      Get_OrderGrid().Find("Value",SecuritySymbolBNC2374,10).Click();
                    SetIsExpandedForAccumulatorAndLogExpanders(previousStateOfOrderAccumulator, null); //Christophe : Stabilisation
                      Get_OrdersBar_BtnView().Click();
                      /*8.valider que le Total à convertir n`est pas perdue, c`est à dire différent N/A*/
                      Get_WinOrderDetail_TabExchangeRate().Click();
                      
                      //Les points de vérifications
                     
                      
                      aqObject.CheckProperty( Get_WinOrderDetail_TabExchangeRate_GrpRate_TxtTotalToConvert(), "Enabled", cmpEqual, false);
                      aqObject.CheckProperty( Get_WinOrderDetail_TabExchangeRate_GrpRate_TxtTotalToConvert(), "Text", cmpEqual, totalToConvertBNC2374);
                      
                    //Fermer Croesus
                    Get_WinOrderDetail_BtnCancel().Click();
                    Close_Croesus_MenuBar();
                    SetAutoTimeOut();
                    if (Get_DlgConfirmation().Exists)
                        Get_DlgConfirmation_BtnYes().Click();
                    
          } catch (e) {
                   
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));
                    Terminate_CroesusProcess();
                    Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
                    //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders) // la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
                    //RestartServices(vServerOrders)
                   
          
          }
          finally {
          
                                      
                    Terminate_CroesusProcess();
                    Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
                    //Activate_Inactivate_Pref("KEYNEJ","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders)//la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
                    //RestartServices(vServerOrders)
                    CloseExcel();
          }
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