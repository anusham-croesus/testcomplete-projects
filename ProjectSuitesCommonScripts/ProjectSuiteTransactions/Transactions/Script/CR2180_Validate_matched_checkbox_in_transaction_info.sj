//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints



/**
    Description : 
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6613
    Analyste d'assurance qualité : Xian Wei (analyste d'automatisation)
    Analyste d'automatisation : Philippe Maurice
    Version:  90.24.2021.04-143   (Base de Données CIBC)
*/

function CR2180_Validate_matched_checkbox_in_transaction_info()
{
    try {
        
        /*Variables*/
        userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        userNameFORTINN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTINN", "username");
        passwordFORTINN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "FORTINN", "psw");
        
        var champ = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Field", language+client);
        var operator = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Operator", language+client);
        var value = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Value", language+client);
        
        var symbol = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Symbol", language+client);
        var clientNo = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_ClientNo", language+client);
        var accountNA = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_AccountNA", language+client);
        var accountRE = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_AccountRE", language+client);

        var qty = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Qty", language+client);
        var price = ReadDataFromExcelByRowIDColumnID(filePath_Transactions, "CR2180", "CR2180_Price", language+client);
                
        Log.Link("https://jira.croesus.com/browse/TCVE-1881", "Lien du cas de test sur X-Ray");
        Log.Link("https://jira.croesus.com/browse/TCVE-6087", "Lien de la story sur JIRA");
              
        var myUsername = "philippema";
        var CRFolder = "CR2180";
        var filterName = "TEST_CR2180";
      
        
        
        //---- ÉTAPE 1 ----        
        // *Inserer les transactions dans la BD:*
        Log.PopLogFolder();
        logInsertTransactions = Log.AppendFolder("-- Étape 1: Insérer les transactions. --");
        InsertTransactions(CRFolder, myUsername);
        
        
        //---- ÉTAPE 2 ----
        //Activer la pref et redémarrer les services
        Log.PopLogFolder();
        logActivationPrefs = Log.AppendFolder("-- Étape 2: Activation des PREFS --");
        Activation_PREFS();
        

        //Login
        Login(vServerTransactions, userNameKEYNEJ, passwordKEYNEJ, language);
        

        //---- ÉTAPE 4 ----
        Log.PopLogFolder();
        logValidationQuantity = Log.AppendFolder("-- Étape 4: Mailler client vers module Transactions, création de filtre et aller dans info transactions. --");
        
        //Mailler vers le module Transactions
        Get_ModulesBar_BtnClients().Click();  
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
  
        //* Mailler le client 300001 dans le module Transactions
        Search_Client(clientNo);  //Sélectionner le client
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();
        Delay(5000);
        
        //* Dans la barre de menu, ajouter le filtre 'Type de transaction égal Transfert'
        Create_RapideFilter(filterName, champ, operator, value);
        Delay(1000);
        
        //* Ouvrir la fenêtre Info transaction pour une transaction parmi la liste affichée* + Validations
        SelectTransaction(symbol, accountNA);
        Get_TransactionsBar_BtnInfo().Click();  //La fenêtre Info transaction pour le compte 300001-NA
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, true);  //1. La case 'MATCHED'/'Reliée' est cochée par défaut et non grisée
        aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate(), "IsEnabled", cmpEqual, false);  //2. Le bouton Séparer est grisé
        Get_WinTransactionsInfo_BtnCancel().Click();
        

        SelectTransaction(symbol, accountRE);
        Get_TransactionsBar_BtnInfo().Click();  //La fenêtre Info transaction pour le compte 300001-RE
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, true);  //1. La case 'MATCHED'/'Reliée' est cochée par défaut et non grisée
        aqObject.CheckProperty(Get_WinTransactionsInfo_BtnSeparate(), "IsEnabled", cmpEqual, true);  //2. Le bouton Séparer est actif
        Get_WinTransactionsInfo_BtnCancel().Click();
        Delay(1000);
        
        
        //---- ÉTAPE 7 ----
        Log.PopLogFolder();
        logUncheckMatched = Log.AppendFolder("-- Étape 7: Décocher la case 'Relié'. --");
        
        //* Revenir à l'application, ouvrir la fenêtre Info transaction pour la transaction dans le compte 300001-NA (no_trans=4100172019321)
        SelectTransaction(symbol, accountNA);
        Get_TransactionsBar_BtnInfo().Click();
        
        //* Décocher la case MATCHED/Reliée 
        if (Get_WinTransactionsInfo_ChkMatched().IsChecked == true)
            Get_WinTransactionsInfo_ChkMatched().Click();
        
        Get_WinTransactionsInfo_BtnOK().Click();  //* Cliquer sur OK   

        
        //---- ÉTAPE 8 ----
        Log.PopLogFolder();
        logValidationMatched = Log.AppendFolder("-- Étape 8: Validation de la case à cocher 'Relié'. --");
        
        SelectTransaction(symbol, accountNA);  //1. Dans compte 300001-NA (no-trans=4100172019321)
        Get_TransactionsBar_BtnInfo().Click();  //Réouvrir la fenêtre Info transaction pour la transaction:
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, false);  //1. Compte 300001-NA  La case MATCHED/Reliée est décochée
        Get_WinTransactionsInfo_BtnCancel().Click();
        
        
        SelectTransaction(symbol, accountRE);  //2. Dans compte 300001-RE (no-trans=4100172019323)  
        Get_TransactionsBar_BtnInfo().Click();
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, false); //2. Compte 300001-RE  La case MATCHED/Reliée est décochée
        Get_WinTransactionsInfo_BtnCancel().Click();

        
        
        //---- ÉTAPE 11 ----
        Log.PopLogFolder();
        logSeperate = Log.AppendFolder("-- Étape 11: Séparer transaction et modifier les quantités --.");
        
        SelectTransaction(symbol, accountRE);  //2. Dans compte 300001-RE (no-trans=4100172019323)  
        Get_TransactionsBar_BtnInfo().Click();  // * Reouvrir la fenêtre Info transaction pour le compte 300001-RE, Symbole SAP 
        Get_WinTransactionsInfo_BtnSeparate().Click();        // * Cliquer sur Séparer
        
        // * Modifier les quantités affichée à 200, prix=20 et sauvegarder
        Edit_Seperated_Quantities(qty, price);
        Get_WinTransactionsInfo_BtnOK().Click();


        
        //---- ÉTAPE 13 ---
        Log.PopLogFolder();
        logReprocess = Log.AppendFolder("-- Étape 13: Exécuter la commande REPROCESS. --");
               
        //Faire le reprocess pour s'assurer que les 2 lots secondaires S ne sont pas supprimés
        Reprocess(CRFolder, myUsername);
              
        
        
        //---- ÉTAPE 14 ----
        Log.PopLogFolder();
        logCheckMatched = Log.AppendFolder("-- Étape 14: Cocher la case 'Relié'.  --");
        
        // * Revenir à l'application, ouvrir la fenêtre Info transaction pour la transaction dans le compte 300001-NA (no_trans=4100172019321)
        SelectTransaction(symbol, accountNA);
        Get_TransactionsBar_BtnInfo().Click();
        
        // * Cocher la case MATCHED/Reliée
        if (Get_WinTransactionsInfo_ChkMatched().IsChecked == false)
            Get_WinTransactionsInfo_ChkMatched().Click();
        
        Get_WinTransactionsInfo_BtnOK().Click();   //* Cliquer sur OK
        
        
        
        //---- ÉTAPE 15 ---- 
        Log.PopLogFolder();
        logValidationMatched = Log.AppendFolder("-- Étape 15: Validation de la case 'Relié'. --");
          
        SelectTransaction(symbol, accountNA);  //1. Dans compte 300001-NA (no-trans=4100172019321)
        Get_TransactionsBar_BtnInfo().Click();  //Réouvrir la fenêtre Info transaction pour la transaction
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, true);  //1. Compte 300001-NA  La case MATCHED/Reliée est cochée
        Get_WinTransactionsInfo_BtnCancel().Click();
        
        SelectTransaction(symbol, accountRE);   //2. Dans compte 300001-RE (no-trans=4100172019323)
        Get_TransactionsBar_BtnInfo().Click();  //Réouvrir la fenêtre Info transaction pour la transaction  
        aqObject.CheckProperty(Get_WinTransactionsInfo_ChkMatched(), "IsChecked", cmpEqual, true);  //2. Compte 300001-RE  La case MATCHED/Reliée est cochée aussi
        Get_WinTransactionsInfo_BtnCancel().Click();
        

        //---- ÉTAPE 18 ----
        Log.PopLogFolder();
        logActicationPREF2 = Log.AppendFolder("-- Étape 18: Activation de PREF. --");
        //Activer PREF        
        Activate_Inactivate_Pref("FORTINN", "PREF_ALLOW_STOP_MATCHING_TRANSACTION", "NO", vServerTransactions);
        RestartServices(vServerTransactions);
        
        
        //---- ÉTAPE 19 ----
        Log.PopLogFolder();
        logLogin = Log.AppendFolder("-- Étape 19: Se loguer avec FORTINN. --");
        
        //Ouvrir Croesus Advisor avec le user FORTINN et aller dans le module Transactions
        Login(vServerTransactions, userNameFORTINN, passwordFORTINN, language);
        
        
        //---- ÉTAPE 20 ----
        Log.PopLogFolder();
        logStep4 = Log.AppendFolder("-- Étape 20: Refaire étape 4. --");
        
        //Refaire étape 3 et 4
        Get_ModulesBar_BtnClients().Click(); 
        WaitObject(Get_RelationshipsClientsAccountsGrid(), ["ClrClassName", "WPFControlOrdinalNo"], ["XamTextEditor", "1"]);
  
        //Mailler External Clients vers Transactions
        Search_Client(clientNo);  //Sélectionner le client
        Get_MenuBar_Modules().Click();
        Get_MenuBar_Modules_Transactions().Click();
        Get_MenuBar_Modules_Transactions_DragSelection().Click();

        Get_MainWindow().Maximize();
        Get_ModulesBar_BtnTransactions().Click();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 15000);
        WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071");
        
        //---- ÉTAPE 21 ----
        Log.PopLogFolder();
        logSeperateAndValidation = Log.AppendFolder("-- Étape 21: Séparer transactions et validation message. --");
        
        //Dans la fenêtre Info transaction du compte 300001-RE, symbole SAP, cliquer sur Séparer
        SelectTransaction(symbol, accountRE);   //2. Dans compte 300001-RE (no-trans=4100172019323)
        Get_TransactionsBar_BtnInfo().Click();
        Get_WinTransactionsInfo_BtnSeparate().Click();
        
        //Validation
        //Un message d'avertissement est affiché "Cette transaction ne peut pas être séparée"
         if (Get_DlgWarning().Exists && Get_DlgWarning().IsActive){
            Log.Message("La boîte de dialogue 'Avertissement' s'est affichée.");
            Get_DlgWarning().Keys("[Enter]");
         }
         else
            Log.Error("La boîte de dialogue 'Avertissement' devrait s'afficher.");
    }
    catch(e) {
		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
		    //Fermer le processus Croesus
        Terminate_CroesusProcess();
		
        //---- ÉTAPE 22 ----
        Log.PopLogFolder();
        logCleanup = Log.AppendFolder("-- Étape 22: Remise à l'état initial. --");
        //Faire le cleanup nécessaire pour remettre le tout à l'état initial
        Clean_Up_Data(CRFolder, myUsername);
    }
}


function Activation_PREFS()
{
    var sqlQueryString = "Insert into b_config (Cle,User_NuM, CLEGROUPE,RANG,CLELONG_L1,CLELONG_L2,FPICTURE,FVALID,AVANCE,NOTE,FIRM_ID,CUSTODIAN_ID) values ('MANUALLY_DE_MATCHABLE_TRANS_TYPES',0,'P125 Transactions',1,'Cette configuration contient la liste des typ','This configuration contains the list of trans','','','','5',1,1)";
    Execute_SQLQuery(sqlQueryString, vServerTransactions);
    
    Activate_Inactivate_Pref("KEYNEJ", "PREF_ALLOW_STOP_MATCHING_TRANSACTIONS", "YES", vServerTransactions);
    RestartServices(vServerTransactions);
}


function InsertTransactions(CRFolder, myUsername)
{  
    var folderPath_Data = aqFileSystem.GetFolderInfo(folderPath_ProjectSuiteCommonScripts).ParentFolder.Path + "Data\\";
    var vserverFolder = "/home/" + myUsername + "/loader/" + CRFolder + "/";

    CopyFileToVserverThroughWinSCP(vServerTransactions,  vserverFolder, folderPath_Data + "CIBC\\CR2180\\tra_IN-OUT_BDQA.xml");
        
    // * Ouvrir le vserver avec Putty, se positionner sur l'emplacement du fichier 
    // * Lancer la commande:  loader tra_IN-OUT_BDQA.xml -FORCE -LOG2STDOUT
    ExecuteSSHCommand(CRFolder, vServerTransactions, "loader tra_IN-OUT_BDQA.xml -FORCE -LOG2STDOUT", myUsername);
    Reprocess(myUsername);
}



function SelectTransaction(symbol, account)
{
    var i = 1;
    var found = false;
  
    while (found == false && i < Get_Transactions_ListView().Items.Count) {
        if (((Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", i], 10).WPFObject("BrowserCellTemplateSimple", "", 6).Text  == symbol)
          && (Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", i], 10).WPFObject("BrowserCellTemplateSimple", "", 1).Text == account))) {
          found = true;
          Get_Transactions_ListView().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DragableListViewItem", i], 10).WPFObject("BrowserCellTemplateSimple", "", 6).Click();
          Log.Message("Transaction trouvée: Compte: " + account + "Symbole: " + symbol);
        }
        else {
          i = i + 1;
        } 
    }
    if (i >= Get_Transactions_ListView().Items.Count)
        Log.Error("Transaction" + account + "  " + symbol + "  n'a pas trouvée!");
}


function Edit_Seperated_Quantities(quantity, price)
{     
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).Click();
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("XamNumericEditor", "", 1).Keys(quantity);
    
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).Click();
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1).Keys(price);

    
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).Click();
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 2).WPFObject("XamNumericEditor", "", 1).Keys(quantity);

    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).Click();
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 3).WPFObject("XamNumericEditor", "", 1).Keys(price);
    
    Get_WinSeperate_SeperatedQuantities_Grid().WPFObject("DataRecordPresenter", "", 2).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid").WPFObject("CellValuePresenter", "", 4).Click();
    
    Get_WinSeperate_SeperatedQuantities_BtnSave().Click();
}


function Delete_Transactions()
{
    var sqlQueryString = "delete FROM b_trans WHERE no_trans IN (select no_trans FROM b_trans where no_compte LIKE '%300001%'and SECURITY=49132)";
    
    Execute_SQLQuery(sqlQueryString, vServerTransactions);
}


function Clean_Up_Data(CRFolder, myUsername)
{
    var sqlQueryString = "delete from b_config where CLE ='MANUALLY_DE_MATCHABLE_TRANS_TYPES' AND FIRM_ID = 1";
    
    //Supprimer les transactions
    Delete_Transactions();
    Reprocess(CRFolder, myUsername);
         
    //Remettre les prefs à leur valeur initiale et redémarrer les services
    Execute_SQLQuery(sqlQueryString, vServerTransactions);
    
    Activate_Inactivate_Pref("KEYNEJ", "PREF_ALLOW_STOP_MATCHING_TRANSACTIONS", "NO", vServerTransactions);
    RestartServices(vServerTransactions);   
}


function Reprocess(CRFolder, myUsername) 
{
     //*Lancer le reprocess pour s'assurer que les transactions ont bien été inserer: (lancer une commande à la fois)*
    // * loader -REPROCESS=300001-RE,2009.01.01 -FORCE -LOG2STDOUT
    ExecuteSSHCommand(CRFolder, vServerTransactions, "loader -REPROCESS=300001-RE,2009.01.01 -FORCE -LOG2STDOUT", myUsername);
    // * loader -REPROCESS=300001-NA,2009.01.01 -FORCE -LOG2STDOUT
    ExecuteSSHCommand(CRFolder, vServerTransactions, "loader -REPROCESS=300001-NA,2009.01.01 -FORCE -LOG2STDOUT", myUsername);
}