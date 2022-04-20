//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT GDO_2456_FundReport
//USEUNIT Ordres_Get_functions
//USEUNIT DBA
//USEUNIT CROES_6794_Copy_of_configurations_simulator
//USEUNIT CR1872_5755_ExtractOfRates_followedBy1stand2ndPhasefile_forPTFandNAVex



/*Description : Le but de ce cas est de Valider l'ajout et la modification de nouveau flag dans le fichier json.

 
    Analyste d'assurance qualité: Karima Mouzaoui
    Analyste d'automatisation: Philippe Maurice
    Version: 90.29.2022.02-89, 90.30  ou 90.31
*/  
 
 function GDO_TCVE_8207_Echelon_Phase1_Highgate_Branch()
 {             
    try{
        
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-8207","Lien de la story dans Jira", "TCVE-8207");
           
        
//---- ÉTAPE 17 ----//

        Log.PopLogFolder();
        logEtape1_17 = Log.AppendFolder("Étapes 1 et 2: Pre_conditions du cas de test et suppression des ordres dans l'accumulateur");
        Log.Message("Activation des PREFS et GDO Auto");
        PREF_Activation_GDO_Auto();
        
        //Supprimer les comptes inventaires et en ajouter d'autres
        Log.Message("Exécuter la requête pour: Supprimer les comptes inventaire 'EP1AVG8A' et 'EP1AVG8B' du user rep REAGAR Ajouter le compte inventaire 'SEBGX98C' pour les titres CAD + Ajouter le compte inventaire 'SEBGX98D' pour les titres USD");
        Insert_AVGCOST_Account();
        

        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
         
        //Se connecter à croesus avec Keynej
        Log.Message("Connexion avec l'utilisateur " + userNameKEYNEJ + ".")
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Log.Message("Supprimer les ordres de l'accumulateur.")
        Clear_Accumulator();
        

//---- ÉTAPE 18 ----//

        Log.PopLogFolder();
        logEtape18 = Log.AppendFolder("Étapes 18: Se logguer avec l'utilisateur 'REAGAR'");
        
        var userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
        var passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
        
        //Se connecter à croesus avec REAGAR
        Login(vServerOrders, userNameREAGAR, passwordREAGAR, language);
               
        
        
//---- ÉTAPE 19 ----//
      
        Log.PopLogFolder();
        logEtape19 = Log.AppendFolder("Étape 19: Sélectionner les comptes: 800267-RE et 800268-FS dans le module Comptes, générer ordre multiple, ajouter note, vérifier et soumettre");
        
        
        var listOfAccounts = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Accounts2", language+client);
        var arrayOfAccounts = listOfAccounts.split("|");   
        
        Log.Message("Acceder au Module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        
        //* Dans le module compte, sélectionner les comptes 800267-RE, 800268-FS puis cliquer sur Ordres multiple
        Log.Message ("Sélectionner les comptes 800267-RE, 800268-FS puis cliquer sur Ordres multiple");
        SelectAccounts(arrayOfAccounts);
        
        //* Ajouter un ordre de vente, Quantité: 200 Unités par compte, Symbole: DIS
        Log.Message("Création d'ordres multiples");
        var transTypeSell = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_TransactionType_Sell", language+client);
        var qty9 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty9", language+client);
        var perAccount = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_UnitsPerAccounts", language+client); 
        var secDescrDIS = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SecDesc_DIS", language+client);
        var qty10 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty10", language+client);
        
        
        Log.Message("Creation d'ordre multiple: ordre de vente, Quantité: 200 Unités par compte, Symbole: DIS");
        Create_Order(transTypeSell, qty9, perAccount, secDescrDIS);  //Création d'ordre multiple
        
        
        //* Double cliquer sur l'ordre DIS dans l'acumulateur
        Log.Message("Acceder au Module Ordres");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        
        Log.Message("Sélectionner l'odre " + secDescrDIS + ", ajouter des notes dans l'ordre.  Vérifier et soumettre.");
        
        var status_partialFill = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_StatusPartialFill", language+client);
        var note = "??A;S(3000);F2(200,50,XNAS,P)";
        var symbolDIS = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SymbolDIS", language+client);
        
        //* Dans la section Notes, ajouter la note ??A;S(3000);F2(200,50,XNAS,P)
        //* Vérifier puis soumettre
        Add_Notes_To_Orders(symbolDIS, note);
        Delay(5000);
        Log.Message("Valider le status de l'ordre");
        Validate_Order_Status(symbolDIS, qty10, transTypeSell, status_partialFill);


//---- ÉTAPE 20 ----// 
       
        Log.PopLogFolder();
        logEtape20 = Log.AppendFolder("Étape 20: Ajouter ordre d'achat, ajouter une note, valider et soumettre.");
        

        var acc800049OB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_acc800049OB", language+client);
        var qty11_100 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty11", language+client);
        var symbolTD = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SymbolTD", language+client);
        var status_executed = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_StatusExecuted", language+client);
        var note2 = "??A;S(3000);F2(100,50,XTSE,P)";
         
        Log.Message("Acceder au Module Ordres");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
         
        // * Dans le module Ordres, ajouter un ordre d'achat Action: Compte 800049-OB, Quantité 100, Symbole TD (Bourse TSE)
        Log.Message("Dans le module Ordres, ajouter un ordre d'achat Action: Compte 800049-OB, Quantité 100, Symbole TD (Bourse TSE)");      
        Get_Toolbar_BtnCreateASellOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        Create_Sell_Order(acc800049OB, qty11_100, symbolTD, "TSE");
        
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        
        // * Dans onglet Notes, ajouter la note "??A;S(3000);F2(100,50,XTSE,P)"
        // * Vérifier puis soumettre
        Add_Notes_To_Orders(symbolTD, note2);
        Validate_Order_Status(symbolTD, qty11_100, transTypeSell, status_executed);
        

        
//---- ÉTAPE 21 ----//
        
        Log.PopLogFolder();
        logEtape21 = Log.AppendFolder("Étape 21: Générer le fichier PhaseOne et le valider");
        
        //Vider le dossier dans le vseveur
        ExecuteSSHCommand("TCVE8207", vServerOrders, "rm -f /home/karimamo/*.*", "karimamo");
        //Générer le fichier PhaseOne
        Log.Message("Générer le fichier Phase1 avec la commande cfLoader -PhaseOneGenerator -Firm=FIRM_1");
        ExecuteSSHCommandCFLoader("TCVE8207", vServerOrders, "cfLoader -PhaseOneGenerator -Firm=FIRM_1", "karimamo");
        
        var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d");
        var vserverFilePath = "/home/karimamo/loader/TCVE8207/ism" + date + "_39.txt"; 
        var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\";
        Log.Message("Copier le fichier Phase1 généré du vserver");
        CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
        
        // * Valider le fichier généré
        Log.Message("Comparaison du fichier PhaseOne avec la référence.");
        var refFile = "phase1_ref2.txt";
        Compare_Phase1_File(refFile);
        
        //Supprimer le fichier Phase One
        if (aqFileSystem.Exists(vserverFilePath)){
            Log.Message("Suppression du fichier Phase One");    
            aqFileSystem.DeleteFile(vserverFilePath);
        }
        
        Log.Message("Dans WinSCP, '/var/log/finansoft/FIX/OMSSupId6', ouvrir le fichier 'FIX.4.2-CROESUS6-PROXY.messages.current.log' et valider le tag 50");
        Validate_Tag_In_Log_File();
        
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         
    }
    finally {
        Log.Message("Fermeture de Croesus")
        Terminate_CroesusProcess(); //Fermer Croesus
        
//---- ÉTAPE 22 ----//        

        Log.PopLogFolder();
        logEtape22 = Log.AppendFolder("Étape 22: Remise de la BD à l'état initial.");
        
        Reset_DataBase();
    }
 }
 
 
 
 
function PREF_Activation_GDO_Auto()
{
    //Activation des prefs
    Activate_Inactivate_PrefFirm("FIRM_1", "PREF_TRADE_ALLOCATION_EXTRACT", "8", vServerOrders);
    RestartServices(vServerOrders);
           
    Log.Message("Exécuter petit script pour mode auto");    
    //CROES_6794_Configurations_simulator();
    var remoteDestinationFolder="/var/lib/finansoft";
    var localFolderPath="P:\\divers\\aq\\FixSimulator\\Config_FixStores_Simulator\\"
    var listOfFolders  = "configs|FIXStores|Simulator|";
    var arrayOfFolders = listOfFolders.split("|");
          
    var localFolderPathAddSentExtension = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\" 
            
    Log.Message("copier les dossiers");
    TryConnexionAndTrustHostKeyThroughWinSCP(vServerOrders);
          
    for (i in arrayOfFolders)
        CopyFileToVserverThroughWinSCP(vServerOrders, remoteDestinationFolder, localFolderPath + arrayOfFolders[i]);
                            
    Log.Message("mettre le fichier dans AddSentExtension.sh /etc/finansoft/");
    CopyFileToVserverThroughWinSCP(vServerOrders, "/etc/finansoft/", localFolderPathAddSentExtension + "AddSentExtension.sh");
    
    
//    Log.Message("Modifier le fichier dans var/lib/finansoft/configs et celui dans etc/finansoft");
//    SSHExecute("CommandeSSHForCROES6795_1");
//    Delay(2000);
//    SSHExecute("CommandeSSHForCROES6795_2");
          
             
    /*yes | cp /var/lib/finansoft/configs/* /etc/finansoft
    service cffixproxy restart
    cd /var/lib/finansoft/Simulator
    mono --debug Simulator.exe >Simulator.log 2>&1 &
    service cfordermanagementserver restart
    ps -ef | grep mono*/
 
    SSHExecute("CommandeSSHForCROES6795"); 
}



function Insert_AVGCOST_Account()
{
    var sqlString1 = "delete from B_GDO_AVGCOST_ACCOUNT where rep_id=14";
    Execute_SQLQuery(sqlString1, vServerOrders); 
    
    var sqlString6 = "delete from B_GDO_AVGCOST_ACCOUNT where rep_id=13";
    Execute_SQLQuery(sqlString6, vServerOrders); 
    
    var sqlString2 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'CAD', 'SEBGX98C')";
    Execute_SQLQuery(sqlString2, vServerOrders);
    
    var sqlString3 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'USD', 'SEBGX98D')";
    Execute_SQLQuery(sqlString3, vServerOrders);
    
    var sqlString4 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'CAD', 'SEBGX98C')";
    Execute_SQLQuery(sqlString4, vServerOrders);
    
    var sqlString5 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'USD', 'SEBGX98D')";
    Execute_SQLQuery(sqlString5, vServerOrders);
}


function Clear_Accumulator()
{
    Get_ModulesBar_BtnOrders().Click();
	  Get_ModulesBar_BtnOrders().WaitProperty("IsChecked.OleValue", true, 100000);
    
    if (Get_OrderAccumulatorGrid().RecordListControl.Items.Count > 0) {
        Get_OrderAccumulatorGrid().RecordListControl.Keys("^a");
        Get_OrderAccumulator_BtnDelete().Click();
        Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
    } 
}


function Create_Order(transaction, quantity, perAccount, securityDescription)
{

    //Click sur ordre multiple
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
          
    //Ajout d'une transaction(s):Vente          
    AddSellTransactionsOrder(quantity, perAccount, securityDescription);
    
    Log.Message("Cliquer sur Aperçu puis Générer, confirmer le message affiché (la quantité de vente est supérieur à celle détenue");
    Get_WinSwitchBlock_BtnPreview().Click();//GDO-2691
    Get_WinSwitchBlock_BtnGenerate().WaitProperty("IsEnabled", true, 20000);
    Delay(3000);
    Get_WinSwitchBlock_BtnGenerate().Click();
    
    if (Get_DlgConfirmation_BtnYes().Exists)
        Get_DlgConfirmation_BtnYes().Click();
}



function AddSellTransactionsOrder(quantity, perAccount, securityDescription)
{

    Get_WinSwitchBlock_GrpTransactions_BtnAdd().WaitProperty("IsEnabled",true,20000);
    Delay(3000);
    Get_WinSwitchBlock_GrpTransactions_BtnAdd().Click();
                    
    //Adaptation de script (Lu-14). Avoir le champ de Description lors d'ouverture de la fenêtre. 
    Get_WinSwitchSource_CmbSecurity().Click();
    Get_CroesusApp().FindChild(["ClrClassName", "DataContext.LongDefinition"], ["ComboBoxItem", "Description"], 10).Click();
                    
    Get_WinSwitchSource_CmbQuantity().set_IsDropDownOpen(true);
    Get_WinSwitchSource_TxtQuantity().Keys(quantity);
    Get_WinSwitchSource_CmbQuantity().set_Text(perAccount);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Clear();
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys(securityDescription);
    Get_WinSwitchSource_GrpPosition_TxtSecurity().Keys("[Tab]");
    Delay(500);
    
    if(Get_SubMenus().Exists){       
        Aliases.CroesusApp.subMenus.Find("Value", securityDescription, 10).DblClick();
    }      
    Get_WinSwitchSource_btnOK().Click();  

}



function Add_Notes_To_Orders(symbole, note)
{
    //Selectionner l'ordre
    Log.Message("Sélectionner l'ordre " + symbole + ".  Ajouter la note " + note);
    Get_OrderAccumulatorGrid().Find("Value", symbole, 10).Click();
        
    Get_OrderAccumulator_BtnEdit().WaitProperty("Enabled", true, 5000);
    Get_OrderAccumulator_BtnEdit().Click();          
        
    Get_WinOrderDetail_TabNotes().WaitProperty("IsVisible", true, 100000);
    Get_WinOrderDetail_TabNotes().Click();
        
    Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().WaitProperty("isVisible", true, 5000);
    Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Keys(note);
        
    Get_WinOrderDetail_BtnVerify().WaitProperty("Enabled", true, 5000);
    Get_WinOrderDetail_BtnVerify().Click();
        
    Get_WinOrderDetail_BtnVerify().WaitProperty("Enabled", true, 5000);
    Get_WinOrderDetail_BtnVerify().Click();
 }
 
 
 
function Validate_Order_Status(orderSymbol, quantity, type, status)
{
    //Valider que l'ordre obtient le statut voulu
    Log.Message("Valider que l'ordre  " + orderSymbol + " quantité: " + quantity + " obtient le statut " +  status);
    var nbr = Get_OrderGrid().RecordListControl.Items.Count;
    
    for(var i = 0; i<nbr; i++) {
        if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == orderSymbol 
           && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity
           && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Type == type){
           aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual, status);
           Log.Message("Le status '" + status + "' de l'ordre '" + orderSymbol + "' est validé!");
           break;
           
        }                          
    }
}


function Create_Sell_Order(account, quantity, symbol, stockExchange)
 {
    //Saisir la quantité et sélectionner le titre désiré
    Log.Message("Saisir comme quantité = " + quantity + " et Selectionner le titre " + symbol);
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account);
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbol);
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys("[Tab]");
               
    SetAutoTimeOut();
    if(Get_SubMenus().Exists)  
        //Aliases.CroesusApp.subMenus.Find("Value", stockExchange, 10).DblClick();               
        Search_Security(symbol, stockExchange);
    RestoreAutoTimeOut();
    
    Get_WinOrderDetail_BtnSave().Click();  
 }
 
 
 
 
 function Search_Security(orderSymbol, stockExchange)
{
    //
    //var nbr = Aliases.CroesusApp.subMenus.RecordListControl.Items.Count;
    
    for(var i=1; i<25; i++) {
        if(Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.Symbol == orderSymbol 
            && Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).DataContext.DataItem.MarketName == stockExchange) {
           Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).set_IsSelected(true);
           Get_SubMenus().WPFObject("Grid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", i).set_IsActive(true);
           Sys.Keys("[Enter]");
           break;
        }                          
    }
}


function Compare_Phase1_File(refFile)
{   
    var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d")
    var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\";
    var refFolder = folderPath_Data + client + "\\TCVE8207\\ExpectedFolder\\";
    var generatedFileName = "ism" + date + "_39.txt";
    
    //Comparaison des fichiers
    CompareTxtFiles(refFolder, refFile, localDestinationFilePath, generatedFileName);
}
 
 
 
function Reset_DataBase()
{
    var sqlString1 = "delete from B_GDO_AVGCOST_ACCOUNT where rep_id=14";
    Execute_SQLQuery(sqlString1, vServerOrders); 
    
    var sqlString6 = "delete from B_GDO_AVGCOST_ACCOUNT where rep_id=13";
    Execute_SQLQuery(sqlString6, vServerOrders); 
    
    var sqlString2 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'CAD', 'EP1AVG8A')";
    Execute_SQLQuery(sqlString2, vServerOrders);
    
    var sqlString3 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'USD', 'EP1AVG8B')";
    Execute_SQLQuery(sqlString3, vServerOrders);
    
    var sqlString4 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'CAD', 'EP1AVG8A')";
    Execute_SQLQuery(sqlString4, vServerOrders);
    
    var sqlString5 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'USD', 'EP1AVG8B')";
    Execute_SQLQuery(sqlString5, vServerOrders);
    
}

function Validate_Tag_In_Log_File()
{
    Log.PopLogFolder();
    logEtape13= Log.AppendFolder("Ouvrir WinSCP Aller dans /home/crweb/Test_CR1571/ et consulter et valider le fichier le plus récent");
    
    Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
    SSHExecute("CommandeSSHForTCVE8207");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
    var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\"
          
    //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON )       
    var vserverFilePath = "/home/crweb/Test_CR1571/SearchResultsTCVE8207.txt" 
    //var vserverFilePathLog = "/var/log/finansoft/FIX/OMSSupId6/FIX.4.2-CROESUS6-PROXY.messages.current.log";     
    CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
          
    
    //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
    var listOfResults  = "0|";
    var arrayOfResults = listOfResults.split("|");
              
    // Déclaration de string recherchés
    var listOfStringTofind  = "50=REAGAR|";
    var arrayOfStringTofind = listOfStringTofind.split("|"); 
          
          
    //Validation du fichier log
    //var myFile = aqFile.OpenTextFile(localDestinationFilePath + "SearchResultsTCVE8207.txt", aqFile.faRead, aqFile.ctANSI);
    var myFile = aqFile.OpenTextFile(localDestinationFilePath + "SearchResultsTCVE8207.txt", aqFile.faRead, aqFile.ctANSI);
                     
    while(! myFile.IsEndOfFile()) {    
        line = myFile.ReadLine();
        //Split at each space character.
        var LogArr = line.split("\n"); 
        Log.Message("Nombre de fois que se retrouve la chaîne de caractères: " + line);   
        
           
        if(aqObject.CompareProperty(VarToString(LogArr), cmpGreater, 0, true, lmNone)) {
            Log.Checkpoint("Le texte " + listOfStringTofind + " est présent " + VarToString(LogArr) + " fois dans le fichier Log");
        } 
        else{
            Log.Error("Le texte " + arrayOfStringTofind + " n'est pas présent dans le fichier 'FIX.4.2-CROESUS6-PROXY.messages.current.log'.");
        }

    }
}