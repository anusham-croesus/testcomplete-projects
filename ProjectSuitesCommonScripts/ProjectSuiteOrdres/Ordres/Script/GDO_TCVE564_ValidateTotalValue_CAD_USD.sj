//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0
//USEUNIT CR2140_6028_NotDiscWhoseASC3rdPos1Or2And12thPos0AndOthersIncluding10thPosIsU
//USEUNIT GDO_2464_Split_Of_BlockTrade
//USEUNIT GDO_TCVE608_TotalValue_CAD_USD_LimitPrice

/**
    Module               :  Orders
    Jira                 :  TCVE-564
    Description          :  GDO Ajouter des ordres en bloc pour valider les colonnes: Valeur totale(CAD - USD) en fonction du champ Type d'ordre
    Préconditions        : 
    
    Auteur               :  Youlia Raisper
    Version de scriptage :	90.14-Lu-77
  
    
*/


function GDO_TCVE564_ValidateTotalValue_CAD_USD() {
         
      try {
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-564");
                        
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                        
            var Account800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account800002NA", language+client);
            var Account800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Account800002OB", language+client);            
            var cmbTransactionType_TCVE564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE564", language+client);            
            var quantity_TCVE564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantity_TCVE564", language+client);           
            var symbol_TCVE564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "symbol_TCVE564", language+client);                        
            var cmbTransaction_TCVE564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransaction_TCVE564", language+client); 
            var descSecurityNA_2514=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "descSecurityNA_2514", language+client); 
            var atPrice=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "atPrice_TCVE564", language+client);  
            var limit=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "limit_TCVE564", language+client);
            var Value_Acc800002NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value_Acc800002NA_564", language+client);  
            var Value_Acc800002OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "Value_Acc800002OB_564", language+client); 
            var stop_564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "stop_TCVE564", language+client); 
            var totalValueCad_NA=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "totalValueCad_NA", language+client);
            var totalValueCad_OB=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "totalValueCad_OB", language+client);
            var stopWithlimit_564=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "stopWithlimit_564", language+client);
                                
            //Se connecter à croesus
            Log.Message("Se connecter à croesus");
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            
            /*Aller dans le module Compte; Sélectionner les comptes 800002-NA et 800002-OB
            cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)*/
            Log.Message("Aller dans le module Compte; Sélectionner les comptes 800002-NA et 800002-OB");
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().WaitProperty("IsEnabled", true, 30000);
            SelectTwoAccounts(Account800002NA,Account800002OB);
            
            Log.Message("cliquer sur le bouton Ordres multiple, en bloc et d'échanges (icone bleue et rose $)");
            Get_Toolbar_BtnSwitchBlock().Click();
            WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
            
            /*Dans la fenêtre choisir.Transactions = Achat + Ajouter .Quantité = 100.Unités par compte.Symbole = NA (BANQUE NATIONALE DU CDA).OK
            Cliquer sur Générer*/
            Log.Message("Dans la fenêtre choisir.Transactions = Achat + Ajouter .Quantité = 100.Unités par compte.Symbole = NA (BANQUE NATIONALE DU CDA).OK");
            CreateBuyOrderSwitchBlock(cmbTransaction_TCVE564,quantity_TCVE564,cmbTransactionType_TCVE564,symbol_TCVE564,descSecurityNA_2514);
           
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE564)*2,10).DblClick();
                           
            Log.Message("Dans la section Paramètres champ Type d'ordres:Sélectionner dans la liste déroulante 'Cours limite' Mettre 50.00 dans le champ Prix de l'ordre");            
            ChangeParameters(limit, Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit(), atPrice);            
            Validations(totalValueCad_NA,totalValueCad_OB,Account800002NA,Account800002OB,Value_Acc800002NA,Value_Acc800002OB);
            
            /*réouvrir en double cliquant sur le même ordre.*/
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE564)*2,10).DblClick();
            
            /*Sélectionner dans la liste déroulante 'Stop'.Mettre 50.00 dans le champ Prix de l'ordre Cours limite*/
            Log.Message("Sélectionner dans la liste déroulante 'Stop'.Mettre 50.00 dans le champ Prix de l'ordre Cours limite");
            ChangeParameters(stop_564, Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit(), atPrice);            
            Validations(totalValueCad_NA,totalValueCad_OB,Account800002NA,Account800002OB,Value_Acc800002NA,Value_Acc800002OB);
           
            /*réouvrir en double cliquant sur le même ordre.*/
            Log.Message("Dans l'accumulateur sélectionner l'ordre créé et faire un double click pour ouvrir la fenêtre.");
            Get_OrderAccumulatorGrid().FindChild("DisplayText",aqConvert.StrToInt(quantity_TCVE564)*2,10).DblClick();
            
            Log.Message("Sélectionner dans la liste déroulante 'Stop'. Mettre 50.00 dans le champ Prix de l'ordre Cours limite");            
            ChangeParameters(stop_564, Get_WinStocksOrderDetail_GrpParameters_TxtPriceLimit(), atPrice);
            
            Log.Message("Sélectionner dans la liste déroulante 'Stop avec limite'. Mettre 50.00 dans le champ Prix de l'ordre Cours limite");            
            ChangeParameters(stopWithlimit_564,  Get_WinStocksOrderDetail_GrpParameters_TxtStopPrice(), atPrice);            
            Validations(totalValueCad_NA,totalValueCad_OB,Account800002NA,Account800002OB,Value_Acc800002NA,Value_Acc800002OB);
                                   
            
      }
      catch (e) {                   
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
      }
      finally {
            Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
            Get_ModulesBar_BtnOrders().Click();
            //Supprimer l'ordre généré
            DeleteAllOrdersInAccumulator(); 
            //Fermer l'application
            Terminate_CroesusProcess();                       
        }
}

function ValidateTotalValueCAD(value1,value2,Account800002NA,Account800002OB)
{
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",Account800002NA,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value1);
  aqObject.CheckProperty(Get_WinOrderDetail_TabUnderlyingAccounts_DgvUnderlyingAccounts().FindChild("Value",Account800002OB,10).DataContext.DataItem, "ValueNeededND", cmpEqual,value2);
}


function Validations(totalValueCad_NA,totalValueCad_OB,Account800002NA,Account800002OB,Value_Acc800002NA,Value_Acc800002OB){
   Log.Message("Valider que la valeur totale (CAD):tous les comptes affichent 5000,00");
   ValidateTotalValueCAD(totalValueCad_NA,totalValueCad_OB,Account800002NA,Account800002OB);
            
   Log.Message("Valider que la valeur totale en devise du compte: Le 800002-NA affiche 5000,00; Le 800002-OB affiche 4723.67.");
   ValidateTotalValue(Value_Acc800002NA,Value_Acc800002OB,Account800002NA,Account800002OB); 
   Get_WinOrderDetail_BtnCancel().Click();
}

function ChangeParameters(subMenuItem, typePrice, price){
    Get_WinStocksOrderDetail_GrpParameters_CmbOrderType().Click();
    Get_SubMenus().FindChild("WPFControlText",subMenuItem,10).DblClick();             
    typePrice.Keys(price);
    typePrice.Keys("[Tab]");
}