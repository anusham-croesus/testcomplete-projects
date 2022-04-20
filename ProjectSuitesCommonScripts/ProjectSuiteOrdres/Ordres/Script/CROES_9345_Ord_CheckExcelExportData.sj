//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA



/**
    Module: Ordres
    Exportation MS Excel ne respect pas l'ordre des colonnes de la grille Relation.
    Voir GetColumnOrderFromFieldLayout() dans FieldLayoutToExportLyout.cs
    
    Vérifier toutes les données exportées en excel avec:
    1- une configuration par défaut des colonnes
    2- Ajouter toutes les colonnes possibles à la grille
    3- Supprimer une colonne et déplacer une autre colonne

    Auteur :                Abdel Matmat
    Anomalie:               CROES-9345
    Version de scriptage:	90-07-Co-21
    Version mise à jour:    90.25.48 (Philippe Maurice)
    
    NB: Ce script couvre le script "CROES_9345_ExcelExportNotRespectOrderGridColumn", ce dernier n'est pas ajouté au projet d'exécution.
*/


function CROES_9345_Ord_CheckExcelExportData() {
    
    Log.Message("---- Activation des PREFs ----")
    Execute_SQLQuery("delete b_gdo_order where blotter_date >= convert(varchar, getdate(), 101) and status <> 70", vServerOrders)
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX", "YES", vServerOrders);
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_GDO_DISPLAY_FX_TAB_MF","YES", vServerOrders);
    RestartServices(vServerOrders);


    var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                              
    Log.Link("https://jira.croesus.com/browse/CROES-9345", "Cas de tests JIRA CROES-9345");
    Log.Link("https://jira.croesus.com/browse/TCVE-5427", "Lien XRay");
          
    try {
        var ExpectedFile_DefaultColumns = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES9345_Ord_DefaultColumnsFile", language+client);
        var ExpectedFile_AllColumns = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES9345_Ord_AllColumnsFile", language+client);
        var ExpectedFile_RandomColumns = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES9345_Ord_RandomColumnsFile", language+client);
        var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\Orders\\"+language+"\\";
        var ResultFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\Orders\\"+language+"\\";         
        
        var account = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Account1", language + client);
        var account2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Account2", language + client);
        var quantity = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Qty1", language + client);
        var quantity2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Qty2", language + client);
        var secDescription = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_SecDescription1", language + client);
        var secDescription2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_SecDescription2", language + client);
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Symbol1", language + client);
        var symbol2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "CROES_9345_Symbol2", language + client);
            
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        
        Log.PopLogFolder();
        logCreateMultipleOrders = Log.AppendFolder("Recherche des comptes et création des ordres multiples");        
        createMultipleOrder(account, quantity, secDescription, symbol);
        createMultipleOrder(account2, quantity2, secDescription2, symbol2);
        
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 30000);  
        Get_MainWindow().Maximize();
        
        
        //ÉTAPE 1
        Log.PopLogFolder();
        logValidationCROES10231 = Log.AppendFolder("Étape1: Validation du jira Croes-10231");        
        
        //Sélectionner tous les ordres
        Log.Message("Sélectionner tous avec: Ctrl+A ")
        Get_OrderAccumulatorGrid().Keys("^a");
        
        
        Get_OrderAccumulatorGrid().ClickR();
        while (! Get_OrderAccumulator_ContextualMenu_Copy().Exists )
            Get_OrderAccumulatorGrid().ClickR();
        Get_OrderAccumulator_ContextualMenu_Copy().Click();
        
        //Les points de vérifications
        Log.Message("Valider s'il y a un crash ou non");
        if (!Get_DlgError().Exists)
            Log.Checkpoint("No Crash detected");
        else 
            Log.Error("There is a crash!")
            
            
        //---ÉTAPE 2 ----
        Log.PopLogFolder();
        logDeleteAllOrders = Log.AppendFolder("Etape 2: Sélectionner toutes les ordres et les supprimer");        
        //Sélectionner tous les ordes
        Log.Message("Sélectionner tous avec :Ctrl+A ")
        Get_OrderAccumulatorGrid().Keys("^a");
        
        //Supprimer les ordres
        Log.Message("Suppression des ordres")
        if (Get_OrderAccumulator_BtnDelete().IsEnabled) {
            Get_OrderAccumulator_BtnDelete().Click();
            Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45); 
        }
        
        Get_OrderAccumulatorGrid().ClickR();
        while (! Get_OrderAccumulator_ContextualMenu_Copy().Exists )
            Get_OrderAccumulatorGrid().ClickR();
        Get_OrderAccumulator_ContextualMenu_Copy().Click();
        
        //Les points de vérifications
        Log.Message("Valider s'il y a un crash ou non");
        if (!Get_DlgError().Exists)
            Log.Checkpoint("No Crash detected");
        else 
            Log.Error("There is a crash!")
                  
        
        //-----ÉTAPE 3 -------
        Log.PopLogFolder();
        logStep3 = Log.AppendFolder("Etape 3: Vérification des données exportées en Excel");
        
        //1- Set the default configuration of columns in the grid
        Log.Message("Set the default configuration");
        SetDefaultConfiguration(Get_OrderGrid_ChPrice());
                    
        //Click the button export excel 
        Log.Message("Export file to excel");
        ClickOnExportToExcel(Get_OrderGrid()); 
                    
        //fermer les fichiers excel
        CloseExcel();
                    
        //Comparer les deux fichiers
        Log.Message("Check data exported to excel for default configuration " + ExpectedFile_DefaultColumns);
        ExcelFilesCompare(ExpectedFolder, ExpectedFile_DefaultColumns, ResultFolder);
                    
        //2-  Add All columns
        Log.Message("Add all columns");
        Add_AllColumnsWithoutProfiles(Get_OrderGrid_ChSymbol());
                    
        //Click the button export excel 
        Log.Message("Export file to excel");
        ClickOnExportToExcel(Get_OrderGrid());                   
                    
        //fermer les fichiers excel
        CloseExcel();
                    
        //Comparer les deux fichiers
        Log.Message("Check data exported to excel for all possible columns added with " + ExpectedFile_AllColumns);
        ExcelFilesCompare(ExpectedFolder, ExpectedFile_AllColumns, ResultFolder);
                    
        //3- Delete and move Columns
        Log.Message("Delete and move columns");
        DeleteColumn(Get_OrderGrid_ChPrice());
        MoveColumn(Get_OrderGrid_ChStatus());
                    
        //Click the button export excel 
        Log.Message("Export file to excel");
        ClickOnExportToExcel(Get_OrderGrid());                  
                    
        //fermer les fichiers excel
        CloseExcel();
                    
        //Comparer les deux fichiers
        Log.Message("Check data exported to excel after delete and move columns with " + ExpectedFile_RandomColumns);
        ExcelFilesCompare(ExpectedFolder, ExpectedFile_RandomColumns, ResultFolder);
         
    } 
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));                      
    }         
    finally { 
        //fermer les fichiers excel
        CloseExcel();
          
        //Delete files exported
        aqFileSystem.DeleteFile(Sys.OSInfo.TempDirectory + "\CroesusTemp\\*.txt");
                    
        //Set the default configuration of columns in the grid
        SetDefaultConfiguration(Get_OrderGrid_ChSymbol());
                   
        // Close Croesus 
        Terminate_CroesusProcess();                   
    }
}



function createMultipleOrder(account, quantity, securityDescription, symbol)
{    
    var transaction = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_transactionType", language + client);
    var qtyType = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "Anomalies", "ORC2125_QtyType", language + client);
    
    
    Log.Message("Aller dans le module Comptes et rechercher le compte " + account + ".");
    Get_ModulesBar_BtnAccounts().WaitProperty("Enabled", true, 15000);
    Get_ModulesBar_BtnAccounts().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    WaitUntilObjectDisappears(Get_CroesusApp(), ["ClrClassName", "WPFControlOrdinalNo"], ["ToggleButton", 1]);
        
    //recherche un compte
    Search_Account(account);
    WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", "1"]);
    Get_RelationshipsClientsAccountsGrid().Find("Value", account, 100).Click();
        
    //Creation de l'ordre
    Log.PopLogFolder();
    logCreationMultipleOrder = Log.AppendFolder("---- Création d'un ordre multiple: Symbole: " + symbol + "  Compte: " + account + " ----");
    
    //Click sur ordre multiple
    Log.Message("Cliquer sur ordre multiple et choisir le type de transaction (Vente)");
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
                    
    //Ajout d'une transaction(s):Vente 
    Log.Message("Ajout d'une transaction de vente")
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,10)      
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
          
    Log.Message("Entrer les informations:  Quantité = " + quantity + " unités par compte");
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_WinSwitchSource_TxtQuantity().set_Text(quantity);
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_SubMenus().Find("WPFControlText", qtyType, 10).Click();
    
    Log.Message("Entrer les informations:  Description = " + securityDescription );                
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    //Get_WinSwitchSource_CmbSecurity().Click();
    //Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();     
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Click();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().set_Text(symbol);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    if(Get_SubMenus().Exists){
        Get_SubMenus().FindChild("Value", securityDescription, 10).DblClick();
    }
    Get_WinSwitchSource_GrpPosition_TxtSecurity().WaitProperty("IsEnabled", true, 30000);
    Get_WinSwitchSource_GrpPosition_TxtPrice().WaitProperty("IsEnabled", true, 30000);   
    
    Get_WinSwitchSource_btnOK().WaitProperty("IsEnabled", true, 30000);
    Get_WinSwitchSource_btnOK().Click();
                      
    Log.Message("Cliquer sur Aperçu et Générer par la suite.");                
    Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
    Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 2000);
    Get_WinSwitchBlock_BtnGenerate().Click();
    
    //si il y a fenêtre pour confirmation ici
    if(Get_DlgConfirmation().Exists){
        Get_DlgConfirmation_BtnYes().Click();
    }
}

