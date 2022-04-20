
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Portefeuille_Get_functions
//USEUNIT CR1037_C2MO9_Edit_Sleeve
//USEUNIT EnablePrefDataBase

/**
          Description : Valider l'assignation massive des comptes à des gabarits
          
          Lien de la story: https://jira.croesus.com/browse/TCVE-7517
          Lien du scénario: https://jira.croesus.com/browse/TCVE-6276

          Analyste d'assurance qualité : Karima Mo
          Analyste d'automatisation : A.A
          version: 2021.08-67
          Date: 24/09/2021
**/


//            var AccountDesignationList = "Nominé|Intermédiaire|Compte client";
//            var AccountList            = "800003-NA|800011-JW|800011-NA|800013-NA|800013-OB|800014-RE|800014-SF|800015-NA|800015-OB|800015-RE";
            
            var AccountDesignationList = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_AccountDesignationList", language+client);
            var AccountList            = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_AccountList", language+client);
            
            var ArrayOfAccountsNumber  = AccountList.split("|");
            var ArrayOfDesignation     = AccountDesignationList.split("|");


function CR2431_TCVE_7517_AutomateMassiveAssignmentOfTemplatesFor_BNC()
{
      try{   
         Log.Link("https://jira.croesus.com/browse/TCVE-6276", "Lien du récit");
         Log.Link("https://jira.croesus.com/browse/TCVE-7517", "Lien de la tâche dans jira");  
         
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");

            var Comptes_ColumnList         = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_ColumnList", language+client);
            var Comptes_ProfilList         = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_ProfilList", language+client);
            var Comptes_FullProfilList     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_FullProfilList", language+client);
            var category_SecurityFixIncome = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_SecurityFixIncome", language+client);
            
            var operator_containing = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_Operator_Containing", language+client);
            var field_AcountNo      = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_Field_AcountNo", language+client);
            var operator_equals     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_Operator_equals", language+client);
            var managementStart     = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_ManagementStart", language+client);
            var MoyenTerme          = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_MoyenTerme", language+client);
            
            var nbPosition  = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_nbPosition", language+client);
            var marketValue = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_marketValue", language+client);
            
            var date_2010_01_25 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_date_2010_01_25", language+client);
            var date_2007_03_10 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_date_2007_03_10", language+client);
            var date_2007_03_15 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7517_date_2007_03_15", language+client);
                           
            var CSV_FileName = "CR2431_test"; 
            var xmlFilesList = "bkv|pro|sec|tra"
            var arrayOfXmlFilesName  = xmlFilesList.split("|");                      
            var CR2431_FolderPath    = folderPath_ProjectSuiteCommonScripts + "\ProjectSuiteSleeves\\Sleeves\\CR2431\\";            
            var vserverFolder        = "/home/aminea/loader/CR2431/";            
            var vserverLogFolderPath = "/var/log/finansoft/";
            var logFileName          = "UMATemplateAssignation.log"; //version non grafana
            
//            var Comptes_ColumnList     = "Segments|Début de gestion"
//            var Comptes_FullProfilList = "Numéro du compte du courtier|Numéro du compte de l'intervenant|Compte conjoint|Désignation du compte";
//            var Comptes_ProfilList     = "Numéro du compte du|Numéro du compte de|Compte conjoint|Désignation du compt";
    
//            var nbPosition  = 8;
//            var marketValue = 195614.34;
    
            var model_ChAmericanEqui = "CH AMERICAN EQUI";
            var model_ChCanadianEqui = "CH CANADIAN EQUI"
            var security_AAPL = "AAPL";
            var security_DIS  = "DIS";
            var security_MSFT = "MSFT";
            var security_BMO  = "BMO";
            
            var quantity_AAPL = "725";
            var quantity_DIS  = "4926";
            var quantity_MSFT = "3351";
            var quantity_BMO  = "2963";
            var quantity_null = "5552";
            var account800241RE = "800241-RE";
            var account800241SF = "800241-SF";

            var attr = Log.CreateNewAttributes();
            attr.Bold = true;
            
            //************************************************************************* Étape 1******************************************************************/
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1:   Copier les fichiers .csv et les fichiers .xml dans le vserveur", "", pmNormal, attr);
 /*            
            //Étape 1: Copier les fichiers .csv dans le vserveur
            for(var i = 1; i<8; i++){
              Log.Message(CR2431_FolderPath + CSV_FileName + i + ".csv");
              CopyFileToVserverThroughWinSCP(vServerSleeves, vserverFolder, CR2431_FolderPath + CSV_FileName + i + ".csv");
            }
            
            //Copier le fichier  dans le vserveur
            CopyFileToVserverThroughWinSCP(vServerSleeves, vserverFolder, CR2431_FolderPath + CSV_FileName + "_UMA.csv");
            
            //Copier les fichiers .xml dans le vserveur
            for(var i = 0; i<arrayOfXmlFilesName.length; i++)
                CopyFileToVserverThroughWinSCP(vServerSleeves, vserverFolder, CR2431_FolderPath + arrayOfXmlFilesName[i] + "_0A26_UNI.xml");
  */          
            //*********************************************************************** Étape 2******************************************************************
         
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2:       Exécuter la commande cfLoader avec test1.csv", "", pmNormal, attr);
            //Supprimer le fichier Log existant
//            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
//            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
      
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test1.csv" -firm=FIRM_1 
            var i=1;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            Log.Message( cfLoaderCommand); 
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Detecter le format du fichier Log
            var formatLog = IsLogFileJsonFormat();
         
            //Copier le fichier Log du vserveur
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            Log.Message("Copier le fichier Log du vserveur");
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
         
          
            //************************************************************************* Étape 3******************************************************************
              
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Valider les messages dans le ficchier log", "", pmNormal, attr);
                
            //Vérifier si le fichier Log contient les messages
            Log.Message(CR2431_FolderPath +"   "+logFileName)
            FindStringInFile("Number of Updates : 10",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath);
            
            Log.Message("Se connecter avec KEYNEJ et aller aux Comptes", "", pmNormal, attr);
            //Se connecter avec KEYNEJ
            Login(vServerSleeves, userNameKEYNEJ, passwordKEYNEJ, language); 
         
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
           
            //************************************************************************* Étape 4******************************************************************
            
            //Ajouter les colonnes et profils dans le module Comptes:  
            Log.PopLogFolder();
            logEtape2 = Log.AppendFolder("Étape 4: Ajouter les colonnes dans le module Comptes ", "", pmNormal, attr);
            
            //Mettre la configuration par défaut
            Get_AccountsGrid_ChAccountNo().ClickR()
            Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
            
            Log.Message("Configurer les profils dans Comptes");
            AddProfil(Comptes_FullProfilList, 3, false);
            AddListOfColumns(Get_AccountsGrid_ChAccountNo(), Comptes_ColumnList);
            AddListOfProfils(Get_AccountsGrid_ChAccountNo(), Comptes_ProfilList);
        
            
            //Créer un filtre rapide avec Début de gestion = 2007/03/10
            CreateModifyQuickFilter("#DebutGestion", managementStart, operator_equals, date_2007_03_10, false, true)
           
            //Validation des valeurs dans les colonnes
            ColomnsValidation([2,1,0,2,2,1,1,0,0,0], 1);
              
            //Valider la date Début de gestion pour le compte 800011-JW
            if(language == "french")
              var toDayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y/%m/%d");
            else  
              var toDayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%Y");
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", ArrayOfAccountsNumber[1], 10).DblClick();
            WaitObject(Get_CroesusApp(),["ClrClassName", "WPFControlOrdinalNo"], ["UniDialog", "1"]);
            Get_WinDetailedInfo_TabDates().Click();
            Get_WinDetailedInfo_TabDates().WaitProperty("IsSelected", true, 15000);
            Log.Message(Get_WinDetailedInfo_TabDates_DtpUpdate().StringValue+"      "+ toDayDateString);
            aqObject.CheckProperty(Get_WinDetailedInfo_TabDates_DtpUpdate(), "StringValue", cmpEqual, toDayDateString);
            Get_WinDetailedInfo().Close();
            
            //************************************************************************* Étape 5******************************************************************
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 5: Maillage du compte '800003-NA' dans portefeuille", "", pmNormal, attr);
            CheckIfAccountHasSleeves(ArrayOfAccountsNumber[0], date_2010_01_25);
            
            //Valider les valeurs des sleeves
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
              Get_PortfolioBar_BtnSleeves().Click();
              numberOftries++;
            }  
            var count = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.count;
            Log.Message(count)
            for(i=0; i<count; i++){
              var object = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.item(i);
              Log.Message(object.DataItem.Description)
              if(object.DataItem.Description == "Sleeve1"){
                aqObject.CheckProperty(object.DataItem, "Ratio", cmpEqual, 50);
                aqObject.CheckProperty(object.DataItem, "LowerTolerance", cmpEqual, 49);
                aqObject.CheckProperty(object.DataItem, "UpperTolerance", cmpEqual, 51);
                aqObject.CheckProperty(object.DataItem, "ModelName", cmpEqual, model_ChAmericanEqui);
              }
              if(object.DataItem.Description == "Sleeve2"){
                aqObject.CheckProperty(object.DataItem, "Ratio", cmpEqual, 50);
                aqObject.CheckProperty(object.DataItem, "LowerTolerance", cmpEqual, 10);
                aqObject.CheckProperty(object.DataItem, "UpperTolerance", cmpEqual, 50);
                aqObject.CheckProperty(object.DataItem, "ModelName", cmpEqual, model_ChCanadianEqui);
              }
            }
          
      //************************************************************************* Étape 6******************************************************************
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 6: Déplacer des titres vers Sleeve1", "", pmNormal, attr);
   
            var count = Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).Items.count;
            for(i=0; i<count; i++){
              if(Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).items.item(i).DataItem.MainCategoryDescription == category_SecurityFixIncome)
                Get_WinManagerSleeves_GrpUnderlyingSecurities_DgvSecurities().WPFObject("RecordListControl", "", 1).items.item(i).IsSelected = true;
            }
  
            Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click(); 
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinMoveSecurities().Exists){
              Get_WinManagerSleeves_GrpUnderlyingSecurities_BtnMove().Click();
              numberOftries++;
            } 
  
            //Selectionner 'Sleeve1'
            SelectComboBoxItem(Get_WinMoveSecurities_CmbToSleeve(), "Sleeve1");
            Get_WinMoveSecurities_BtnOk().Click();
            Get_WinManagerSleeves_BtnSave().Click(); 
    
            //Valider que nombre de position = 8 et valeur marché = 195614.34
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            
            var count = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.count;
            for(i=0; i<count; i++){
              var object = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.item(i);
          //    Log.Message(object.DataItem.Description)
              if(object.DataItem.Description == "Sleeve1"){
                aqObject.CheckProperty(object.DataItem, "PositionsCount", cmpEqual, nbPosition);
                aqObject.CheckProperty(object.DataItem, "MarketValue", cmpEqual, marketValue); 
              }
            } 
            
      //************************************************************************* Étape 7 ******************************************************************
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 7: Supprimer les sleeves et valider qu'ils sont supprimés", "", pmNormal, attr);
            
            Get_WinManagerSleeves_GrpSleeveCreation_RdoManual().Click();
            Get_DlgConfirmation_BtnRemove().Click(); //Delete().Click();           
            Get_WinManagerSleeves_BtnSave().Click();
            
            Get_PortfolioBar_BtnSleeves().Click();
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
              Get_PortfolioBar_BtnSleeves().Click();
              numberOftries++;
            }
            aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate(), "IsChecked", cmpEqual, false);
            Get_WinManagerSleeves().Close();
           
      //************************************************************************* Étape 8  ******************************************************************
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 8: valider que Template1 est bien assigné à aux comptes: 800013-NA, 800014-RE, 800015-NA", "", pmNormal, attr);
            
            CheckIfAccountHasSleeves(ArrayOfAccountsNumber[3], date_2010_01_25); //800013-NA
            CheckIfAccountHasSleeves(ArrayOfAccountsNumber[5], date_2010_01_25); //800014-RE
            CheckIfAccountHasSleeves(ArrayOfAccountsNumber[7], date_2010_01_25); //800015-NA 
           
      //************************************************************************* Étape 9  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 9: Valider le rééquilibrage d'un compte UMA: 800013-NA", "", pmNormal, attr);   
            //Ouvrir le module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000); 
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", ArrayOfAccountsNumber[3], 10).Click();
            
            //Rééquilibrer le compte 
            Get_Toolbar_BtnRebalance().Click();
            //Dans le cas, si le click ne fonctionne pas         
            if(!Get_WinRebalancingMethod().Exists){
               Get_Toolbar_BtnRebalance().Click();
            }
            Get_WinRebalancingMethod_GrpParameters_RdoRebalanceAccount().set_IsChecked(true)
            Get_WinRebalancingMethod_BtnOK().Click();
        
            Get_WinRebalance().Parent.Maximize();        
            // avancer à l'étape suivante par la flèche en-bas à droite pour afficher l'écran 'Portefeuilles à rééquilibrer'.
            Get_WinRebalance_BtnNext().Click();       
            // avancer à l'étape suivante la flèche en-bas à droite pour afficher l'écran 'portefeuille projeté'
            Get_WinRebalance_BtnNext().Click();   
            WaitObject(Get_CroesusApp(), "Uid", "DataGrid_6f42", 90000); 

            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value","sleeve1",10).Click();

            var count = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.count;
            for(i=0; i<count; i++){
              var object = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i);
//              Log.Message(object.DataItem.DisplayQuantityStr);
              switch(object.DataItem.SecuritySymbol.OleValue){
    						case security_AAPL : aqObject.CheckProperty(object.DataItem, "Quantity", cmpEqual, quantity_AAPL); break; 
                case security_DIS  : aqObject.CheckProperty(object.DataItem, "Quantity", cmpEqual, quantity_DIS);  break;
                case security_MSFT : aqObject.CheckProperty(object.DataItem, "Quantity", cmpEqual, quantity_MSFT); break;
					   }
            }
            
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true)
            Get_WinRebalance_TabProjectedPortfolios_PnlBrowser_DgvNavigator().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Find("Value","sleeve2",10).Click();

            var count = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.count;
            for(i=0; i<count; i++){
              var object = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.Item(i);
//              Log.Message(object.DataItem.DisplayQuantityStr);
              switch(object.DataItem.SecuritySymbol.OleValue){
    						case security_BMO: aqObject.CheckProperty(object.DataItem, "Quantity", cmpEqual, quantity_BMO);  break; 
                case ""          : aqObject.CheckProperty(object.DataItem, "Quantity", cmpEqual, quantity_null); break;
					   }
            }
            
            //Fermer la fenêtre de rééquilibrage
            Get_WinRebalance_BtnClose().Click();  
            Get_DlgConfirmation_BtnContinue().Click();  
            
       //************************************************************************* Étape 10  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 10: Valider l'assignation de Template2 aux comptes auquels on a déjà assigné Template1:", "", pmNormal, attr);        
             
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test2.csv" -firm=FIRM_1 
            Log.Message("Étape 10:       Exécuter la commande cfLoader avec test2.csv", "", pmNormal, attr);
            var i=2;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            Log.Message("Copier le fichier Log du vserveur");
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            FindStringInFile("Number of Updates : 10",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath); 
            
      //************************************************************************* Étape 11  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 11: Valider le contenu des colonnes Début de gestion et les colonnes profils", "", pmNormal, attr);  
            
            //Modifier le filtre rapide avec Début de gestion = 2007/03/15 
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            CreateModifyQuickFilter("#DebutGestion", "", "", date_2007_03_15, true, true);
            
            //Validation des valeurs dans les colonnes
            ColomnsValidation([2,2,1,1,1,0,0,0,0,1], 2);
            
       //************************************************************************* Étape 12  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 12: Mailler un compte UMA dans Portefeuille (ex: 800011-JW) et Valider les informations", "", pmNormal, attr);  
            
            //Mailler le compte 800011-NA dans Portefeuille
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", ArrayOfAccountsNumber[1], 10).Click();
            Get_RelationshipsClientsAccountsGrid().keys("^!6");
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
            
            //Valider les valeurs des sleeves
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
              Get_PortfolioBar_BtnSleeves().Click();
              numberOftries++;
            }  
            var count = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.count;
            Log.Message(count)
            for(i=0; i<count; i++){
              var object = Get_WinManagerSleeves_GrpSleeves_DgvSleeves().WPFObject("RecordListControl", "", 1).items.item(i);
              Log.Message(object.DataItem.Description)
              if(object.DataItem.Description == "Sleeve1"){
                aqObject.CheckProperty(object.DataItem.AssetClasses.Item(2).LongDescription,"OleValue", cmpEqual, MoyenTerme);
                aqObject.CheckProperty(object.DataItem, "Ratio", cmpEqual, 100);
                aqObject.CheckProperty(object.DataItem, "LowerTolerance", cmpEqual, 100);
                aqObject.CheckProperty(object.DataItem, "UpperTolerance", cmpEqual, 100);
                aqObject.CheckProperty(object.DataItem, "ModelName", cmpEqual, model_ChAmericanEqui);
              }
            }
            Get_WinManagerSleeves().Close();
            
        //************************************************************************* Étape 13  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 13: Valider les messages log et l'assignation dans plusieurs cas d'exception", "", pmNormal, attr);                 
            
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test3.csv" -firm=FIRM_1 
            Log.Message("Étape 13:       Exécuter la commande cfLoader avec test3.csv", "", pmNormal, attr);
            var i=3;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            FindStringInFile("Number of Updates : 0",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 2", logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Errors : 2",    logFileName, CR2431_FolderPath); 
            
        //************************************************************************* Étape 14  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 14: Valider les messages log et l'assignation dans plusieurs cas d'exception", "", pmNormal, attr);  
             
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
                                   
            //Modifier le filtre rapide avec no compte contenant 800241
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            CreateModifyQuickFilter("#DebutGestion", field_AcountNo, operator_containing, "800241", true, false);
           
           var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.count;
//            Log.Message("count : "+count)
            for(var i=0; i<count; i++){
              accountNB = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber;
              Log.Message("Account : "+accountNB)
              switch (accountNB.OleValue){
                case account800241RE:
                  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "HasSleeve", cmpEqual, false);
                  IsNullObject(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(0), 0);
                  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(1).ValueForDisplay, "OleValue", cmpEqual, "PAC350@Test");
                  IsNullObject(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(2), 2);
                  IsNullObject(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(3), 3);
                  break;
              
                case account800241SF:
                  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "HasSleeve", cmpEqual, false);
                  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(0), "ValueForDisplay", cmpEqual, "AAGUC3&Test");
                  IsNullObject(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(1), 1);
                  aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(2), "ValueForDisplay", cmpEqual, "UMA-G&Test" );
                  IsNullObject(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(3), 3);
                  break;
              } 
           }              
            
        //************************************************************************* Étape 15  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 15: Valider que la date de mis à jour pour le comptes : 800241-RE est la date du jour", "", pmNormal, attr); 
            
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            Search_Account(account800241RE);
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", account800241RE,10).DblClick();
            Get_WinDetailedInfo_TabDates().Click();
            Log.Message(Get_WinDetailedInfo_TabDates_DtpUpdate().StringValue+"      "+ toDayDateString);
            aqObject.CheckProperty(Get_WinDetailedInfo_TabDates_DtpUpdate(), "StringValue", cmpEqual, toDayDateString);
            Get_WinDetailedInfo().Close();
        
        //************************************************************************* Étape 16  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 16: Valider l'assignation de template lorsque un header est manquant", "", pmNormal, attr); 

            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test4.csv" -firm=FIRM_1 
            Log.Message("Étape 16:       Exécuter la commande cfLoader avec test4.csv", "", pmNormal, attr);
            var i=4;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            FindStringInFile("FATAL",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Updates : 0",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath); 
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath); 
            
        //************************************************************************* Étape 17  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 17: Valider l'assignation lorsqu'un header est mal nommé", "", pmNormal, attr); 
            
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test5.csv" -firm=FIRM_1 
            Log.Message("Étape 17:       Exécuter la commande cfLoader avec test5.csv", "", pmNormal, attr);
            var i=5;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            FindStringInFile("FATAL",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Updates : 0",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath); 
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath); 
            

        //************************************************************************* Étape 18  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 18: Valider l'assignation lorsque le nombre de champ header est différents du nombre dans les lignes du fichier", "", pmNormal, attr); 
            
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test6.csv" -firm=FIRM_1 
            Log.Message("Étape 18:       Exécuter la commande cfLoader avec test6.csv", "", pmNormal, attr);
            var i=6;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            if (formatLog == 1)
                FindStringInFile("\"The column {columnName} does not exist. Please make sure that the column exist.\",\"Properties\":{\"columnName\":\"MIDDLEMANACCOUNTNUMBERababab\"",    logFileName, CR2431_FolderPath); //version grafana
            else
                FindStringInFile("The column MIDDLEMANACCOUNTNUMBERababab does not exist",    logFileName, CR2431_FolderPath); //version non grafana
            
            FindStringInFile("PAC350Test does not have matching profile header. This profile was skipped. - Line number: 2", logFileName, CR2431_FolderPath);
            FindStringInFile("PAC350Test does not have matching profile header. This profile was skipped. - Line number: 3", logFileName, CR2431_FolderPath);
            FindStringInFile("PAC350Test does not have matching profile header. This profile was skipped. - Line number: 4", logFileName, CR2431_FolderPath);
            FindStringInFile("Unable to assign the template Template1 for the account 800038-NA - Line number: 4",   logFileName, CR2431_FolderPath); 

            FindStringInFile("The value for Profile 950 was empty. - Line number: 4",    logFileName, CR2431_FolderPath);         
            FindStringInFile("Number of Updates : 0",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 3", logFileName, CR2431_FolderPath); 
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath);  
            
        //************************************************************************* Étape 19  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 19: Valider l'assignation de template lorsque le fichier est vide", "", pmNormal, attr); 
            
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test7.csv" -firm=FIRM_1 
            Log.Message("Étape 19:       Exécuter la commande cfLoader avec test7.csv", "", pmNormal, attr);
            var i=7;           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='" + CSV_FileName + i + ".csv ' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);

            FindStringInFile("Number of Updates : 0",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath); 
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath);  
            
        //************************************************************************* Étape 20  ******************************************************************
      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 20: Valider l'assignation lorsque le fichier n'est pas renseigné dans la commande du plugin", "", pmNormal, attr); 
            
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="test8.csv" -firm=FIRM_1 
            Log.Message("Étape 20:       Exécuter la commande cfLoader sans fichier .csv", "", pmNormal, attr);           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");          
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("      Vérifier si le fichier Log contient les messages", "", pmNormal, attr);
            
            FindStringInFile("Starting UMATemplateAssignation plugin",    logFileName, CR2431_FolderPath);
            
      
      //******************************************************************************************************************************************************
      /*            Automatiser l'assignation massive des gabarits lorsque le le loader est avancé d'une journée  
      
        Lien de la story: https://jira.croesus.com/browse/TCVE-7861
        Lien du scénario: https://jira.croesus.com/browse/TCVE-7608
        
        Analyste d'assurance qualité : Karima Mo
        Analyste d'automatisation : A.A
        version: 2021.08-67
        Date:    03/11/2021
        
      */
      //*******************************************************************************************************************************************************
             
            var SQLFile_AdvanceLoader = "ConfigurationAvancerLoader.sql";
            var TCVE_7861_AccountList = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7861_AccountList", language+client);
//            var TCVE_7861_AccountList = "800017-FS|800011-LV|800217-SF|800228-FS|800290-NA";
            var date_2010_01_26 = ReadDataFromExcelByRowIDColumnID(filePath_Sleeves, "CR2431", "TCVE_7861_date_2010_01_26", language+client);
            var ArrayOfAccounts = TCVE_7861_AccountList.split("|");
            var security_ChMoyenTerme = "CH MOYEN TERME";
            var security_ChLongTerm   = "CH LONG TERM";
            
        //************************************************************************* Étape 2  ******************************************************************
                      
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("TCVE-7608: Étape 2: Ajouter un compte sleeve manuellement", "", pmNormal, attr); 
            
            //Ajouter un compte sleeve manuellement 800017-SF
            Log.Message("Étape 2:      Ajouter un compte sleeve manuellement", "", pmNormal, attr);
              
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Mailler le compte 800017-SF dans Portefeuille
            Search_Account(ArrayOfAccounts[0]);  
                       
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", ArrayOfAccounts[0], 10).Click();
            Get_RelationshipsClientsAccountsGrid().keys("^!6");
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
            
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            
            Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
            AddEditSleeveWinSleevesManager("sleeve1", "", 50, 49, 51, security_ChMoyenTerme);
           
            Get_WinManagerSleeves_GrpSleeves_BtnAdd().Click();
            AddEditSleeveWinSleevesManager("sleeve2", "", 50, 40, 50, security_ChLongTerm);
            
            Get_WinManagerSleeves_BtnSave().Click();
            
        //************************************************************************* Étape 3  ******************************************************************
                  
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("TCVE-7608: Étape 3-5: Avancer le loader à la date du 26.01.2010", "", pmNormal, attr); 
            
            //Avancer le loader à la date 26.01.2010
            Log.Message("Étape 3:      Avancer le loader à la date du 26.01.2010", "", pmNormal, attr);  
             
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_CLIENT_GROUPING", "NO", vServerSleeves);
            Activate_Inactivate_PrefFirm("FIRM_1", "PREF_ENABLE_ALLOC_FUNDS",     "NO", vServerSleeves);
     
            //Rouler le fichier SQL: ConfigurationAvancerLoader.sql
            ExecuteSQLFile(CR2431_FolderPath+SQLFile_AdvanceLoader, vServerSleeves)
                  
            //Lancer la commande: loader -FULL=1 -SECURITY_ONLY -LOG2STDOUT
            var cfLoaderCommand = "loader -FULL=1 -SECURITY_ONLY -LOG2STDOUT";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");
      
            //Supprimer le fichier Log existant
            Log.Message("Supprimer le fichier Log existant", "", pmNormal, attr);
            ExecuteWinSCPCommand(vServerSleeves, '"rm ' + vserverLogFolderPath + logFileName + '"');
                        
            //Exécuter la commande cfLoader -UMATemplateAssignation -FileName="CR2431_Test_UMA.csv" -firm=FIRM_1 
            Log.Message("Étape 5:       Exécuter la commande cfLoader avec le fichier CR2431_Test_UMA.csv", "", pmNormal, attr);           
            var cfLoaderCommand = "cfLoader -UMATemplateAssignation --FileName='"+  CSV_FileName + "_UMA.csv' -firm=FIRM_1";
            ExecuteSSHCommand("CR2431", vServerSleeves, cfLoaderCommand, "aminea");
            
        //************************************************************************* Étape 6  ******************************************************************
                    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("TCVE-7608: Étape 6: Valider les messages dans le fichier Log", "", pmNormal, attr); 
            
            //Copier le fichier Log du vserveur
            Log.Message("Copier le fichier Log du vserveur");
            if (formatLog == 1){
                var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
                var logFileName     = "cfLoader"+ todayDateString +".jsonl";
            }
            CopyFileFromVserverThroughWinSCP(vServerSleeves, vserverLogFolderPath + logFileName, CR2431_FolderPath);
          
            //Vérifier si le fichier Log contient les messages
            Log.Message("     Valider les messages dans le fichier Log ", "", pmNormal, attr);

            FindStringInFile("Number of Updates : 4",    logFileName, CR2431_FolderPath);
            FindStringInFile("Number of Partial Updates : 0", logFileName, CR2431_FolderPath); 
            FindStringInFile("Number of Errors : 0",    logFileName, CR2431_FolderPath); 
            
        //************************************************************************* Étape 7  ******************************************************************
        
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("TCVE-7608: Étape 7: Valider les données des comptes: ", "", pmNormal, attr); 
            
            //Aller au module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            
            //Modifier le filtre pour date début de gestion 2007/03/10        
            CreateModifyQuickFilter("#DebutGestion", managementStart, operator_equals, date_2007_03_10, true, true);

            var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.count;
            for(var i=0; i<count; i++)
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "HasSleeve", cmpEqual, true);
            
            for(var j=1; j<ArrayOfAccounts.length; j++)
              CheckIfAccountHasSleeves(ArrayOfAccounts[j], date_2010_01_26);
   
			Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("----------------------CLEAN UP-----------------", "", pmNormal, attr);				   
														
            //Supprimer le fitre
            //Aller au module Comptes
			Log.Message("Supprimer le filtre et fermer Croesus")													
            Get_ModulesBar_BtnAccounts().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000);
            Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
            Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
            Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild("Text", "#DebutGestion", 10).Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnDelete().Click();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnDelete().Click();
            Get_WinQuickFiltersManagerForRelationshipsClientsAccounts().Close();   
            
            //Fermer Croesus
            Close_Croesus_MenuBar();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();      
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
      }
}


function IsLogFileJsonFormat(){
    var todayDateString = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d"); 
    var logFileName     = "/var/log/finansoft/cfLoader"+ todayDateString +".jsonl";
    var sshCommandCount = "ls -l " + logFileName + " 2> /dev/null | wc -l";
    var matchedItemsCount = ExecuteSSHCommand(null, vServerSleeves, sshCommandCount, null, null, false);
    var nbFileFound       = aqConvert.StrToInt(matchedItemsCount);
    return nbFileFound;
}


function Get_DlgConfirmation_BtnRemove(){
  if (language == "french"){
      return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Supprimer" ], 10)}
  else{
      return Get_DlgConfirmation().FindChild(["ClrClassName", "WPFControlText"], ["Button","Remove" ], 10)}
}


function IsNullObject(object, i){
            var colomnName = "";
              switch (i){
                case 0:
                  colomnName = "Numéro du compte du"; break;
                case 1:
                  colomnName = "Numéro du compte de"; break;
                case 2:
                  colomnName = "Compte conjoint"; break;
                case 3:
                  colomnName = "Désignation du compte"; break;
                  }
              if(object == null)
                Log.Checkpoint("Le champ '"+ colomnName +"' est vide")
              else 
                Log.Error("Le champ '"+ colomnName +"' n'est pas vide")
}

 function ColomnsValidation(ArrayOfValues, k){
            
            //Validation des valeurs dans les colonnes
            var count = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.count;
//            Log.Message("count : "+count)
            for(var i=0; i<count; i++){
              var AccountNum = Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.AccountNumber;
              Log.Message("Account : " + AccountNum)
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem, "HasSleeve", cmpEqual, true);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(0), "ValueForDisplay", cmpEqual, "AAGUC3Test" + k);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(1), "ValueForDisplay", cmpEqual, "PAC350Test" + k);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(2), "ValueForDisplay", cmpEqual, "UMA-GTest"  + k);
        
              var j = IndiceInArrayOfaccounts(AccountNum);
              aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(i).DataItem.Profiles.Item(3), "ValueForDisplay", cmpEqual, ArrayOfDesignation[ArrayOfValues[j]]);
           } 
}

function IndiceInArrayOfaccounts(accountNumber){
  
      for(i=0; i<ArrayOfAccountsNumber.length; i++)
        if(ArrayOfAccountsNumber[i] == accountNumber)
          return i;   
}


function CheckIfAccountHasSleeves(nbAccount, loaderDate){
  
            //Ouvrir le module Comptes
            Get_ModulesBar_BtnAccounts().Click();
            WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 5000); 
            Get_ModulesBar_BtnAccounts().WaitProperty("IsChecked.OleValue", true, 100000);
            
            //Mailler le compte dans Portefeuille
            Log.Message(nbAccount)
            Get_RelationshipsClientsAccountsGrid().FindChild("Text", nbAccount, 10).Click();
            Get_RelationshipsClientsAccountsGrid().keys("^!6");
            Get_ModulesBar_BtnPortfolio().WaitProperty("IsChecked", true, 15000); 
            
            //Valider la date du Loader
            aqObject.CheckProperty(Get_PortfolioGrid_BarToolBarTray_dtpDate(), "StringValue", cmpEqual, loaderDate);
            
            //Cliquer sur le bouton segment
            Get_PortfolioBar_BtnSleeves().Click();
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinManagerSleeves().Exists){
              Get_PortfolioBar_BtnSleeves().Click();
              numberOftries++;
            }  
            //Valider que  
            aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeveCreation_RdoUsingAtemplate(), "IsChecked", cmpEqual, true);
            aqObject.CheckProperty(Get_WinManagerSleeves_GrpSleeveCreation_TxtUsingAtemplate(), "Text", cmpEqual, "Template1");
        
            Get_WinManagerSleeves().Close();
}


function Get_WinDetailedInfo_TabDates(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "WPFControlText"], ["TabItem", "Dates"], 10)}
function Get_WinDetailedInfo_TabDates_DtpUpdate(){return Get_WinDetailedInfo().FindChild(["ClrClassName", "ClrFullClassName"], ["DateField", "Croesus.ClientFoundations.CustomWidgets.DateControls.DateField"], 10)}

function CreateModifyQuickFilter(filterName, field, operator, value, modifyFilter, isFieldDate){
        
        Get_Toolbar_BtnQuickFiltersForRelationshipsClientsAndAccounts().Click();
        if(modifyFilter){
          Get_Toolbar_BtnQuickFilters_ContextMenu_ManageFilters().Click();
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_DgvFilters().FindChild("Text", filterName, 10).Click();
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnEdit().Click();
        }
        else{
          Get_Toolbar_BtnQuickFilters_ContextMenu_AddFilter().Click();
        
          Get_WinCRUFilter_GrpDefinition_TxtName().Click();
          Get_WinCRUFilter_GrpDefinition_TxtName().Keys(filterName);

          Get_WinCRUFilter_GrpCondition_CmbField().Click(); 
        
          SetAutoTimeOut();
          if (Get_SubMenus().Exists){
              Get_SubMenus().Find("WPFControlText",field,10).Click();
          }
          RestoreAutoTimeOut();
    
          Get_WinCRUFilter_GrpCondition_CmbOperator().Click(); 
          SetAutoTimeOut();
          if (Get_SubMenus().Exists){
            Get_SubMenus().Find("WPFControlText",operator,10).Click();
          }
          RestoreAutoTimeOut();
        }
        
        if(field != "" && field != null)
          SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbField(), field);
          
        if(operator != "" && operator != null)
          SelectComboBoxItem(Get_WinCRUFilter_GrpCondition_CmbOperator() , operator);
          
        if(isFieldDate){ 
          Get_WinCRUFilter_GrpCondition_DtpValue().Click();
          Get_WinCRUFilter_GrpCondition_DtpValue().keys("^a[BS][BS][BS][BS][BS][BS][BS][BS]")
          Get_WinCRUFilter_GrpCondition_DtpValue().keys(value);             
        }
        else{
          Get_WinCRUFilter_GrpCondition_TxtValue().Click();
          Get_WinCRUFilter_GrpCondition_TxtValue().keys(value);
        }
        Get_WinCRUFilter_BtnOK().Click();
        
        if(modifyFilter)
          Get_WinQuickFiltersManagerForRelationshipsClientsAccounts_BtnApply().Click();
}

function AddProfil(profilsList, i, isSecurities){
    
        var itemProfiles = "Profiles";
        if (language == "french") itemProfiles = "Profils";
        var arrayOfProfils = profilsList.split("|");

        //Ouvrir la fenêtre Info/Profil
        if(isSecurities){
            Get_SecuritiesBar_BtnInfo().Click();
            Get_WinInfoSecurity_TabProfiles().Click();
            WaitObject(Get_WinInfoSecurity(), "Uid", "Button_06f8", 3000);
        }else {
            Get_RelationshipsClientsAccountsBar_BtnSplitDropDown(i).Click();
            Get_SubMenus_Item(itemProfiles).Click();
            WaitObject(Get_WinDetailedInfo(), "Uid", "Button_06f8", 3000);
        }
             
        Get_WinInfo_TabProfile_BtnSetup().Click();
        
        for (j in arrayOfProfils){
            var profilEmpl = Get_WinVisibleProfilesConfiguration_ChkProfile(arrayOfProfils[j]);
            Log.Message(arrayOfProfils[j] + " état est : " + profilEmpl.get_IsChecked())
            if(profilEmpl.get_IsChecked() == false){                
                profilEmpl.Click();
//                Get_WinVisibleProfilesConfiguration().Find("Value",revenuBrut,10).WaitProperty("IsChecked", true, 10000);
            }
        }
        Get_WinVisibleProfilesConfiguration_BtnSave().Click();
        if(isSecurities)
            Get_WinInfoSecurity_BtnOK().Click();
        else
            Get_WinDetailedInfo_BtnOK().Click();
}

function AddListOfColumns(columnClickR, listOfColumns){
    
        var arrayOfColunms = listOfColumns.split("|");
        for (j in arrayOfColunms){
            Add_ColumnByLabel(columnClickR, arrayOfColunms[j])
        }
}

function AddListOfProfils(columnClickR, listOfProfils){
    
        var arrayOfProfils = listOfProfils.split("|");
        
        for (j in arrayOfProfils){   
            columnClickR.ClickR();
            columnClickR.ClickR();
            Get_GridHeader_ContextualMenu_AddColumn().OpenMenu();
            Get_GridHeader_ContextualMenu_AddColumn_Profiles().Click();
            Delay(1000)
            Aliases.CroesusApp.WPFObject("HwndSource: PopupRoot", "", 1).WPFObject("PopupRoot", "", 1).Find(["ClrClassName", "WPFControlText"], ["TextBlock", arrayOfProfils[j]], 10).Click();
        }        
}

function FindStringInFile(messageToFind, fileName, filePath){
  
          var sPath = filePath + fileName;
          
          var attr = Log.CreateNewAttributes();
          attr.Bold = true;
          
          // Read the whole file
          fileContent = aqFileSystem.GetFileInfo(sPath).ReadWholeTextFile(aqFile.ctUTF8);

          if(aqString.Contains(fileContent, messageToFind, 0, false)>-1)
              Log.Checkpoint("Le message -- '"+ messageToFind +"' -- existe dans le fichier log", "", pmNormal, attr);
          else
            Log.Error("Le fichier Log ne contient pas le message :" + messageToFind, "", pmNormal, attr);   
}

function Get_RelationshipsClientsAccountsBar_BtnSplitDropDown(i){       //Relations:1;  Clients:2;  Comptes:3
    return Get_RelationshipsClientsAccountsBar().WPFObject("SplitDropDownButton", "_Info", i).WPFObject("PART_Menu")}
    
function Get_SubMenus_Item(itemName){
    return Get_SubMenus().FindChild(["ClrClassName", "WPFControlText"], ["MenuItem", itemName], 10)}