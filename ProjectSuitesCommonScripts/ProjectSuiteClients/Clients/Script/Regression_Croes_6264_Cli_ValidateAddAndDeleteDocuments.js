//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA


/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6264
       
    Description :Valider l'archivage des documents dans le module client et la gestion du commenataire.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-10--V9-croesus-co7x-1_5_1_572
    
    Date: 26/04/2019
*/

function Regression_Croes_6264_Cli_ValidateAddAndDeleteDocuments()
{
  try{
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6264", "Croes-6264");
     
    var clientNum300011=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ClientNum_6264", language+client);
    var docWord=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile1", language+client);
    var commentaire=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Comments", language+client);
    var commentaireModifie=ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NewComments", language+client);
   
   
    //Accès au module client
    Login(vServerClients, userName,psw,language);
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    
    //Sélectionner le client 300011 et cliquer sur le bouton Info  
    Search_Client(clientNum300011);
    Get_ClientsBar_BtnInfo().Click();
    
    //Cliquer sur le bouton Documents
    Get_WinDetailedInfo_TabDocuments().Click();
    
    //Ajouter un fichier et cliquer su parcourir
    Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_WinAddAFile_GrpFile_BtnBrowse().Click();
    var FolderPath=folderPath_Data +docWord;
    Get_DlgOpen_CmbFileName().Keys(FolderPath)
    Get_DlgOpen_BtnOpen().Click();
    Get_WinAddAFile_GrpComments_TxtComments().Keys(commentaire)
    Get_WinAddAFile_BtnOK().Click();
    
    //Valider que le document word et le cpmmentaire ont été ajoutés
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument().DataContext.Metadata.Filename, "OleValue", cmpEqual, docWord);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire)
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().Click();
     
    //Modifier le commentaire dans la séction "Commentaires" et sauvgarder
    Search_Client(clientNum300011);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_PersonalDocuments_GrpComments_BtnEdit().Click();
    Get_PersonalDocuments_GrpComments_TxtComment().Clear();
    Get_PersonalDocuments_GrpComments_TxtComment().Keys(commentaireModifie);
    Get_PersonalDocuments_GrpComments_BtnSave().Click();
    
    
    //Valider l'affichage du nouveau commentaire
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaireModifie)
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"VisibleOnScreen", cmpEqual, true);
    Get_WinDetailedInfo_BtnOK().Click();
    
    //Supprimer le document ajouté 
    Search_Client(clientNum300011);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_PersonalDocuments_LstDocuments_ItemTopDocument().Click();
    //Cliquer sur "Enlever"
    Get_PersonalDocuments_Toolbar_BtnRemove().Click();
    Get_DlgConfirmation_BtnDelete().Click();
    
    //Valider que le document n'est plus affiché
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument(), "Exists", cmpEqual, false);
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    
  }
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  finally {
    Terminate_CroesusProcess();
    
  }   
}     

