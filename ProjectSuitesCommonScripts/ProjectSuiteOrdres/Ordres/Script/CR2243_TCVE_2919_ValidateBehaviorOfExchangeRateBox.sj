//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA


/**
    Description : Suite aux modifications apportés avec la story GDO-3523 le comportement de la boîte de Taux de change/module Ordres a été changé.

    1. Valider les options dans le menu contextuel du champ ‘Origine du taux’
    2. Valider le comportement de la boîte de taux de change :
   - les ordres ayant statut = ouvert, annulé, rejeté et expiré = GRISÉ (on ne peut pas appliquer de taux de change)
   - les ordres ayant un statut exécuté / exécuté partiellement = NON GRISÉ (on peut appliquer un taux de change)
    Lors d'une sélection multiple, tous les ordres sélectionnés doivent avoir un statut exécuté ou partiellement exécuté afin de pouvoir appliquer un taux de change.
    (Le comportement lors d’une saisie multiple doit être le même que pour une saisie individuelle)
    3. Valider la possibilité d’appliquer un taux de change aux ordres ayant un statut exécuté / exécuté partiellement
    4. Valider que les ordres annulé, expirés et les ordres rejetés peuvent être replacés dans l'accumulateur (le bouton Renvoyer doit être activé) GDO-3522
    
    Préconditions:
    PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX = YES
    PREF_GDO_DISPLAY_FX_TAB_MF = YES
    Exécuter le script attaché au cas de test pour ajouter des ordres dans le blotter   GDO-3622  (GDO3622_OB_inserer_ordres.sql)
    
    Analyste d'assurance qualité : Marina Gasin
    Analyste d'automatisation : Abdel Matmat
    Date: 21/10/2020
    version 2020.09-23
    version mis-à-jour:  90.24.2021.04-46
*/

function CR2243_TCVE_2919_ValidateBehaviorOfExchangeRateBox()
{
    try {
        
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-2620", "Lien vers la story");
        Log.Link("https://jira.croesus.com/browse/TCVE-2919", "Lien vers le cas de test");
         
        
        /*VARIABLES*/
        var userName = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var password = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var fileSQLToExecute = folderPath_Data + "GDO3622_OB_inserer_ordres.sql";
        var qteNA           = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteNA", language+client);
        var symbolNA        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolNA", language+client);
        var qteMSFT         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFT", language+client);
        var qteA27404       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteA27404", language+client);
        var infoMsg         = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "infoMsg", language+client);
        var nbrItems        = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "nbrItems", language+client);
        var rateOrigin1     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "rateOrigin1", language+client);
        var rateOrigin2     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "rateOrigin2", language+client);
        var rateOrigin3     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "rateOrigin3", language+client);
        var rateOrigin4     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "rateOrigin4", language+client);
        var rateChange      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "rateChange", language+client);
        var internalNumber  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "internalNumber", language+client);
        var symbolStep6     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolStep6", language+client);
        var internalNumberStep6 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "internalNumberStep6", language+client);
        var qteMSFTStep4    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFTStep4", language+client);
        var qteMSFTStep7    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFTStep7", language+client);
        var qteMSFTStep8    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFTStep8", language+client);
        var qteMSFTStep9    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFTStep9", language+client);
        var qteMSFTStep10   = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteMSFTStep10", language+client);
        var symbolStep11    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolStep11", language+client);
        var statusStep11    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusStep11", language+client);
        var qteStep12       = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteStep12 ", language+client); 
        var priceStep12     = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "priceStep12", language+client);
        var statusStep12    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "statusStep12", language+client); 
        var msgErrorStep13  = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "msgErrorStep13", language+client);
        var symbolMSFT      = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolMSFT", language+client);
        var symbolA27404    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolA27404", language+client);
        var symbol_NA_Status    = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbol_NA_Status", language+client);
        var qteA27404_2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "qteA27404_2", language+client);
        var symbolA27404_Status = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR2243", "symbolA27404_Status", language+client);

        
/************************************Préconditions************************************************************************/     
        Log.PopLogFolder();
        logEtape0 = Log.AppendFolder("Préconditions: Executer le fichier SQL et activation des prefs");
        Log.Message("Activation des prefs");
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_INTERNAL_NUMBER_FX","YES",vServerOrders);
        Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_DISPLAY_FX_TAB_MF","YES",vServerOrders);
        //Executer le fichier SQL
        ExecuteSQLFile_ThroughISQL(folderPath_Data + "GDO3622_OB_inserer_ordres.sql", vServerOrders);
        RestartServices(vServerOrders);
        
        
/************************************Étape 1************************************************************************/     
        //Se connecter à croesus avec Keynej
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1: Se connecter à croesus avec KEYNEJ");
        Log.Message("Se connecter à croesus avec KEYNEJ")
        Login(vServerOrders, userName, password, language);
        Get_MainWindow().Maximize();
          
        //Acceder au module Ordres
        Log.Message("Aller dans module Ordres");
        Get_ModulesBar_BtnOrders().Click();
          
        
/************************************Étape 2************************************************************************/     
        Log.PopLogFolder();
        logEtape2 = Log.AppendFolder("Étape 2: Ajouter la colonne Taux" );

        //Ajouter la colonne Taux
        Log.Message("Ajouter la colonne Taux");  
        if(!Get_OrderGrid_ChRate().Exists){
            Get_OrderGrid_ChAccountName().ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Get_GridHeader_ContextualMenu_AddColumn_Rate().Click();
        }

/************************************Étape 3************************************************************************/     
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Sélectionner 3 ordres suivants avec l’État ‘Exécuté’:" );
        //Sélectionner les ordres suivants avec l’État ‘Exécuté’:
        //Symbole: MSFT (CAD-CAD); Q=108 (Action)
        //Symbole: MSFT (USD- CAD); Q=102 (Action)
        //Symbole: A27404 (USD- CAD); Q=600 (Obligation)
        
        Get_OrderGrid_ChStatus().Click();
        Get_OrderGrid().Keys("[Right][Right][Right][Right][Right][Right]");
        Get_OrderGrid().Find("Value",qteA27404,10).Click();
        //Maintenir la touche CTRL enfoncée
        Sys.Desktop.KeyDown(0x11);
        Get_OrderGrid().Find("Value",qteMSFT, 10).Click();
        //Maintenir la touche CTRL enfoncée
        Sys.Desktop.KeyDown(0x11);
        Get_OrderGrid().Find("Value", qteMSFTStep4, 10).Click();
        //Relâcher la touche CTRL enfoncée
        Sys.Desktop.KeyUp(0x11);
        Get_OrderGrid().Find("Value", qteMSFTStep4, 10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        
        //les points de vérifications:Le champ Taux de change est disponible
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "Enabled", cmpEqual, true);
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "VisibleOnScreen", cmpEqual, true);
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
        aqObject.CheckProperty(Get_DlgInformation_LblMessage1(),"WPFControlText",cmpEqual, infoMsg);
        Get_DlgInformation_BtnOK().Click();
          
/************************************Étape 4************************************************************************/     
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Valider les options dans le menu contextuel du champ ‘Origine du taux’" );
           
        //Valider les options dans le menu contextuel du champ ‘Origine du taux’ 
        Log.Message("Valider que Taux négocié / Negotiated rate, s’affiche par défaut, les champs : Taux de change et No interne devraient être disponibles (ne sont pas grisés)");
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(),"Text",cmpEqual, rateOrigin1);
        Get_WinExchangeRate_GrpRate_CmbRateOrigin().Click();
        aqObject.CheckProperty(Get_SubMenus(),"ChildCount",cmpEqual, nbrItems);
        Get_SubMenus().Find("Text",rateOrigin1,10).Click();
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(),"Text",cmpEqual, rateOrigin1);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(),"IsReadOnly",cmpEqual, false);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(),"IsReadOnly",cmpEqual, false);
                    
        Log.Message("Valider que Taux quotidien / Daily rate, les champs : Taux de change et No interne devraient être disponibles (sont grisés)");
        Get_WinExchangeRate_GrpRate_CmbRateOrigin().Click();
        Get_SubMenus().Find("Text",rateOrigin2,10).Click();
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(),"Text",cmpEqual, rateOrigin2);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(),"IsReadOnly",cmpEqual, true);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(),"IsReadOnly",cmpEqual, true);
         
        Log.Message("Valider que Taux quotidien – net / Daily rate – wash, les champs : Taux de change et No interne devraient être disponibles (ne sont pas grisés)");
        Get_WinExchangeRate_GrpRate_CmbRateOrigin().Click();
        Get_SubMenus().Find("Text",rateOrigin3,10).Click();
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(),"Text",cmpEqual, rateOrigin3);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(),"IsReadOnly",cmpEqual, false);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(),"IsReadOnly",cmpEqual, false);
          
        Log.Message("Valider que Taux négocié – net / Negotiated rate – wash, les champs : Taux de change et No interne devraient être disponibles (ne sont pas grisés)");
        Get_WinExchangeRate_GrpRate_CmbRateOrigin().Click();
        Get_SubMenus().Find("Text",rateOrigin4,10).Click();
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_CmbRateOrigin(),"Text",cmpEqual, rateOrigin4);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble(),"IsReadOnly",cmpEqual, false);
        aqObject.CheckProperty(Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber(),"IsReadOnly",cmpEqual, false);
          
        Get_WinExchangeRate_GrpRate_CmbRateOrigin().Click();
        Get_SubMenus().Find("Text",rateOrigin1,10).Click();
        AddRateChange(rateChange, internalNumber);
                  
        if (Get_WinFXRateConfirmation().Exists)
            Get_WinFXRateConfirmation_BtnContinue().Click();
          
        var grid = Get_OrderGrid().RecordListControl;
        var count = grid.Items.Count;
        found = false;
        for (i=0; i < count; i++){
            if (grid.Items.Item(i).DataItem.Quantity == qteMSFT || grid.Items.Item(i).DataItem.Quantity == qteA27404){
                aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Rate", cmpEqual, rateChange);
                found = true;
            }
        }
        if (found == false)Log.Error("L'ordre n'existe pas dans la grille");
         
 /************************************Étape 6************************************************************************/     
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Sélectionner l'ordre d'achat de Fond mutuel / l’État : *En approbation (négociateur) /*Symbole:  A27404" );
                  
        Search_Order_Symbol(symbolStep6);
        selectAnOrderWithRate(symbolStep6);
        Get_OrderGrid().Find("Value", qteA27404, 10).ClickR();
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
        Log.Message("Ajouter un taux de change à l'ordre sélectionné");
        AddRateChange(rateChange, internalNumberStep6);
          
        //Potentiel message d'avertissement
        if (Get_WinFXRateConfirmation().Exists)
            Get_WinFXRateConfirmation_BtnContinue().Click();

        Log.Message("Valider que le taux de change est affiché dans le blotter pour l'ordre sélectionné");
        CheckRateInOrderGrid(symbolStep6, qteA27404, rateChange);
 
 /************************************Étape 7************************************************************************/     
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Sélectionner l'ordre d'achat action / l’État : Ouvert / Symbole: MSFT (USD - CAD); Q=103" );
                  
        Get_OrderGrid_ChSymbol().Click();
        selectAnOrderWithQuantity(symbolMSFT, qteMSFTStep7);
        SelectOrders(symbolMSFT); 
        Get_OrderGrid().Find("Value", qteMSFTStep7, 10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Log.Message("Valider que le champ Taux de chenge est grisé");
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
          
          
  /************************************Étape 8************************************************************************/     
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Sélectionner l'ordre d'achat - Action / l’État : Annulé / Symbole: MSFT (USD - CAD); Q=104" );
        
        Get_OrderGrid().Find("Value", qteMSFTStep8, 10).ClickR();
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Log.Message("Valider que le champ Taux de chenge est grisé");
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
        
/************************************Étape 9************************************************************************/     
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Sélectionner l'ordre d'achat - Action / l’État : Expiré / Symbole: MSFT (USD - CAD); Q=107" );

        Get_OrderGrid().Find("Value", qteMSFTStep9, 10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Log.Message("Valider que le champ Taux de chenge est grisé");
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
        Log.Message("Cliquer sur le bouton Renvoyer");
        Get_OrdersBar_BtnReplace().Click();
        Log.Message(" Valider que l’ordre est replacé dans l’Accumulateur");
        aqObject.CheckProperty(Get_OrderAccumulator().Find("Value", qteMSFTStep9, 10), "Exists", cmpEqual, true);
        aqObject.CheckProperty(Get_OrderAccumulator().Find("Value", qteMSFTStep9, 10), "VisibleOnScreen", cmpEqual, true);
          
/************************************Étape 10************************************************************************/     
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 10: Sélectionner l'ordre d'achat - Action / l’État : Rejeté / Symbole: MSFT (USD - CAD); Q=106" );
        
        Get_OrderGrid().Find("Value", qteMSFTStep10, 10).ClickR()
        Get_OrderGrid_ContextualMenu_Functions().Click();
        Log.Message("Valider que le champ Taux de chenge est grisé");
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, false);
        Log.Message("Valider que le bouton Renvoyer est activé");
        aqObject.CheckProperty(Get_OrdersBar_BtnReplace(), "Enabled", cmpEqual, true);
          
/************************************Étape 11************************************************************************/     
        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Étape 11: Sélectionner l’ordre Symbole : A27404 / Cliquer sur bouton : Consulter…+ Approuver" );

        selectAnOrderWithStatus(symbolA27404, symbolA27404_Status);
        
        Get_OrdersBar_BtnView().Click();
        WaitObject(Get_CroesusApp(), "Uid", "OrderDetails_d698");
        Get_WinOrderDetail_BtnApprove().Click();
        Delay(2000);
        Log.Message("Valider que l'état de l'ordre est 'ouvert'");
        aqObject.CheckProperty(Get_WinOrderFills_GrpBuyOrSellOrder_TxtStatus(), "Text", cmpEqual, statusStep11);

/************************************Étape 12************************************************************************/     
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: Sélectionner l’ordre A27404 et appuyer sur le bouton Exécutions…" );

        Log.Message("Ajouter une exécution A27404");
        Get_WinOrderFills_GrpFills_BtnAdd().Click(); 
                
        Get_WinAddOrderFill_TxtQuantity().Keys(qteStep12);
           
        Get_WinAddOrderFill_TxtClientPrice().Keys(priceStep12);  
                
        Get_WinAddOrderFill_CmbMarket().Click();
        Get_WinAddOrderFill_CmbMarket_ChBource().Click();
           
        Get_WinAddOrderFill_CmbOurRole().Click();
        Get_WinAddOrderFill_CmbOurRole_ChAgent().Click();
           
        Get_WinAddOrderFill_CmbInvetoryCode().Click();
        Get_WinAddOrderFill_CmbInvetoryCode_ChCode().Click();
           
        Get_WinAddOrderFill_BtnOK().Click();
        Get_WinOrderFills_BtnSave().Click(); 
           
        Log.Message("Valider que l'état de L'ordre est 'Exécuté partiellement'");
          
        var grid = Get_OrderGrid().RecordListControl;
        var count = grid.Items.Count;
        found = false;
        for (i=0; i<count; i++){
            if ((grid.Items.Item(i).DataItem.OrderSymbol == symbolA27404) && (grid.Items.Item(i).DataItem.Quantity == qteA27404_2)) {
                aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Status", cmpEqual, statusStep12);
                found = true;
                break;
            }
        }
        if (found == false)Log.Error("L'ordre n'existe pas dans la grille ou n'est pas à l'état ouvert");

/************************************Étape 13************************************************************************/     
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 13: Sélectionner les ordres : Symbole :NA (CAD-USD) / l'État: Exécuté partiellement et  Symbole : A27404 (USD-CAD)/Q600/l’État: Exécuté" );

        Search_Order_Symbol(symbolNA);
        Get_OrderGrid().Find("Value", qteNA, 10).Click();
          
        Search_Order_Symbol(symbolMSFT);
        Sys.Desktop.KeyDown(0x11);   //Maintenir la touche CTRL enfoncée
        Get_OrderGrid().Find("Value", qteMSFT, 10).Click();
    
          
        //Relâcher la touche CTRL enfoncée
        Sys.Desktop.KeyUp(0x11);  
        Get_OrderGrid().Find("Value", qteMSFT, 10).ClickR();
        Get_OrderGrid_ContextualMenu_Functions().Click();
          
          
        Log.Message("Valider que le champ Taux de change n'est pas grisé");
        aqObject.CheckProperty(Get_OrderGrid_ContextualMenu_Functions_ExchangeRate(), "IsEnabled", cmpEqual, true); 
          
        Log.Message("Valider le message d'erreur affiché");
        Get_OrderGrid_ContextualMenu_Functions_ExchangeRate().Click();
    
        aqObject.CheckProperty(Get_DlgError_LblMessage1(),"Text",cmpEqual, msgErrorStep13);
        Get_DlgError_Btn_OK().Click();                     
  
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 14: Se déconnecter de croesus et CleanUP" );
          
		//Fermer le processus Croesus
        Terminate_CroesusProcess();
        
        //Executer le fichier SQL pour le cleanup
        Log.Message(" ----------- C L E A N U P -------------");
        ExecuteSQLFile_ThroughISQL(folderPath_Data + "GDO3622_OB_Supprimer_ordres.sql", vServerOrders); 
    }
}


function AddRateChange(rateChange, internalNumber){
    if (language == "french"){
        var rateChangeFr = aqString.Replace(rateChange, "." , ",");
        Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Set_Text(rateChangeFr);
    }
    else
        Get_WinExchangeRate_GrpRate_TxtExchangeRateDouble().Set_Text(rateChange);
        
    Get_WinExchangeRate_GrpRate_TxtCustomInternalNumber().Set_Text(internalNumber);
    Get_WinExchangeRate_BtnOK().Click();
}


function CheckRateInOrderGrid(symbol, quantity, rate)
{
    var grid = Get_OrderGrid().RecordListControl;
    var count = grid.Items.Count;
    found = false;
    
    for (i=0; i < count; i++){
        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && (grid.Items.Item(i).DataItem.Quantity == quantity)) {
            aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Rate", cmpEqual, rate);
            found = true;
        }
    }
    if (found == false)Log.Error("L'ordre n'existe pas dans la grille");
}


function selectAnOrderWithRate(symbol)
{    
    var grid = Get_OrderGrid().RecordListControl;
    var count = grid.Items.Count;
    var found = false;
    var i = 0;
    
    while (i < count && found == false){
        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && !(grid.Items.Item(i).DataItem.Rate == 0)&& !(grid.Items.Item(i).DataItem.Rate == null)) {
            aqObject.SetPropertyValue(grid.Items.Item(i), "IsSelected", true);
            found = true;
        }
        i = i + 1;
    }
    if (found == false)
        Log.Error("L'ordre n'existe pas dans la grille");
}

function selectAnOrderWithStatus(symbol, status)
{
    var grid = Get_OrderGrid().RecordListControl;
    var count = grid.Items.Count;
    var found = false;
    var i = 0;
    
    Get_Toolbar_BtnRedisplayAllAndKeepCheckmarks().Click();
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    
    while (i < count && found == false){
        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && (grid.Items.Item(i).DataItem.Status == status)) {
            aqObject.SetPropertyValue(grid.Items.Item(i), "IsSelected", true);
            found = true;
        }
        i = i + 1;
    }
    if (found == false)
        Log.Error("L'ordre n'existe pas dans la grille");
}


function selectAnOrderWithQuantity(symbol, quantity)
{
    var grid = Get_OrderGrid().RecordListControl;
    var count = grid.Items.Count;
    var found = false;
    var i = 0;
    while (i < count && found == false){
        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && (grid.Items.Item(i).DataItem.Quantity == quantity)) {
            aqObject.SetPropertyValue(grid.Items.Item(i), "IsSelected", true);
            found = true;
        }
        i = i + 1;
    }
    if (found == false)
        Log.Error("L'ordre n'existe pas dans la grille");
}

//function validerStatus(symbol, quantity)
//{
//    var grid = Get_OrderGrid().RecordListControl;
//    var count = grid.Items.Count;
//    var found = false;
//    
//    for (i=0; i < count; i++){
//        if ((grid.Items.Item(i).DataItem.OrderSymbol == symbol) && (grid.Items.Item(i).DataItem.Quantity == quantity)) {
//            aqObject.CheckProperty(grid.Items.Item(i).DataItem, "Status", cmpEqual, "Open");
//            found = true;
//            break;
//        }
//    }
//    if (found == false)
//        Log.Error("L'ordre n'existe pas dans la grille");
//}