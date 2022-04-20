﻿//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 


/**   
    2) Achat de titre CAD dans un compte US

    sélectionner 800047-SF puis cliquer sur Ordres multiples, en bloc et échanges
    Transaction = Achat
    ajouter(500 AGF110C $ par compte au prix de 13.14CAD)
    OK
    Générer
    double cliquer sur l`ordre dans l`Accumulateur de GDO
    consulter l`onglet Taux de changer
    Résultat : Total à convertir = 529.24  CAD$ à convertir en USD$
    
    explication : 
    Taux de change : 1CAD en US = 0.94473311
    529.24 * 0.94473311 = 499.990545844 ~ 500 USD$

    Auteur : Abdel
    Anomalie:BNC-2346
    Version de scriptage:	90-07-23
    Version d'adaptation:   90-07-Co-13
*/

function BNC_2243_AmountInTotalToBeConvertedShouldBeInCurrencySecurity_USD_Buy() {
         
          var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
          var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");   
          var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AccountBNC_2243_Buy", language+client);
          var transaction = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TransactionBNC_2243_Buy", language+client);
          var securityDescription = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SecurityDescriptionBNC_2243_Buy", language+client);
          var totalToConvert = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "TotalToConvertBNC_2243_Buy", language+client);
          var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QuantityBNC_2243_Buy", language+client);
          var perAccount = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PerAccountBNC_2243_Buy", language+client);
          var securitySymbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "SecuritySymbolBNC_2243_Buy", language+client);
          var CADconvertUSD = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CADConvertUSDBNC_2243_Buy", language+client);         
     
          Log.Link("https://jira.croesus.com/browse/BNC-2243", "Cas de tests JIRA BNC-2243");

          try {
          
                    Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
                    
                    //Click le module compte
                    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
                    Get_ModulesBar_BtnAccounts().Click();
                    Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
                    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
                    
                    //recherche un compte 
                    Search_Account(account);
                    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
                    Get_RelationshipsClientsAccountsGrid().Find("Value",account,100).Click();
                    
                    //Click sur ordre multiple
                    Get_Toolbar_BtnSwitchBlock().Click();
                    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
                    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
                    
                    //Ajout d'une transaction(s):Achat  
                    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,20000);
                    Delay(3000);
                    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                    
                    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
                    Get_WinSwitchSource_TxtQuantity().set_Text(quantity);
                    Get_WinSwitchSource_CmbQuantity().set_Text(perAccount);
                    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
                    //Get_WinSwitchSource_CmbSecurity().Click();
                    //Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();                    
                    Get_WinSwitchSource_GrpPosition_TxtSecurity().Click();
                    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
                    Get_WinSwitchSource_GrpPosition_TxtSecurity().set_Text(securitySymbol);
                    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");        
                    if(Get_SubMenus().Exists){       
                        Aliases.CroesusApp.subMenus.Find("Value",securityDescription,10).DblClick();
                    }             
                    Get_WinSwitchSource_GrpPosition_TxtPrice().WaitProperty("IsEnabled", true, 30000);
                    Delay(2500);                    
                    
                    Get_WinSwitchSource_btnOK().WaitProperty("IsEnabled", true, 30000);       
                    Get_WinSwitchSource_btnOK().Click();
            
                    
                   Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
                   Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,20000);
                   Delay(3000);
                   Get_WinSwitchBlock_BtnGenerate().Click();  
        
                    //Sélectionner le bloc dans l’accumulateur 
                    Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securityDescription,10).DblClick();
                    WaitObject(Get_WinOrderDetail(),"Uid", "TabControl_2c50");
                    Get_WinOrderDetail_TabExchangeRate().Click();
                    
                    //validation de la valeur total à convertir
                    Log.Message("Valider la valeur Total à convertir");
                    aqObject.CheckProperty(Get_WinOrderDetail().FindChild("Uid", "CustomTextBox_5cec",10), "Text", cmpEqual, totalToConvert);
                    Log.Message("Valider USD$ à Convertir en CAD$");
                    aqObject.CheckProperty(Get_WinOrderDetail().FindChild("Uid", "CustomTextBox_5cec",10), "Text", cmpEqual, totalToConvert);
                    Get_WinOrderDetail_BtnCancel().Click();
                  
          } catch (e) {
                    Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
                     
          }
          finally {
                    //Selectionner le bloc dans l'accumulateur
                    Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Find("Value",securitySymbol,10).Click();                  
                    Get_OrderAccumulator_BtnDelete().Click();
                    Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
                    Terminate_CroesusProcess();
                    Runner.Stop(true); 
          }
}