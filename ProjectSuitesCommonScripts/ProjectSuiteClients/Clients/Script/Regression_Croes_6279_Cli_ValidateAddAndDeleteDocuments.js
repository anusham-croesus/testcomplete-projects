//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA
//USEUNIT Regression_OptiCroes_4322_4292_6264_6267

/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6279
       
    Description :Le but de ces cas est de valider l'archivage des documents sur l'utilisateur.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 06/05/2019
*/


function Regression_Croes_6279_Cli_ValidateAddAndDeleteDocuments()
{
  try{
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6279", "Croes-6279");
    var docXls=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_XLS", language+client);
    var commentaire=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Comments_6279", language+client);
    var nouveauDossier=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "SelectNewFolder", language+client);
    var SelectRenommer=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "SelectRename", language+client);
    var TextRenommer=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NewFileName", language+client);
    var docWord=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_DOC", language+client);
    
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Cliquer sur le bouton Archiver mes documents
    Get_Toolbar_BtnArchiveMyDocuments().Click();
    WaitObject(Get_WinPersonalDocuments(),"Uid", "Button_7d78", 15000);
    
    //Ajouter un fichier Xls et un commentraire et valdier l'affichage
    Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
    Get_WinAddAFile_GrpFile_BtnBrowse().Click();
    var FolderPath=folderPath_Data +docXls;
    Get_DlgOpen_CmbFileName().Keys(FolderPath)
    Get_DlgOpen_BtnOpen().Click();
    Get_WinAddAFile_GrpComments_TxtComments().Keys(commentaire)
    Get_WinAddAFile_BtnOK().Click();
    
    //Valider que le document excel et le commentaire ont été ajoutés
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument().DataContext.Metadata.Filename, "OleValue", cmpEqual, docXls);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire)
    Get_WinPersonalDocuments_BtnOK().Click();
    
    //Ajouter un fichier par clic droit sur le dossier "Document"
    Get_Toolbar_BtnArchiveMyDocuments().Click();
    WaitObject(Get_WinPersonalDocuments(),"Uid", "Button_7d78", 15000);
    Get_WinPersonalDocuments_TvwDocuments().FindChild("WPFControlText", "Documents", 10).Click();
    Get_WinPersonalDocuments_TvwDocuments().FindChild("WPFControlText", "Documents", 10).ClickR();
    Get_SubMenus().FindChild("WPFControlText",nouveauDossier , 10).Click();
    Get_WinPersonalDocuments_TvwDocuments().FindChild("WPFControlText", "Documents", 10).Click();
    
    //Renommer le nouveau dossier ajouté
    Get_WinPersonalDocuments_TvwDocuments().FindChild("WPFControlText", nouveauDossier, 10).Click();
    Get_WinPersonalDocuments_TvwDocuments().FindChild("WPFControlText", nouveauDossier, 10).ClickR();
    Get_SubMenus().FindChild("WPFControlText",SelectRenommer , 10).Click();
    Get_WinPersonalDocuments_TvwDocuments_TviUser().WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).WPFObject("PathEditBox", "", 1).Keys(TextRenommer);   
    Get_WinPersonalDocuments_TvwDocuments_TviUser().WPFObject("TreeViewItem", "", 1).WPFObject("TreeViewItem", "", 1).WPFObject("PathEditBox", "", 1).Keys("[Enter]"); 
    
    //Ajouter un fichier word
    Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
    Get_WinAddAFile_GrpFile_BtnBrowse().Click();
    var FolderPath=folderPath_Data +docWord;
    Get_DlgOpen_CmbFileName().Keys(FolderPath)
    Get_DlgOpen_BtnOpen().Click();
    Get_WinAddAFile_BtnOK().Click();
    
    //Valider que le fichier a le chemin d'accès "Regression Document"
    aqObject.CheckProperty(Get_PersonalDocuments_GrpDocumentProperties_TxtPath(),"Text",cmpEqual, TextRenommer)    
    Get_WinPersonalDocuments_BtnOK().Click();
    
    //Valider l'affichage des deux fichiers ajoutés
    Get_Toolbar_BtnArchiveMyDocuments().Click();
    WaitObject(Get_WinPersonalDocuments(),"Uid", "Button_7d78", 15000);
    Get_WinPersonalDocuments_TvwDocuments_TviUser().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock","COPERN"], 10).Click();
    CheckVisibFilDocuments(docXls)
    CheckVisibFilDocuments(docWord)
    
    //Supprimer les fichiers ajoutés
    deleteFileDocument(docXls)
    deleteFileDocument(docWord)
    Get_WinPersonalDocuments_BtnOK().Click();
    
    }
     catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     
    