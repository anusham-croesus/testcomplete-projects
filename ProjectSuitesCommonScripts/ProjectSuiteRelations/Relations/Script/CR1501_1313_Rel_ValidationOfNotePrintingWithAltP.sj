//USEUNIT Common_functions
//USEUNIT DBA
//USEUNIT PDFUtils

/**
     https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1313

     Préconditions : 
     Se connecter avec COPERN
     
     
     1-Choisir le module relation.:Le module relation s'ouvre correctement.
     2-Sélectionner une relation:La relation est bien sélectionnée.
     3-Cliquer sur le bouton 'Info':La fenêtre info de la relation sélectionnée est ouverte.
     4-Choisir l'onglet note ensuite utiliser Alt+P.:
     L'impression du brouillon de travail fonctionne correctement et la liste des notes imprimée correspond aux notes de la position.
     
    Auteur : Sana Ayaz
    
    Version de scriptage:	ref90-09-9--V9-croesus-co7x-1_4_546
*/


function CR1501_1313_Rel_ValidationOfNotePrintingWithAltP()
{
    try {
        Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-1313", "CR1501_1313_Rel_ValidationOfNotePrintingWithAltP()");
        
        //Les variables
        var RelTextAddNotCROES1313      = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "RelTextAddNotCROES1313", language+client);
        var textphrasePredefiniCROES1344= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "textphrasePredefiniCROES1344", language+client);
        var nameRelation1CROES1313      = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "nameRelation1CROES1313", language+client);
        var NameFileCROES1313           = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "NameFileCROES1313", language+client);
        var line1ImpressioCROES1313     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "line1ImpressioCROES1313", language+client);
        var pageimpressionCROES1313     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "pageimpressionCROES1313", language+client);
        var line2ImpressioCROES1313     = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "line2ImpressioCROES1313", language+client);
        var Userline6impressionCROES1313= ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR1501", "Userline6impressionCROES1313", language+client);
        
        //Login
        var userNameCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "username");
        var passwordCOPERN = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "COPERN", "psw");
        
        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        
        //Choisir le module relation
        Get_ModulesBar_BtnRelationships().Click();
        Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 30000);
        CreateRelationship(nameRelation1CROES1313);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1313, 10).ClickR(); 
       
        //Ajout d'une note  
        Get_RelationshipsClientsAccountsGrid_ContextualMenu_AddANote().Click();
        Get_WinCRUANote_GrpNote_TxtNote().Click();
        Get_WinCRUANote_GrpNote_TxtNote().set_Text(RelTextAddNotCROES1313);
        Get_WinCRUANote_GrpNote_BtnDateTime().Click();
        
        Get_WinCRUANote_TabGrid_DgvPredefinedSentences().FindChild("Value", textphrasePredefiniCROES1344, 10).Click();
        Get_WinCRUANote_GrpNote_BtnAddSentence().Click();
        
        WaitObject(Get_WinCRUANote(),"UID","NoteSentenceDataGrid_ae74");
        var textAjoutNote = Get_WinCRUANote_GrpNote_TxtNote().Text.OleValue;
        Log.Message(textAjoutNote);
        Get_WinCRUANote_BtnSave().Click();
/*          
        //Les points de vérification
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1313, 10).Click(); 
        Get_RelationshipsBar_BtnInfo().Click()
        Get_WinDetailedInfo_TabInfo().Click();
        Get_WinInfo_Notes_TabGrid().Click();
        
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpEqual, textAjoutNote);
        aqObject.CheckProperty(Get_WinInfo_Notes_TabGrid_TxtNote(),"wText", cmpContains, RelTextAddNotCROES1313);
        var textNotCROES1313 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value", VarToString(textAjoutNote), 10);
        var x = textNotCROES1313.Exists;
        Log.Message(x);
        if (textNotCROES1313.Exists && textNotCROES1313.VisibleOnScreen)
            Log.Checkpoint("La note est ajoutée");
        else
            Log.Error("La note n'est pas ajoutée");
        
        Get_WinDetailedInfo_BtnOK().Click();
 */       
        //3-Cliquer sur le bouton 'Info':La fenêtre info de la relation sélectionnée est ouverte.
        SelectRelationships(nameRelation1CROES1313);
        Get_RelationshipsClientsAccountsGrid().FindChild("Value", nameRelation1CROES1313, 10).Click(); 
        Get_RelationshipsBar_BtnInfo().Click();
        Get_WinDetailedInfo_TabInfo().Click();
        Get_WinInfo_Notes_TabGrid().Click();  
        
        //Set the default configuration of columns in the grid
        Get_WinInfo_Notes_TabGrid_DgvNotes_ChEffectiveDate().ClickR();
        Get_GridHeader_ContextualMenu_DefaultConfiguration().Click();
        
        var enteteColonne1 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "1"], 10).WPFControlText
        var enteteColonne2 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "2"], 10).WPFControlText
        var enteteColonne3 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "3"], 10).WPFControlText
        var line3ImpressioCROES1313 = enteteColonne1 + "  " + enteteColonne2 + "         " + enteteColonne3;
        
        var line4ImpressioCROES1313 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["LabelPresenter", "4"], 10).WPFControlText
        var indexligne = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",VarToString(textAjoutNote), 10).Record.Index;
        var datCrationCroes1313 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indexligne+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 2], 10).WPFObject("XamDateTimeEditor", "", 1).DisplayText.OleValue
        var creaBycROES1313 = Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", indexligne+1], 10).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["CellValuePresenter", 3], 10).WPFObject("XamTextEditor", "", 1).DisplayText.OleValue
        var line5ImpressioCROES1313 = Userline6impressionCROES1313 + datCrationCroes1313 + "  " + creaBycROES1313;
        var datCreationAndPage = datCrationCroes1313 + pageimpressionCROES1313;
        
        // 4-Choisir l'onglet note ensuite utiliser Alt + P.
        var FilePathCROES1313 = Project.Path+ NameFileCROES1313;
        if (aqFileSystem.Exists(FilePathCROES1313) && !aqFileSystem.DeleteFile(FilePathCROES1313))
            Log.Error("Il y a eu problème lors de la suppression d'un fichier existant de même nom : " + FilePathCROES1313, FilePathCROES1313);
        
        Get_WinInfo_Notes_TabGrid_DgvNotes().FindChild("Value",VarToString(textAjoutNote), 10).Click()
        Get_WinInfo_Notes_TabGrid_DgvNotes().Keys("~p");
        if (Get_DlgPrint().Exists)
            Log.Checkpoint("Dialogue d'impression est présent.");
        else
            Log.Error("Dialogue d'impression est absent.");
            
        /*
            les points de vérifications :
            L'impression du brouillon de travail fonctionne correctement et la liste des notes imprimée correspond aux notes de la position.
        */
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).HScroll.Pos = 0;
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).ClickItem("Microsoft Print to PDF");
        Get_DlgPrint_BtnPrint().Click();
        Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().Keys(FilePathCROES1313);
        Get_DlgSavePrintOutputAs_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["WndClass", "WndCaption"], ["Button", "&Save"]);
             
        //Récupérer le texte (reconnu comme texte) du fichier PDF
        var PDFPageNumber = 1; //Numéro de la page cible du fichier PDF
        var fileName = ExtratTxtFromPdf(FilePathCROES1313, PDFPageNumber);
        if (fileName == null)
            return Log.Error("Il y a eu problème lors de l'extraction de texte de la page " + PDFPageNumber + " du fichier PDF : " + FilePathCROES1313, FilePathCROES1313);
        
        //Put Expected lines content in an Array
        var arrayDataCroes1313 = new Array();
        arrayDataCroes1313.push(line1ImpressioCROES1313);
        arrayDataCroes1313.push(line2ImpressioCROES1313);
        arrayDataCroes1313.push(datCreationAndPage);
        arrayDataCroes1313.push(line3ImpressioCROES1313);
        arrayDataCroes1313.push(line4ImpressioCROES1313);
        arrayDataCroes1313.push(line5ImpressioCROES1313);
        arrayDataCroes1313.push(textAjoutNote);
        
        //Read text lines from the file and post them to the test log and compare them to the expected content from Array
        var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctUTF8);
        var lineNumberInMyFile = 0; //les numéros de lignes dans le fichier txt 
        while (! myFile.IsEndOfFile()){
            lineNumberInMyFile++;
            var line = myFile.ReadLine();
            Log.Message("La ligne est : " + lineNumberInMyFile, line);
            Log.Message(line);
            if (lineNumberInMyFile != 3)
                CheckEquals(line, arrayDataCroes1313[lineNumberInMyFile - 1], "Le texte affiché sur la ligne " + lineNumberInMyFile);
            else {
                var timeToleranceInMinutes = 2;
                Log.Message("Vérifier le texte affiché sur la ligne " + lineNumberInMyFile + " avec une tolérance de " + timeToleranceInMinutes + " minutes pour la date/heure.");
                Log.Message("Il y a un espace entre la date et page 1 donc  le cas il faut adapterle script")
                var arrayOfExpected_datCreationAndPage = [arrayDataCroes1313[lineNumberInMyFile - 1]];
                var timeDisplayFormat = GetDateTimeStrFormat(datCrationCroes1313);
                if (timeDisplayFormat != null)
                    for (var nbOfMinutes = 0 ; nbOfMinutes <= timeToleranceInMinutes; nbOfMinutes++)
                        arrayOfExpected_datCreationAndPage.push(aqConvert.DateTimeToFormatStr(aqDateTime.AddMinutes(StrToDateTime(datCrationCroes1313), nbOfMinutes), timeDisplayFormat) + pageimpressionCROES1313);
                
                CheckEqualsToOneArrayItem(line, arrayOfExpected_datCreationAndPage, "Le texte affiché sur la ligne " + lineNumberInMyFile);
            }
        }
        myFile.Close();
        Get_WinDetailedInfo_BtnOK().Click();
    }
    catch(e) {
        Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
    finally {
//        Login(vServerRelations, userNameCOPERN, passwordCOPERN, language);
        DeleteRelationship(nameRelation1CROES1313);
        Terminate_CroesusProcess();
    }
    
}



function GetDateTimeStrFormat(dateTimeStr)
{
    var yearFormat = (language == "french")? "%Y/%m/%d": "%m/%d/%Y";
    var timeFormat = (language == "french")? "%H:%M": "%H:%M";
    
    var yearStr = aqConvert.DateTimeToFormatStr(StrToDateTime(dateTimeStr), yearFormat);
    var timeStr = aqConvert.DateTimeToFormatStr(StrToDateTime(dateTimeStr), timeFormat);
    
    var yearPos = aqString.Find(dateTimeStr, yearStr);
    var timePos = aqString.Find(dateTimeStr, timeStr);
    
    if (yearPos != -1 && timePos != -1){
        var yearEnd = yearPos + yearStr.length;
        var yearTimeSeparator = aqString.SubString(dateTimeStr, yearEnd, timePos - yearEnd);
//        return yearFormat + yearTimeSeparator + timeFormat;
        return yearFormat + "  " + timeFormat;
    }
    
    if (yearPos == -1)
        Log.Error("Year '" + yearStr + "' not found in DateTimeString '" + dateTimeStr + "' according to the format '" + yearFormat + "'");
        
    if (timePos == -1)
        Log.Error("Time '" + timeStr + "' not found in DateTimeString '" + dateTimeStr + "' according to the format '" + timeFormat + "'");
    
    //var defaultDateTimeFormat = (language == "french")? "%Y/%m/%d %H:%M": "%m/%d/%Y %H:%M";
    return null;
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
            Log.Message("The PDF text extracted file is : " + outputTextFilePath, outputTextFilePath);
            return outputTextFilePath;
        }
    }
    
    Log.Error("The PDF text extraction was not successful.");
    return null;

}
