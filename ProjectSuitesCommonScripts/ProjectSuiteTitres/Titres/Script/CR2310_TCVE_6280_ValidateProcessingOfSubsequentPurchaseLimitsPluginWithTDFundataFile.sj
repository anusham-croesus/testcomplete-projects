//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Common_Get_functions
//USEUNIT Titres_Get_functions
//USEUNIT DBA


/**
    Description : 
    Ce test permet de valider le traitement du plugin avec le fichier Fundata de TD pour mettre à jour les colonnes 
    BUY_MIN_AMOUNT_INITIAL et BUY_MIN_AMOUNT_NEXT de la table B_TITRE basé sur un symbole. Ces colonnes correspondent 
    aux champs Montant initial / Initial amount et Montant subséquent / Subsequent amount pour l'achat des fonds mutuels 
    dans la fenêtre Info Titres.

    Voir la documentation dans Confluence SubsequentPurchaseLimits : 
    https://confluence.croesus.com/pages/viewpage.action?spaceKey=DEV&title=SubsequentPurchaseLimits
    
    Analyste d'assurance qualité : Christine Perreault
    Analyste d'automatisation : Abdel Matmat
    Date: 30/06/2021
    version 2021.04-127 pour le client TD
    MAJ le 02/11/2021
    version 2021.08-96 pour TD
*/

function CR2310_TCVE_6280_ValidateProcessingOfSubsequentPurchaseLimitsPluginWithTDFundataFile()
{
    try {
        
        //Lien de la story dans Jira
        Log.Link("https://jira.croesus.com/browse/TCVE-6445", "Lien vers la story");
        Log.Link("https://jira.croesus.com/browse/TCVE-6280", "Lien vers le cas de test");
         
        
        /*VARIABLES*/
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
       
        var queryStep3 = "SELECT SYMBOLE, SECUFIRME, BUY_MIN_AMOUNT_INITIAL, BUY_MIN_AMOUNT_NEXT FROM B_TITRE WHERE SYMBOLE IN"
        queryStep3 += "('AGF102', 'AGF104', 'AGF110',"
        queryStep3 +="'AGF201', 'AGF202', 'AGF210',"
        queryStep3 +="'AGF304', 'AGF306', 'AGF307',"
        queryStep3 +="'AGF410', 'AGF414', 'AGF418',"
        queryStep3 +="'AIC117', 'AIC118', 'AIC119',"
        queryStep3 +="'AIC301', 'AIC302', 'AIC310',"
        queryStep3 +="'AIC402', 'AIC446', 'AIC450',"
        queryStep3 +="'ABC123', 'DEF456', 'GHI789',"
        queryStep3 +="'AIM1231', 'AIM1233', 'AIM1235',"
        queryStep3 +="'AIM1511', 'AIM1512', 'AIM1513',"
        queryStep3 +="'AIM1641', 'AIM1643', 'AIM1645',"
        queryStep3 +="'AIM1721','AIM1731', 'AIM1733', 'AIM1735', 'AIM1741', 'AIM1743')"
        queryStep3 +="OR SECUFIRME IN ('760929', '760931', '760943')"
        queryStep3 +="OR SYMBOLE = '' AND (BUY_MIN_AMOUNT_INITIAL != NULL OR BUY_MIN_AMOUNT_NEXT != NULL)"
        queryStep3 +="ORDER BY SYMBOLE"
        
        var field1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "field1", language+client);
        var field2= ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "field2", language+client);
        var field3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "field3", language+client);
        var field4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "field4", language+client);
        
        var expected1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "expected1", language+client);
        var expected2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "expected2", language+client);
        var expected3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "expected3", language+client);
        var expected4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "expected4", language+client);
        
        var msg1 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg1", language+client);
        var msg2 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg2", language+client);
        var msg3 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg3", language+client);
        var msg4 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg4", language+client);
        var msg5 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg5", language+client);
        var msg6 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg6", language+client);
        var msg7 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg7", language+client);
        var msg8 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg8", language+client);
        var msg9 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg9", language+client);
        var msg10 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg10", language+client);
        var msg11 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "msg11", language+client);
        var SecuritySymbolAGF304 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "SecuritySymbolAGF304", language+client);
        var initialAmount = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "initialAmount", language+client);
        var subsequentAmount = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR2310", "subsequentAmount", language+client);
           
        

        
/************************************Étape 1et 2 ************************************************************************/     
        //Se connecter au vserver avec WinSCP et PuTTY
        Log.PopLogFolder();
        logEtape1 = Log.AppendFolder("Étape 1 et 2: Se connecter au vserver avec WinSCP et PuTTY");
        
        var loaderFileName = "CR-2310_Tests_Regroupes.xml"//ReadDataFromExcelByRowIDColumnID(filePath_Titre, "CR1449", "Croes-5437_LoaderFileName", language + client);
        var loaderFilePath = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTitres\\Titres\\" + loaderFileName;
        var testUserName = "abdelm"
        var CRFolder = "CR2310"
        var vserverFolder = "/home/" + testUserName + "/loader/" + CRFolder;
        
        var vserverLogFilePath = "/var/log/finansoft/cfLoaderFIRM_0.log"; 
        var logFile = "cfLoaderFIRM_0.log"
        var Titres_REPOSITORY_SSH = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTitres\\Titres\\SSH\\";
        //Supprimer le fichier Log existant
        var attr = Log.CreateNewAttributes();
        attr.Bold = true;
        Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
        ExecuteWinSCPCommand(vServerTitre, '"rm ' + vserverLogFilePath + '"'); 
        
        //Copier le fichier CR-2310_Tests_Regroupes.xml dans le vserver et lancer la commande loader : cfLoader -SubsequentPurchaseLimits --FileName="CR-2310_Tests_Regroupes.xml"
        Log.Message("Copier le fichier CR-2310_Tests_Regroupes.xml dans le vserver et lancer la commande loader : cfLoader -SubsequentPurchaseLimits --FileName='CR-2310_Tests_Regroupes.xml'", "", pmNormal, attr);
        CopyFileToVserverThroughWinSCP(vServerTitre, vserverFolder, Titres_REPOSITORY_SSH + loaderFileName);
        
//        CopyFileToVserver(vServerTitre, testUserName, vserverFolder + loaderFileName, loaderFilePath);
//        var sshCommands = "cd " + vserverFolder;
        var sshCommands = "cfLoader -SubsequentPurchaseLimits --FileName="+ loaderFileName;
        ExecuteSSHCommandCFLoader(CRFolder, vServerTitre, sshCommands, testUserName);
        

/************************************Étape 3************************************************************************/     
        Log.PopLogFolder();
        logEtape3 = Log.AppendFolder("Étape 3: Se connecter à la BD du vserver et rouler la requête SQL" );
  
        var output1 = Execute_SQLQuery_GetFieldAllValues(queryStep3, vServerTitre, field1);
        Log.Message( output1);
        var output2 = Execute_SQLQuery_GetFieldAllValues(queryStep3, vServerTitre, field2);
        Log.Message( output2);
        var output3 = Execute_SQLQuery_GetFieldAllValues(queryStep3, vServerTitre, field3);
        Log.Message( output3);
        var output4 = Execute_SQLQuery_GetFieldAllValues(queryStep3, vServerTitre, field4);
        Log.Message( output4);
       
      
/************************************Étape 4 et 5************************************************************************/     
        Log.PopLogFolder();
        logEtape4 = Log.AppendFolder("Étape 4 et 5: Valider les résultats de la requête SQL" );
        
        checkResults(expected1,output1);
        checkResults(expected2,output2);
        checkResults(expected3,output3);
        checkResults(expected4,output4);
        
 /************************************Étape 6************************************************************************/     
        Log.PopLogFolder();
        logEtape6 = Log.AppendFolder("Étape 6: vérifier les information liées à l'exécution du plugin SubsequentPurchaseLimits à la fin du fichier." );
                 
         //Copier le fichier Log du vserveur
         Log.Message("Copier le fichier Log du vserveur");
         CopyFileFromVserverThroughWinSCP(vServerTitre, vserverLogFilePath, Titres_REPOSITORY_SSH);
          
         //Vérifier si le fichier Log contient les deux messages

         Log.Message("Vérifier si le fichier Log contient les messages liés au plugin", "", pmNormal, attr);
         FindStringInFile(msg1, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg2, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg3, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg4, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg5, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg6, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg7, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg8, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg9, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg10, logFile, Titres_REPOSITORY_SSH);
         FindStringInFile(msg11, logFile, Titres_REPOSITORY_SSH);
          
 /************************************Étape 7************************************************************************/     
         Log.PopLogFolder();
         logEtape7 = Log.AppendFolder("Étape 7: Se connecter à Croesus avec KEYNEJ et Valider les valeurs des champs Montant initial et Montant subséquent dans la section Achats." );
         
         Log.Message("Se connecter à Croesus avec KEYNEJ et accéder au module Titres");
         
         Login(vServerTitre, userNameKEYNEJ, passwordKEYNEJ, language);
         Get_ModulesBar_BtnSecurities().Click();
         Get_ModulesBar_BtnSecurities().WaitProperty("IsChecked", true, 30000);  
         
         //Rechercher le symbole = AGF304.
         Log.Message("Rechercher le symbole = AGF304.");
         Search_SecurityBySymbol(SecuritySymbolAGF304);
         Get_SecurityGrid().Find("Value", SecuritySymbolAGF304, 10).DblClick();
         
         //Valider les valeurs du Montant Initial et Montant suséquent
         Log.Message("Valider les valeurs du Montant Initial et Montant suséquent");
         aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_TxtInitialAmount(), "Value", cmpEqual, initialAmount);
         aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpBuys_TxtSubsequentAmount(), "Value", cmpEqual, subsequentAmount);           
 
    }
    catch(e) {
        //S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
        Log.PopLogFolder();
        logEtape8 = Log.AppendFolder("Étape 8: rouler la requête suivante pour remettre la BD à son état initial" );
        var queryStep6 = "UPDATE B_TITRE SET BUY_MIN_AMOUNT_INITIAL = NULL , BUY_MIN_AMOUNT_NEXT = NULL WHERE SYMBOLE IN"
            queryStep6 += "('AGF102', 'AGF104', 'AGF110',"
            queryStep6 += "'AGF201', 'AGF202', 'AGF210',"
            queryStep6 += "'AGF304', 'AGF306', 'AGF307',"
            queryStep6 += "'AGF410', 'AGF414', 'AGF418',"
            queryStep6 += "'AIC117', 'AIC118', 'AIC119',"
            queryStep6 += "'AIC301', 'AIC302', 'AIC310',"
            queryStep6 += "'AIC402', 'AIC446', 'AIC450',"
            queryStep6 += "'ABC123', 'DEF456', 'GHI789',"
            queryStep6 += "'AIM1231', 'AIM1233', 'AIM1235',"
            queryStep6 += "'AIM1511', 'AIM1512', 'AIM1513',"
            queryStep6 += "'AIM1641', 'AIM1643', 'AIM1645',"
            queryStep6 += "'AIM1721','AIM1731', 'AIM1733', 'AIM1735', 'AIM1741', 'AIM1743')"
            queryStep6 += "OR SECUFIRME IN ('760929', '760931', '760943')"
            queryStep6 += "OR SYMBOLE = '' AND (BUY_MIN_AMOUNT_INITIAL != NULL OR BUY_MIN_AMOUNT_NEXT != NULL)"
            
        Execute_SQLQuery(queryStep6, vServerTitre);
        
        //Fermer croesus
        Terminate_CroesusProcess();
          
	
    }
}

function checkResults(expected,obtain){
  if (expected == obtain)
      Log.Checkpoint("La valeur obtenue égale à la valeur attendue");
  else  
      Log.Error("La valeur obtenue est différente de la valeur attendue ");
}
function FindStringInFile(messageToFind, fileName, filePath){
  
          var sPath = filePath + fileName;
          var executionDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d");
//          Log.Message(sPath);

          var attr = Log.CreateNewAttributes();
          attr.Bold = true;
          // Opens the specified file for reading
          var myFile = aqFile.OpenTextFile(sPath, aqFile.faRead, aqFile.ctUTF8);
          
          var Str = "\n";
          var isFound = false;
          // Reads text lines from the file
          while(! myFile.IsEndOfFile())
          {
              InputString = myFile.ReadToSymbol(Str);
              myFile.Skip(1);
              if(aqString.Contains(InputString, messageToFind, 0, false)>-1 && aqString.Contains(InputString, executionDateString, 0, false)>-1){
                  Log.Checkpoint("Le message -- '"+ messageToFind +"' -- existe dans le fichier log", "", pmNormal, attr);
                  isFound = true
               }
          }
          if (!isFound)
                Log.Error("Le fichier Log ne contient pas le message :" + messageToFind, "", pmNormal, attr);        
          // Closes the file
          myFile.Close();
} 

function test(){
  var queryStep3 = "SELECT SYMBOLE, SECUFIRME, BUY_MIN_AMOUNT_INITIAL, BUY_MIN_AMOUNT_NEXT FROM B_TITRE WHERE SYMBOLE IN"
        queryStep3 += "('AGF102', 'AGF104', 'AGF110',"
        queryStep3 +="'AGF201', 'AGF202', 'AGF210',"
        queryStep3 +="'AGF304', 'AGF306', 'AGF307',"
        queryStep3 +="'AGF410', 'AGF414', 'AGF418',"
        queryStep3 +="'AIC117', 'AIC118', 'AIC119',"
        queryStep3 +="'AIC301', 'AIC302', 'AIC310',"
        queryStep3 +="'AIC402', 'AIC446', 'AIC450',"
        queryStep3 +="'ABC123', 'DEF456', 'GHI789',"
        queryStep3 +="'AIM1231', 'AIM1233', 'AIM1235',"
        queryStep3 +="'AIM1511', 'AIM1512', 'AIM1513',"
        queryStep3 +="'AIM1641', 'AIM1643', 'AIM1645',"
        queryStep3 +="'AIM1721','AIM1731', 'AIM1733', 'AIM1735', 'AIM1741', 'AIM1743')"
        queryStep3 +="OR SECUFIRME IN ('760929', '760931', '760943')"
        queryStep3 +="OR SYMBOLE = '' AND (BUY_MIN_AMOUNT_INITIAL != NULL OR BUY_MIN_AMOUNT_NEXT != NULL)"
        queryStep3 +="ORDER BY SYMBOLE"
        Execute_SQLQuery(queryStep3, vServerTitre);
}
function test1(){
  RestartServices(vServerTitre)
}