//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT GDO_2464_Split_Of_BlockTrade

/**
    Jira Xray                 : TCVE-132
    Description               : Colonne Type - Modifications Filtres (GDO-1175)
    Version de scriptage      : ref90-16-2020-5-42

    Analyste d'automatisation : Youlia Raisper
**/

function TCVE_132_GDO1318GDO1175_EditFilters()
{
    var logEtape1, logEtape2,logEtape3,logEtape4, logRetourEtatInitial;
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-132","https://jira.croesus.com/browse/GDO-1318");
        
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        var nameBuyFilter=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameBuyFilter", language+client);
        var nameSellFilter=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "nameSellFilter", language+client);
        var cmbFieldTCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbFieldTCVE312", language+client);
        var cmbOperatorTCVE312=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbOperatorTCVE312", language+client);
        var cmbBuyValueGDO1318=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbBuyValueGDO1318", language+client);
        var cmbSellValueGDO1318=ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO", "cmbSellValueGDO1318", language+client);
        
        //******************************************* Étape 1***************************************************
        logEtape1 = Log.AppendFolder("Étape 1:Atteindre le module Ordres.");
        
        Log.Message("Se connecter à croesus");
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Get_ModulesBar_BtnOrders().Click();
 
        //******************************************* Étape 2***************************************************

        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2:Atteindre l'ajout de Filtres.");
        SetAutoTimeOut();
		    var numberOftries=0; 
		    while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click(); 
		    numberOftries++;
        }
        RestoreAutoTimeOut();         
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();

        //******************************************* Étape 3***************************************************
        
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: créer un filtre -Achat");
        Log.Message("Créer le filtre");
        Get_WinAddFilter_TxtName().Keys(nameBuyFilter);
        
        Log.Message(" Sélectionner:Champ = Côté");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(),cmbFieldTCVE312);
        
        Log.Message(" Sélectionner:Opérateur = égale");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(),cmbOperatorTCVE312);
          
        Log.Message(" Sélectionner:Valeur = Achat");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbValue(),cmbBuyValueGDO1318);
        
        Log.Message("Appliquer le filtre")
        Get_WinAddFilter_BtnOK().Click();
        Log.Message("Crash lorsqu'on ajoute un filter. Jira :TCVE-2088");
        Delay (2000);
        
        Log.Message("Les ordres d'ACHAT sont affichés dans le Blotter.")
        var count =Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Count          
        for(i=0;i<count;i++){
          aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"TypeForDisplay",cmpEqual,cmbBuyValueGDO1318);
        };
        
        Log.Message("Désactiver le filtrer ");        
        Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().Click();
        Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",false,5000);
        
        if(Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().IsChecked==true){
          Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().Click();
          Get_Toolbar_BtnActiveQuickFilterForSecuritiesAndOrders().WaitProperty("IsChecked",false,5000);
        };
        //******************************************* Étape 4***************************************************
        
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: créer un filtre Vente");
        SetAutoTimeOut();
        var numberOftries=0;
        while ( numberOftries < 5 && !Get_SubMenus().Exists){//Dans le cas, si le click ne fonctionne pas 
          Get_Toolbar_BtnQuickFiltersForSecuritiesAndOrders().Click() 
		    numberOftries++;
        }
        RestoreAutoTimeOut();         
        Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        
        Log.Message("Créer le filtre");
        Get_WinAddFilter_TxtName().Keys(nameSellFilter);
        
        Log.Message(" Sélectionner:Champ = Côté");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbField(),cmbFieldTCVE312);
        
        Log.Message(" Sélectionner:Opérateur = égale");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbOperator(),cmbOperatorTCVE312);
          
        Log.Message(" Sélectionner:Valeur = Vente");
        SelectComboBoxItem(Get_WinAddFilter_GrpCondition_CmbValue(),cmbSellValueGDO1318);
        
        Log.Message("Appliquer le filtre")
        Get_WinAddFilter_BtnOK().Click();
        Delay (2000);
        
        Log.Message("Les ordres de Vente sont affichés dans le Blotter.")
        var count =Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Count          
        for(i=0;i<count;i++){
          aqObject.CheckProperty(Get_OrderGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem,"TypeForDisplay",cmpEqual,cmbSellValueGDO1318);
        };         

    }
    catch(e) {

        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
  
        Log.PopLogFolder();
        logRetourEtatInitial = Log.AppendFolder("Retour à l'état initial");
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        Delete_FilterCriterion(nameSellFilter,vServerOrders)//Supprimer le filtre de BD
        Delete_FilterCriterion(nameBuyFilter,vServerOrders)//Supprimer le filtre de BD  
    }
}