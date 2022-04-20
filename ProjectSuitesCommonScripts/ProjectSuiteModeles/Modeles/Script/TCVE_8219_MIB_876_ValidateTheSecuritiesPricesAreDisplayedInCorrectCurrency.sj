//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT PDFUtils
//USEUNIT DBA



/**
    Description : (MIB-876, MIB-3485) Valider que les prix des titres sont affichés dans la bonne devise aux étapes 4 et 5 du rééquilibrage
                   et dans le rapport des ordres PDF (pour les titres dont la devise du prix est différente de la devise du titre)
        
    https://jira.croesus.com/browse/TCVE-8219
    https://jira.croesus.com/browse/MIB-5336
    
    Analyste d'assurance qualité : Christine P
    Analyste d'automatisation : A.A
    
    Version de scriptage:	90.28-66
*/

function TCVE_8219_MIB_876_ValidateTheSecuritiesPricesAreDisplayedInCorrectCurrency()
{
    try {
            //Afficher le lien du cas de test
            Log.Link("https://jira.croesus.com/browse/TCVE-8219") 
            Log.Link("https://jira.croesus.com/browse/MIB-5336")     
                               
            var logEtape1, logEtape2, logEtape3, logEtape4, logEtape5, logEtape6, logEtape7, logEtape8, logEtape9, logEtape10; 
                  
            var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
            var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
                        
            var typePicker      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_typePickerSymbol", language+client);
            var account800251GT = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_Account800251GT", language+client);           
            var modelType       = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_ModelType", language+client);
            
            var security_BCE      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_security_BCE", language+client);
            var target_BCE        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_target_BCE", language+client);
            var Quantity_BCE      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_Quantity_BCE", language+client);
            var SecurityPrice_BCE = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_SecurityPrice_BCE", language+client);
            var MarketValue_BCE   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_MarketValue_BCE", language+client);
            
            var security_BIP      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_security_BIP", language+client);
            var target_BIP        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_target_BIP", language+client);
            var Quantity_BIP      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_Quantity_BIP", language+client);
            var SecurityPrice_BIP = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_SecurityPrice_BIP", language+client);
            var MarketValue_BIP   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_MarketValue_BIP", language+client);
            
            var security_DIS      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_security_DIS", language+client);
            var target_DIS        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_target_DIS", language+client);
            var Quantity_DIS      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_Quantity_DIS", language+client);
            var SecurityPrice_DIS = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_SecurityPrice_DIS", language+client);
            var MarketValue_DIS   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_MarketValue_DIS", language+client);
            
            var security_NT      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_security_NT", language+client);
            var target_NT        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_target_NT", language+client);
            var Quantity_NT      = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_Quantity_NT", language+client);
            var SecurityPrice_NT = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_SecurityPrice_NT", language+client);
            var MarketValue_NT   = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_MarketValue_NT", language+client);
            
            var GroupedGeneratedOrders = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_GroupedGeneratedOrders", language+client);
            var GeneratedOrders        = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_GeneratedOrders", language+client);
            var EnregistrementsGroupes = ReadDataFromExcelByRowIDColumnID(filePath_Modeles, "MIB_876", "TCVE_8219_GroupedRecords", language+client);
            
            var Model_MIB_876 = "#Model_MIB_876";      
            var Currency_USD = "USD";
            var Currency_CAD = "CAD";          
           
//Étape1    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 1: Mettre la pref: PREF_REPORT_ORDER_ENTRY= yes");  
            Activate_Inactivate_PrefFirm("Firm_1", "PREF_REPORT_ORDER_ENTRY", "YES", vServerModeles);    
//Étape2  
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 2: Se connecter à croesus avec Keynej et aller à modèles"); 
            //Se connecter à croesus avec Keynej
            Log.Message("Se connecter à croesus avec Keynej");
            Login(vServerModeles, userNameKEYNEJ, passwordKEYNEJ, language);
            
            //Accéder au module Modèle 
            Log.Message("Accéder au module Modèle");         
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);         
  
 //Étape3           
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 3: Créer le modèle de firme MIB_876 mailler dans portefeuille et ajouter les positions");      
            //Créer le modèle MIB_876
            Log.Message("Créer le modèle MIB_876"); 
            Create_Model(Model_MIB_876, modelType)
            
            
            //Maillerle Modèle MIB_876 dans Portefeuille
            Log.Message("Ajouter la position NBC100 au Modèle MIB_876"); 
            SearchModelByName(Model_MIB_876);
            Drag( Get_ModelsGrid().Find("Value",Model_MIB_876,10), Get_ModulesBar_BtnPortfolio());

            //Ajouter la  position BCE
            Log.Message("Ajout de la  position BCE")
            Get_Toolbar_BtnAdd().Click();
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_btnNo().Click();
            AddPositionToModel(security_BCE, target_BCE, typePicker,"");
            
            //Ajouter la  position BIP.UN
            Log.Message("Ajout de la  position BIP.UN")
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(security_BIP, target_BIP, typePicker,"");
            
            //Ajouter la  position DIS
            Log.Message("Ajout de la  position DIS")
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(security_DIS, target_DIS, typePicker,"");
            
            //Ajouter la  position NT
            Log.Message("Ajout de la  position NT")
            Get_Toolbar_BtnAdd().Click();
            AddPositionToModel(security_NT, target_NT, typePicker,"");
            
            //Sauvegarder le Modele
            Get_PortfolioBar_BtnSave().Click();
            Get_WinWhatIfSave_BtnOK().CLick();

//Étape4    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 4: Associer le compte 800251-GT au modèle #Model_MIB_876");                    
            //Retour au module Modèle 
            Get_ModulesBar_BtnModels().Click();
            Get_ModulesBar_BtnModels().WaitProperty("IsChecked", true, 30000);
            
            //Associer le compte 800251-GT au modèle MIB_876
            AssociateAccountWithModel(Model_MIB_876, account800251GT);
            
//Étape5    
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 5: Réequilibrer le modèle");                              
            //Réequilibrer le modèle
            Log.Message("Réequilibrer le modèle");
            //Sélectionner le modèle 
            Get_ModelsGrid().Find("Value", Model_MIB_876,10).Click();      
        
            //Rééquilibrer le modele jusqu'a étape4
            Log.Message("Rééquilibrer le modele jusqu'a l'étape4")       
            Get_Toolbar_BtnRebalance().Click();               
            var numberOftries=0;  
            while ( numberOftries < 5 && !Get_WinRebalance().Exists){//Dans le cas, si le click ne fonctionne pas 
              Get_Toolbar_BtnRebalance().Click();
            numberOftries++;}                                                  
            Get_WinRebalance().Parent.Maximize();

            //Etape 1 décocher valider les limites , répartir la liquidité, Appliquer les frais
            Get_WinRebalance_TabParameters_ChkValidateTargetRange().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkDistributeAccountLiquidity().set_IsChecked(false);
            Get_WinRebalance_TabParameters_ChkApplyAccountFees().set_IsChecked(false);
        
            Log.Message("--- Next jusqu'à l'étape 4 portefeuille projetés")
            Get_WinRebalance_BtnNext().Click();
            Get_WinRebalance_BtnNext().Click(); 
            Get_WinRebalance_BtnNext().Click(); 
            WaitObject(Get_WinRebalance(), ["Uid","VisibleOnScreen"], ["DataGrid_6f42",true])
            
//Étape6     
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 6: Valider les informations en mode Groupé des titres suivants :BCE, BIP.UN, DIS, NT"); 
                   
            var count = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.count;
        
            Log.Message(count)
            var j = 1;
            for(var i=0; i<count; i++){
              var object = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.item(i);
              Log.Message(object.DataItem.SecuritySymbol) 
              if(object.DataItem.SecuritySymbol == Trim(security_BCE)){
                validateValues(object, Quantity_BCE, SecurityPrice_BCE, Currency_CAD, MarketValue_BCE);
                if(j++ == 4) break;
              }
              else  
                if(object.DataItem.SecuritySymbol == Trim(security_BIP)){
                  validateValues(object, Quantity_BIP, SecurityPrice_BIP, Currency_USD, MarketValue_BIP);
                  if(j++ == 4) break;
                }
                else            
                if(object.DataItem.SecuritySymbol == Trim(security_DIS)){
                  validateValues(object, Quantity_DIS, SecurityPrice_DIS, Currency_USD, MarketValue_DIS);
                  if(j++ == 4) break;
                }
                else  
                  if(object.DataItem.SecuritySymbol == Trim(security_NT)){
                    validateValues(object, Quantity_NT, SecurityPrice_NT, Currency_CAD, MarketValue_NT)  
                    if(j++ == 4) break;
                  }
            }
             
//Étape7
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 7: Valider les informations en mode dégroupé des titres suivants :BCE, BIP.UN, DIS, NT"); 
            
            Get_WinRebalance_TabProjectedPortfolios_BarPadHeader_BtnBlock().Click();
            
            Get_WinRebalance_TabProjectedPortfolios_TabProposedOrdersBlockOff_ChType().Click();
            
            var j = 1;
            for(var i=0; i<count; i++){
              var object = Get_WinRebalance_TabProposedOrders_DgvProposedOrders().WPFObject("RecordListControl", "", 1).Items.item(i);
              Log.Message(object.DataItem.SecuritySymbol) 
              if(object.DataItem.SecuritySymbol == Trim(security_BCE)){
                validateValues(object, Quantity_BCE, SecurityPrice_BCE, Currency_CAD, MarketValue_BCE);
                if(j++ == 4) break;
              }
              else  
                if(object.DataItem.SecuritySymbol == Trim(security_BIP)){
                  validateValues(object, Quantity_BIP, SecurityPrice_BIP, Currency_USD, MarketValue_BIP);
                  if(j++ == 4) break;
                }
                else            
                if(object.DataItem.SecuritySymbol == Trim(security_DIS)){
                  validateValues(object, Quantity_DIS, SecurityPrice_DIS, Currency_USD, MarketValue_DIS);
                  if(j++ == 4) break;
                }
                else  
                  if(object.DataItem.SecuritySymbol == Trim(security_NT)){
                    validateValues(object, Quantity_NT, SecurityPrice_NT, Currency_CAD, MarketValue_NT)  
                    if(j++ == 4) break;
                  }
            }            

//Étape8
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 8:  sélectionner le mode Aperçu et cocher les 5 rapports"); 
            
            //Aller à l'étape 5
            Get_WinRebalance_BtnNext().Click();
            //Aller à l'étape suivante
            Get_WinRebalance_BtnGenerate().Click();
            WaitObject(Get_CroesusApp(), "Uid", "GenerateOrdersWindow_c7ad"); 
            
            Get_WinGenerateOrders_GrpMode_ChkPreview().set_IsChecked(true);
            Get_WinGenerateOrders_GrpPDF_ChkProjectedPortfolio().set_IsChecked(true);
            Get_WinGenerateOrders_GrpPDF_ChkOrdersReport().set_IsChecked(true);
            
            Get_WinGenerateOrders_GrpExcel_ChkGroupedOrders().set_IsChecked(true);
            Get_WinGenerateOrders_GrpExcel_ChkIndividualOrders().set_IsChecked(true);
//            Get_WinGenerateOrders_GrpExcel_ChkProjectedPortfolio().set_IsChecked(true);


//Étape9-10            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 9-10: Dans les rapports Excel, valider les informations des titres suivants :BCE, BIP.UN, DIS, NT"); 
            
            var arrayOfValueCheck  = ["1 686", "BCE", "27,610 CAD", "(46 550,46)", "5 479", "BIP.UN", "17,000 CAD", "(93 143,00)", "4 411", "DIS", "29,920 USD", "(131 977,12)", "4 631 343", "NT", "0,038 USD", "(175 991,03)"];
            var arrayOfValueCheck2 = ["1 686", "BCE", "27,610", "46 550,46", "5 479", "BIP.UN", "17,000", "93 143,00", "4 411", "DIS", "31,670", "139 697,78", "4 631 343", "NT", "0,040", "186 303,68"];

            
            var sysTempFolder        = Sys.OSInfo.TempDirectory;
            var ExcelFilesFolderPath = sysTempFolder + "\CroesusTemp\\";
            var PDFFilesFolderPath   = "C:\\CroesusWeb\\pdf\\";
            
            var ExcelReferencefilesFolderPath = folderPath_Data + client + "\\MIB_876\\ExpectedFolder\\";
            var ExcelResultFolderPath         = folderPath_Data + client + "\\MIB_876\\ResultFolder\\";
            var suffix = (language == "french")? "FR.txt" : "EN.txt";
            var GroupedGeneratedOrdersReportReferenceName = ExcelReferencefilesFolderPath + GroupedGeneratedOrders + suffix ;
         
            //Fermer Excel et Acrobat s'ils existent
            TerminateProcess("Acrobat")
            TerminateProcess("EXCEL");
            
            //Générer les rapports
            Get_WinGenerateOrders_BtnGenerate().Click();
            
            //Attendre Excel que Excel s'oouvre
            var nbTries = 0;            
            do {
                ProcessExecl = Sys.WaitProcess("EXCEL", "30000");        
            } while((++nbTries) <= 3 && !ProcessExecl.Exists)
            
            if (ProcessExecl.Exists){
              //Trouver les rapports générés
              var GroupedGeneratedOrdersReportFileName = FindLastModifiedFileInFolder(ExcelFilesFolderPath, GroupedGeneratedOrders);
              
              var GeneratedOrdersFileName = aqFileSystem.GetFileName(GeneratedOrdersReportFileName);
              
              //Valider les données dans le rapport OrdresGenereesyyyy-mm-dd-hhmmss.txt
              OrdresGenereesCheckData(aqString.Trim(security_DIS), Currency_USD, Currency_USD, "4 411", "29,920");//'4 411'
              OrdresGenereesCheckData(aqString.Trim(security_BCE), Currency_CAD, Currency_CAD, "1 686", "27,610");//'1 686'
              OrdresGenereesCheckData(aqString.Trim(security_NT),  Currency_CAD, Currency_USD, "4 631 343", "0,038");//'4 631 343'
              OrdresGenereesCheckData(aqString.Trim(security_BIP), Currency_USD, Currency_CAD, "5 479", "17,000"); //'5 479'
              
              //Comparer le rapport: OrdresGenereesGroupeesyyy-mm-dd-hhmmss.txt 
              var GroupedGeneratedOrdersFileName = aqFileSystem.GetFileName(GroupedGeneratedOrdersReportFileName);
              Log.Message("Comparer les rapports: "+ GroupedGeneratedOrdersReportFileName + " et " + GroupedGeneratedOrdersReportReferenceName);
              Log.Checkpoint(objectExcel.ExcelCompare(GroupedGeneratedOrdersReportFileName, GroupedGeneratedOrdersReportReferenceName, ExcelResultFolderPath + "ResultCompare_" + GroupedGeneratedOrdersFileName ));
            }
            else{
              Log.Error("Excel n'a pas démmaré")
            }
 
//Étape11-12         
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("Étape 11-12: Dans les rapports PDF, valider les informations des titres suivants :BCE, BIP.UN, DIS, NT"); 
            
            //Attendre AcrobatReader 
            var nbTries = 0;
            do {
                ProcessAcrobat = Sys.WaitProcess("Acrobat", 30000)        
            } while((++nbTries) <= 3 && !ProcessAcrobat.Exists)
            
            if (ProcessAcrobat.Exists){
              //Trouver les rapports générés
              var GeneratedOrdersReportFileName        = FindLastModifiedFileInFolder(ExcelFilesFolderPath, GeneratedOrders);
              var GroupedGeneratedOrdersReportFileName = FindLastModifiedFileInFolder(ExcelFilesFolderPath, GroupedGeneratedOrders);
              
              //Comparer les rapports générés
              var EnregistrementsGroupesReportFileName = FindLastModifiedFileInFolder(PDFFilesFolderPath, EnregistrementsGroupes);
            
              var reportFileName = aqFileSystem.GetFileName(EnregistrementsGroupesReportFileName);
              var Report2000xxxx = aqConvert.StrToInt((aqConvert.StrToInt(aqString.SubString(reportFileName, 23, aqString.Find(reportFileName, ".pdf") - 23)) + 1));           
              var Report2000xxxxFileName = FindLastModifiedFileInFolder(PDFFilesFolderPath, Report2000xxxx);
              
              //REchercher les valeurs dans les rapports générés
              CheckStringOccurenceInPdfFile(EnregistrementsGroupesReportFileName, null, arrayOfValueCheck);
              CheckStringOccurenceInPdfFile(Report2000xxxxFileName,               null, arrayOfValueCheck2);
            }
            else{
              Log.Error("Acrobat n'a pas démmaré")
            }
            
            Log.PopLogFolder();
            logEtape1 = Log.AppendFolder("----------------------------Clean-up------------------------");
            
            if(Get_WinRebalance().Exists){
              Get_WinRebalance_BtnClose().Click();
              Get_DlgConfirmation_BtnContinue().Click();
            }
            
            //Enlever le compte du modèl
            RemoveAccountFromModel(account800251GT, Model_MIB_876);
            //Supprimer le modèl
            DeleteModelByName(Model_MIB_876) ;
            
            //Fermer Croesus
            Close_Croesus_X(); 
            if(Get_DlgConfirmation().Exists)
                Get_DlgConfirmation_BtnYes().Click();
              
            //Fermer Excel et Acrobat s'ils existent
            TerminateProcess("Acrobat")
            TerminateProcess("EXCEL");
            
    }
    catch(e) {
    		    //S'il y a exception, en afficher le message
            Log.Error("Exception: " + e.message, VarToStr(e.stack));
		}
    finally {
  	        //Fermer le processus Croesus
            Terminate_CroesusProcess();
            //Remettre la pref à NO
            Activate_Inactivate_PrefFirm("Firm_1", "PREF_REPORT_ORDER_ENTRY", "NO", vServerModeles)               
    }
}

function OrdresGenereesCheckData(securitySymbol, securityCurrency, priceCurrency, quantity, price){

        var sTempFolder = Sys.OSInfo.TempDirectory;
        var ExportedFolder = sTempFolder+"\CroesusTemp\\";
        Log.Message(ExportedFolder);
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-");
        var ExportedFilePath = FindLastModifiedFileInFolder(ExportedFolder, "OrdresGenerees"+FileNameContains); 
        Log.Message(ExportedFilePath);

        var attr = Log.CreateNewAttributes();
        attr.Bold = true;
        // Opens the specified file for reading
        var myFile = aqFile.OpenTextFile(ExportedFilePath, aqFile.faRead, aqFile.ctANSI);
          
        myFile.SkipLine(1);
        // Reads text lines from the file
        while(! myFile.IsEndOfFile())
        {
           var readLine = myFile.ReadLine();             
           var arrayLine = readLine.split("\t");
           if(aqString.Unquote(arrayLine[12]) == securitySymbol){
              Log.Message("Symbole du Titre: "+aqString.Unquote(arrayLine[12]));
              CheckEquals(aqString.Unquote(arrayLine[6]),  quantity,"Quantité");
              CheckEquals(aqString.Unquote(arrayLine[7]),  price,"Prix");
              CheckEquals(aqString.Unquote(arrayLine[8]),  priceCurrency,"Devise du prix"); 
              CheckEquals(aqString.Unquote(arrayLine[14]), securityCurrency,"Devise du titre");
           } 
        }      
        // Closes the file
        myFile.Close();
}
function jsonPath(localDestinationFilePath){ 
  
   var myFile = aqFile.OpenTextFile(localDestinationFilePath+"JSONTCVE1410.txt", aqFile.faRead, aqFile.ctANSI);                 
   while(! myFile.IsEndOfFile()){    
        var oneLine = myFile.ReadLine();
        Log.Message(jsonPath)  
        return jsonPath    
   };        
}

function CheckStringOccurenceInPdfFile(PDFFilePath, startPageNumber, arrayOfString){
     Log.Message(PDFFilePath);
        var PdfFileContent = GetPdfTextThroughCommandLine(PDFFilePath, startPageNumber);
            Log.Message(PdfFileContent);  
        for(i=0; i<arrayOfString.length; i++ ){ 
            var Res = aqString.Contains(PdfFileContent, arrayOfString[i]); 
            if ( Res != -1 )
              Log.Checkpoint("Substring:  '" + arrayOfString[i] + "'  was found in report text file  at position " + Res)
            else
              Log.Error("There are no occurrences of   '" + arrayOfString[i] + "'  in report text file'")
        }
}

function validateValues(object, quantity, securityPrice, securityCurrency, marketValue){
  
            aqObject.CheckProperty(object.DataItem, "Quantity",             cmpEqual, quantity);
            aqObject.CheckProperty(object.DataItem, "SecurityPrice",        cmpEqual, securityPrice);
            aqObject.CheckProperty(object.DataItem, "SecurityCurrency",     cmpEqual, securityCurrency);
            aqObject.CheckProperty(object.DataItem.MarketValue, "OleValue", cmpEqual, marketValue);
}

function Get_WinGenerateOrders_GrpPDF_ChkOrdersReport(){return Get_WinGenerateOrders_GrpPDF().Find("Uid", "CheckBox_8ccb", 10)}