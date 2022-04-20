//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT CommonCheckpoints
//USEUNIT Global_variables
//USEUNIT DBA 
//USEUNIT PDFUtils
//USEUNIT CR2345_TCVE_823_CopyPrintExporClienGridWithPrefDefinedWithoutLimitation

/**
   Copier, imprimer, exporter la grille CRM Clients, pref définie avec limitation [10]]

    Auteur :               Ayaz Sana
    Cas de test :          TCVE823
    Version de scriptage:	90.15.2020.3-47
*/


function CR2345_TCVE_870_CopyPrintExporClientGridPrefDefinedwithLimitationTen()
{
    try {
        Log.Link("https://jira.croesus.com/browse/TCVE-870");
              
        var userNameKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
        var passwordKEYNEJ    = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
        
        var msgWarningTCVE870          =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "msgWarningTCVE870", language+client);
        var croesusRowCount            =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "croesusRowCount", language+client);
        var NameFileTCVE870            =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "NameFileTCVE870", language+client);
        var nbreLignePDFExcelTCVE870   =ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "nbreLignePDFExcelTCVE870", language+client);
        var nbreLigneExportExcelTCVE870=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "CR2243", "nbreLigneExportExcelTCVE870", language+client);
          
        Log.Message("*************************** L'étape 1 *********************************************")
        /*Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à 10*/
        Log.Message("Dans la table B_DEF mettre la pref PREF_MAX_ROW_EXPORTATION à 10")
        Activate_Inactivate_Pref(userNameKEYNEJ,"PREF_MAX_ROW_EXPORTATION","10",vServerClients); 
                
        Log.Message("*************************** L'étape 2 *********************************************")
        Log.Message("Redémarrer les services du vserver")
        RestartServices(vServerClients);
        
        Log.Message("*************************** L'étape 3 *********************************************")
        Log.Message("Ouvrir Croesus Client avec KEYNEJ")
        Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        Log.Message("Aller dans le pad Client")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
        Log.Message("Maximiser l'application") 
        Get_MainWindow().Maximize();
        //Click the button export excel 
        Get_RelationshipsClientsAccountsGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"],["Button", 3],10).Click(); 
        //Les points de vérifications
        Log.Message("Un message s'affiche : (Votre configuration ne permet pas l'exportation de données pour cette grille)")
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, msgWarningTCVE870);
        Get_DlgWarning_BtnOK().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(),["ClrClassName","WPFControlOrdinalNo"],["BaseWindow", 1]);
        Log.Message("*************************** L'étape 4 *********************************************")               
        //Sélectionner le menu: Edition > Copier
        Log.Message("Sélectionner le menu: Edition > Copier");
        Log.Message("Sélectionner le menu: Edition ");
        Get_MenuBar_Edit().OpenMenu();
        Log.Message("Clic sur  Copier");
        Get_MenuBar_Edit_Copy().Click();
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, msgWarningTCVE870);
        Get_DlgWarning_BtnOK().Click();
        TerminateProcess("EXCEL");
        Log.Message("*************************** L'étape 5 *********************************************")     
        //Ouvrir excel et copier le contenu du Clipboard
        Log.Message("Ouvrir excel et copier le contenu du Clipboard")
        Terminate_CroesusProcess();
        TerminateProcess("EXCEL");
                 
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
                  
        objExcelWorkbook.Close(false);
        objExcel.Quit();
        TerminateExcelProcess();
        
        Log.Message("*************************** L'étape 6 *********************************************")
        Login(vServerClients, userNameKEYNEJ, passwordKEYNEJ, language);
        Log.Message("Aller dans le pad Client")
        Get_ModulesBar_BtnClients().Click();
        Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 30000); 
        Log.Message("Maximiser l'application") 
        Get_MainWindow().Maximize();
        Log.Message("Dans PAD Clients, sélectionner  15 ligne dans la grille")
        Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsSelected(true)
        Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(0).set_IsActive(true)
        Sys.Desktop.KeyUp(0x10);
        Get_RelationshipsClientsAccountsGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).Click();
        Sys.Desktop.KeyDown(0x10);
        //Sélectionner le 15 élèment
        Get_RelationshipsClientsAccountsGrid() .WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 15).Click();
        //Relâcher la touche Shift
        Sys.Desktop.KeyUp(0x10);
        Log.Message("*************************** L'étape 7 *********************************************")
        Log.Message("Sélectionner le menu: Fichier > Imprimer")
        Log.Message("Click sur le bouton fichier")
        Get_MenuBar_File().OpenMenu();
                   
        Get_MenuBar_File_Print().Click();
        Log.Message("Une boite de dialogue doit ouvrir avec un Warning qui explique que le maximum accordé est dépassé et que seulement 10 lignes sera exporté")
        Log. Message("click sur le bouton imprimer")
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, msgWarningTCVE870);
        Get_DlgWarning_BtnOK().Click();
        if (Get_DlgPrint().Exists){
            Log.Checkpoint("Dialogue d'impression est présent.");     
        }
        else
            Log.Error("Dialogue d'impression est absent.");
                    
        Log.Message("*************************** L'étape 8 *********************************************")
        Log.Message("Selectionner l'imprimante: Microsoft Print to PDF, puis consulter le fichier pdf résultant")
        Log.Message("Suppression du fichier pdf s'il existe")
        var FilePathTCVE870=Project.Path+ NameFileTCVE870;
        if (aqFileSystem.Exists(FilePathTCVE870))
            aqFile.Delete(FilePathTCVE870);
                     
        var tempFileName = aqFileSystem.GetFileNameWithoutExtension(FilePathTCVE870) + "_" + aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%y%m%d_%H%M%S");
        Log.Message("Le chemin du dossier FilePathTCVE870"+FilePathTCVE870)
        
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).HScroll.Pos = 0;
        Get_DlgPrint().FindChild(["WndClass", "WndCaption"], ["SysListView32", "FolderView"], 10).ClickItem("Microsoft Print to PDF");
        Get_DlgPrint_BtnPrint().Click();
             
        Get_DlgSavePrintOutputAs_CmbFileName_TxtFileName().Keys(FilePathTCVE870);
        Get_DlgSavePrintOutputAs_BtnSave().Click();
        WaitUntilObjectDisappears(Get_CroesusApp(), ["WndClass", "WndCaption"], ["Button", "&Save"])
        
        var PDFPageNumber = 1; //Numéro de la page cible du fichier PDF
        var pictureIndex = 1;
        var PDFPageEndNumber=10 //Numéro de l'image cible dans la page cible
        var fileName= ExtratTxtFromPdf(FilePathTCVE870,PDFPageNumber,PDFPageEndNumber);
        var myFile = aqFile.OpenTextFile(fileName, aqFile.faRead, aqFile.ctUTF8);
    
        // Reads text lines from the file and posts them to the test log 
        var countLineInMyFile=0; // les lignes dans le fichier txt 
        var countLineInGrid=0; 
        var tabLine= new Array();
        while (! myFile.IsEndOfFile()){
            countLineInMyFile++;
            line = myFile.ReadLine();
            tabLine[countLineInMyFile] =line;
        } 
        Log.Message("Le contenu de la ligne avant la dernière "+tabLine[countLineInMyFile-1])
        var positionDuPoint=aqString.Find(tabLine[countLineInMyFile-1],".")
        var NbrLigneFichierPdf=aqString.SubString (tabLine[countLineInMyFile-1], 0, positionDuPoint)
        Log.Message("Nombre de ligne dans le fichier pdf est "+NbrLigneFichierPdf)
        CheckEquals(NbrLigneFichierPdf,nbreLignePDFExcelTCVE870,"Le nombre de ligne dans le fichier pdf")
                 
        Log.Message("*************************** L'étape 9 *********************************************")
        Log.Message("Dans PAD Clients, ne rien sélectionner dans la grille")
        Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
        Log.Message("*************************** L'étape 10 *********************************************")
        Log.Message("Sélectionner le menu: Edition > Exporter vers MS Excel...")
        Log.Message("click sur le bouton Edition")
        Get_MenuBar_Edit().OpenMenu();
        Log.Message("Click sur le bouton Exporter vers Excels")
        Get_MenuBar_Edit_ExportToMsExcel().Click();  
        aqObject.CheckProperty(Get_DlgWarning_LblMessage(), "Message", cmpEqual, msgWarningTCVE870);
        Get_DlgWarning_BtnOK().Click();
        Log.Message("*************************** L'étape 11 *********************************************")
        Log.Message("Le contenu de la grille du pad Client devrait s'afficher. Avec seulement les 10 premières lignes de celles qui étaient sélectionnées.")
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
        CheckEquals(countLineInMyFile,nbreLigneExportExcelTCVE870,"Le nombre de ligne exporté dans le fichier excel")
        
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
        Activate_Inactivate_Pref(userNameKEYNEJ,"PREF_MAX_ROW_EXPORTATION","-1",vServerClients); 
        RestartServices(vServerClients);   
    }
}
