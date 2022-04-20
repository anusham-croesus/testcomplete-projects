//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA



/**
    https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6276
       
    Description :Valider l'ajout de Documents de type rapport.
            
    Auteur : Asma Alaoui
    
    Version de scriptage:	ref90-10-Fm-13--V9-croesus-co7x-1_5_1_572
    
    Date: 16/05/2019
*/



function Regression_CROES_6276_Acc_ValidateAddReportsFilesToDocument()
{
  try{
   Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6276","Croes-6276");

     var accountNo= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "account800069-FS", language+client);
     var reportNameEval= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "Report_Name_Evaluation", language+client);
     var rapport800069= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "CroesusReport", language+client);
     var docPDF= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "docPDF", language+client);
     var clientNum800069= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ClientNum800069", language+client);
     var ClientReport= ReadDataFromExcelByRowIDColumnID(filePath_Accounts, "Regression", "ClientReport", language+client);
     
     
     
    //se connecter avec Copern
    Login(vServerAccounts, userName, psw, language);
    
    //Accès au module Comptes
    Get_MainWindow().Maximize();
    Get_ModulesBar_BtnAccounts().Click();
    
    //chercher le compte "800069-FS" et aller sur rapport
    SelectAccounts(accountNo);
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    
    //Sélectionner le rapport Évaluation du portefeuille (intermédiaire)et cocher la case Archiver les rapports
    SelectAReport(reportNameEval);
    Get_WinReports_GrpOptions_ChkArchiveReports().Click();

    //Valider le rapport
    ValidateReport()  
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
    
    //Mailler le compte vers Clients
    SearchAccount(accountNo);
    Drag(Get_RelationshipsClientsAccountsGrid().Find("Value",accountNo ,10), Get_ModulesBar_BtnClients());
    
    //Aller sur info
    Get_ClientsBar_BtnInfo().Click();
    
    //Cliquer sur le bouton Documents
    Get_WinDetailedInfo_TabDocuments().Click();
  
    //Sélectionner le répertoire "Rapports Croessus" ensuite cliquer sur "800069 Maheu Mathieu"
    Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", rapport800069], 10).Click();
    Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", ClientReport], 10).Click();
    
    //Valider l'affichage du documnent pdf
    CheckVisibFilDocuments(docPDF)  
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
    
    //Supprimer le document ajouté 
    Get_ModulesBar_BtnClients().Click();  
    Search_Client(clientNum800069);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_PersonalDocuments_LstDocuments_ItemTopDocument().Click();
    //Cliquer sur "Enlever"
    Get_PersonalDocuments_Toolbar_BtnRemove().Click();
    Get_DlgConfirmation_BtnDelete().Click();
    Get_WinDetailedInfo_BtnOK().Click();
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
    
    }
    
  catch(e) {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
    }
  finally {
    Terminate_CroesusProcess();
    
    }

}


function CheckVisibFilDocuments(NameFile)
{
    var existfilePdf=Get_PersonalDocuments_LstDocuments().Find("Text",NameFile,100).Exists 
    Log.Message(existfilePdf)      
    if(existfilePdf == true){
     var visiblefilePdf=Get_PersonalDocuments_LstDocuments().Find("Text",NameFile,100).VisibleOnScreen
      Log.Message(visiblefilePdf) 
   if(visiblefilePdf == true)
    {
       Log.Checkpoint("Le fichier existe et il est visible a l'écran "+NameFile)}
    }
    else{
       Log.Error("Le fichier n'existe pas et il est pas visible a l'écran "+NameFile)
    } 

}
