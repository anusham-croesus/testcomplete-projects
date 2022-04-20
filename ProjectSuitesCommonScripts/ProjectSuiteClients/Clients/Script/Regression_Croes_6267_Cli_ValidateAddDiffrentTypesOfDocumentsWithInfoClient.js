//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT BNC_2222_SetFileNotVisibOnHighLevelOfTheTree


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6267
       
    Description :Le but de ces cas est de valider l'archivage différents type de documents dans le module client par Info client.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 03/05/2019
*/


function Regression_Croes_6267_Cli_ValidateAddDiffrentTypesOfDocumentsWithInfoClient()
{
  try{
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6267", "Croes-6267");
   
    var clientNum300012=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client_6267", language+client);
    var docWord=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_DOC", language+client);
    var docPDF=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile1_PDF", language+client);
    var docPPt=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_PPt", language+client);
    var docXls=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_XLS", language+client);
    var reportName=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Report_Name", language+client);
    var commentaire=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Comments_6267", language+client);
    var reportNameEval=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Report_Name_Evaluation", language+client);
    
   //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //I Sélectionner le client 300012 et cliquer sur le bouton Info  
    Search_Client(clientNum300012);
    Get_ClientsBar_BtnInfo().Click();

    //Cliquer sur le bouton Documents
    Get_WinDetailedInfo_TabDocuments().Click();
    
    //Ajouter le fichier Word :"test1BNC_2222.docx"
    AddFilesToDocument(docWord)
        
    //Ajouter le fichier PDF :"test1BNC_2222.pdf"
    AddFilesToDocument(docPDF)
     
    //Ajouter le fichier ppt :"test1BNC_2222.pptx"
    AddFilesToDocument(docPPt)
    
    //Ajouter le fichier xls :"test1BNC_2222.xlsx"
    AddFilesToDocument(docXls)

    //Valider l'affichage des 4 fichiers
    CheckVisibFilDocuments(docXls)
    CheckVisibFilDocuments(docPPt)
    CheckVisibFilDocuments(docPDF)
    CheckVisibFilDocuments(docWord)
    Get_WinDetailedInfo_BtnOK().Click();
    
    //II Sélectionner le client 300012 et aller sur rapport
    Search_Client(clientNum300012);
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    Delay(3000);
    
    //Sélectionner le rapport Évaluation du portefeuille (simple)et cocher la case Archiver les rapports
    SelectAReport(reportNameEval);
    Delay(3000);
    Get_WinReports_GrpOptions_ChkArchiveReports().Click();

    //Valider le rapport
    ValidateReport()  
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
   
    
    //Sélectionner le client 300012 et cliquer sur le bouton Info  
    Search_Client(clientNum300012);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum300012, 10).Click();
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNum300012, 10).DblClick();
    
    //Cliquer sur le bouton Documents
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    
    
    //Valider l'ajout du rapport et le commentaire : Rapport produit par Croesus
    Get_PersonalDocuments_LstDocuments().WaitProperty("VisibleOnScreen", true, 3000);
    CheckVisibFilDocuments(reportName)
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire)

    //Aller sur le nom client et cliquer sur le bouton fichiers PDF seulement
    Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "TRXIONS FONDS CI"], 10).Click();
    Get_PersonalDocuments_Toolbar_BtnFilterPdf().Click();
    
    //Valider l'affichage des deux documnents pdf
    Get_PersonalDocuments_LstDocuments().WaitProperty("VisibleOnScreen", true, 3000);
    CheckVisibFilDocuments(reportName)
    CheckVisibFilDocuments(docPDF) 
    
    //Cliquer sur Autres types de fichier seulement et valider l'affichage des fichier word, excel et ppt
    Get_PersonalDocuments_Toolbar_BtnFilterFile().Click();
    CheckVisibFilDocuments(docXls)
    CheckVisibFilDocuments(docPPt)
    CheckVisibFilDocuments(docWord)
    
    //Retablir la configuration d'origine
    deleteFileDocument(reportName)
    deleteFileDocument(docXls)
    deleteFileDocument(docPPt)
    deleteFileDocument(docPDF)
    deleteFileDocument(docWord)
    Get_WinDetailedInfo_BtnOK().Click();
    
    }
     catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
  }   
} 

function AddFilesToDocument(folderName)
{
    Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_WinAddAFile_GrpFile_BtnBrowse().Click();
    var FolderPath=folderPath_Data +folderName;
    
    Get_DlgOpen_CmbFileName().Keys(FolderPath)
    Get_DlgOpen_BtnOpen().Click();
    Get_WinAddAFile_BtnOK().Click();
}


function deleteFileDocument(FileName)
{
    Get_PersonalDocuments_Toolbar_BtnFilterAll().Click()
    Get_PersonalDocuments_Toolbar_BtnRemove().Click();
    var width = Get_DlgConfirmation().Get_Width();
    Get_DlgConfirmation().Click((width*(1/3)),73);

}
