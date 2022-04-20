//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0()
//USEUNIT Ordres_Get_functions 

/**
    Module               :  Orders
    Jira                 :  TCVE_3668 
    Description          :  Script pour Valider la fonctionnalité taux de change avec right click pour les ordres ouvert
    
    Analyste d'assurance qualité : Taous Amalou
    Analyste d'automatisation : Alhassane Diallo 
    
    Version de scriptage :	90.22-2020-12-19
    date                 :  30-12-20120 
  
    
*/

function TCVE_3668_ORC_1484_Validate_The_RateOfChange_Functionality_With_RightClick_For_OpenOrders()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-3668","Lien de la story dans Jira");
           
    
            //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
           
           var account800049NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "AccountBNC_2346", language+client);
           var orderMGA             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDER_MGA", language+client);
           
           var quantityMGA         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QUANTITE_MGA", language+client);
           var partialQuantity     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PARTIAL_QUANTITE", language+client);
           var priceMGA            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PARTIAL_QUANTITE", language+client);
           var partialPrice        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PARTIAL_PRICE", language+client);
           var cmbOrderTypeValue   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDER_TYPE_VALUE", language+client);
           var typeBuy             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2080", "TypeBuy", language+client);
          
           
                  
/************************************Étape 1************************************************************************/     
          //Se connecter à croesus avec KEYNEJ
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ et mailler le compte 800053-NA vers le portefeuille ");
          Log.Message("Se connecter à croesus avec KEYNEJ");
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          
           
/************************************Étape 2************************************************************************/     
          
          Log.PopLogFolder();
          logEtape2= Log.AppendFolder("Étape 2:Aller dans le module Ordres, Créer un ordre comme suit Juste pour la date de validité plus que la date du jour  ");
         
          Log.Message("Aller dans le module Ordres. ");
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);
          
          Log.Message("Créer un ordre d'achat du titre MGA pour le compte 800049-NA avec une quantité de 3500 et un prix de cour limite de 50 . ");
          
          var forma_date="%Y/%m/%d"
          if(language=="english"){
            forma_date="%m/%d/%Y"
          } 
          
          var today = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), forma_date);
          var date1 = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(today, 4), forma_date);
          var date2 = aqConvert.DateTimeToFormatStr(aqDateTime.AddDays(today, -3), forma_date);

          Get_Toolbar_BtnCreateABuyOrder().Click();
          Get_WinFinancialInstrumentSelector_RdoStocks().Click();
          Get_WinFinancialInstrumentSelector_BtnOK().WaitProperty("IsEnabled",true,1500);
          Get_WinFinancialInstrumentSelector_BtnOK().Click();
          
          
          Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account800049NA)
          Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
          Get_WinStocksOrderDetail_TxtQuantity().Keys(quantityMGA);
          
          if (Trim(VarToStr(orderMGA))!== ""){  
          Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().set_SelectedText(orderMGA);
          Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
          } 
          Get_WinStocksOrderDetail_CmbOrderType().Click();
          Get_SubMenus().FindChild("WPFControlText",cmbOrderTypeValue,10).Click();
          Get_WinStocksOrderDetail_TxtPriceLimit().Keys(priceMGA);
          Get_WinStocksOrderDetail_RdoSpecificDate().Click();
          Get_WinStocksOrderDetail_DtpExpirationSpecificDate().Click();
          Get_WinStocksOrderDetail_DtpExpirationSpecificDate().Keys(date1); 
          Get_WinOrderDetail_BtnSave().Click();
          
          //Selectionner et verifier l'ordre créé 
          Log.Message("Selectionner et verifier l'ordre créé ");
          selectAndVerify_OrderMGA(orderMGA);
          
           //Cocher la case inclure puis soumettre l'ordre
           Log.Message("Cocher la case inclure puis soumettre l'ordre");
           if (Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["XamCheckEditor","1"],10).IsChecked == false){
              Get_WinAccumulator().FindChild(["ClrClassName","WPFControlOrdinalNo"],["XamCheckEditor","1"],10).Click();
           }
           Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled",true,1500);
           Get_WinAccumulator_BtnSubmit().Click();
           WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
           WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);
           
/************************************Étape 3************************************************************************/     
            
           
           Log.PopLogFolder();
           logEtape3 = Log.AppendFolder("Étape 3:Aller dans le module Ordres, Créer un ordre comme suit Juste pour la date de validité plus que la date du jour  ");
         
           //Aller dans la section du haut (Blotter), sélectionner l'ordre de MGA  puis cliquer sur le bouton execution.
           Log.Message("Aller dans la section du haut (Blotter), sélectionner l'ordre de MGA  puis cliquer sur le bouton execution.");
           Search_OrderBySymbol(orderMGA)
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).Click();
           Get_OrdersBar_BtnView().Click();
           WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
           Get_WinOrderDetail_BtnApprove().Click();
           WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
           
           Search_OrderBySymbol(orderMGA)
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).Click();
           
           //Faire l'exécution des ordres   
           Log.Message("Faire l'exécution des ordres");
           Get_OrdersBar_BtnFills().Click();     
           Get_WinOrderFills_GrpFills_BtnAdd().Click();        
           Get_WinAddOrderFill_TxtQuantity().Keys(partialQuantity);
           Get_WinAddOrderFill_TxtClientPrice().Keys(partialPrice); 
           Get_WinAddOrderFill_TxtExecutionDate().Click(); 
           Get_WinAddOrderFill_TxtExecutionDate().Keys(date2); 
           Get_WinAddOrderFill_TxtSettlementDate().Click(); 
           Get_WinAddOrderFill_TxtSettlementDate().Keys(today);   
           Get_WinAddOrderFill_CmbMarket().Click();
           Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 4).Click();
           Get_WinAddOrderFill_CmbOurRole().Click();
           Get_WinAddOrderFill_CmbOurRole_ChAgent().Click();
           Get_WinAddOrderFill_BtnOK().Click();
           Get_WinOrderFills_BtnSave().Click(); 
           
           
           //Search_OrderBySymbol(orderMGA)
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           if(!Get_SubMenus().Exists){       
                Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           } 
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           Get_OrderGrid_ContextualMenu_Functions().Click();
           Get_OrderGrid_ContextualMenu_Functions().Click();
           
           
           //Valider que le taux de change n est pas grié avant l'execution de plugin    
           Log.Message("Valider que le taux de change n est pas grisé avant l'execution a la generation du PhaseOne ") ;     
           aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, true);
           
           
/************************************Étape 4************************************************************************/           
           
           Log.PopLogFolder();
           logEtape4= Log.AppendFolder("Étape 4:Rouler le plugin de la phase One pour fermer la journée, donner un chemin d'exécution Exemple: cd /home/taousa/ORC-1334 cfLoader -PhaseOneGenerator -Firm=FIRM_1  ");
         
           var CRFolder = "CR1958"
           var vserverCommand = vServerOrders;
           var username = "alhassaned";
           var sshCommand1 = "cfLoader -PhaseOneGenerator -Firm=FIRM_1";
           ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand1, username);
          
/************************************Étape 5************************************************************************/
           Log.PopLogFolder();
           logEtape5 = Log.AppendFolder("Étape 5:Rafraîchir l'application à nouveau dans le module Ordres Valider que le taux de change  est désactivé avec le right  click  ");
           
           Log.Message("Rafraîchir l'application ") ; 
           Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
           
           Log.Message("Valider que le taux de change est  desactivé (Grisé) apres l'execution a la generation du PhaseOne ") ; 
           Search_OrderBySymbol(orderMGA);
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           if(!Get_SubMenus().Exists){       
                Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           } 
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).ClickR();
           Get_OrderGrid_ContextualMenu_Functions().Click();
           Get_OrderGrid_ContextualMenu_Functions().Click();
           
           
           //Valider que le taux de change est  grisé apres le Click right    
           Log.Message("Valider que le taux de change est  grisé apres le Click right ") ;     
           aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
           
/************************************Étape 6************************************************************************/           
           Log.PopLogFolder();
           logEtape6 = Log.AppendFolder("Étape 6:Valide que dans la fenêtre d'exécution le taux de change  est désactivé(Grisé) ");
           
           //Valider que le taux de change est  grisé dans la fenetre execution de l'ordre    
           Log.Message("Valider que le taux de change est  grisé dans la fenetre execution de l'ordre  ") ; 
           Get_OrderGrid().FindChild("DisplayText",orderMGA,10).Click();
           Get_OrdersBar_BtnFills().Click();
           aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForBond(), "IsVisible", cmpEqual, true);
           aqObject.CheckProperty(Get_WinOrderFills_GrpFills_CmbRateOriginForBond(), "IsEnabled", cmpEqual, false);
           Get_WinOrderFills_BtnCancel().Click();
         
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
        //suppression des critere de la BD
        Log.Message("------------- C L E A N U P -----------------------------");
       
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }
 
 function Get_WinStocksOrderDetail_CmbOrderType(){return Get_WinOrderDetail().FindChild("Uid", "ComboBox_9fdb", 10)} //ok

 // fonction pour Selectionner et Verifier l'ordre MGA
function selectAndVerify_OrderMGA(order){
  
                 var nbr = Get_OrderAccumulatorGrid().RecordListControl.Items.Count
                 for(var i = 0; i<nbr; i++) {
                    if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == order)
                    {
                        
                        Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).set_IsSelected(true); 
                        Get_OrderAccumulator().FindChild("Text",order , 10).Click();
                        Get_OrderAccumulator_BtnVerify().Click();
                      
                     
                   
                 break;
                }                
              
            }
}


function Search_OrderBySymbol(order){
      
  ClickOnToolbarSearchButton();
  Get_WinQuickSearch_TxtSearch().SetText(order);
  Get_WinOrdersQuickSearch_RdoSymbol().set_IsChecked(true);
  Get_WinQuickSearch_BtnOK().Click();
  Delay(3000);

}

