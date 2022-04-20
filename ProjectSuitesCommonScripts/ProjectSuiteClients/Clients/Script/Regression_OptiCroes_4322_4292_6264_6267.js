//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT ExcelUtils
//USEUNIT Clients_Get_functions
//USEUNIT DBA

//
// Description: Validation de l'onglet Produits & Services et Documents dans Info CLient du module Clients.
// Analyste d'assurance qualité: Karima Mehiguene
// Analyste d'automatisation: Emna IHM  
// Version de scriptage: ref90-19-2020-09-45
//
// Regression_Croes_4322_Cli_AddProductsAndServicesToClient  
// Regression_Croes_4292_Cli_ProfilesClientsManagement
// Regression_Croes_6267_Cli_ValidateAddDiffrentTypesOfDocumentsWithInfoClient
// Regression_Croes_6264_Cli_ValidateAddAndDeleteDocuments
//
// MAJ: Pierre Lefebvre (June 02, 2021)
//      --> Retrait d'un CheckProperty VisibleOnScreen = false car on ne peut pas effectuer cela lorsque Exits = False.  
//      --> Ajout d'information additionelle dans les Logs.
//

function Regression_OptiCroes_4322_4292_6264_6267()
{
  try
  {
    var errorCountBeforeExecution = 0;
    var errorCountAfterExecution = 0;
    var functionName = arguments.callee.toString().match(/function (\w*)/)[1];
    var boldAttribute = Log.CreateNewAttributes();
    var clientNumber = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Client_6267", language + client);    
   
    boldAttribute.Bold = true;
    Log.CallStackSettings.EnableStackOnCheckpoint = true;    
    Log.Message("***** Execution of '" + functionName + "' started.", "", pmNormal, boldAttribute);     
    Log.AppendFolder("Preparation of test envionment on " + vServerClients + " for client " + client + " using username " + userName + ".");        
    Log.AppendFolder("Environment Setup.");

    Login(vServerClients, userName, psw, language);
    
    var currentCroesusAdvisorBuild = GetCroesusBuildVersion();
        
    Log.PopLogFolder();    
    Log.PopLogFolder();
    Log.Message("Croesus Advisor on " + vServerClients + " running build: " + currentCroesusAdvisorBuild + ".", "", pmNormal, boldAttribute);
    
    /************************************************* Étape 1 : Validation of client Products & Services ***********************************************/
    Log.AppendFolder("Étape 1: Croes-4322 - Validation of Client Products & Services.", "", pmNormal, boldAttribute);
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4322", "Cas de test TestLink: Croes-4322");  
    /****************************************************************************************************************************************************/
    Log.AppendFolder("Setup.");
    Log.AppendFolder("Add Products to client profile.");          
    Log.Message("Select Clients module, search for client " + clientNumber + " and open Client Info."); 
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    
    Log.Message("Select Products & Services tab.");
    Get_WinDetailedInfo_TabProductsAndServices().Click();
    Get_WinDetailedInfo_TabProductsAndServices().WaitProperty("IsSelected", "True", 30000);
    
    Log.Message("Configure 2 products for client.");
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
    Get_WinProductSetup_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
    Get_WinProductSetup_ChkProduct( "Obl. corporatives", "Bonds-Corporate").set_IsChecked(true);
    Get_WinProductSetup_BtnOK().Click();
    
    Log.Message("Select the 2 newly added Products for the client."); 
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(true);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate").set_IsChecked(true);
    
    Log.Message("Validate the 2 Products are present for the client.");    
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible"),"IsChecked", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate"),"IsChecked", cmpEqual, true)
    
    Log.PopLogFolder();
    Log.AppendFolder("Add Services to client profile.");
    Log.Message("Configure 2 Services for client.");
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
    Get_WinServiceSetup_ChkService("Séminaires", "Seminars").set_IsChecked(true);
    Get_WinServiceSetup_ChkService("Recherches", "Research").set_IsChecked(true);
    Get_WinServiceSetup_BtnOK().Click();
    
    Log.Message("Select the 2 newly added Services for the client.");
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").WaitProperty("VisibleOnScreen", "True", 30000);
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").set_IsChecked(true);
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research").set_IsChecked(true);

    Log.Message("Validate the 2 Services are present for the client.");     
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars"),"IsChecked", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"VisibleOnScreen", cmpEqual, true)
    aqObject.CheckProperty(Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research"),"IsChecked", cmpEqual, true)

    Log.PopLogFolder();
    Log.AppendFolder("Restore default configuration.");         
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(false);
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_ChkProduct("Obl. corporatives", "Bonds-Corporate").set_IsChecked(false);
    
    Get_WinDetailedInfo_TabProductsAndServices_GrpProducts_BtnSetup().Click();
    Get_WinProductSetup_ChkProduct("Obl. convertibles", "Bonds-Convertible").set_IsChecked(false);
    Get_WinProductSetup_ChkProduct( "Obl. corporatives", "Bonds-Corporate").set_IsChecked(false);
    Get_WinProductSetup_BtnOK().Click();

    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Séminaires", "Seminars").set_IsChecked(false);
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_ChkService("Recherches", "Research").set_IsChecked(false);
        
    Get_WinDetailedInfo_TabProductsAndServices_GrpServices_BtnSetup().Click();
    Get_WinServiceSetup_ChkService("Séminaires", "Seminars").set_IsChecked(false);
    Get_WinServiceSetup_ChkService("Recherches", "Research").set_IsChecked(false);
    Get_WinServiceSetup_BtnOK().Click();
    
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 15000);
    Get_WinDetailedInfo_BtnOK().Click();    
    Log.PopLogFolder();

    Log.PopLogFolder();
    Log.PopLogFolder();
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 1: Croes-4322 - Validation of Client Products & Services.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 1: Croes-4322 - Validation of Client Products & Services.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }
            
    /************************************************ Étape 2 : Client Profile Management ***************************************************************/
    Log.AppendFolder("Étape 2: Croes-4292 - Client Profile Management.", "", pmNormal, boldAttribute);
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-4292", "Cas de test TestLink: Croes-4292");  
    /****************************************************************************************************************************************************/
    var profilLangue = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil1", language + client);
    var profilEmployeur = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil2", language + client);
    var profilRevenuBrut = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil3", language + client);
    var profilProfession = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Profil4", language + client);
    var GroupBoxDefaut = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "GroupBoxDefaut", language + client);
    var TextBoxEmployeur = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TextBoxEmployeur", language + client);
    var ValeurRevenu = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ValeurRevenu", language + client);
    var ComboLangue = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "ComboLangue", language + client);
    var TabProfilText = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "TabProfilText", language + client);

    Log.AppendFolder("Setup.");
    Log.AppendFolder("Add Products to client profile.");          
    Log.Message("Select Clients module, search for client " + clientNumber + " and open Client Info."); 
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
        
    Log.Message("Select Profile tab.");
    Get_WinDetailedInfo_TabProfile().Click();
    WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false);
   
    Log.Message("Select 3 profiles for client and save.");
    Get_WinInfo_TabProfile_BtnSetup().Click();
    WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94"); 
    
    var profilLang = Get_WinVisibleProfilesConfiguration_ChkProfile(profilLangue);
    
    if (profilLang.get_IsChecked() == false)
    {
      profilLang.Click(); 
    }
 
    Get_WinVisibleProfilesConfiguration().Find("Value", profilLangue, 10).WaitProperty("IsChecked", true, 10000);
   
    var profilEmpl = Get_WinVisibleProfilesConfiguration_ChkProfile(profilEmployeur)
    
    if (profilEmpl.get_IsChecked() == false)
    {
      profilEmpl.Click();  
    }
    
    Get_WinVisibleProfilesConfiguration().Find("Value", profilEmployeur, 10).WaitProperty("IsChecked", true, 10000);
   
    var profilRevenu = Get_WinVisibleProfilesConfiguration_ChkProfile(profilRevenuBrut)
    
    if (profilRevenu.get_IsChecked() == false)
    {
      profilRevenu.Click();   
    }
         
    Get_WinVisibleProfilesConfiguration().Find("Value", profilRevenuBrut, 10).WaitProperty("IsChecked", true, 10000);
   
    Get_WinVisibleProfilesConfiguration_BtnSave().WaitProperty("IsEnabled", true, 15000);  
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
   
    Log.Message("Fill the newly added profiles with data.");
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).set_IsExpanded(true);
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys(TextBoxEmployeur);
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Keys(ValeurRevenu);
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
    Get_SubMenus().FindChild("WPFControlText", ComboLangue , 10).Click();
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(10000);
   
    Log.Message("Add a fourth profile to the client.");
    Get_WinInfo_TabProfile_BtnSetup().Click();
    WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
    
    var profilProf = Get_WinVisibleProfilesConfiguration_ChkProfile(profilProfession);

    if (profilProf.get_IsChecked() == false)
    {
        profilProf.Click();  
    }

    Get_WinVisibleProfilesConfiguration().Find("Value", profilProfession, 10).WaitProperty("IsChecked", true, 10000);
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    Get_WinDetailedInfo_BtnApply().Click();
    
    Log.Message("Valider l'affichage du profil ajouté");
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).set_IsExpanded(true);
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profilProfession], 10),"Exists", cmpEqual, true)
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profilProfession], 10),"VisibleOnScreen", cmpEqual, true)

    Log.Message("Cocher masquer les champs vides et valider que le champ vide ajouté est masqué");
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().Click();
    aqObject.CheckProperty(Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", profilProfession], 10),"VisibleOnScreen", cmpEqual, false)
    
    Log.Message("Rétablir la Configuration initiale");
    Get_WinInfo_TabProfile_ChkHideEmptyProfiles().set_IsChecked(false); 
    Get_WinInfo_TabProfile_BtnSetup().Click();
    WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
    
    Get_WinVisibleProfilesConfiguration_ChkProfile(profilProfession).Click(); 
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    Get_WinDetailedInfo_BtnApply().Click();
    
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).set_IsExpanded(true);
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["TextBox", 1], 10).Keys("^a[BS]");
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ComboBox", 1], 10).Click();
    Get_SubMenus().FindChild("WPFControlText","", 10).Click();
    Get_WinInfo_TabProfile_ItemControl().FindChild(["ClrClassName", "WPFControlText"], ["Expander", GroupBoxDefaut]).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DoubleTextBox", 1], 10).Clear();
 
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnOK().Click(); 
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
   
   
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabProfile().Click();
    WaitObject(Get_CroesusApp(), ["WPFControlText", "VisibleOnScreen", "IsSelected"], [TabProfilText, true, true]);
   
    Get_WinInfo_TabProfile_BtnSetup().Click();
    WaitObject(Get_CroesusApp(),"Uid","VisibleProfilConfigurationWindow_0c94");
    
    Get_WinVisibleProfilesConfiguration_ChkProfile(profilLangue).Click();  
    Get_WinVisibleProfilesConfiguration().Find("Value",profilLangue,10).WaitProperty("IsChecked", false, 10000);
   
    Get_WinVisibleProfilesConfiguration_ChkProfile(profilEmployeur).Click();    
    Get_WinVisibleProfilesConfiguration().Find("Value",profilEmployeur,10).WaitProperty("IsChecked", false, 10000);
    
    Get_WinVisibleProfilesConfiguration_ChkProfile(profilRevenuBrut).Click();   
    Get_WinVisibleProfilesConfiguration().Find("Value",profilRevenuBrut,10).WaitProperty("IsChecked", false, 10000);
        
    Get_WinVisibleProfilesConfiguration_BtnSave().Click();
    Delay(10000);
    Get_WinDetailedInfo_BtnApply().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnApply().Click();
    Delay(10000);
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnOK().Click();
    
    Log.PopLogFolder();
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 2: Croes-4292 - Client Profile Management.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 2: Croes-4292 - Client Profile Management.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }    
        
    /****************************************** Étape 3 : Validation of various document types in Clients module *****************************************/
    Log.AppendFolder("Étape 3: Croes-6267 - Validation of various document types in Clients module.", "", pmNormal, boldAttribute);
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6267", "Cas de test TestLink: Croes-6267");  
    /*****************************************************************************************************************************************************/
    var documentPDF = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile1_PDF", language + client);       
    var documentDOCX = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_DOC", language + client);
    var documentPPTX = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_PPt", language + client);
    var documentXLSX = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NameFile_XLS", language + client);
    var reportName = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Report_Name", language + client);
    var commentaire = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Comments_6267", language + client);
    var reportNameEval = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Report_Name_Evaluation", language + client);

    Log.AppendFolder("Setup.");        
    Log.Message("Select Clients module, search for client " + clientNumber + " and open Client Info."); 
    Get_ModulesBar_BtnClients().Click();    
    Get_MainWindow().Maximize();
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
        
    Log.Message("Select the Documents tab.");
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
             
    AddFilesToDocument(documentPDF);    
    AddFilesToDocument(documentDOCX);
    AddFilesToDocument(documentPPTX); 
    AddFilesToDocument(documentXLSX);

    Log.Message("Validate that all 4 document types are present in client Documents tab.");
    CheckVisibFilDocuments(documentPDF);
    CheckVisibFilDocuments(documentDOCX);
    CheckVisibFilDocuments(documentPPTX);
    CheckVisibFilDocuments(documentXLSX);
 
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnOK().Click();
    Delay(15000);
    
    Search_Client(clientNumber);
    Get_Toolbar_BtnReportsAndGraphs().Click();
    WaitReportsWindow();
    
    Log.Message("Select report 'Évaluation du portefeuille (simple)' and select 'Archiver les rapports'.");
    SelectAReport(reportNameEval);
    Get_WinReports_GrpOptions_ChkArchiveReports().Click();

    Log.Message("Validate the report.");
    ValidateReport();  
    WaitObject(Get_CroesusApp(), "Uid", "CRMDataGrid_3071", 2000);
     
    Search_Client(clientNumber);
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).Click();
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", clientNumber, 10).DblClick();
    
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_PersonalDocuments_Toolbar_BtnRefresh().Click();
    Get_PersonalDocuments_LstDocuments().WaitProperty("VisibleOnScreen", true, 3000);
    
    Log.Message("Validate that the report was added to client profile.");
    CheckVisibFilDocuments(reportName);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire);

    Log.Message("Display only PDF files.");
    Get_PersonalDocuments_TvwDocumentsForClientAndModel().FindChild(["ClrClassName", "WPFControlText"], ["TextBlock", "TRXIONS FONDS CI"], 10).Click();
    Get_PersonalDocuments_Toolbar_BtnFilterPdf().Click();
    
    Log.Message("Validate the 2 PDF documents.");
    Get_PersonalDocuments_LstDocuments().WaitProperty("VisibleOnScreen", true, 3000);
    CheckVisibFilDocuments(reportName, true);
    CheckVisibFilDocuments(documentPDF, true);
    CheckVisibFilDocuments(documentDOCX, false);
    CheckVisibFilDocuments(documentPPTX, false); 
    CheckVisibFilDocuments(documentXLSX, false);

    Log.Message("Validate that DOCX, PPTX, and XLSX files are displayed when selecting other file types.");
    Get_PersonalDocuments_Toolbar_BtnFilterFile().Click();
    CheckVisibFilDocuments(reportName, false);
    CheckVisibFilDocuments(documentPDF, false);
    CheckVisibFilDocuments(documentDOCX, true);
    CheckVisibFilDocuments(documentPPTX, true);
    CheckVisibFilDocuments(documentXLSX, true);
    
    Log.Message("Delete the added documents.");
    Get_PersonalDocuments_Toolbar_BtnFilterAll().Click();
    deleteFileDocument(reportName);
    deleteFileDocument(documentPDF);
    deleteFileDocument(documentDOCX);
    deleteFileDocument(documentPPTX);
    deleteFileDocument(documentXLSX);

    Log.PopLogFolder();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 3: Croes-6267 - Validation of various document types in Clients module.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 3: Croes-6267 - Validation of various document types in Clients module.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }  
       
    /******************************************* Étape 4 : Validate document archiving and comment management. ******************************************/
    Log.AppendFolder("Étape 4: Croes-6264 - Validate document archiving and comment management.", "", pmNormal, boldAttribute);
    Log.Link("https://jira.croesus.com/testlink/linkto.php?tprojectPrefix=Croes&item=testcase&id=Croes-6264", "Cas de test TestLink: Croes-6264");  
    /****************************************************************************************************************************************************/
    var commentaire6264 = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "Comments", language + client);
    var commentaireModifie = ReadDataFromExcelByRowIDColumnID(filePath_Clients, "Regression", "NewComments", language + client);
    
    Log.Message("Ajouter un fichier et inscrire un commentaire");
    Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_WinAddAFile_GrpFile_BtnBrowse().Click();
    var FilePath = folderPath_Data + documentDOCX;
    Get_DlgOpen_CmbFileName().Keys(FilePath)
    Get_DlgOpen_BtnOpen().Click();
    Get_WinAddAFile_GrpComments_TxtComments().Keys(commentaire6264)
    Get_WinAddAFile_BtnOK().Click();
    
    Log.Message("Valider que le document Word et le commentaire ont été ajoutés");
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments_ItemTopDocument().DataContext.Metadata.Filename, "OleValue", cmpEqual, documentDOCX);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaire6264)
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnOK().Click();
    
    Log.Message("Modifier le commentaire dans la séction Commentaires et sauvgarder");
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    Get_PersonalDocuments_GrpComments_BtnEdit().Click();
    Get_PersonalDocuments_GrpComments_TxtComment().Clear();
    Get_PersonalDocuments_GrpComments_TxtComment().Keys(commentaireModifie);
    Get_PersonalDocuments_GrpComments_BtnSave().Click();
    
    Log.Message("Valider l'affichage du nouveau commentaire");
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment(), "Text", cmpEqual, commentaireModifie)
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"Exists", cmpEqual, true);
    aqObject.CheckProperty(Get_PersonalDocuments_GrpComments_TxtComment().Find("Text", commentaireModifie, 10),"VisibleOnScreen", cmpEqual, true);
    Get_WinDetailedInfo_BtnOK().Click();
    
    Log.Message("Supprimer le document ajouté");
    Search_Client(clientNumber);
    Get_ClientsBar_BtnInfo().Click();
    Get_WinDetailedInfo_TabDocuments().Click();
    Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
    deleteFileDocument(documentDOCX);
    
    Log.Message("Valider que le document n'est plus affiché");
    aqObject.CheckProperty(Get_PersonalDocuments_LstDocuments().Find("Text",documentDOCX,10), "Exists", cmpEqual, false);
    Get_WinDetailedInfo_BtnApply().Click();
    Get_WinDetailedInfo_BtnOK().WaitProperty("IsEnabled", true, 10000);
    Get_WinDetailedInfo_BtnOK().Click();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;
    var errorsStep = errorCountAfterExecution - errorCountBeforeExecution;    
    if (errorsStep == 0)
    {
      Log.Checkpoint("***** 'Étape 4 : Validate document archiving and comment management.' completed successfully with " + errorsStep + " errors.");
    }
    else
    {
      Log.Error("***** 'Étape 4 : Validate document archiving and comment management.' completed with " + errorsStep + " errors.");
      errorCountAfterExecution = --errorCountAfterExecution;
    }  
  }
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
  
  finally
  {
    Log.AppendFolder("Restore default configuration.");
    Log.AppendFolder("Close and terminate Croesus.");
    Close_Croesus_X();
    Terminate_CroesusProcess();
    Log.PopLogFolder();
    Log.AppendFolder("Close and terminate Acrobar Reader.");    
    TerminateAcrobatProcess();//2021-12-24: MAJ par Christophe Paring pour fermer le processus Acrobat, qu'il soit 64 bits ou 32 bits
    
    Log.PopLogFolder();
    Log.PopLogFolder();
    
    errorCountAfterExecution = Log.ErrCount;    
    if (errorCountAfterExecution == 0)
    {
      Log.Checkpoint("***** Execution of script '" + functionName + "' completed successfully with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute);
    }
    else
    {
      Log.Error("***** Execution of script '" + functionName + "' completed with " + errorCountAfterExecution + " errors.", "", pmNormal, boldAttribute, Sys.Process("TestComplete"));
    }          
  }   
} 

function AddFilesToDocument(FileName)
{
  var FilePath = folderPath_Data + FileName;
  
  Log.Message("Ajouter le fichier: " + FileName);  
  Get_PersonalDocuments_Toolbar_BtnAddAFile().Click();
  Get_WinDetailedInfo_TabDocuments().WaitProperty("IsSelected", true, 30000);
  Get_WinAddAFile_GrpFile_BtnBrowse().Click();
  Get_DlgOpen_CmbFileName().Keys(FilePath);
  Get_DlgOpen_BtnOpen().Click();
  Get_WinAddAFile_BtnOK().Click();
}

function deleteFileDocument(FileName)
{
  Get_PersonalDocuments_LstDocuments().Find("Text", FileName, 10).Click();
  Get_PersonalDocuments_Toolbar_BtnRemove().Click();
  Get_DlgConfirmation_BtnDelete().Click();
}

function CheckVisibFilDocuments(FileName, mustExist)
{
  var existFile = Get_PersonalDocuments_LstDocuments().Find("Text", FileName, 10).Exists;
          
  if (existFile)
  {
     var visibleFile = Get_PersonalDocuments_LstDocuments().Find("Text", FileName, 10).VisibleOnScreen;
             
     if (visibleFile == true && (mustExist == true || mustExist == undefined))
     {
      Log.Checkpoint(FileName + ": Le fichier existe et il est visible a l'écran ");  
     }       
  }
  else
  {
    if (mustExist == false)
    {
      Log.Checkpoint(FileName + ": Le fichier ne s'affiche pas a l'écran.");  
    }  
    else
    {
      Log.Message("Jira CROES-12273");
      Log.Error(FileName + ": Le fichier n'existe pas et il est pas visible a l'écran ");
    } 
  } 
}

function GetCroesusBuildVersion()
{
  var croesusBuildVersion = "";
  var propertiesArray = ["ClrClassName", "WPFControlOrdinalNo"];
  var valuesArray = ["TextBlock", 7];

  Sys.Process("CroesusClient").WPFObject("HwndSource: MainWindow").SetFocus();
  Get_MenuBar().FindChild("Uid", "CustomizableMenu_3049", 10).Click();  
  Get_SubMenus().FindChild("Uid", "CFMenuItem_cf20", 10).Click();
  croesusBuildVersion = Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").WPFObject("AboutWin").FindChild(propertiesArray, valuesArray, 10).WPFControlText;
  Sys.Process("CroesusClient").WPFObject("HwndSource: AboutWin").Click();

  return (croesusBuildVersion);  
}