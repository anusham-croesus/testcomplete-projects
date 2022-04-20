//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT CR2140_6026_MultipleOrdersOnNonDiscAccountIncludingASC3rdPosition1Or2And12thPosition0()


/**
    Module               :  Orders
    Jira                 :  GDO-2999 et tcve-1965
    Description          :  Script pour couvrir les 2 jiras GDO-2468 et GDO-2571 
    Préconditions        : 
    
    Auteur               :  Alhassane D
    Version de scriptage :	90.12.2020.8-7
    date                 :  13-08-2020 
  
    
*/

function TCVE_1965_GDO2999_SearchCriteria_From_GDO_ReturnsFalseResult()
 {             
    try{  
 
           //Lien de la story dans Jira
           Log.Link("https://jira.croesus.com/browse/TCVE-1897","Lien de la story dans Jira");
           
    
            //Declaration des Variables
           var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
           var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
           
           var account800214NA      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT800214NA", language+client);
           var account800217RE      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT800217RE", language+client);
           var account800215OB      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT800215OB", language+client);
           var orderRY              = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDER_RY", language+client);
           var orderFID083          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDER_FID083", language+client);
           
           var curentListCrochet    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "sourceTypeStep4", language+client);
           var buyOrder             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDRE_ACHAT", language+client);
           var sellOrder            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORDRE_VENTE", language+client);
           
           var quantityRY          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QUANTITE_RY", language+client);
           var quantityFID083      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "QUANTITE_FID083", language+client);
           var perAccount          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "PERACCOUNT", language+client);
           var moduleOrdres        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "MODULE", language+client);
           var nameCriteria        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CRITERIA800214NA", language+client);
           var critere2            = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "NBR_ELEMENTS", language+client)
           
           
           var verifyquantityRY     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "VERIFY_QUANTITE_RY", language+client);
           var verifyQuantityFID083 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "VERIFY_QUANTITE_FID083", language+client)
           var account800214        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ACCOUNT800214", language+client)
           var nbr_element          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "NBR_ELEMENTS", language+client)
           
//         
/************************************Étape 1************************************************************************/     
          //Se connecter à croesus avec KEYNEJ
          Log.PopLogFolder();
          logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ et mailler le compte 800053-NA vers le portefeuille ");
          Log.Message("Se connecter à croesus avec KEYNEJ");
          Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
          Get_MainWindow().Maximize();
          
           
/************************************Étape 2************************************************************************/     
          
          Log.PopLogFolder();
          logEtape2= Log.AppendFolder("Acceder au module compte puis selectionner les comptes 800214-NA, 800215-OB et 800217RE ");
         
          //Accéder au module compte
          Log.Message("Acceder au module Compte");
          Get_ModulesBar_BtnAccounts().Click();
          Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 30000);
          
          //Sélectionner les comptes 800214-NA et 800217-RE
          Log.Message("Sélectionner le compte "+account800214NA+" , "+account800214NA+""+account800214NA);
          Search_Account(account800214NA);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800214NA, 10).Click(-1, -1, skCtrl);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800215OB, 10).Click(-1, -1, skCtrl);
          Get_RelationshipsClientsAccountsGrid().FindChild("Value", account800217RE, 10).Click(-1, -1, skCtrl);
          
          //Cliquer sur espace
          Log.Message("Cliquer sur espace")
          Get_RelationshipsClientsAccountsGrid().Keys(" ");
          
/************************************Étape 3************************************************************************/    
       
          
          
          
          Log.PopLogFolder();
          logEtape3= Log.AppendFolder("Generer deux ordres d achat avec les donnes suivantes : Sources : Sélectionner Liste courante (Crochets), Transaction: Achat, (RY quantite =100) et (FID083 quantite + 150  puis faire les validations");
          //cliquer sur le bouton ordres en bloc 
          Get_Toolbar_BtnSwitchBlock().Click();
          
          //Valider le nombre d'element
          aqObject.CheckProperty(Get_WinSwitchBlock_GrpParameters_LblElements(),"Text", cmpEqual, nbr_element);
                  
          
          
          /// selectionner la liste courante dans source  et achat dans transaction 
          Log.Message("selectionner la liste courante dans source  et achat dans transaction ")
          Get_WinSwitchBlock_GrpParameters_CmbSources().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",curentListCrochet],10).Click();
          Get_WinSwitchBlock_GrpParameters_CmbTransactions().Click();
          Get_SubMenus().FindChild(["ClrClassName","WPFControlText"],["TextBlock",buyOrder],10).Click();
          Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click(); 
          Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10);
          
           //Saisir les données pour RY :quantite =100
           Log.Message("Saisir les données pour RY :quantite =100");
           Get_WinSwitchSource_TxtQuantity().Keys(quantityRY);
           Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
           Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 3).Click();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(orderRY);
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
           if(Get_SubMenus().Exists){
              Get_SubMenus().FindChild("Value",orderRY,10).DblClick();
           }
           Get_WinSwitchSource_btnOK().Click();
          
          
           //Saisir les données pour FID083 :quantite =150
           Log.Message("Saisir les données pour FID083 :quantite =150");
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click(); 
           Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10);
           Get_WinSwitchSource_TxtQuantity().Keys(quantityFID083);
           Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
           Aliases.CroesusApp.subMenus.WPFObject("ComboBoxItem", "", 3).Click();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(orderFID083);
           Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
           Get_WinSwitchSource_btnOK().Click();
           
           //Points de verication 
           Log.Message("valider que :Les deux transactions sont ajoutées Dans Aperçu, 6 ordres d'achats cochés dans les comptes 800214-NA, 800217-RE et 800215-OB (2 ordres pour chaque compte)") 
            var grid = Get_WinSwitchBlock().WPFObject("GroupBox", "Transaction(s): Achat", 3).WPFObject("SwitchSourceGrid").WPFObject("RecordListControl", "", 1)
            var displayquantityitem1=grid.Items.Item(0).DataItem.Quantity
            var displayquantityitem2=grid.Items.Item(1).DataItem.Quantity
            var displaySymbolItem1=grid.Items.Item(0).DataItem.SymbolDisplay
            var displaySymbolItem2=grid.Items.Item(1).DataItem.SymbolDisplay
            
            CheckEquals(displaySymbolItem1, orderRY, "Le Symbole du premier item ");
            CheckEquals(displaySymbolItem2, orderFID083, "Le Symbole du deuxieme item");
            CheckEquals(displayquantityitem1, quantityRY, "La quantité de RY (Premier item)");
            CheckEquals(displayquantityitem2, quantityFID083, "La quantité de FID083 (deuxieme  item)");
            
            //Cliquer sur le bouton appercu puis faire les validations 
            Get_WinSwitchBlock_BtnPreview().Click();     
            
            Delay(3000);
            var grid1 = Get_WinSwitchBlock().WPFObject("_switchTransactionGrid").WPFObject("RecordListControl", "", 1)
            //Aliases.CroesusApp.winSwitchBlock.WPFObject("_switchTransactionGrid").WPFObject("RecordListControl", "", 1)
            var accountNumberItem1=grid1.Items.Item(0).DataItem.AccountNumber
            var accountNumberitem2=grid1.Items.Item(1).DataItem.AccountNumber
            var accountNumberItem3=grid1.Items.Item(2).DataItem.AccountNumber
            var accountNumberItem4=grid1.Items.Item(3).DataItem.AccountNumber
            var accountNumberItem5=grid1.Items.Item(4).DataItem.AccountNumber
            var accountNumberItem6=grid1.Items.Item(5).DataItem.AccountNumber
            
            var symbolItem1=grid1.Items.Item(0).DataItem.Symbol
            var symbolItem2=grid1.Items.Item(1).DataItem.Symbol
            var symbolItem3=grid1.Items.Item(2).DataItem.Symbol
            var symbolItem4=grid1.Items.Item(3).DataItem.Symbol
            var symbolItem5=grid1.Items.Item(4).DataItem.Symbol
            var symbolItem6=grid1.Items.Item(5).DataItem.Symbol
            
            CheckEquals(accountNumberItem1, account800214NA, "Le numero de compte du premier item ");
            CheckEquals(accountNumberItem1, account800214NA, "Le numero de compte du deuxieme item ");
            CheckEquals(accountNumberItem3, account800217RE, "Le numero de compte du troisieme item ");
            CheckEquals(accountNumberItem4, account800217RE, "Le numero de compte du quatrieme item");
            CheckEquals(accountNumberItem5, account800215OB, "Le numero de compte du cinquieme item");
            CheckEquals(accountNumberItem6, account800215OB, "Le numero de compte du sixieme item");
            
            
            CheckEquals(symbolItem1, orderRY, "Le Symbole du deuxieme item");
            CheckEquals(symbolItem2, orderFID083, "Le Symbole du premier item ");
            CheckEquals(symbolItem3, orderRY, "Le Symbole du quatrieme item)");
            CheckEquals(symbolItem4, orderFID083, "Le Symbole du troisieme item)");
            CheckEquals(symbolItem5, orderRY, "Le Symbole du sixieme item");
            CheckEquals(symbolItem6, orderFID083, "Le Symbole du cinquieme item");
 
 
          
            

/************************************Étape 4************************************************************************/            
          
          Log.PopLogFolder();
          logEtape4= Log.AppendFolder("Generer les  ordres  et faire les validstion dans l'accumulateur");
          Get_WinSwitchBlock_BtnGenerate().Click();
          
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(0).DataItem, "OrderSymbol", cmpEqual,orderFID083);
          aqObject.CheckProperty(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(1).DataItem, "OrderSymbol", cmpEqual,orderRY);
              
          Get_OrderAccumulatorGrid().FindChild("Value", orderRY, 10).Click(-1, -1, skCtrl);
          Get_OrderAccumulatorGrid().FindChild("Value", orderFID083, 10).Click(-1, -1, skCtrl);
          Get_OrderAccumulator_BtnVerify().Click();
 
          
/************************************Étape 5************************************************************************/            
                      
          Log.PopLogFolder();
          logEtape5= Log.AppendFolder("Cocher la case inclure puis soumettre l'ordre");   
          //Cocher la case inclure puis soumettre l'ordre
          var width=Get_WinAccumulator().get_ActualWidth()
          var height=Get_WinAccumulator().get_ActualHeight()
          Get_WinAccumulator().Click(width/20,height-320);
          Get_WinAccumulator().Click(width/20,height-290);
          Get_WinAccumulator_BtnSubmit().Click();
          WaitObject(Get_CroesusApp(), "Uid","DataGrid_e262", true);
          
          //Validation Blotter
/************************************Étape 6************************************************************************/            
                    

          Log.PopLogFolder();
          logEtape6= Log.AppendFolder("À partir de la bare de menu de la grille du module Ordres, Ajouter le critère de recherche 'Liste des ordres portant sur des comptes sous-jascents ayant numéro de compte égal à 800214-NA' puis sauvegarder et appliqué");
          
                      
          Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
          Get_WinAddSearchCriterion_TxtName().Clear();
          Get_WinAddSearchCriterion_TxtName().Keys(nameCriteria);
          Get_WinAddSearchCriterion_CmbModule().Click();
          Get_SubMenus().FindChild("WPFControlText",moduleOrdres,10).Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
          Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemUnderlyingAccountsHaving().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemAccountNumber().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(account800214NA);
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
          Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
          Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
                         
          
          
          //Validation
          var grid= Get_OrderGrid().RecordListControl
          var count = grid.Items.Count
        
          for(var i = 0; i<count; i++) {
              if(grid.Items.Item(i).DataItem.OrderSymbol == orderRY){
                
                     aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DisplayQuantityStr", cmpEqual,verifyquantityRY);                            
          }  
           if(grid.Items.Item(i).DataItem.OrderSymbol == orderFID083){
                
                     aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DisplayQuantityStr", cmpEqual,verifyQuantityFID083);                            
           }              
            
         }
           
          
                      
/************************************Étape 7************************************************************************/            
          Log.PopLogFolder();
          logEtape7= Log.AppendFolder("Dans la bare de menu du module Ordres, cliquer sur  le bouton 'Réafficher tout et enlever les crochets' pour raffraichir la grille Ordres"); 
          Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
                  
          
                      
          
/************************************Étape 8************************************************************************/            
                    
          Log.PopLogFolder();
          logEtape8= Log.AppendFolder("Modifier le critère de recherche crée précédement à 'Liste des ordres portant sur des comptes sous-jascents ayant numéro de compte débutant par 800214'Sauvegarder et appliquer");
          
            
            var critere2 = "critere2"
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
            Get_WinAddSearchCriterion_TxtName().Clear();
            Get_WinAddSearchCriterion_TxtName().Keys(critere2);
            Get_WinAddSearchCriterion_CmbModule().Click();
            Get_SubMenus().FindChild("WPFControlText",moduleOrdres,10).Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
            Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemUnderlyingAccountsHaving().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemAccountNumber().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemStartingWith().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Keys(account800214);
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
            Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
            Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
            
            
             //Validation
            var grid= Get_OrderGrid().RecordListControl
            var count = grid.Items.Count
        
            for(var i = 0; i<count; i++) {
               if(grid.Items.Item(i).DataItem.OrderSymbol == orderRY){
                
                     aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DisplayQuantityStr", cmpEqual,verifyquantityRY);                            
             }  
            if(grid.Items.Item(i).DataItem.OrderSymbol == orderFID083){
                
                     aqObject.CheckProperty(grid.Items.Item(i).DataItem, "DisplayQuantityStr", cmpEqual,verifyQuantityFID083);                            
             }              
            
            }
            
      
           
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        
    }
    finally {   
        
        //suppression des critere de la BD
        Log.Message("------------- C L E A N U P -----------------------------");
        Delete_FilterCriterion(nameCriteria,vServerOrders)
        Delete_FilterCriterion(critere2,vServerOrders) 
     
        //Fermer Croesus
        Terminate_CroesusProcess();      
    }
 }
 
 

 function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemInvolvingAccountsHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "portant sur des comptes ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "involving accounts having"], 10)}
}
 
 function Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemUnderlyingAccountsHaving()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "portant sur des comptes sous-jacents ayant"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "involving underlying accounts having"], 10)}
}

function Get_BuyTransaction_Grid(){return Get_WinSwitchBlock().FindChild("Uid", "DataGrid_78be", 10)}
  
function Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemStartingWith()
{
  if (language == "french"){return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "débutant par"], 10)}
  else {return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "starting with"], 10)}
}


