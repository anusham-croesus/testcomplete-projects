//USEUNIT Common_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA

/**
    Description : Extract des Taux suivi du 1er et 2e fichier phase pour PTF et NAVex
                    Étapes 11 -14
     
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5755
    Analyste d'assurance qualité : mamoudoud
    Analyste d'automatisation : Emna IHM
    
    Version de scriptage:	Er-1
*/

function CR1872_5755_ExtractOfRates_followedBy1stand2ndPhasefile_forPTFandNAVex()
{
    try {       
    
         //Afficher le lien de cas de test
         Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-5755","Cas de test TestLink : Croes-5755")
         
         var user = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers,"USER", "KEYNEJ", "username");
         var psw = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
         var ELUXY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "ELUXY", language+client);
         var AIGDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "AIGDotUN", language+client);
         var CFRUY = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "CFRUY", language+client);
         var CBKDotUN = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "CBKDotUN", language+client);
         var statusExecuted = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "StatusExecuted", language+client);
         var statusPartialFill = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "StatusPartialFill", language+client);
         var statusOpen = ReadDataFromExcelByRowIDColumnID(filePath_Orders, "CR1872", "OpenStatus", language+client);
         //Format date
         if (language == "french")
            var dateFormat = "%Y/%m/%d";
         else
            var dateFormat = "%m/%d/%Y";
         
         
         var CRFolder = "CR1872"
         var vserverCommand = vServerOrders;
         var username = "emnai";
         var sshCommand1 = "cfLoader -GdoFxReportExtract -FIRM=FIRM_1";
         var sshCommand2 = "cfLoader -PhaseOneGenerator -FIRM=FIRM_1";
         var sshCommand3 = "cfLoader -PhaseOneGenerator --PTF_TRADING_ONLY -FIRM=FIRM_1";
     
	       var refFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\CR1872\\";
         var ResultlocalFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\CR1872\\";  
	       //Delete all existant old files in ResultFolder
         aqFile.Delete(ResultlocalFolder+"\*")
         
		     var refFile = "WM_CROES_ref_01.csv";
         var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d") 
         var generatedFileName = "WM_CROES_"+date+"_01.csv";
         var resultServerFilePath = "/home/emnai/loader/CR1872/"+generatedFileName;
         var resultLocalFilePath = ResultlocalFolder + generatedFileName;
		     
         Log.AppendFolder("**Execute SSH Command 1 = "+sshCommand1)     
         ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand1, username); 
         
         //Try Connexion And Trust HostKey Through WinSCP to vserverCommand
         TryConnexionAndTrustHostKeyThroughWinSCP(vserverCommand)
         
         //Copier le fichier en local
         Log.Message("-- Copy Result File From Vserver.")             
         if (!CopyFileFromVserverThroughWinSCP(vserverCommand, resultServerFilePath, resultLocalFilePath))
            Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand1);
         
         //Comparer les deux fichiers
         Log.Message("-- Check data of generated file "+generatedFileName+" with reference file data "+refFile+" for sshCommand = ",sshCommand1);
         Log.Warning("++ Dans la comparaison de deux fichiers, on ne tient pas compte des dates et des Ids des ordres.",
         "parce qu'ils ne sont pas les mêmes ordres que le fichier référence. +++ Confirmé par Mamoudou")
         CompareCsvFiles(refFolder,refFile,ResultlocalFolder, generatedFileName);
		 
		     Log.PopLogFolder();
         //---------------------------------------------------
         
          var refFile = "CR_CROESUS_TRADING_REF.raw";
          var FileNameContains = "CR_CROESUS_TRADING"+date+"*";     
	        var generatedFileName = "CR_CROESUS_TRADING"+date+".raw"; 
          var resultServerFilePath = "/home/emnai/loader/CR1872/"+FileNameContains;
          var resultLocalFilePath = ResultlocalFolder + generatedFileName;
     
          Log.AppendFolder("**Execute SSH Command 2 = "+sshCommand2)
          ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand2, username);
          
          /*************************** EM : 90.12.HF-12 -- Ancien code a été changé par la validation de status des ordres à partir de l'application car 
          /************************ on a pas une référence fixe (cette dernière ça change si la BD change) --> voir Étape 13 de cas de test sur TestLink
          
          //Copier le fichier en local
          Log.Message("-- Copy Result File From Vserver.") 
          if (!CopyFileFromVserverThroughWinSCP(vserverCommand, resultServerFilePath, resultLocalFilePath))
             Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand2);
     
          //Comparer les deux fichiers
          Log.Message("-- Check data of generated file "+generatedFileName+" with reference file data "+refFile+" for sshCommand = ",sshCommand2);
          Log.Warning("++ Dans la comparaison de deux fichiers, On tient pas compte de la première ligne dans la comparaison car la date n'est pas fixe. Ainsi que toutes les dates car ils sont pas fixes.")
          CompareTxtFiles(refFolder,refFile,ResultlocalFolder, generatedFileName);
          
          ***********************************************************************************/
          //***********************************************************************************

          //Login
          Log.Message("-- Se connecter à l'application et valider que les ordres gardent leur statut dans GDO")
          Login(vServerOrders, user, psw, language);
          Get_MainWindow().Maximize();
          Get_ModulesBar_BtnOrders().Click();
          Get_ModulesBar_BtnOrders().WaitProperty("IsChecked", true, 15000);
          WaitObject(Get_CroesusApp(), ["Uid", "VisibleOnScreen"], ["DataGrid_e262", true]);
          
          Log.Message("-- Ordre symbole = "+ELUXY+" ==> Valider Status = "+statusOpen) 
          CheckOrderStatus(ELUXY, statusOpen, dateFormat)
          Log.Message("-- Ordre symbole = "+AIGDotUN+" ==> Valider Status = "+statusOpen) 
          CheckOrderStatus(AIGDotUN, statusOpen, dateFormat)
          Log.Message("-- Ordre symbole = "+CFRUY+" ==> Valider Status = "+statusExecuted) 
          CheckOrderStatus(CFRUY, statusExecuted, dateFormat)
          Log.Message("-- Ordre symbole = "+CBKDotUN+" ==> Valider Status = "+statusPartialFill)
          CheckOrderStatus(CBKDotUN, statusPartialFill, dateFormat)
          
		      Log.PopLogFolder();
          //---------------------------------------------------
                  
          var refFile = "CR_CROESUS_PTFTRADING_REF.raw";
          var FileNameContains = "CR_CROESUS_PTFTRADING"+date+"*";     
    	    var generatedFileName = "CR_CROESUS_PTFTRADING"+date+".raw";     
          var resultServerFilePath = "/home/emnai/loader/CR1872/"+FileNameContains;
          var resultLocalFilePath = ResultlocalFolder + generatedFileName;
          
          Log.AppendFolder("**Execute SSH Command 3 = "+sshCommand3)
          ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand3, username);
        
          //Copier le fichier en local
         Log.Message("-- Copy Result File From Vserver.")   
         if (!CopyFileFromVserverThroughWinSCP(vserverCommand, resultServerFilePath, resultLocalFilePath))
            Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand3);
     
         //Comparer les deux fichiers
         Log.Message("-- Check data of generated file "+generatedFileName+" with reference file data "+refFile+" for sshCommand = ",sshCommand3);
         Log.Warning("++ Dans la comparaison de deux fichiers, On tient pas compte de la première ligne dans la comparaison car la date n'est pas fixe. Ainsi que toutes les dates car ils sont pas fixes.")
		     CompareTxtFiles(refFolder,refFile,ResultlocalFolder, generatedFileName);
         
		     Log.PopLogFolder();		 
         Log.AppendFolder("*************************************CLEANUP**********************************************")
         //Fermer Croesus
        Log.Message("Fermer Croesus")
        Close_Croesus_X();
       
    }
    catch(e) {
  		//S'il y a exception, en afficher le message
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
    }
    finally {
		    
        //Fermer le processus Croesus
        Terminate_CroesusProcess();
        //S'il y a lieu rétablir l'état ininial (Cleanup)
        Activate_Inactivate_PrefFirm("FIRM_1","GDO_ETF_MARKET","",vServerOrders)
		    //Activate_Inactivate_PrefFirm("FIRM_1","PREF_GDO_MARKET_CLOSE_TIME","STOCKS>16:00|BONDS>16:00|FUNDS>16:00",vServerOrders)//la pref est activée dans le premier script pour toute la suite , désactivation affecte d'autres scripts YR
        Log.Message("Supprimer les ordres qui ont été créés aujourd'hui")
        //Execute_SQLQuery("delete b_gdo_order where blotter_date = convert(varchar, getdate(), 101)", vServerOrders);
        Execute_SQLQuery("delete B_GDO_BLOCK_ACCOUNTS from B_GDO_ORDER o join B_GDO_BLOCK_ACCOUNTS b on o.GDODER_ID = b.GDODER_ID where o. TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerOrders);
        Execute_SQLQuery("delete B_GDO_Fill from B_GDO_ORDER o join B_GDO_Fill f on o.wire_number = f.wire_number where o. TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerOrders);
        Execute_SQLQuery("delete B_GDO_ORDER where  TSTAMP_CREATE  >= convert(varchar, getdate(), 101)",vServerOrders);
        
        RestartServices(vServerOrders)
        Runner.Stop(true)
    }
}

function Test(){
     
     var refFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ExpectedFolder\\CR1872\\";
     var ResultlocalFolder = folderPath_Data+"ExportToExcel\\"+client+"\\ResultFolder\\CR1872\\"; 
                         
     var CRFolder = "CR1872"
     var vserverCommand = vServerOrders;
     var username = "emnai";
     var sshCommand1 = "cfLoader -GdoFxReportExtract -FIRM=FIRM_1";
     var sshCommand2 = "cfLoader -PhaseOneGenerator -FIRM=FIRM_1";
     var sshCommand3 = "cfLoader -PhaseOneGenerator --PTF_TRADING_ONLY -FIRM=FIRM_1";
     
     var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d") 
     
     var refFile = "WM_CROES_ref_01.csv";
         var date = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y%m%d") 
         var generatedFileName = "WM_CROES_"+date+"_01.csv";
         var resultServerFilePath = "/home/emnai/loader/CR1872/"+generatedFileName;
         var resultLocalFilePath = ResultlocalFolder + generatedFileName;

//     Log.Message("**Execute SSH Command  = "+sshCommand3)
//     ExecuteSSHCommandCFLoader(CRFolder, vserverCommand, sshCommand3, username);
     
     //Copier le fichier en local
//     Log.Message("-- Copy Result File From Vserver.")    
//     if (!CopyFileFromVserverThroughWinSCP(vserverCommand, resultServerFilePath, resultLocalFilePath))
//        Log.Error("Unable to check if there was no error upon the execution of this SSH command : ", sshCommand2);
     
     //Comparer les deux fichiers
     Log.Message("-- Check data of generated file "+generatedFileName+" with reference file data "+refFile+" for sshCommand = ",sshCommand2);
     CompareCsvFiles(refFolder,refFile,ResultlocalFolder, generatedFileName);
     
}

function CheckOrderStatus(security, status, dateFormat){
    //Choisir l'order créé aujourd’hui    
    Search_Order_Symbol(security);  
    WaitObject(Get_CroesusApp(),"Uid","DataGrid_e262", maxWaitTime);
         
    var count = Get_OrderGrid().RecordListControl.Items.Count
    var found=false;
    for(var i=0;i<count;i++){      
      var orderDate = aqConvert.DateTimeToFormatStr(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.LastUpdateTimestamp,dateFormat)
      
      if(orderDate == aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat) && Get_OrderGrid().RecordListControl.Items.Item(i).DataItem.OrderSymbol == security){
          found = true;       
          aqObject.CompareProperty(orderDate,cmpEqual,aqConvert.DateTimeToFormatStr(aqDateTime.Now(), dateFormat));  
          aqObject.CheckProperty(Get_OrderGrid().RecordListControl.Items.Item(i).DataItem, "Status", cmpEqual,status);   
          break; 
      }
    }
    if(!found)
        Log.Error("L’ordre n’existe pas");
    

}

function CompareCsvFiles(ExpectedCsvFilePath,ExpectedFile,DownloadCsvFilePath,DownloadedFile)
{          
  var Driver;
  var DriverExpected;
  var Line = 1;
  var checkPoints = "";
  var errors = "";
  var errorNum = 0;
  var succesNum = 0;
             
 /*Vérifier que le fichier de reference existe dans le dossier expected*/        
  var FileExpectedExiste = CheckIfFileExists(ExpectedCsvFilePath, ExpectedFile);
  var FileDownloadExiste = CheckIfFileExists(DownloadCsvFilePath, DownloadedFile);   
        
  if(FileExpectedExiste!=null) /* si le fichier attendu existe*/               
      if (FileDownloadExiste!=null)/* si le fichier téléchargé existe*/ 
      {
          /*Ouvrire une connexion aux fichier*/  
          Driver = DDT.CSVDriver(DownloadCsvFilePath + DownloadedFile)            
          DriverExpected = DDT.CSVDriver(ExpectedCsvFilePath + ExpectedFile);
         
          var numberOfColumn = DriverExpected.ColumnCount;
          //Parcourir les entêtes
          for(Column=0; Column < numberOfColumn; Column++)
            if (DriverExpected.ColumnName(Column) == Driver.ColumnName(Column)){
                succesNum++;
				var message = "la ligne(" + Line + ") et colonne(" + Column +") - detectedValue = '" + Driver.ColumnName(Column) + "' \t\t- expectedValue = '" + DriverExpected.ColumnName(Column) + "'";
				checkPoints += "\r\n" + message;
			}
            else
            {
				var message = "Erreur à la ligne(" + Line + ") et colonne(" + Column +") - detectedValue = '" + Driver.ColumnName(Column) + "' \t\t- expectedValue = '" + DriverExpected.ColumnName(Column) + "'";
                errors += "\r\n" + message;
                errorNum++; 
            } 
          /*Lire le fichier CSV Ligne Par Ligne */      
          while (! DriverExpected.EOF())
          {//...
                var EndExpectedFile = DriverExpected.EOF()
                var EndDownloadedFile = Driver.EOF()
                /*Dans le cas où le Nbr de Lignes n,est pas identique*/  
                if(!EndExpectedFile && !EndDownloadedFile)
                {                   
                      for(Column=0; Column < numberOfColumn; Column++)
                      {
                          //On tient pas compte de ces colonnes dans la comparaison car ils sont pas fixes.                      
                          var verifIfNotTestingCulumn = DriverExpected.ColumnName(Column) != "Order ID1" && DriverExpected.ColumnName(Column) != "Order ID2" && DriverExpected.ColumnName(Column) != "Process date" && DriverExpected.ColumnName(Column) != "Trade date" && DriverExpected.ColumnName(Column) != "Settlement_Value date";
                          if(verifIfNotTestingCulumn)
                          {
                              //lire la ligne CSV case par case
                                var ValCelExpected = DriverExpected.Value(Column);
                                var ValCel = Driver.Value(Column);
                                if (ValCelExpected == ValCel){
                                  succesNum++;
								  var message = "la ligne(" + Line + ") et colonne(" + Column +") - detectedValue = '" + ValCel + "' \t\t- expectedValue = '" + ValCelExpected + "'";
								  checkPoints += "\r\n" + message;
                                }
								else{
                                  var message = "Erreur à la ligne(" + Line + ") et colonne(" + Column +") - detectedValue = '" + ValCel + "' \t\t- expectedValue = '" + ValCelExpected + "'";
                                  errors += "\r\n" + message;
                                  errorNum++; 
                                }       
                                /*AssertIsEquals(ValCelExpected,ValCel,
                                "Erreur a la ligne (" + Line + ") et colonne (" + Column +") Avec le Fichiers ( " + ExpectedFile + " ) et téléchargé :( " + DownloadedFile + ")")*/
                            }
                      }
                                        
                      DriverExpected.Next();
                      Driver.Next();
                      Line++;
                }
                 else
                 {
                    Log.Error("Les deux CSV n'ont pas le même nombre de lignes ");
                    break;
                 }
          }  
		  
		  Log.Checkpoint("Comparaison identique: " + succesNum+ ". Pour plus de détails, voir additional Info",checkPoints);
		  
		  //Vérifier si le fichier généré est plus grand que le fichier référence
		  if(!Driver.EOF())
			Log.Error("Les deux fichiers n'ont pas la même taille.");
		  while (!Driver.EOF()){				
			var message = "Erreur : la ligne(" + Line + ") de fichier généré ("+DownloadedFile+") n'existe pas dans le fichier reférence ("+ExpectedFile+")";
			errors += "\r\n" + message;
			errorNum++; 
			Driver.Next();
			Line++;
		  }         
          
          if (errorNum != 0)
             Log.Error("Comparaison échoués: " + errorNum + " (voir additional info)", errors);
		  
		  // Closes the driver
          DDT.CloseDriver(Driver.Name);
          DDT.CloseDriver(DriverExpected.Name);
      }
      else/*Cas où le ficheir téléchargé n'a pas été trouvé*/
          Log.Error("Le fichier téléchargé (" + DownloadedFile + ") est introuvable ");                        
  else/*Cas où le ficheir Attendu n'a pas été trouvé*/
      Log.Error("Le fichier de référence (" + ExpectedFile + ") est introuvable ");
}

//Txt Files compare
function CompareTxtFiles(ExpectedTxtFilePath,ExpectedFile,DownloadTxtFilePath,DownloadedFile)
{ 
  var yearDate = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y")
  var Driver;
  var DriverExpected; 
  var errors = "";
  var checkPoints = "";
  var errorNum = 0;
  var succesNum = 0;
  var Line = 1;
            
 /*Vérifier que le fichier de reference existe dans le dossier expected*/        
  var FileExpectedExiste = CheckIfFileExists(ExpectedTxtFilePath, ExpectedFile);
  var FileDownloadExiste = CheckIfFileExists(DownloadTxtFilePath, DownloadedFile);   
        
  if(FileExpectedExiste!=null) /* si le fichier attendu existe*/               
      if (FileDownloadExiste!=null)/* si le fichier généré existe*/ 
      {          
          // Opens the specified files for reading
          Driver = aqFile.OpenTextFile(DownloadTxtFilePath + DownloadedFile, aqFile.faRead, aqFile.ctANSI);
          DriverExpected = aqFile.OpenTextFile(ExpectedTxtFilePath + ExpectedFile, aqFile.faRead, aqFile.ctANSI);         
                    
          // Skips one line - On tient pas compte de la première ligne dans la comparaison car la date n'est pas fixe 
          Driver.SkipLine(1);
          DriverExpected.SkipLine(1);
          /*Lire le fichier txt Ligne Par Ligne */      
          while (! DriverExpected.IsEndOfLine() && !Driver.IsEndOfLine())
          {
                var EndExpectedFile = DriverExpected.IsEndOfLine();
                var EndDownloadedFile = Driver.IsEndOfLine();
				
                /*Dans le cas où le Nbr de Lignes n'est pas identique*/  
                if(!EndExpectedFile && !EndDownloadedFile)
                {    
                      var LineExpected = DriverExpected.ReadLine();
                      var LineGenerated = Driver.ReadLine();
					  
					  // Split at each '|' character.
						var textArr = LineGenerated.split("|");
						var textArrExpected = LineExpected.split("|");
						for(i=0; i < textArrExpected.length && i< textArr.length; i++){
							/*Traitement fait car les dates de fichier référence et fichier généré ne sont pas identiques
							 ==> Dans la comparaison, on tient pas compte des dates car ils sont pas fixes. */
							var posDate = aqString.Find(textArr[i], yearDate);
							if(posDate == -1){							
								//lire la ligne txt chaine par chaine
								if (textArrExpected[i] == textArr[i]){
								  succesNum++;
								  var message = "ligne(" + Line + ") - chaine(" + i +") detectedValue = '" + textArr[i] + "' \t\t- expectedValue = '" + textArrExpected[i] + "'";
								  checkPoints += "\r\n" + message;
								}  
								else{
								  var message = "Erreur à la ligne(" + Line + ") - chaine(" + i +") detectedValue = '" + textArr[i] + "' \t\t- expectedValue = '" + textArrExpected[i] + "'";
								  errors += "\r\n" + message;
								  errorNum++; 
								}
							}
						}          
                  Line++;                      
                }
           }  
          
          Log.Checkpoint("Comparaison identique: " + succesNum+ ". Pour plus de détails, voir additional Info","N.B : Séparateur des chaines est '|' \n"+checkPoints);
          
		  //Vérifier si le fichier généré est plus grand que le fichier référence
          var Size = aqFile.GetSize(DownloadTxtFilePath + DownloadedFile);
          var SizeDriverExpected = aqFile.GetSize(ExpectedTxtFilePath + ExpectedFile); 
          
		  if (Size > SizeDriverExpected)
		  {
			while (!Driver.IsEndOfLine()){
				var message = "Erreur : la ligne(" + Line + ") de fichier généré ("+DownloadedFile+") n'existe pas dans le fichier reférence ("+ExpectedFile+")";
				errors += "\r\n" + message;
				errorNum++; 
				Driver.ReadLine();
				Line++;
			}
		  }
          if (errorNum != 0){
			 if (Size != SizeDriverExpected)
				Log.Error("Les deux fichiers n'ont pas la même taille. DetectedSize = "+Size+" ExpectedSize = "+SizeDriverExpected);
             Log.Error("Comparaison échoués: " + errorNum + " (voir additional info)", errors);		 
          } 
		  // Closes the driver
          Driver.Close();
          DriverExpected.Close();
      }
      else/*Cas où le ficheir téléchargé n'a pas été trouvé*/
          Log.Error("Le fichier téléchargé (" + DownloadedFile + ") est introuvable ");                        
  else/*Cas où le ficheir Attendu n'a pas été trouvé*/
      Log.Error("Le fichier de référence (" + ExpectedFile + ") est introuvable ");
}
