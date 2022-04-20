//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Titres_Get_functions
//USEUNIT DBA 



/**
  
    Description : Valider que la fonctionnalité de dividende exceptionnel fonctionne avec historique de distribution (au lieu de historique des dividendes)
    https://jira.croesus.com/browse/TCVE-1182   
    Analyste d'automatisation : A.A
    
*/

          var descriptionNintendo = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_descriptionNintendo", language+client);

function TCVE_1182_AutomatisationDeLaFonctionIDC(){

        try{           
            //lien pour TestLink
            Log.Link("https://jira.croesus.com/browse/TCVE-1182");
            
            var userNameUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "username");
            var passwordUNI00 = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "UNI00", "psw");            
            var waitTime = 5000;
            var prefIDCIndicesValue   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_prefIDCIndicesValue", language+client);
            
            //Modifier les pref                                 
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_IDC_INDICES",prefIDCIndicesValue ,vServerTitre);
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_INDEXES","FIRMADM,SYSADM",vServerTitre);                        
            RestartServices(vServerTitre);      
            
            var descriptionIndex1   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_descriptionIndex1", language+client);
            var descriptionIndex2   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_descriptionIndex2", language+client);
            var descriptionIndex3   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_descriptionIndex3", language+client);
            
            var currencyCAD = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_currencyCAD", language+client);
            var currencyUSD = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_currencyUSD", language+client);
            var currencyEUR = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_currencyEUR", language+client);
            
            var valueCUSIP111 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_valueCUSIP111", language+client);
            var valueCUSIP222 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_valueCUSIP222", language+client);
            var valueCUSIP333 = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_valueCUSIP333", language+client);
            
            var countryCanada = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_countryCanada", language+client);              
            var valeur0000    = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_valeur0000", language+client);
            
            var securityNotFountMessage    = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotFoundMessage", language+client);              
            var securityNotReceveidMessage = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotReceveidMessage", language+client);
            
            var securityNotFountMessageJson    = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotFoundMessageJson", language+client);              
            var securityNotFoundValueJson      = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotFoundValueJson", language+client);
            var securityNotReceveidMessageJson = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotReceveidMessageJson", language+client);              
            var securityNotReceveidValueJson   = ReadDataFromExcelByRowIDColumnID(filePath_Titre, "TCVE", "1182_securityNotReceveidValueJson", language+client);
              
            var Titres_REPOSITORY_SSH = folderPath_ProjectSuiteCommonScripts + "ProjectSuiteTitres\\Titres\\SSH\\";
            var vserverRemoteFolder = "/home/aminea/loader/TCVE_1182/";
            var vserverLogFilePath = "/var/log/finansoft/";
              
            var fileName1 = "REGRESSION_1.csv";
            var fileName2 = "REGRESSION_2.txt";
            var logFile   = "cfLoaderFIRM_1.log";
            
            var toDayDateString = aqConvert.DateTimeToStr( aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d"));  
  
            var attr = Log.CreateNewAttributes();
            attr.Bold = true;
                               
            //Mettre la date d'aujourd'hui dans le fichier "REGRESSION_2.txt" à la ligne 1 et 3 
            Log.Message(" Mettre la date d'aujourd'hui dans le fichier REGRESSION_2.txt à la ligne 1 et 3 ");
            ChangeDateInFile(Titres_REPOSITORY_SSH, fileName2);
 
            //Copier les fichiers fileName1 fileName2 dans le vserveur
            Log.Message("Copier les fichiers REGRESSION_1.csv et REGRESSION_2.txt dans le vserveur", "", pmNormal, attr);
            CopyFileToVserverThroughWinSCP(vServerTitre, vserverRemoteFolder, Titres_REPOSITORY_SSH + fileName1);
            CopyFileToVserverThroughWinSCP(vServerTitre, vserverRemoteFolder, Titres_REPOSITORY_SSH + fileName2);
            
            //Supprimer le fichier Log existant
//            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
//            ExecuteWinSCPCommand(vServerTitre, '"rm ' + vserverLogFilePath + logFile + '"');
            
            //Se loguer avec UNI00
            Login(vServerTitre, userNameUNI00, passwordUNI00, language);
            
            //Aller aux module Titres 
            Log.Message("Aller aux module Titres");         
            Get_ModulesBar_BtnSecurities().Click();
            Get_ModulesBar_BtnSecurities().WaitProperty("IsSelected",true, waitTime);
            
            //Ajouter les titres  
            Log.Message("Étapes 4:     Ajouter les titres ", "", pmNormal, attr);  
            AddIndexSecurity(descriptionIndex1, descriptionIndex1, countryCanada, currencyCAD, valueCUSIP111, valueCUSIP111);   
            AddIndexSecurity(descriptionIndex2, descriptionIndex2, countryCanada, currencyUSD, valueCUSIP222, valueCUSIP222);
            AddIndexSecurity(descriptionIndex3, descriptionIndex3, countryCanada, currencyCAD, valueCUSIP333, valueCUSIP333);
            
            //Exécuter la commande cfLoader  -IDCIndices REGRESSION_1.csv -Firm=FIRM_1
            Log.Message("Étape 7:       Exécuter la 1ere commande cfLoader ", "", pmNormal, attr);
            ExecuteSSHCommand("TCVE_1182", vServerTitre, "cfLoader  -IDCIndices "+ fileName1 +" -Firm=FIRM_1", "aminea");

            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            var logIsJsonFormat = false;
            if(IsLogFileJsonFormat() == 1){
              var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
              logFile = "cfLoader"+ todayDateString +".jsonl";
              logIsJsonFormat = true;
            }
            
            CopyFileFromVserverThroughWinSCP(vServerTitre, vserverLogFilePath + logFile, Titres_REPOSITORY_SSH);
            
            //Vérifier si le fichier Log contient les deux messages
            Log.Message("Étape 8:         Vérifier si le fichier Log contient les deux messages", "", pmNormal, attr);
            
            if(logIsJsonFormat){
              FindStringInFile(securityNotFountMessageJson,    logFile, Titres_REPOSITORY_SSH);
              FindStringInFile(securityNotFoundValueJson,      logFile, Titres_REPOSITORY_SSH);
              FindStringInFile(securityNotReceveidMessageJson, logFile, Titres_REPOSITORY_SSH);
              FindStringInFile(securityNotReceveidValueJson,   logFile, Titres_REPOSITORY_SSH);
            }
            else{
              FindStringInFile(securityNotFountMessage,    logFile, Titres_REPOSITORY_SSH);
              FindStringInFile(securityNotReceveidMessage, logFile, Titres_REPOSITORY_SSH);
            }

            //Valider les prix de vente
            Log.Message("Étapes 9, 10, 11, 12:   Valider les prix de vente la 1ere fois", "", pmNormal, attr);
            ValidateWinInfoPrices(descriptionIndex1, valeur0000, valeur0000, 1, currencyCAD,"", false);
            ValidateWinInfoPrices(descriptionIndex2, valeur0000, valeur0000, 1, currencyCAD,"", false);
            ValidateWinInfoPrices(descriptionIndex3, valeur0000, valeur0000, 0, currencyCAD,"", false);
            ValidateWinInfoPrices(descriptionNintendo, valeur0000, valeur0000, 1, currencyCAD,"", false);
            
            //Exécuter la commande cfLoader  -IDCIndices REGRESSION_2.csv -Firm=FIRM_1
            Log.Message("Étape 14:      Exécuter la 2ere commande cfLoader ", "", pmNormal, attr);
            ExecuteSSHCommand("TCVE_1182", vServerTitre, "cfLoader  -IDCIndices "+ fileName2 +" -Firm=FIRM_1", "aminea");

            //Valider les prix de vente
            Log.Message("Étape 15 16:      Valider les prix de vente la 2ere fois", "", pmNormal, attr);
            ValidateWinInfoPrices(descriptionIndex1, valeur0000, valeur0000, 2, currencyEUR,"", true);
            ValidateWinInfoPrices(descriptionIndex2, valeur0000, valeur0000, 3, currencyUSD, currencyCAD, true);
            
            //Supprimer les titres
            Log.Message("Supprimer les titres ajoutés", "", pmNormal, attr);
            DeleteSecurityByDescription(descriptionIndex1);
            DeleteSecurityByDescription(descriptionIndex2);
            DeleteSecurityByDescription(descriptionIndex3);
            
            //Supprimer le fichier Log
            aqFile.Delete(Titres_REPOSITORY_SSH + logFile);
                  
            }
    catch (e) {
            
            Log.Error("Exception: " + e.message, VarToStr(e.stack));                   
           }         
    finally {
            Terminate_CroesusProcess();       
            //Remise des pref par défaut
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_IDC_INDICES","" ,vServerTitre);
            Activate_Inactivate_PrefFirm("FIRM_1","PREF_EDIT_INDEXES","SYSADM",vServerTitre);
            RestartServices(vServerTitre);
    }         
}


function IsLogFileJsonFormat(){
          var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
          var logFileName     = "/var/log/finansoft/cfLoader"+ todayDateString +".jsonl";
          var sshCommandCount = "ls -l " + logFileName + " 2> /dev/null | wc -l";
//          Log.Message(logFileName)
          var matchedItemsCount = ExecuteSSHCommand(null, vServerTitre, sshCommandCount, null, null, false);
          var nbFileFound       = aqConvert.StrToInt(matchedItemsCount);
          return nbFileFound;
}

function ChangeDateInFile(filePath, fileName){  
                
          var sPath = filePath + fileName;
          var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d");
          
          Log.Message("Enlever le 'read-only' du fichier.")
          if ( aqFileSystem.CheckAttributes(sPath, aqFileSystem.faReadOnly) )
                  aqFileSystem.ChangeAttributes(sPath, aqFileSystem.faReadOnly, 1);

          // Opens the specified file for reading and writing
          var myFile = aqFile.OpenTextFile(sPath, aqFile.faReadWrite, aqFile.ctUTF8);

          myFile.SetPosition(0, 0);
          line = myFile.ReadLine();          
          myFile.SetPosition(0, aqString.FindLast(line,",") + 1);
          myFile.Write(todayDateString);// + "\r\n")
          
          myFile.SetPosition(2, 0);
          line = myFile.ReadLine();
          myFile.SetPosition(2, aqString.FindLast(line,",") + 1);
          myFile.Write(todayDateString)
         
          // Closes the file
          myFile.Close();
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

function ValidateWinInfoPrices(SecurityDescription, askBidePrice, closePrice, nbRowInPriceHistoryList, currency, currency2, afterSecondcfLoader){
            
            var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y");
            var BDDateString = "1/26/2010";
            var waitTime = 5000;
            
            //Chercher le titre et ouvrir la fenêtr Info
            Search_SecurityByDescription(SecurityDescription);
//            Delay(waitTime);
            WaitObject(Get_CroesusApp(),"Uid","DataGrid_8414", waitTime); 
            Get_SecurityGrid().Find("Value",SecurityDescription,10).Click();  
            Get_SecuritiesBar_BtnInfo().Click();
            WaitObject(Get_CroesusApp(),"Uid","InfoSecurityWindow_3448", waitTime);        
            
            if (SecurityDescription == descriptionNintendo){
                Get_WinInfoSecurity_TabPriceHistory().Click();
                Get_WinInfoSecurity_TabPriceHistory().WaitProperty("IsSelected",true, waitTime);
                var objectControl = Get_WinInfoSecurity_TabPriceHistory_Grid().WPFObject("RecordListControl", "", 1);
                aqObject.CheckProperty(objectControl.Items.Item(0).DataItem.HistoryDate, "OleValue", cmpNotEqual, BDDateString);
            }
            else{
                Get_WinInfoSecurity_TabInfo().Click();
                Get_WinInfoSecurity_TabInfo().WaitProperty("IsSelected",true, waitTime);
                aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtAsk().Text,   "OleValue", cmpEqual, askBidePrice);
                aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtBid().Text,   "OleValue", cmpEqual, askBidePrice);
                if(afterSecondcfLoader)
                    aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Text, "OleValue", cmpNotEqual, closePrice);
                else
                    aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_TxtClose().Text, "OleValue", cmpEqual, closePrice);
                aqObject.CheckProperty(Get_WinInfoSecurity_TabInfo_GrpPrice_CmbCurrency().Text, "OleValue", cmpEqual, currency);
                  
                Get_WinInfoSecurity_TabPriceHistory().Click();
                Get_WinInfoSecurity_TabPriceHistory().WaitProperty("IsSelected",true, waitTime);
                var nbLine = Get_WinInfoSecurity_TabPriceHistory_Grid().WPFObject("RecordListControl", "", 1).Items.Count;
                CheckEquals(nbLine, nbRowInPriceHistoryList, "la liste de l'historique des prix contient : ");
                if(afterSecondcfLoader){
                      var objectControl = Get_WinInfoSecurity_TabPriceHistory_Grid().WPFObject("RecordListControl", "", 1);
                      aqObject.CheckProperty(objectControl.Items.Item(0).DataItem.HistoryDate, "OleValue", cmpEqual, todayDateString); 
                      aqObject.CheckProperty(objectControl.Items.Item(0).DataItem.Currency, "OleValue", cmpEqual, currency);
                      if (nbRowInPriceHistoryList == 3)
                              aqObject.CheckProperty(objectControl.Items.Item(1).DataItem.Currency, "OleValue", cmpEqual, currency2);
                }                 
            }            
            Get_WinInfoSecurity().Close();
}



function AddIndexSecurity(frenchDescription, englishDescription, country, currency, cusip, mainSymbol){
  
      Get_Toolbar_BtnAdd().Click();
      WaitObject(Get_CroesusApp(),"Uid", "CreateSecurityWindow_3c43");
      Get_WinCreateSecurity_LstCategories_ItemIndex().Click();
      Get_WinCreateSecurity_BtnOK().Click();
      WaitObject(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
  
      Get_WinInfoSecurity_GrpDescription_TxtFrenchDescription().Keys(frenchDescription);
      Get_WinInfoSecurity_GrpDescription_TxtEnglishDescription().Keys(englishDescription);
      
      Get_WinInfoSecurity_GrpDescription_CmbCountry().Click();
      Get_SubMenus().Find("WPFControlText", country, 10).Click();
      
      Get_WinInfoSecurity_GrpDescription_CmbCurrency().Click();
      Get_SubMenus().Find("WPFControlText", currency,10).Click();

      Get_WinInfoSecurity_GrpDescription_TxtCUSIP().Click();
      Get_WinInfoSecurity_GrpDescription_TxtCUSIP().keys(cusip);

      Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol().Click();
      Get_WinInfoSecurity_GrpDescription_GrpMarket_TxtMainSymbol().keys(mainSymbol);
      
      Get_WinInfoSecurity_BtnOK().Click();
      if (Get_DlgConfirmation().Exists)
          Get_DlgConfirmation().Click(Get_DlgConfirmation().get_ActualWidth()/3, Get_DlgConfirmation().get_ActualHeight()-45);
      WaitUntilObjectDisappears(Get_CroesusApp(), "Uid", "InfoSecurityWindow_3448");
}