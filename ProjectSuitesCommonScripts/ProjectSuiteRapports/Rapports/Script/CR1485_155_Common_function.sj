//USEUNIT Common_Get_functions
//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT DBA
//USEUNIT CR1485_150_Common_functions


function selectDates(dateDebut, dateFin){
  
             
            Get_WinReports_GprReport_FieldStartDate().Click();
            Get_WinReports_GprReport_FieldStartDate().Keys(dateDebut)
            Sys.Keys("[Tab]"); //Ajouté par Christophe (pour s'assurer de la validation de la saisie de date)
            Get_WinReports_GprReport_FieldEndDate().Click();
            Get_WinReports_GprReport_FieldEndDate().Keys(dateFin);
           
            
}
function WaitGet_DlgPrintingStatusMessageLogs(maxWaitTime)
{
    if (maxWaitTime == undefined)
        maxWaitTime = 120000;
    
    SetAutoTimeOut(maxWaitTime);
    var isFound = Get_DlgPrintingStatusMessageLogs().Exists;
    RestoreAutoTimeOut();
    if (!isFound) Log.Message("Reports window not displayed by Auto-wait timeout.");
    return isFound;
}



function SaveAs_AcrobatReader_155(pathReportName, backupFolder)
{
    //var reportFullPath = pathReportName;
    var reportFullPath = pathReportName + ".pdf";
    
    //S'il existe un fichier de même nom, le supprimer ; sinon en créer le dossier parent si ce dernier n'existe pas
    if (aqFile.Exists(reportFullPath)){
        if (!aqFileSystem.DeleteFile(reportFullPath)){
            Log.Error("Issue while deleting an existing file with the same name: " + reportFullPath);
        }
    }
    else if (!aqFileSystem.Exists(aqFileSystem.GetFileFolder(reportFullPath))){
        Create_Folder(aqFileSystem.GetFileFolder(reportFullPath));
    }
    
    //Si la langue d'affichage de Windows n'est pas connue, mettre à jour la variable globale y relative : WINDOWS_DISPLAY_LANGUAGE
    //Car le bouton "Enregistrer" de la boîte de dialogue "Enregistrer sous" s'affiche dans cette langue
    GetWindowsDisplayLanguage();
    
    //Faire CTRL + SHIFT + S et sauvegarder le fichier
    var AcrobatSDIWindow = Sys.FindChild("WndClass", "AcrobatSDIWindow", 10);
    var nbOfTries = 0;
    do {
        Delay(1000);
        AcrobatSDIWindow.Keys("^S");
        Delay(3000);
    }
    while (++nbOfTries < 5 && !Get_AcrobatReader_DlgSaveAs().Exists) 
    
    Get_AcrobatReader_DlgSaveAs().WaitProperty("Visible", true, 10000);
    Get_AcrobatReader_DlgSaveAs().SetFocus();
    Get_AcrobatReader_DlgSaveAs_CmbFileName().SetText(pathReportName);
    Get_AcrobatReader_DlgSaveAs_BtnSave().Click();
    
    while (Get_AcrobatReader_DlgSaveAs().Exists){
        Get_AcrobatReader_DlgSaveAs_BtnSave().Click();
    }
    
    //Fermer Acrobat Reader
    Delay(1000);
    AcrobatSDIWindow.WaitProperty("Enabled", true, 10000);
    AcrobatSDIWindow.Keys("~[F4]");
    WaitObjectPropertyExistsToFalse(AcrobatSDIWindow, 10000);
    TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
    
    //Vérifier l'existence effective du fichier PDF
    if (!aqFile.Exists(reportFullPath)){
        Log.Error("File not successfully saved: " + reportFullPath);
    }
    else {
        Log.Checkpoint("File successfully saved: " + reportFullPath);
        if (backupFolder != undefined){
            if (aqFileSystem.CopyFile(reportFullPath, aqFileSystem.IncludeTrailingBackSlash(backupFolder), false)){
                Log.Checkpoint("File successfully saved in backup folder: " + backupFolder);
            }
            else {
                Log.Error("File not successfully saved in backup folder: " + backupFolder);
            }
        }
    }
}




/*Cette fonction permet de selectionner la relation et de telecharher 
le rapport dans la fenetre info relation onglet document*/

function SelectRelationship_And_Dowload_Rapport(ReportName){
   
         
           Get_RelationshipsClientsAccountsGrid().FindChild("Text", ReportName, 10).Click();
           Get_RelationshipsBar_BtnInfo().Click();
           Get_WinDetailedInfo_TabDocuments().Click();
           Get_PersonalDocuments_LstDocuments_ItemTopDocument().DblClick(); 


}



function Get_WinReports_GprReport_FieldStartDate(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 1], 10)}
function Get_WinReports_GprReport_FieldEndDate(){return Get_Reports_GrpReports().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DateField", 2], 10)} 
