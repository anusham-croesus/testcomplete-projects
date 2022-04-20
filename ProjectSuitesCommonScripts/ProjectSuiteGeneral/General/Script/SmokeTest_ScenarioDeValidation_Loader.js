//USEUNIT SmokeTest_Common
//USEUNIT DBA




/*
    Description : Scénario de validation loader
    https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc
        1. Exécuter les commandes SSH suivantes (les fichiers .xml doivent se trouver dans le répertoire à partir duquel les commandes sont exécutées) :
            loader auto_999999_profil.xml -FORCE
            loader auto_999999_transactions.xml -FORCE
            loader -TOTALS -FORCE
        2. Se connecter à Croesus.
        3. Aller au module Clients et vérifier que le client 999999 existe.
        4. Mailler le client 999999 vers le module Comptes et valider que la grille de Comptes n'est pas vide .
        5. Mailler le client 999999 vers le module Transactions et valider que la grille de Transactions n'est pas vide.
        
    Analyste d'automatisation : Christophe Paring
*/

function SmokeTest_ScenarioDeValidation_Loader()
{
    Log.Link("https://docs.google.com/spreadsheets/d/1EgafIJRaV9-ebh37PGOwWckH9lbsTnSHZ0FAE5HZYAc", "SmokeTest_ScenarioDeValidation_Loader()");
    
    var logAttributes = Log.CreateNewAttributes();
    logAttributes.Bold = true;
    
    try {
        var profilFileName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_ProfilFileName", language + client);
        var transactionsFileName = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_TransactionsFileName", language + client);
        var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_ClientNumber", language + client);
        var Loader_XML_File_Processing_OutputSuccessRegEx = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_XML_File_Processing_OutputSuccessRegEx", language + client);
        var Loader_Transactions_Calculator_OutputSuccessRegEx = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_Transactions_Calculator_OutputSuccessRegEx", language + client);
        var Loader_Calculate_models_OutputSuccessRegEx = ReadDataFromExcelByRowIDColumnID(filePath_General, "SmokeTests", "Loader_Calculate_models_OutputSuccessRegEx", language + client);
        var vserverFolder = "/tmp/";
        var localFolder = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteGeneral\\General\\SSH\\";
        
        
        //1. Exécuter les commandes SSH suivantes (les fichiers .xml doivent se trouver dans le répertoire à partir duquel les commandes sont exécutées) :
        //   loader auto_999999_profil.xml -FORCE
        //   loader auto_999999_transactions.xml -FORCE
        //   loader -TOTALS -FORCE
            
        Log.Message("1. Execute SSH commands :", "", pmNormal, logAttributes);
        Log.Message("loader " + profilFileName + " -FORCE");
        Log.Message("loader " + transactionsFileName + " -FORCE");
        Log.Message("loader -TOTALS -FORCE");
        
        //Copier les fichiers XML sur le vserver.
        Log.Message("Copy file '" + profilFileName + "' to the vserver", "", pmNormal, logAttributes);
        if (!CopyFileToVserver(vServerGeneral, userNameGeneral, vserverFolder + profilFileName, localFolder + profilFileName))
            return Log.Error("Unable to copy file '" + profilFileName + "' to the vserver");
        
        Log.Message("Copy file '" + transactionsFileName + "' to the vserver", "", pmNormal, logAttributes);
        if (!CopyFileToVserver(vServerGeneral, userNameGeneral, vserverFolder + transactionsFileName, localFolder + transactionsFileName))
            return Log.Error("Unable to copy file '" + transactionsFileName + "' to the vserver");

        //Exécuter les commandes Loader
        var sshCommand_1 = "loader " + vserverFolder + profilFileName + " -FORCE";
        var outputSuccessRegEx_1 = Loader_XML_File_Processing_OutputSuccessRegEx;
        Log.Message("Execute : " + sshCommand_1, sshCommand_1, pmNormal, logAttributes);
        ExecuteSSHCommandWithErrorCheck("SmokeTest_ScenarioDeValidation_Loader_1", vServerGeneral, sshCommand_1, userNameGeneral, outputSuccessRegEx_1, vserverFolder + "SmokeTest_Loader_Error_1.txt", folderPath_ProjectSuiteCommonScripts + "SmokeTest_Loader_Error_1.txt");
        
        var sshCommand_2 = "loader " + vserverFolder + transactionsFileName + " -FORCE";
        var outputSuccessRegEx_2 = Loader_Transactions_Calculator_OutputSuccessRegEx;
        Log.Message("Execute : " + sshCommand_2, sshCommand_2, pmNormal, logAttributes);
        ExecuteSSHCommandWithErrorCheck("SmokeTest_ScenarioDeValidation_Loader_2", vServerGeneral, sshCommand_2, userNameGeneral, outputSuccessRegEx_2, vserverFolder + "SmokeTest_Loader_Error_2.txt", folderPath_ProjectSuiteCommonScripts + "SmokeTest_Loader_Error_2.txt");
        
        var sshCommand_3 = "loader -TOTALS -FORCE";
        var outputSuccessRegEx_3 = Loader_Transactions_Calculator_OutputSuccessRegEx + Loader_Calculate_models_OutputSuccessRegEx;
        Log.Message("Execute : " + sshCommand_3, sshCommand_3, pmNormal, logAttributes);
        ExecuteSSHCommandWithErrorCheck("SmokeTest_ScenarioDeValidation_Loader_3", vServerGeneral, sshCommand_3, userNameGeneral, outputSuccessRegEx_3, vserverFolder + "SmokeTest_Loader_Error_3.txt", folderPath_ProjectSuiteCommonScripts + "SmokeTest_Loader_Error_3.txt");
        
        //2. Se connecter à Croesus.
        Log.Message("2. Login to Croesus.", "", pmNormal, logAttributes);
        Login(vServerGeneral, userNameGeneral, pswGeneral, language);
        
        //3. Aller au module Clients et vérifier que le client 999999 existe.
        Log.Message("3. Go to the Clients module and Check if client '" + clientNumber + "' exists.", "", pmNormal, logAttributes);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        Search_Client(clientNumber);
        var clientNumberCell = Get_RelationshipsClientsAccountsGrid().FindChild(["Value", "Uid"], [clientNumber, "ClientNumber"], 10);
        if (!clientNumberCell.Exists)
            return Log.Error("Client number '" + clientNumber + "' not found, this is unexpected.");
        
        Log.Checkpoint("Client number '" + clientNumber + "' found, this is expected.");
        
        //4. Mailler le client 999999 vers le module Comptes et valider que la grille de Comptes n'est pas vide .
        Log.Message("4. Drag client '" + clientNumber + "' to the Accounts module and check if there is some records.", "", pmNormal, logAttributes);
        clientNumberCell.Click();
        DragToAccountsByMenuBar();
        Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked", true, 100000);
        aqObject.CheckProperty(Get_ModulesBar_BtnAccounts(), "IsChecked", cmpEqual, true, true);
        
        var accountsCount = VarToInt(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Count);
        if (accountsCount < 1)
            return Log.Error("There is no record in the Accounts grid, this is unexpected.");
        
        Log.Checkpoint("There is some record (" + accountsCount + ") in the Accounts grid, this is expected.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        //5. Mailler le client 999999 vers le module Transactions et valider que la grille de Transactions n'est pas vide.
        Log.Message("5. Drag client '" + clientNumber + "' to the Transactions module and check if there is some records.", "", pmNormal, logAttributes);
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 100000);
        clientNumberCell.Click();
        DragToTransactionsByMenuBar();
        Get_ModulesBar_BtnTransactions().WaitProperty("IsChecked", true, 100000);
        aqObject.CheckProperty(Get_ModulesBar_BtnTransactions(), "IsChecked", cmpEqual, true, true);
        
        var transactionsCount = VarToInt(Get_Transactions_ListView().Items.Count);
        if (transactionsCount < 1)
            return Log.Error("There is no record in the Transactions grid, this is unexpected.");
        
        Log.Checkpoint("There is some record (" + transactionsCount + ") in the Transactions grid, this is expected.");
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        
        
        //Fermer Croesus
        Close_Croesus_MenuBar();
    }
    catch(e) {
        Log.Error("Exception : " + e.message, VarToStr(e.stack));
    }
    finally {
        Terminate_CroesusProcess();
    
        if (clientNumber != undefined){
            Log.Message("**************** CLEANUP *******************");
            var clientNumberInSqlSring = "'%" + clientNumber + "%'";
            Execute_SQLQuery("delete from B_TRANS where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_STATIS where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_PORTEF where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_HISPO_DELTA where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_LOT where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_HISTO_LOT where not exists (select * from B_LOT where B_HISTO_LOT.LOT_ID = B_LOT.LOT_ID)", vServerGeneral);
            Execute_SQLQuery("delete from B_COMPTE where NO_COMPTE like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_CLTEL where NO_CLIENT like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_CLADDR where NO_CLIENT like " + clientNumberInSqlSring, vServerGeneral);
            Execute_SQLQuery("delete from B_CLIENT where NO_CLIENT like " + clientNumberInSqlSring, vServerGeneral);
        }
    }
}


function ExecuteSSHCommandWithErrorCheck(CRFolderOrSSHCommandId, vServerURL, sshCommand, username, outputSuccessRegEx, remoteErrorFilePath, localErrorFilePath)
{
    //Exécuter la commande Loader
    sshCommand = sshCommand + " 2> " + remoteErrorFilePath;
    ExecuteSSHCommand(CRFolderOrSSHCommandId, vServerURL, sshCommand, username, outputSuccessRegEx);
    
    //S'assurer que la commande a été exécutée sans erreur.
    CopyFileFromVserver(vServerURL, remoteErrorFilePath, localErrorFilePath);
    var errorContent = Trim(aqFile.ReadWholeTextFile(localErrorFilePath, aqFile.ctANSI));
    if (Trim(errorContent) != "")
        Log.Error("There was error upon the execution of this SSH command : " + sshCommand, errorContent);
}
