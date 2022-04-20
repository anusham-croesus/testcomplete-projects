//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade

/**
    Jira Xray                 : TCVE-132
    Description               : Ajout de valeur "Switch/Échange" dans Filtres et Critères
    Version de scriptage      : ref90-16-2020-5-42

    Analyste d'automatisation : Youlia Raisper
**/

function TCVE_132_GDO2153_SwitchExchangeFiltersCriteria()
{
    var logEtape1, logEtape2,logEtape3,logEtape4, logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-132","https://jira.croesus.com/browse/GDO-2153");
        
        var userNameKEYNEJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ     = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var cmbTransactionType_TCVE132=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbTransactionType_TCVE132", language+client);
        var cmbQuan            =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbQuan", language+client);
        var quantityTCVE132    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "quantityTCVE132", language+client);
        var FID081             =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FID081", language+client);
        var FID1001            =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "FID1001", language+client);
        var exchangeTCVE312    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "exchangeTCVE312", language+client);
        var QuantityAcc        =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "QuantityAcc", language+client);
        var nameFilter         =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameFilter", language+client);
        var nameCriteria       =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameCriteria", language+client);
        var cmbFieldTCVE312    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbFieldTCVE312", language+client);
        var cmbOperatorTCVE312 =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbOperatorTCVE312", language+client);
        var cmbValueTCVE312    =ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbValueTCVE312", language+client);
        var criterion          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CriterionName_2507", language+client);
        var status             = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "StatusExecuted_2483", language+client);
        var coteAchat          = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CoteAchat_2507", language+client);
        var criterionCoteAchat = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "CriterionCoteAchat_2507", language+client);
        

        //******************************************* Étape 1***************************************************
        logEtape1 = Log.AppendFolder("Étape 1: Créer un ordre d'échange.");
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders) 
        
        Log.Message("Se connecter à croesus");
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.Message("Vider l'accumulateur");
        Get_ModulesBar_BtnOrders().Click();
        DeleteAllOrdersInAccumulator(); 
        
        Log.Message("Aller dans le module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        
        Log.Message("Cliquer sur bouton 'Ordres multiples' (bleu-rose).");
        Get_Toolbar_BtnSwitchBlock().Click()
         WaitObject(Get_CroesusApp(),"Uid","SwitchWindow_e8cd");
        
        Log.Message("Transaction(s): Échange de fonds d'investissement");
        SelectComboBoxItem(Get_WinSwitchBlock_GrpParameters_CmbTransactions(),cmbTransactionType_TCVE132);
  
        Log.Message(" Transaction(s): Vente; cliquer sur Ajouter..");
        Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchSourceWindow_4043");
        SelectComboBoxItem(Get_WinSwitchSource_CmbQuantity(),cmbQuan);
               
        Log.Message("Quantité: 1500 unités; Titre: FID081");
        Get_WinSwitchSource_TxtQuantity().Keys(quantityTCVE132);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(FID081);
        Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]"); 

        SetAutoTimeOut(); 
        if(Get_SubMenus().Exists){       
          Aliases.CroesusApp.subMenus.Find("Value",FID081,10).DblClick();   
        } 
        RestoreAutoTimeOut();  
        
        Log.Message("Confirmer.");   
        Get_WinSwitchSource_btnOK().Click();
               
        Log.Message("Transaction(s) équivalente(s): Achat");
        Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
        WaitObject(Get_CroesusApp(),"Uid","SwitchEquivalentWindow_6398");
        
        Log.Message("Quantité: 100%; Titre: FID1001");
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(FID1001);
        Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys("[Tab]");
        SetAutoTimeOut(); 
        if(Get_SubMenus().Exists){       
          Aliases.CroesusApp.subMenus.Find("Value",FID1001,10).DblClick();   
        } 
        RestoreAutoTimeOut(); 
        Get_WinSwitchEquivalent_btnOK().Click();
        
        Log.Message(" Cliquer Générer.");
        Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
        Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled",true,2000);
        Get_WinSwitchBlock_BtnGenerate().Click(); 
        
        WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
        SetAutoTimeOut();
        if(Get_WinSwitchBlock().Exists){
           Get_WinSwitchBlock_BtnGenerate().Click(); 
           WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "SwitchWindow_e8cd");
        }
        RestoreAutoTimeOut();
        
        Log.Message("L'ordre apparait dans l'Accumulateur.");
        aqObject.CheckProperty(Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",exchangeTCVE312,10).DataContext.DataItem,"Quantity", cmpEqual, QuantityAcc);     

       
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Envoyer l'ordre au Blotter.");
        Log.Message("Sélectionner l'ordre dans l'Accumulateur.");
        Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",exchangeTCVE312,10).Click();
        
        Log.Message("Cliquer sur Vérifier.");
        Get_OrderAccumulator_BtnVerify().Click();
        WaitObject(Get_CroesusApp(),"Uid","BatchOrderVerificationWindow_342c");
        
        Log.Message("Cocher le checkbox.");
         if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
          Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        
        Log.Message("Cliquer Soumettre.");
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
                      
        //******************************************* Étape 3***************************************************
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Appliquer le filtre sur le Blotter.");
        Log.Message("Créer le filtre");
        SetAutoTimeOut();
        do{
          Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click(); 
        }while(!Get_SubMenus().Exists)
        RestoreAutoTimeOut();         
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        
        Log.Message("Côté Égale Échange")
        Get_WinAddFilter_TxtName().Keys(nameFilter);
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(),cmbFieldTCVE312);
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(),cmbOperatorTCVE312);               
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbValue(),cmbValueTCVE312);         
        
        Log.Message("Appliquer le filtre")
        Get_WinAddFilter_BtnOK().Click();
        Log.Message("Crash lorsqu'on ajoute un filter. Jira :TCVE-2088");
           
        Log.Message("L'ordre créé en 1 est visible.");
        aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",exchangeTCVE312,10).DataContext.DataItem,"Quantity", cmpEqual, QuantityAcc);  
        Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",true,5000);
        aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items,"Count", cmpEqual, 1);    
        
        Log.Message("Désactiver le filtrer ");        
        Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",false,5000);
        
        if(Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().IsChecked==true){
          Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().Click();
          Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",false,5000);
        };
              
        aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items,"Count", cmpGreater, 1);
        
        //******************************************* Étape 4***************************************************
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Appliquer le critère de recherche sur le Blotter.");
        
        Log.Message("Cliquer sur le bouton Ajouter un critère.")
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click();
        
        Log.Message("Cérer le critère.")
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().set_Text(nameCriteria);
        
        Log.Message("Liste des ordres Ayant Côté Égale à Échange.")       
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(nameCriteria);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemExchange().Click()
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        Delay (2000);
        
        Log.Message("L'ordre créé en 1 est visible.");
        aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).FindChild("Value",exchangeTCVE312,10).DataContext.DataItem,"Quantity", cmpEqual, QuantityAcc);  
        aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items,"Count", cmpEqual, 1);   
  
        
        //******************************************* Étape 5***************************************************
    
        Log.Message("Cliquer sur Réafficher tout et conserver les crochets");
        Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click(); 
      
        Log.Message("Validation : Le critèrer est enlevé");
        var countAfter2 = Get_OrderGrid().RecordListControl.Items.Count;
        aqObject.CompareProperty(countAfter2,cmpNotEqual,countAfter);    
       
        for (var i=0; i<countAfter2; i++) {
            if (Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Status!=status) {
                Log.Message("Le critère est enlevé");
                break;
            }
        }
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Couvertire du Croes-2507 GDO_2507_Generate_Criterion_In_OrdersModule_Case1.");

        Log.Message("Ajouter un nouveau critère");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Log.Message("Cliquer sur Ajouter ou afficher un critère actif");
        Get_Toolbar_BtnAddOrDisplayAnActiveCriterion().Click(); 
        
        Log.Message("Saisir: Liste des ordres ayant côté égal(e) à Achat");       
        Log.Message("Creation de critère «Saisir par Liste des ordres ayant côté égal(e) à Achat (Buy) puis sauvegarder et régénérer»");
        Get_WinAddSearchCriterion_TxtName().Clear();
        Get_WinAddSearchCriterion_TxtName().Keys(criterionCoteAchat);
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb().Click();   
        Get_WinAddSearchCriterion_LvwDefinition_LlbVerb_ItemHaving().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbOperator_ItemEqualTo().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue().Click();      
        Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemBuy().Click()
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext().Click();
        Get_WinAddSearchCriterion_LvwDefinition_LlbNext_ItemDot().Click();
        Get_WinAddSearchCriterion_BtnSaveAndRegenerate().Click();
        Delay(2000);
    
        Log.Message("Validation: Tous les ordres dont côté égal(e) à Achat seront affichés");
        var countAfter=Get_OrderGrid().RecordListControl.Items.Count;
        for (var i=0; i<countAfter; i++) {
            aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "TypeForDisplay", cmpEqual,coteAchat);
        }
        Close_Croesus_MenuBar();
        
    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
  
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Delete_FilterCriterion(nameCriteria,vServerOrders)//Supprimer le filtre de BD
        Delete_FilterCriterion(nameFilter,vServerOrders)//Supprimer le filtre de BD  
        Delete_FilterCriterion(criterionCoteAchat,vServerOrders); //Supprimer le critère «criterionCoteAchat» cotecriterion de BD 
        Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
    }
}


function Get_WinAddSearchCriterion_LvwDefinition_LlbField_ItemInformative_ItemSide()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "côté"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "side"], 10)}
}

function Get_WinAddSearchCriterion_LvwDefinition_LlbValue_ItemBuy()
{
  if (language == "french") {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Achat"], 10)}
  else {return Get_CroesusApp().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", "Buy"], 10)}
}
