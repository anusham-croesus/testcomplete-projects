//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT PDFUtils


/**
    Copier, imprimer, exporter la grille CRM Clients avec la pref définie sans limitation

    Auteur :               Ayaz Sana
    Cas de test :          TCVE823
    Version de scriptage:	90.15.2020.3-47
*/


function CR2345_TCVE_823_CopyPrintExporClienGridWithPrefDefinedWithoutLimitation()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-823");
        var userNameKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
          
        var NameFileTCVE823      =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "NameFileTCVE823", language+client);
        var nbreLignePDFExcel    =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "nbreLignePDFExcel", language+client);
        var nbreLigneExportExcel =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "nbreLigneExportExcel", language+client);
             
        Log.Message("*************************** L'étape 1 *********************************************")
        /*Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à -1*/
        Log.Message("Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à -1")
        Activate_Inactivate_Pref(userNameKEYNEJ,"PREF_MAX_ROW_EXPORTATION","-1",vServerClients); 
                
        Log.Message("*************************** L'étape 2 *********************************************")
        Log.Message("Redémarrer les services du vserver")
        RestartServices(vServerClients);
        
        Log.Message("*************************** L'étape 3 *********************************************")
        Log.Message("Ouvrir Croesus Client avec KEYNEJ")
        Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        Log.Message("aller dans le pad Client")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
        Log.Message("Maximiser l'application") 
        Get_MainWindow().Maximize();
        arrayOfClientNo = GetAllDisplayedClientNumbers();
        croesusRowCount = arrayOfClientNo.length;
                
        Log.Message("*************************** L'étape 4 *********************************************")
        Log.Message("Sélectionner le menu: Edition ")
        Get_MenuBar_Edit().OpenMenu();
        Log.Message("Clic sur  Copier")
        Get_MenuBar_Edit_Copy().Click();
              
        Terminate_CroesusProcess();
        TerminateProcess("EXCEL");
                
        //Les points de vérifications:Aucun message de limitation ne devrait s'afficher
                 
        Log.Message("*************************** L'étape 5 *********************************************")
        Log.Message("Ouvrir excel et copier le contenu du Clipboard")
                 
        //Paste in the Excel sheet
        WshShell.Run("EXCEL");
        Sys.WaitProcess("EXCEL", 30000);
        Sys.Process("EXCEL").Window("XLMAIN").Activate();
        objExcel = Sys.OleObject("Excel.Application");
        objExcel.Visible = true;
        objExcelWorkbook = objExcel.Workbooks.Add();
        Sys.Keys("^v");
        excelRowCount = objExcel.ActiveSheet.UsedRange.Rows.Count;
        
        //The row count in the Excel sheet should be the same as in Croesus
        if (croesusRowCount == excelRowCount)
          Log.Checkpoint("The Excel row count is the expected : " + excelRowCount);
        else {
          Log.Error("The Excel row count is incorrect ; expecting " + croesusRowCount + ", got " + excelRowCount);
                    
        }
               
        /* for (var i = 0; i < arrayOfClientNo.length; i++){
          croesusClientNo = VarToStr(arrayOfClientNo[i]);
          excelClientNo = VarToStr(objExcel.Cells.Item(i + 1, 2));
          CheckEquals(excelClientNo, croesusClientNo, "The client number in Excel at line " + (i + 1));
        }*/
                 
        //Close Excel without prompt
        objExcelWorkbook.Close(false);
        objExcel.Quit();
        TerminateExcelProcess();
        //Retourner dans le PAD Clients, Sélectionner le menu: Fichier > Imprimer
        Log.Message("*************************** L'étape 6 *********************************************")
        Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        Log.Message("aller dans le pad Client")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
        Log.Message("Click sur le bouton fichier")
        Get_MenuBar_File().OpenMenu();
        Log. Message("click sur le bouton imprimer")
         Get_MenuBar_File_Print().Click();
                    
        if (Get_DlgPrint().Exists){
            Log.Checkpoint("Dialogue d'impression est présent.");
        }
        else
            Log.Error("Dialogue d'impression est absent.");
                      
         Log.Message("*************************** L'étape 7 *********************************************") 
          /*******/
        //Suppression du fichier pdf s'il existe
        Log.Message("Suppression du fichier pdf s'il existe")
        var FilePathTCVE823=Project.Path+ NameFileTCVE823;
        if (aqFileSystem.Exists(FilePathTCVE823))
            aqFile.Delete(FilePathTCVE823);
                     
        var tempFileName = aqFileSystem.GetFileNameWithoutExtension(FilePathTCVE823) + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
        Log.Message("Le chemin du dossier FilePathTCVE823"+FilePathTCVE823);
        
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).HScroll.Pos = 0;
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).ClickItem("Microsoft Print to PDF");
        Get_DlgPrint_BtnPrint().Click();
             
        Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().Keys(FilePathTCVE823);
        Get_DlgSavePrintOutputAs_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["WndClass", "WndCaption"], ["Button", "&Save"]);
        
        var PDFPageNumber = 1; //Numéro de la page cible du fichier PDF
        var pictureIndex = 1;
        var PDFPageEndNumber=10 //Numéro de l'image cible dans la page cible
        var fileName= ExtratTxtFromPdf(FilePathTCVE823,PDFPageNumber,PDFPageEndNumber);
        var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctUTF8);
    
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier txt 
        var countLineInGrid=0; 
        var tabLine = new Array();
        while (! myFile.IsEndOfFile()){
            countLineInMyFile++;
            line = myFile.ReadLine();
            tabLine[countLineInMyFile] =line;
        } 
        Log.Message("Le contenu de la ligne avant la dernière " + tabLine[countLineInMyFile-1]);
        var positionDuPoint = aqString.Find(tabLine[countLineInMyFile-1], ".");
        var NbrLigneFichierPdf = aqString.SubString (tabLine[countLineInMyFile-1], 0, positionDuPoint);
        Log.Message("Nombre de ligne dans le fichier pdf est " + NbrLigneFichierPdf);
        CheckEquals(NbrLigneFichierPdf,nbreLignePDFExcel, "Le nombre de ligne dans le fichier pdf");
        // var nbreOfLineFile=countLineInMyFile-1;
               
        myFile.Close();
        Log.Message("*************************** L'étape 8 *********************************************") 
        Log.Message("click sur le bouton Edition")
        Get_MenuBar_Edit().OpenMenu();
        Log.Message("Click sur le bouton Exporter vers Excels")
        Get_MenuBar_Edit_ExportToMsExcel().Click();  
        Log.Message("Vérifier aucun message de limitation n'est affiché")
        // aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Exists", cmpEqual, false);
        Log.Message("*************************** L'étape 9 *********************************************") 
        /******************************/
        //fermer les fichier excel
        while (Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }

        var sTempFolder = Sys.OSInfo.TempDirectory;
        var FolderPath= sTempFolder+"\CroesusTemp\\"
        Log.Message(FolderPath)
        var FileNameContains = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%Y-%m-%d-")
        Log.Message(FindLastModifiedFileInFolder(FolderPath,FileNameContains))
    
        var myFile = aqFile.OpenTextFile(FindLastModifiedFileInFolder(FolderPath,FileNameContains), aqFile.faRead, aqFile.ctANSI);
    
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier txt 
        while (! myFile.IsEndOfFile()){
            countLineInMyFile++;
            line = myFile.ReadLine();// Split at each space character.
        } 
        Log.Message("Le nombre de ligne dans le fichier excel est "+countLineInMyFile);
        CheckEquals(countLineInMyFile,nbreLigneExportExcel,"Le nombre de ligne exporté dans le fichier excel");
 
        // Closes the file
        myFile.Close();
           
        //fermer les fichier excel
        while (Sys.waitProcess("EXCEL").Exists){
            Sys.Process("EXCEL").Terminate();
        }      
    } 
    catch (e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));   
    }
    finally {  
        //Close croesus
        Terminate_CroesusProcess();
        TerminateExcelProcess();         
    }
}


function GetAllDisplayedClientNumbers()
{
    var isEndOfGriReached = false;
    var arrayOfAllDisplayedClientsNumbers = new Array();
    Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, 50);
    
    while (!isEndOfGriReached){
        clientsPageCount = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
        
        for (var i = 0; i < clientsPageCount; i++){
            displayedClientNumber = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.get_ClientNumber());
            if (GetIndexOfItemInArray(arrayOfAllDisplayedClientsNumbers, displayedClientNumber) == -1)
                arrayOfAllDisplayedClientsNumbers.push(displayedClientNumber);
        }

        var firstRowAccountBeforeScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
        var firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        
        if (firstRowAccountBeforeScroll == firstRowAccountAfterScroll){
            Get_RelationshipsClientsAccountsGrid().Click(Get_RelationshipsClientsAccountsGrid().Width - 10, Get_RelationshipsClientsAccountsGrid().Height - 40);
            firstRowAccountAfterScroll = VarToStr(Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).DataItem.get_ClientNumber());
        }
        
        isEndOfGriReached = (firstRowAccountBeforeScroll == firstRowAccountAfterScroll);
    }
    
    return arrayOfAllDisplayedClientsNumbers;
}

function ExtratTxtFromPdf(PDFFilePath, startPageNumber, endPageNumber)
{
  
  if (startPageNumber != undefined && endPageNumber == undefined)
        endPageNumber = startPageNumber;
    
    Log.Message("Get Text from PDF file : " + PDFFilePath);
    
    //Copier le fichier PDF dans le dossier temporaire
    var tempFileName = aqFileSystem.GetFileNameWithoutExtension(PDFFilePath) + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
    var tempPDFFilePath = Sys.OSInfo.TempDirectory + tempFileName + ".pdf";
    var outputTextFilePath = Sys.OSInfo.TempDirectory + tempFileName + ".txt";
    aqFileSystem.CopyFile(PDFFilePath, tempPDFFilePath);
    
    //Exécuter la ligne de commande
    var commandLineParameters = "ExtractText";
    if (startPageNumber != undefined) commandLineParameters += " -startPage " + startPageNumber;
    if (endPageNumber != undefined) commandLineParameters += " -endPage " + endPageNumber;

    if (ExecuteJARAppCommandLine(commandLineParameters, tempPDFFilePath)){
        //Attendre que le fichier texte de sortie soit correctement écrit
        var nbOfChecks = 0;
        do {
            Delay(1000);
        } while (!aqFileSystem.Exists(outputTextFilePath) && ++nbOfChecks < 20)
        
        //Retourner le chemin d'accès du fichier texte de sortie
        if (aqFileSystem.Exists(outputTextFilePath)){
            Log.Message("The PDF text extracted file is : " + outputTextFilePath);
            return outputTextFilePath;
        }
    }
    
    Log.Error("The PDF text extraction was not successful.");
    return null;

}
