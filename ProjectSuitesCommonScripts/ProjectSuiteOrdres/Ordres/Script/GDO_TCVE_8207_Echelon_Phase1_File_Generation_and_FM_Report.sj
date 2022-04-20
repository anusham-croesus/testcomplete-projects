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
    Vesion: 90.29-37
*/  
 
 function GDO_TCVE_8207_Echelon_Phase1_File_Generation_and_FM_Report()
 {             
    try{ 
        
        //Lien de la story dans Jira
        Log.Link("https://croesus-support.atlassian.net/browse/TCVE-8207","Lien de la story dans Jira", "TCVE-8207");
           
        Log.PopLogFolder();
        logEtape1_2 = Log.AppendFolder("Étapes 1 et 2: Pre_conditions du cas de test"); 
        PREF_Activation_GDO_Auto();
         
        
        //--------------------------  ÉTAPE 3 --------------------------         
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw"); 
        
        //Se connecter à croesus avec Keynej
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Se connecter à croesus avec Keynej"); 
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        Clear_Accumulator();
         
        
        //--------------------------  ÉTAPE 4 --------------------------
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4: Sélectionner les comptes: 800217-RE, 800228-FS, 800241-GT dans le module Comptes");
        var listOfAccounts = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Accounts", language+client);
        var arrayOfAccounts = listOfAccounts.split("|");   
        
        Log.Message("Acceder au Module Compte");
        Get_ModulesBar_BtnAccounts().Click();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
         
        SelectAccounts(arrayOfAccounts);
         
        
        //--------------------------  ÉTAPE 5 --------------------------
        Log.PopLogFolder();
        logEtape5 = Log.AppendFolder("Étape 5: Création d'ordres multiples");
        
        var transTypeSell = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_TransactionType_Sell", language+client);
        var qty1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty1", language+client);
        var perAccount = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_UnitsPerAccounts", language+client); 
        var secDescr = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SecurityDescription", language+client);
        var qty2 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty2", language+client);
        var symbolNA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SymbolNA", language+client);
        
        Log.Message("Creation d'ordre multiple.");
        Create_Orders(transTypeSell, qty1, perAccount, secDescr, qty2, symbolNA);  //Création d'ordre multiple
        Delay(1000);
      
         
        //--------------------------  ÉTAPE 6 --------------------------
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: Ajout d'un ordre de vente (à partir du module Ordres)");
        
        var acc800049NA = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_acc800049NA", language+client);
        var qty3_100 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty3", language+client);
        var symbolAAPL = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_SymbolAAPL", language+client);
         
        Log.Message("Acceder au Module Ordres");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
         
        Log.Message("Toolbar_btnCreateBuyOrder");      
        Get_Toolbar_BtnCreateASellOrder().Click();
        Get_WinFinancialInstrumentSelector_RdoStocks().Click();
        Get_WinFinancialInstrumentSelector_BtnOK().Click();
        Create_Sell_Order(acc800049NA, qty3_100, symbolAAPL);
        
        
        //--------------------------  ÉTAPE 7 --------------------------
        Log.PopLogFolder();
        logEtape7 = Log.AppendFolder("Étape 7: Sélectionner les 2 ordres AAPL et fusionner.");
        Merge_Orders(symbolAAPL);
        

        //--------------------------  ÉTAPE 8 --------------------------
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: Ajouter des notes dans les ordres.  Vérifier et soumettre.");
        var qty4_3100 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty4", language+client);
        var status_partialFill = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_StatusPartialFill", language+client);
        var status_executed = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_StatusExecuted", language+client);
        var qty5_2262 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty5", language+client);
        var transTypeBuy = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_TransactionType_Buy", language+client);
                
        Add_Notes_To_Orders();
        Validate_Order_Status(symbolAAPL, qty4_3100, transTypeSell, status_partialFill);
        Validate_Order_Status(symbolNA, qty5_2262, transTypeBuy, status_executed);
 
        
        
        //--------------------------  ÉTAPE 9 --------------------------
        Log.PopLogFolder();
        logEtape9 = Log.AppendFolder("Étape 9: Ré-équilibrage du modèle CH REVENUS FIXES");
        
        // * Rééquilibrer le modèle: Étape1, décocher les cases à cocher si elles sont affichées
        // * Avancer à l'étape5 du rééquilibrage puis envoyer les ordres dans l'accumulateur
        Log.Message("Avancer à l'étape5 du rééquilibrage puis envoyer les ordres dans l'accumulateur");
        var clientNumber800049 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_client800049", language+client);
        var modelName = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Model", language+client);
        Rebalance_Model(modelName, clientNumber800049);
        
        
        
        //--------------------------  ÉTAPE 10 --------------------------
        
        //Valider ORC-3588:
        Log.PopLogFolder();
        logEtape10 = Log.AppendFolder("Étape 10: Valider ORC-3588");

        //Exécuter la requête suivante pour cacher l'option Code inventaire de la fenêtre d'exécution des ordres revenus fixes: UPDATE B_DEF SET [DEFAULT_VALUE] = 'NO'WHERE [CLE] = 'INVENTORY_CODE'
        var updateSQLQuery = "UPDATE B_DEF SET [DEFAULT_VALUE] = 'NO'WHERE [CLE] = 'INVENTORY_CODE'";
        Log.Message("SQL: " + updateSQLQuery);
        Execute_SQLQuery(updateSQLQuery, vServerOrders);
        
        //Redémarrer les services
        Log.Message("Redémarrage des services.")
        RestartServices(vServerOrders);
        
        
        //--------------------------  ÉTAPE 11 --------------------------
        //Se connecter à croesus avec Keynej
        Log.PopLogFolder();
        logEtape11 = Log.AppendFolder("Étape 11: Se connecter à croesus avec Keynej"); 
        Login(vServerOrders, userNameKEYNEJ, passwordKEYNEJ, language);
        
        
        //--------------------------  ÉTAPE 12 --------------------------
        Log.PopLogFolder();
        logEtape12 = Log.AppendFolder("Étape 12: Sélectionner fond d'investissement FID228 et obligation T58632.  Vérifier et soumettre (cocher inclure et soumettre).");
        
        var status_pending_approval = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_StatusPendingApproval", language+client);
        var qty6_2257808 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty6", language+client);
        var qty7_77000 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty7", language+client);
        var orderFID228 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_OrderFID228", language+client);
        var orderT58632 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_OrderT58632", language+client);
        
        Log.Message("Acceder au Module Ordres");
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        Verify_Submit_Orders();
        Validate_Order_Status(orderFID228, qty6_2257808, transTypeSell, status_pending_approval);
        Validate_Order_Status(orderT58632, qty7_77000, transTypeSell, status_pending_approval);
        

        
        //--------------------------  ÉTAPE 13 --------------------------
        Log.PopLogFolder();
        logEtape13 = Log.AppendFolder("Étape 12: Sélectionner obligation T58632 dans le blotter.  Consulter, approuver et ajouter une exécution.");
        
        var qty8_1000 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_Qty8", language+client);
        var clientPrice_20 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_ClientPrice", language+client);
        var IAPrice_20 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_IAPrice", language+client);
        var indexationFactor_1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_IndexationFactor", language+client);
        var ANN_1 = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_ANN", language+client);
        var invCode_AB = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_InventoryCode", language+client);
        
        //Consult_Approve(orderSymbol, quantity, status, txtQty, clientPrice, IAPrice, indexationFactor, ANN, invCode)
        Log.Message("Consulter et approuver l'exécution de: " + orderT58632);
        Consult_Approve(orderT58632, qty7_77000, status_pending_approval, qty8_1000, clientPrice_20, IAPrice_20, indexationFactor_1, ANN_1, invCode_AB);
        
        
        //--------------------------  ÉTAPE 14 --------------------------
        Log.PopLogFolder();
        logEtape14 = Log.AppendFolder("Étape 14: Sélectionner  dans le blotter et créer rapport avec option Rapport d'investissements.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Select_Order_In_Blotter(orderFID228, qty6_2257808, status_pending_approval);
        Get_MenuBar_Reports().Click();
        Get_MenuBar_Reports_MutualFundsOrderReport().Click();
        
        //fermer les fichiers excel
        Log.Message("Fermeture du fichier Excel");
        CloseExcel();
        
        var ExpectedFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\TCVE8207\\"+language+"\\";
        var ResultFolder   = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\TCVE8207\\"+language+"\\";
        var fichierExcel = "Rapport fonds d'invest.csv";
        Log.Message("Comparaison des fichiers excel.");
        //ExcelFilesCompare(ExpectedFolder, fichierExcel, ResultFolder);
                
        
        //--------------------------  ÉTAPE 15 --------------------------
        Log.PopLogFolder();
        logEtape15 = Log.AppendFolder("Étape 14:  Supprimer les ordres dans l'accumulateur.");
        
        var cleanupSQLQuery = "delete from B_GDO_ORDER where status=70";
        Log.Message("SQL: " + cleanupSQLQuery);
        Execute_SQLQuery(cleanupSQLQuery, vServerOrders);
        
        
        //--------------------------  ÉTAPE 16 --------------------------
        Log.PopLogFolder();
        logEtape1_16 = Log.AppendFolder("Étape 16: ORC-3222: Générer le fichier Phase1 pour un user Highgate ");
        
        //Supprimer les comptes inventaires et en ajouter d'autres
        Log.Message("Supprimer les comptes inventaire 'EP1AVG8A' et 'EP1AVG8B' du user rep REAGAR");
        Log.Message("Exécuter la requête pour: Supprimer les comptes inventaire 'EP1AVG8A' et 'EP1AVG8B' du user rep REAGAR Ajouter le compte inventaire 'SEBGX98C' pour les titres CAD + Ajouter le compte inventaire 'SEBGX98D' pour les titres USD");
        Insert_AVGCOST_Account();
        
        
        //--------------------------  ÉTAPE 17 --------------------------
        Log.PopLogFolder();
        logEtape17 = Log.AppendFolder("Étape 17: Se logguer avec l'utilisateur 'REAGAR'");
        
        var userNameREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "username");
        var passwordREAGAR = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "REAGAR", "psw");
        
        //Se connecter à croesus avec REAGAR
        Login(vServerOrders, userNameREAGAR, passwordREAGAR, language);
        
        
        //--------------------------  ÉTAPE 18 --------------------------
        Log.PopLogFolder();
        logEtape18 = Log.AppendFolder("Étape 18: Sélectionner les comptes: 800267-RE et 800268-FS dans le module Comptes, générer ordre multiple, ajouter note, vérifier et soumettre");
        
        
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
        
        
        //--------------------------  ÉTAPE 19 --------------------------
        Log.PopLogFolder();
        logEtape19 = Log.AppendFolder("Étape 19: Ajouter ordre d'achat, ajouter une note, valider et soumettre.");
        
        var transTypeSell = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_TransactionType_Sell", language+client);
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
        Create_Sell_Order_With_StockExchange(acc800049OB, qty11_100, symbolTD, "TSE");
        
        Get_ModulesBar_BtnOrders().Click();
        Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 100000);
        
        // * Dans onglet Notes, ajouter la note "??A;S(3000);F2(100,50,XTSE,P)"
        // * Vérifier puis soumettre
        Add_Notes_To_Orders(symbolTD, note2);
        Validate_Order_Status(symbolTD, qty11_100, transTypeSell, status_executed);
        
        
        
        //--------------------------  ÉTAPE 20 -------------------------- 
        Log.PopLogFolder();
        logEtape20 = Log.AppendFolder("Étape 20: Générer le fichier PhaseOne et le valider");
        
        //Vider le dossier dans le vseveur
        ExecuteSSHCommand("TCVE8207", vServerOrders, "rm -f /home/karimamo/*.*", "karimamo");
        //Générer le fichier PhaseOne
        Log.Message("Générer le fichier Phase1 avec la commande cfLoader -PhaseOneGenerator -Firm=FIRM_1");
        ExecuteSSHCommandCFLoader("TCVE8207", vServerOrders, "cfLoader -PhaseOneGenerator -Firm=FIRM_1", "karimamo");
        
        var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d");
        var phaseOneFile = "ism" + date + "_39.txt";
        var vserverFilePath = "/home/karimamo/loader/TCVE8207/" + phaseOneFile; 
        var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\";
        
        Log.Message("Copier le fichier Phase1 généré du vserver");
        CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
        
        // * Valider le fichier généré
        Log.Message("Validation du fichier PhaseOne généré.");
        
        
        var arrayOfInventoryCodesList = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "GDO_TCVE", "TCVE8207_InventCode", language+client);
        var arrayOfInventoryCodes = arrayOfInventoryCodesList.split("|");
        Validate_Phase1_File(localDestinationFilePath, arrayOfInventoryCodes, phaseOneFile);
        
                
        //Supprimer le fichier Phase One
//        if (aqFileSystem.Exists(vserverFilePath)){
//            Log.Message("Suppression du fichier Phase One");    
//            aqFileSystem.DeleteFile(vserverFilePath);
//        }
        
        // Déclaration de string recherchés
        var listOfStringTofind  = "50=REAGAR|";
        var arrayOfStringTofind = listOfStringTofind.split("|"); 
        
        Log.Message("Dans WinSCP, '/var/log/finansoft/FIX/OMSSupId6', ouvrir le fichier 'FIX.4.2-CROESUS6-PROXY.messages.current.log' et valider le tag 50 (" + arrayOfStringTofind + ")");
        Validate_Tag_In_Log_File(arrayOfStringTofind);
      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
         
    }
    finally {

      Terminate_CroesusProcess(); //Fermer Croesus
      
      //--------------------------  ÉTAPE 21 --------------------------       
      Log.PopLogFolder();
      logEtape21 = Log.AppendFolder("Étape 21: Remise de la BD à l'état initial.");
        
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
             
    /*yes | cp /var/lib/finansoft/configs/* /etc/finansoft
    service cffixproxy restart
    cd /var/lib/finansoft/Simulator
    mono --debug Simulator.exe >Simulator.log 2>&1 &
    service cfordermanagementserver restart
    ps -ef | grep mono*/
 
    SSHExecute("CommandeSSHForCROES6795"); 
}
 


function Create_Orders(transaction, quantity, perAccount, securityDescription, quantity2, symbole2)
{

    //Click sur ordre multiple
    Get_Toolbar_BtnSwitchBlock().Click();
    WaitObject(Get_CroesusApp(),"Uid", "SwitchWindow_e8cd");
    Get_WinSwitchBlock_GrpParameters_CmbTransactions().set_Text(transaction);
          
    //Ajout d'une transaction(s):Vente          
    AddSellTransactionsOrder(quantity, perAccount, securityDescription);
    
    //Ajouter l'ordre d'achat equivalent
    AddEquivalentOrder(quantity2, symbole2);
                
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

//fonction qui permet d'ajouter l'ordre d'achat equivalent
function AddEquivalentOrder(quantity, security) {    

    Log.Message("Ajout d'une transaction(s):equivalente" );
    Get_WinSwitchBlock_GrpEquivalentTransactions_BtnAdd().Click();
    Get_WinSwitchEquivalent_TxtAllocationPercent().Keys(quantity)
    Get_WinSwitchEquivalent_CmbSecurity_TxtSecurity().Keys(security);
          
    Get_WinSwitchEquivalent_BtnQuickSearchListPicker().Click();
    if(Get_SubMenus().Exists){       
       Aliases.CroesusApp.subMenus.Find("Value", security, 10).DblClick();   
    } 
        
    Get_WinSwitchEquivalent_btnOK().Click();
              
 }
 
 function Create_Sell_Order(account, quantity, symbol)
 {
    //Saisir comme quantité = 1700 et Selectionner le titre MMM
    Log.Message("Saisir comme quantité = " + quantity + " et Selectionner le titre " + symbol);
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys(account)
    Get_WinOrderDetail_GrpAccount_TxtQuickSearchKey().Keys("[Enter]");
    Get_WinStocksOrderDetail_TxtQuantity().Keys(quantity);
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker().Click();
    Get_WinOrderDetail_GrpSecurity_CmbTypePicker_ChSymbol().Click();
    Get_WinOrderDetail_GrpSecurity_TxtQuickSearchKey().Keys(symbol);
    Get_WinOrderDetail_GrpSecurity_BtnSearch().Click();
    Get_WinOrderDetail_BtnSave().Click();  
 }
 
 
 function Create_Sell_Order_With_StockExchange(account, quantity, symbol, stockExchange)
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
        Search_Security2(symbol, stockExchange);
    RestoreAutoTimeOut();
    
    Get_WinOrderDetail_BtnSave().Click();  
 }

 
  
function Search_Security2(orderSymbol, stockExchange)
{ 
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
 


function Merge_Orders(symbol)
{          
    //Selectionner les ordres de symboles "AAPL"
    var itemsCount = Get_OrderAccumulatorGrid().RecordListControl.items.Count;
    
    for(i=1; i<itemsCount; i++){
      
        if(Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i-1).DataItem.OrderSymbol == symbol) {
            Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).Click(-1, -1, skCtrl);
        }  
    }
    
    //Cliquer sur Fusionner
    Get_OrderAccumulator_BtnMerge().WaitProperty("Enabled", true, 5000);
    Get_OrderAccumulator_BtnMerge().Click();
}
 
 
function Add_Notes_To_Orders()
{
    //Selectionner les ordres de symboles "AAPL"
    var itemsCount = Get_OrderAccumulatorGrid().RecordListControl.items.Count;
    var i = 1;   
    
    while ((itemsCount > 0) && (i <= itemsCount)) {
        
        //Get_OrderAccumulatorGrid().RecordListControl.Items.Item(i).IsSelected = true;
        Get_OrderAccumulatorGrid().RecordListControl.WPFObject("DataRecordPresenter", "", i).Click();
        
        Get_OrderAccumulator_BtnEdit().WaitProperty("Enabled", true, 5000);
        Get_OrderAccumulator_BtnEdit().Click();          
        
        Get_WinOrderDetail_TabNotes().WaitProperty("IsVisible", true, 100000);
        Get_WinOrderDetail_TabNotes().Click();
        
        Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().WaitProperty("isVisible", true, 5000);
        Get_WinStocksOrderDetail_TabNotes_GrpNotes_TxtTradingNotes().Keys("??A;S(3000);F(2262,50)");
        
        Get_WinOrderDetail_BtnVerify().WaitProperty("Enabled", true, 5000);
        Get_WinOrderDetail_BtnVerify().Click();
        
        Get_WinOrderDetail_BtnVerify().WaitProperty("Enabled", true, 5000);
        Get_WinOrderDetail_BtnVerify().Click();
        
        itemsCount = itemsCount - 1;
    }
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


function Rebalance_Model(model, clientNo)
{
    Log.Message("Acceder au Module Modèles");
    Get_ModulesBar_BtnModels().Click();
    WaitObject(Get_ModelsPlugin(), "Uid", "ModelListView_6fed"); 
    WaitObject(Get_ModelsPlugin(),["ClrClassName", "WPFControlOrdinalNo"],["DataRecordPresenter", 1]);
    Get_ModelsGrid().FindChild("Value", model, 100).Click();    // * Dans le module Modèle, sélectionner le modèle CH REVENUS FIXES
        
    Get_Models_Details_TabAssignedPortfolios().Click();      // Clique la section portefeuille assignes 
    Get_Models_Details_TabAssignedPortfolios_DdlAssign().Click();
    Get_Models_Details_TabAssignedPortfolios_DdlAssign_Clients().Click();
        
    // Selectionner un client // * Associer le client 800049
    WaitObject(Get_CroesusApp(), "Uid", "PickerBase_dcbf");
    Get_WinPickerWindow_DgvElements().Keys("8"); 
    WaitObject(Get_CroesusApp(),"Uid", "TextBox_6a73");
    Get_WinQuickSearch_TxtSearch().Clear();  
    Get_WinQuickSearch_TxtSearch().Keys("800049");
    Get_WinQuickSearch_BtnOK().Click();
    
    Get_WinPickerWindow_DgvElements().Find("Value", clientNo , 10).Click();
    Get_WinPickerWindow_BtnOK().Click();
    WaitObject(Get_CroesusApp(), "Uid", "AssignToModelWindow_c8c3");
    Get_WinAssignToModel_BtnYes().WaitProperty("Enabled", true, 15000);
    Get_WinAssignToModel_BtnYes().Click();
    
    
    Get_Toolbar_BtnRebalance().Click()
    Get_WinRebalance().Parent.Maximize();
    
    // Decocher les cases valider les limites, Appliquer les frais et Répartir la liquidité.
    Log.Message("Décocher les cases valider les limites Appliquer les frais et Répartir la liquidité.");
    Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
    Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
    Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
            
    //Aller étape 2 
    Get_WinRebalance_BtnNext().Click();
    //Aller étape 3 
    Get_WinRebalance_BtnNext().Click();
    //Aller étape 4
    Get_WinRebalance_BtnNext().Click();
    
    SetAutoTimeOut(15000);
    if (Get_WinWarningDeleteGeneratedOrders().Exists)
        Get_WinWarningDeleteGeneratedOrders_BtnYes().Click();
     RestoreAutoTimeOut();
     
    //Aller étape 5    
    Get_WinRebalance_BtnNext().WaitProperty("Enabled", true, 2000)
    Get_WinRebalance_BtnNext().Click();
    //finir reéquilibrage
    Get_WinRebalance_BtnGenerate().Click(); 
    
    Get_WinGenerateOrders_BtnGenerate().Click();
}


function Verify_Submit_Orders()
{          
    //Selectionner les ordres de symboles ""
    var itemsCount = Get_OrderAccumulatorGrid().RecordListControl.items.Count;
    var symbols = ["FID228", "T58632"];
    
    Log.Message("Items: " + itemsCount);
    
    for(j=0; j < symbols.length; j++){
        
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Select_Order_In_Accumulator(symbols[j])

        //Côcher la cas Inclure + Soumettre
        Get_OrderAccumulator_BtnVerify().WaitProperty("Enabled", true, 5000);
        Get_OrderAccumulator_BtnVerify().Click();
        
        if (Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).IsChecked == false)
            Get_WinAccumulator_DgvAccumulator().WPFObject("RecordListControl", "", 1).Find("ClrClassName","XamCheckEditor",10).Click();
        
        WaitObject(Get_WinAccumulator_DgvAccumulator(), ["ClrClassName", "WPFControlOrdinalNo","IsChecked"], ["XamCheckEditor", "1",true]);
        Get_WinAccumulator_BtnSubmit().WaitProperty("IsEnabled", true, 5000);
        Get_WinAccumulator_BtnSubmit().Click();
    }
}


function Consult_Approve(orderSymbol, quantity, status, txtQty, clientPrice, IAPrice, indexationFActor, ANN, invCode)
{   
    Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
    Delay(2000);
    Select_Order_In_Blotter(orderSymbol, quantity, status);
    
    Get_OrdersBar_BtnView().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["OrderDetails_d698", true]);
    Get_WinOrderDetail_BtnApprove().Click();
    WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
    
    Get_WinOrderFills_GrpFills_BtnAdd().Click();
            
    Get_WinAddOrderFill_TxtQuantity().Keys(txtQty);
    Get_WinAddOrderFill_TxtClientPrice().Keys(clientPrice); 
    Get_WinAddOrderFill_TxtIAPrice().Keys(IAPrice);
    Get_WinAddOrderFill_TxtIndexationFactor().Keys(indexationFActor)
    Get_WinAddOrderFill_TxtYieldANN().set_Value(ANN);
    Get_WinAddOrderFill_CmbInvetoryCode().set_Text(invCode);
    Get_WinAddOrderFill_BtnOK().Click();
    
    Get_WinOrderFills_BtnSave().Click();    
}


function Select_Order_In_Accumulator(orderSymbol)
{
    while (! Get_OrderAccumulatorGrid().FindChild("Value", orderSymbol, 10).Exists){
         Get_OrderAccumulatorGrid().WPFObject("RecordListControl", "", 1).Keys("^[Down]^[Down]");
    }
    
    Get_OrderAccumulatorGrid().Find("Value", orderSymbol, 10).Click(-1, -1, skCtrl);
}


function Select_Order_In_Blotter(orderSymbol, quantity, status)
{
    var nbr = Get_OrderGrid().RecordListControl.Items.Count;
    
    for(var i = 0; i<nbr; i++) {
        if(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == orderSymbol 
           && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Quantity == quantity
           && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.Status == status){
           
           Get_OrderGrid().RecordListControl.Items.Item(i).set_IsSelected(true);
           Get_OrderGrid().RecordListControl.Items.Item(i).set_IsActive(true);
        
        }               
    }
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
           break;
        }                          
    }
}


function Insert_AVGCOST_Account()
{
    var sqlString1 = "delete from B_GDO_AVGCOST_ACCOUNT where rep_id in (14, 13)";
    Execute_SQLQuery(sqlString1, vServerOrders);
    
    var sqlString2 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'CAD', 'SEBGX98C')";
    Execute_SQLQuery(sqlString2, vServerOrders);
    
    var sqlString3 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 14, 'USD', 'SEBGX98D')";
    Execute_SQLQuery(sqlString3, vServerOrders);
    
    var sqlString4 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'CAD', 'SEBGX98C')";
    Execute_SQLQuery(sqlString4, vServerOrders);
    
    var sqlString5 = "insert into dbo.B_GDO_AVGCOST_ACCOUNT (CODE_TYPE, rep_id, CURRENCY, ACCOUNT_NUMBER) values ('R', 13, 'USD', 'SEBGX98D')";
    Execute_SQLQuery(sqlString5, vServerOrders);
}


function Compare_Phase1_File(referenceFile)
{   
    var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d")
    var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\";
    var refFolder = folderPath_Data + client + "\\TCVE8207\\ExpectedFolder\\";

    var generatedFileName = "ism" + date + "_39.txt";
    //Validation du fichier Phase1
    //CompareTxtFiles(refFolder, referenceFile, localDestinationFilePath, generatedFileName);
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



function Validate_Tag_In_Log_File(arrayOfStringTofind)
{
    Log.PopLogFolder();
    logEtape13= Log.AppendFolder("Ouvrir WinSCP Aller dans /home/crweb/Test_CR1571/ et consulter et valider le fichier le plus récent");
    
    Log.Message("Aller dans /home/crweb/Test_CR1571/ et consulter le fichier le plus récent");    
    SSHExecute("CommandeSSHForTCVE8207");// Vérifie que le fichier Json contient les textes recherchés  et par la suite met le fichier avec de résultats sur P:                     
    var localDestinationFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteOrdres\\Ordres\\SSH\\"
          
    //savgarder les fichiers sur P: (les fichiers contenants des résultats et le chemin vers le fichier JSON )       
    var vserverFilePath = "/home/crweb/Test_CR1571/SearchResultsTCVE8207.txt" 
    CopyFileFromVserverThroughWinSCP(vServerOrders, vserverFilePath, localDestinationFilePath);
          
    
    //Déclaration de résultats attendus: combien de fois chaque texte devrait être présent dans le fichier JSON
    var listOfResults  = "0|";
    var arrayOfResults = listOfResults.split("|");
          
          
    //Validation du fichier log
    var myFile = aqFile.OpenTextFile(localDestinationFilePath + "SearchResultsTCVE8207.txt", aqFile.faRead, aqFile.ctANSI);
                     
    while(! myFile.IsEndOfFile()) {    
        line = myFile.ReadLine();
        //Split at each space character.
        var LogArr = line.split("\n"); 
        Log.Message("Nombre de fois que se retrouve la chaîne de caractères: " + line);   
        
           
        if(aqObject.CompareProperty(VarToString(LogArr), cmpGreater, 0, true, lmNone)) {
            Log.Checkpoint("Le texte " + arrayOfStringTofind + " est présent " + VarToString(LogArr) + " fois dans le fichier Log");
        } 
        else{
            Log.Error("Le texte " + arrayOfStringTofind + " n'est pas présent dans le fichier 'FIX.4.2-CROESUS6-PROXY.messages.current.log'.");
        }
    }
}



function Validate_Phase1_File(localDestinationFilePath, arrayOfStringsTofind, generatedFileName)
{         
    //Validation du fichier log
    var myFile = aqFile.OpenTextFile(localDestinationFilePath + generatedFileName, aqFile.faRead, aqFile.ctANSI);
    var found = false;
    
    for (i=0; i< arrayOfStringsTofind.length; i++) {
        found = false;
        
        while(! myFile.IsEndOfFile() && found == false) {    
            line = myFile.ReadLine();

            if(aqString.Find(line, arrayOfStringsTofind[i]) != -1) {
                Log.Checkpoint("Le texte  '" + arrayOfStringsTofind[i] + "'  est présent dans le fichier '" + generatedFileName + "'.");
                found = true;
            }
        }
        
        if (found == false)
            Log.Error("Le texte " + arrayOfStringsTofind[0] + " n'est pas présent dans le fichier '" + generatedFileName + "'.");
    }
}