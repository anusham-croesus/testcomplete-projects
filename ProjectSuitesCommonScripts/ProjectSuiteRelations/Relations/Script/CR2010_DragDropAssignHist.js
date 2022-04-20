//USEUNIT Common_functions
//USEUNIT Common_Get_functions
//USEUNIT Global_variables
//USEUNIT Clients_Get_functions
//USEUNIT DBA

function CR2010_DragDropAssignHist()
{
  try
  {
    var usernameKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "username");
    var passwordKeynej = ReadDataFromExcelByRowIDColumnID(filePath_ExecutionVServers, "USER", "KEYNEJ", "psw");
    var NewRel01 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "NewRel01", language+client);
    var NewRel02 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "NewRel02", language+client);
    var GroupedRelationName = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "GroupedRelationName", language+client);
    var accountNumber800203RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800203RE", language+client);
    var accountNumber800204FS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204FS", language+client);
    var accountNumber800204JW = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204JW", language+client);
    var accountNumber800204NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204NA", language+client);
    var accountNumber800204OB = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800204OB", language+client);      
    var accountNumber800212RE = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800212RE", language+client);
    var accountNumber800213NA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "accountNumber800213NA", language+client);
    var clientNameZA = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "clientNameZA", language+client);
    var clientNumber800203 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client);
    var clientNumber800204 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);
    var ShortNameCli = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010","ShortNameCli", language+client);                                 
    var detenteur800203 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800203", language+client);
    var detenteur800204 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "detenteur800204", language+client);      
    var positionNBC100 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "positionNBC100", language+client)
    var positionK77743 = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "positionK77743", language+client)                                 
    var ModelCHBONDS = ReadDataFromExcelByRowIDColumnID(filePath_Relations, "CR2010", "ModelCHBONDS", language+client);      

    // Login dans Croesus
    Log.AppendFolder("Login dans Croesus Advisor avec l'usagé " + usernameKeynej + ".");
    Login(vServerRelations, usernameKeynej, passwordKeynej, language);
    Log.PopLogFolder();
    
    // Cas de test CROES-6632 - Maillage des assignés du module Relations vers le module Relations
    Log.AppendFolder("Cas de test CROES-6632 - Maillage des assignés du module Relations vers le module Relations.");

    // Étape 1
    Log.AppendFolder("Étape 1: Dans l'arborescence de la Relation REL01, mailler le Compte 800203-RE de la section 'Comptes' vers le module Relations.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);    
    Select_NewRel01(NewRel01);
      
    if (Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded() == 0)
    {
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
    }
      
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnRelationships());          
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();
              
    // Étape 2
    Log.AppendFolder("Étape 2: Dans l'arborescence de la Relation REL01, mailler le Compte 800204-FS de la section 'Hist. Comptes' vers le module Relations.");
    Select_NewRel01(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();
               
    // Étape 3               
    Log.AppendFolder("Étape 3: Dans l'arborescence de la Relation REL01, exploser le Compte 800204-FS de la section 'Hist. Comptes' et mailler le Détenteur 800204 vers le module Relations.");               
    Select_NewRel01(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();
                                 
    //Étape 4               
    Log.AppendFolder("Étape 4: Dans l'arborescence de la Relation REL01, sélectionner le Détenteur 800203 du Compte 800203-RE de la section 'Comptes' sous 'Rel. Groupées' et 'Relations' et mailler vers le module Relations.");
    Select_NewRel01(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGridDataRecordPresenter1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800203, 30).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800203, 30), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();
                                
    //Étape 5
    Log.AppendFolder("Étape 5: Dans l'arborescence de la Relation REL01, sélectionner le Compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.");                
    Select_NewRel01(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails().zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").MouseWheel(-1)                
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Refresh();          
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Value", accountNumber800204FS,10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Value", accountNumber800204FS,10), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();               
                
    //Étape 6
    Log.AppendFolder("Étape 6: Dans l'arborescence de la Relation REL01, sélectionner le Détenteur 800204 du Compte 800204-FS de la section 'Hist. Comptes' sous 'Rel. Group.' et 'Relations' et mailler vers le module Relations.");
    Select_NewRel01(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails().zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").MouseWheel(-1) 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Refresh();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGridDataRecordPresenter1().set_IsExpanded(true);     
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Text", detenteur800204, 100).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild("Text", detenteur800204, 100), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);             
    Log.PopLogFolder();
    Log.PopLogFolder();                

    // Cas de test CROES-6634 - Maillage des assignés du module Relations vers les modules Clients, Comptes, Modèles, Portefeuille, Transaction et Titres
    Log.AppendFolder("Cas de test CROES-6634 - Maillage des assignés du module Relations vers les modules Clients, Comptes, Modèles, Portefeuille, Transaction et Titres.");

    // Étape 1
    Log.AppendFolder("Étape 1: Dans l'arborescence de la Relation REL01, mailler le Compte 800203-RE de la section 'Comptes' vers le module Clients.");                       
    Select_NewRel01_02(NewRel01);
    
    if (Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().get_IsExpanded() == 0)
    {
      Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01().set_IsExpanded(true);
    }
    
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 100), Get_ModulesBar_BtnClients());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNumber800203);
    Log.PopLogFolder();
                                     
    // Étape 2
    Log.AppendFolder("Étape 2: Dans l'arborescence de la Relation REL01, mailler le Compte 800204-FS de la section 'Hist. Comptes' vers le module Clients.");               
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnClients());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNumber800204);
    Log.PopLogFolder();
                             
    // Étape 3
    Log.AppendFolder("Étape 3: Dans l'arborescence de la Relation REL01, exploser le Compte 800204-FS dans la section 'Hist. Comptes' et mailler le Détenteur 800204 vers le module Clients.");              
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte().WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnClients());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNumber800204);
    Log.PopLogFolder();
                               
    // Étape 4
    Log.AppendFolder("Étape 4: Dans l'arborescence de la Relation REL01, sélectionner les Comptes 800203-RE et 800204-FS et mailler vers le module Clients.");                    
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);     
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800203RE, 30), Get_ModulesBar_BtnClients()); 
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "ClientNumber", cmpEqual, clientNumber800203);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "ClientNumber", cmpEqual, clientNumber800204);
    Log.PopLogFolder();
                           
    // Étape 5
    Log.AppendFolder("Étape 5: Dans l'arborescence de la Relation REL01, mailler le Compte 800204-FS de la section 'Hist. Comptes' vers le module Comptes.");
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 10), Get_ModulesBar_BtnAccounts());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
    Log.PopLogFolder();

    // Étape 6
    Log.AppendFolder("Étape 6: Dans l'arborescence de la Relation REL01, exploser le Compte 800204-FS dans la section 'Hist. Comptes' et mailler le Détenteur 800204 vers le module Comptes.");                                  
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Click(40,100);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", detenteur800204, 30), Get_ModulesBar_BtnAccounts());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "AccountNumber", cmpEqual, accountNumber800204JW);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(2).DataItem, "AccountNumber", cmpEqual, accountNumber800204NA);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(3).DataItem, "AccountNumber", cmpEqual, accountNumber800204OB);
    Log.PopLogFolder();
                
    // Étape 7                
    Log.AppendFolder("Étape 7: Dans l'arborescence de la Relation REL01, sélectionner le Compte 800204-FS et mailler vers le module Modèles.");                
    Select_NewRel01_02(NewRel01);                 
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10), Get_ModulesBar_BtnModels());
    aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items.Item(0).DataItem, "Name", cmpEqual, ModelCHBONDS);
    Log.PopLogFolder();
                
    // Étape 8
    Log.AppendFolder("Étape 8: Dans l'arborescence de la Relation REL01, sélectionner le Compte 800204-FS et mailler vers le module Portefeuillle.");      
    Select_NewRel01_02(NewRel01);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10), Get_ModulesBar_BtnPortfolio());
    
    var numberPostions = Get_Portfolio_PositionsGrid().Items.Count;  
    
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items,"Count", cmpGreater, 0); 
    
    if (numberPostions > 0)
    {
      Log.Checkpoint("La grille du module Portefeuille n'est pas vide."); 
    }
    else
    {
      Log.Error("La grille du module Portefeuille est vide."); 
    }
                      
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(0).DataItem, "ClientShortName", cmpEqual, clientNameZA);
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(1).DataItem, "Symbol", cmpEqual, positionNBC100);
    aqObject.CheckProperty(Get_Portfolio_PositionsGrid().Items.Item(2).DataItem, "Symbol", cmpEqual, positionK77743);
    Log.PopLogFolder();
 
    //  Étape 9
    Log.AppendFolder("Étape 9: Dans l'arborescence de la Relation REL01, sélectionner les Comptes 800203-RE et 800204-FS et mailler vers le module Transactions.");       
    Select_NewRel01_02(NewRel01);                  
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100),Get_ModulesBar_BtnTransactions());                  
    
    var numberTransactions = Get_TransactionGridListView().Items.Count;
               
    if (numberTransactions > 0)
    {
      Log.Checkpoint("La grille du module Transactions n'est pas vide.");
    }
    else
    {
      Log.Error("La grille du module Transactions est vide.") 
    }
    
    Log.PopLogFolder();
                  
    // Étape 10               
    Log.AppendFolder("Étape 10: Dans l'arborescence de la Relation REL01, sélectionner les Comptes 800203-RE et 800204-FS et mailler vers le module Titres.");                                          
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);
    Select_NewRel01_02(NewRel01);                   
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800204FS, 10).Click(-1, -1, skCtrl);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100).Click(-1, -1, skCtrl);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Value", accountNumber800203RE, 100),Get_ModulesBar_BtnSecurities());               
    
    var numberTitres = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count;
              
    Log.Message(numberTitres); 
    aqObject.CheckProperty(Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items,"Count", cmpGreater, 0);
    
    if (numberTitres > 0)
    {
      Log.Checkpoint("La grille du module Titres n'est pas vide.");
    }
    else
    {
      Log.Error("La grille du module Titres est vide.");
    }
    
    Log.PopLogFolder();
    Log.PopLogFolder();    

    // Cas de test CROES-6635 - Maillage des Relations de la grille du module Relations vers le module Clients
    Log.AppendFolder("Cas de test CROES-6635 - Maillage des Relations de la grille du module Relations vers les modules Relations et Clients.");

    // Étape 1
    Log.AppendFolder("Étape 1: Dans la grille du module Relations, sélectionner la Relation " + NewRel01 + " et mailler vers le module Clients.");
    Get_ModulesBar_BtnRelationships().Click();
    Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);    
    Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10).Click();
    WaitUntilObjectDisappears(Get_CroesusApp(),"Uid","QuickSearchWindow_b326");
    
    var dragSource = Get_RelationshipsClientsAccountsGrid().FindChild("Value", NewRel01, 10);
    var dragDestination = Get_ModulesBar_BtnClients();
    
    Drag(dragSource, dragDestination);
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
    Log.Message("La grille du module Clients affiche les clients  " +  clientNumber800203 + " et "  + clientNumber800204);
       
    var numberClients = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
    
    Log.Message("Nombre de Clients dans la grille du module Clients: " + numberClients);

    for (i = 0; i < numberClients; i++)
    {
      var ClientsRes = Get_RelationshipsClientsAccountsGrid().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.ClientNumber;
      
      Log.Checkpoint("La grille du module Clients affiche les Clients: " + ClientsRes);
    }
    
    Log.PopLogFolder();
    Log.PopLogFolder();

    // Cas de test CROES-6637 - Maillage des assignés du module Clients vers le module Relations
    Log.AppendFolder("Cas de test CROES-6635 - Maillage des assignés du module Clients vers le module Relations.");              
               
    // Étape 1               
    Log.AppendFolder("Étape 1: Dans l'arborescence du module Clients, sélectionner le détenteur 800204  dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Relations.");  
    Select_Client800203(detenteur800203);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10), Get_ModulesBar_BtnRelationships());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "FullName", cmpEqual, GroupedRelationName);
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(1).DataItem, "FullName", cmpEqual, NewRel01);
    Log.PopLogFolder();
    Log.PopLogFolder();
     
    // Cas de test CROES-6638 - Maillage des assignés du module Clients vers les modules Comptes, Modèles, Transactions et Titres
    Log.AppendFolder("Cas de test CROES-6638 - Maillage des assignés du module Clients vers les modules Comptes, Modèles, Transactions et Titres.");                
              
    // Étape 1               
    Log.AppendFolder("Étape 1: Dans l'arborescence du Client 800203, sélectionner le Compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Modèles.");                
    Select_Client(detenteur800203);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnModels());
    aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items.Item(0).DataItem, "Name", cmpEqual, ModelCHBONDS);
    Log.PopLogFolder();  

    // Étape 2               
    Log.AppendFolder("Étape 2: Dans l'arborescence du module Clients, sélectionner le Détenteur 800204 dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Modèles.");                             
    Select_Client(detenteur800203);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().set_IsExpanded(true);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10).Click();
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid().FindChild("Text", detenteur800204, 10), Get_ModulesBar_BtnModels());
                                             
    var numberModels = Get_ModelsGrid().RecordListControl.Items.Count;                
    
    aqObject.CheckProperty(Get_ModelsGrid().RecordListControl.Items ,"Count", cmpEqual, 0)
    
    if (numberModels == 0)
    {
      Log.Checkpoint("La grille du module Modèles est vide.");  
    }
    else
    {
      Log.Error("La grille du module Modèles n'est pas vide.");
    }
    
    Log.PopLogFolder();
                  
    // Étape 3
    Log.AppendFolder("Étape 3: Dans l'arborescence du Client 800203, sélectionner le Détenteur 800204 du Compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Transactions.");       
    Select_Client(detenteur800203);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnTransactions());
              
    var numberTransactions = Get_TransactionGridListView().Items.Count;
    
    if (numberTransactions > 0)
    {
      Log.Checkpoint("La grille du module Transactions n'est pas vide.");
    }
    else
    {
      Log.Error("La grille du module Transactions est vide.");     
    }
    
    Log.PopLogFolder();  

    // Étape 4
    Log.AppendFolder("Étape 4: Dans l'arborescence du Client 800203, sélectionner le Compte 800204-FS dans la section 'Hist. Comptes' sous 'Relations' et mailler vers le module Titres.");       
    Get_ModulesBar_BtnClients().Click();
    Select_Client(detenteur800203);               
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().set_IsExpanded(true);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnSecurities());
                                             
    var numberTitres = Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items.Count;
              
    Log.Message("Nombre de Titres dans la grille du module Titres: " + numberTitres); 
    aqObject.CheckProperty(Get_TransactionsPlugin().FindChild(["ClrClassName","WPFControlOrdinalNo"],["RecordListControl","1"],10).Items,"Count", cmpGreater, 0);
    
    if (numberTitres > 0)
    {
      Log.Checkpoint("La grille du module Titres n'est pas vide.");
    }
    else
    {
      Log.Error("La grille du module Titres est vide.");            
    }
    
    Log.PopLogFolder();   

    // Étape 5           
    Log.AppendFolder("Étape 5: Dans l'arborescence du Client 800204, sélectionner le Compte 800204-FS dans la section 'Hist. Comptes' sous 'Relation groupées' et mailler vers le module Comptes.");                 
    Select_Client(detenteur800204);
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelationDatarecord().set_IsExpanded(true);
    Drag(Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild("Text", accountNumber800204FS, 100), Get_ModulesBar_BtnAccounts());
    aqObject.CheckProperty(Get_RelationshipsClientsAccountsGrid().RecordListControl.Items.Item(0).DataItem, "AccountNumber", cmpEqual, accountNumber800204FS);
    Log.PopLogFolder();
    Log.PopLogFolder();

    // Cas de test CROES-6640 - Maillage des assignés de l'arborescence du module Comptes vers les modules Modèles, Portefeuille, Transactions
    Log.AppendFolder("Cas de test CROES-6640 - Maillage des assignés de l'arborescence du module Comptes vers les modules Modèles, Portefeuille, Transactions.");

    // Étape 1
    Log.AppendFolder("Étape 1: Dans l'arborescence du module Comptes, sélectionner la Relation REL01 de la section 'Hist. Relations' et mailler vers le module Modèles."); 
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsGrid().Find("Value", accountNumber800204FS, 10 ).Click();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value", NewRel01, 10).Click();
    
    var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value", NewRel01, 10);
    var dragDestinationMod = Get_ModulesBar_BtnModels();
    
    Drag(dragSource, dragDestinationMod);
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
    
    var CountMod = Get_ModelsGrid().WPFObject("RecordListControl", "", 1).Items.get_Count();
    var i= "0";
       
    if (CountMod == i)
    {
      Log.Checkpoint("La grille du module Modèle est vide.");
    }
    else 
    {
      Log.Error("La grille du module Modèles n'est pas vide.");
    }
    
    Log.PopLogFolder();
  
    // Étape 2
    Log.AppendFolder("Étape 2: Dans l'arborescence du module Comptes, sélectionner la Relation REL01 de la section 'Hist. Relations' et mailler vers le module Portefeuille.");        
    Get_ModulesBar_BtnAccounts().Click();
    Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value", NewRel01, 10).Click();
    WaitObject(Get_CroesusApp(),"Uid", "CRMDataGrid_3071", 1000);
    
    var dragDestinationModPort = Get_ModulesBar_BtnPortfolio();
    
    Drag(dragSource, dragDestinationModPort);
                
    var CountPortRel1 = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Get_Count();
      
    for (i = 0; i < CountPortRel1; i++)
    {     
      AccountNo = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.AccountNumber;
      position = Get_Models_Details_TabPositions_DgPosition().WPFObject("RecordListControl", "", 1).Items.Item(i).DataItem.Symbol;
                
      if (AccountNo == accountNumber800203RE)
      {
        Log.Checkpoint("La grille du module Portefeuille affiche la position: " + position);
      }
      else 
      {
        Log.Error("Le résultat n'est pas l'attendue");
      }
    }
    
    Log.PopLogFolder();    

    // Étape 3
    Log.AppendFolder("Étape 3: Dans l'arborescence du module Comptes, sélectionner la Relation REL01 de la section 'Hist. Relations' et mailler vers le module Transactions.");    
    Get_ModulesBar_BtnAccounts().Click();
    
    var dragSource = Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().Find("Value",NewRel01,10);   
    var dragDestinationModTran = Get_ModulesBar_BtnTransactions();
    
    Drag(dragSource, dragDestinationModTran);

    var CountTransRel1 = VarToInt(Get_Transactions_ListView().Items.Count);
    
    Log.Checkpoint("La grille du module Transactions affiche toutes les transactions de la relation REL01. Il y a " + CountTransRel1 + " Transactions totales.");
    Log.PopLogFolder();
    Log.PopLogFolder();         
  }
  
  catch(e)
  {
    Log.Error("Exception: " + e.message, VarToStr(e.stack));
  }
    
  finally 
  {
    Log.AppendFolder("Restauration de l'environment."); 
    Terminate_CroesusProcess();
    Log.PopLogFolder();
  }
}

// Fonction qui selectionne la relation NewRel01 dans le module Relations
function Select_NewRel01(NewRel01)
{   
  Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  SearchRelationshipByName(NewRel01);
  Get_RelationshipsClientsAccountsGrid().FindChild("Text", NewRel01, 10).Click();
}

// Fonction qui permets d'accéder à la grille Relations Groupées sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouper()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 3], 10);    
}

// Fonction qui permets d'accéder à la grille Histo. Compte sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoCompte()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10);    
}
 
// Fonction qui permets d'accéder à la première Relation Groupée de la grille Relations Groupées sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1()
{ 
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouper().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder à la première Relation de la grille Relations qui se trouve dans la grille Relations Groupées sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder à la grille Comptes dans la grille Relations qui se trouve dans la grille Relations Groupées sous details de la Relation
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGrid()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationDataRecordPresenter1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder au premier Compte de la grille Compte dans la grille Relations qui se trouve dans la grille Relations Groupées sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGridDataRecordPresenter1()
{    
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationAccoountGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder à la grille Histo. Compte dans la grille Relations qui se trouve dans la grille Relations Groupées sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperExpandableFieldRecordPresenterSchroll().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10);
}

// Fonction qui permets d'accéder au premier compte de la grille Histo. Compte dans la grille Relations qui se trouve dans la grille Relations Groupées sous details de la Relation  
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGridDataRecordPresenter1()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperRelationHistoCompteGrid().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder à la grille Relation groupées sous details de la Relation aprés le scroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperschroll()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10);    
}

// Fonction qui permets d'accéder à la premiere Relation Groupée de la grille Relations Groupées sous details de la Relation aprés le scroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1Scrholl()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperschroll().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);    
}

// Fonction qui permets d'accéder à la grille Relations sous la grille Relations Groupées sous details de la Relation aprés le scroll
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperExpandableFieldRecordPresenterSchroll()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGrouperDatarecord1Scrholl().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10);    
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRel01()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);  
}

function Select_NewRel01_02(NewRel01)
{
  Get_ModulesBar_BtnRelationships().Click();
  Get_ModulesBar_BtnRelationships().WaitProperty("IsChecked", true, 10000);
  Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  SearchRelationshipByName(NewRel01);
  Get_RelationshipsClientsAccountsGrid().FindChild("Text", NewRel01, 10).Click();                             
}

function Get_RelationshipsClientsAccountsDetailsRelGrouperHistoCompte()
{
  return Aliases.CroesusApp.winMain.RelationshipsClientsAccountsPlugin.bottomGroupBox.zsummary.WPFObject("HierarchyPanel", "", 1).WPFObject("_currentGrid").WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("RecordListControl", "", 1).WPFObject("ExpandableFieldRecordPresenter", "", 2).WPFObject("RecordListControl", "", 1).WPFObject("DataRecordPresenter", "", 1).WPFObject("DataRecordCellArea", "", 1).WPFObject("ContentItemGrid");
}

function Select_Client800203(client)
{
  Get_ModulesBar_BtnClients().Click();
  Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 10000);   
  Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  Search_Client(client);
  Get_RelationshipsClientsAccountsGrid().FindChild("Text", client, 10).Click();
}

// Fonction qui permets d'accéder à la grille Relation sous details de la Relation
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelation()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 2], 10); 
}

// Fonction qui permets d'accéder à la première Relation de la grille Relation sous details de la Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction qui permets d'accéder à la grille Comptes sous Relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1AccountGrid()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(1).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

// Fonction permets d'accéder à la grille Histo Compte sous relation 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1HistoCompteGrid()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(2).FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1Expandle(indice)
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationLine1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", indice], 10);
}

// Fonction qui sélectionne le Client 800203 dans le module Clients
function Select_Client(client)
{ 
  Get_ModulesBar_BtnClients().Click();
  Get_ModulesBar_BtnClients().WaitProperty("IsChecked", true, 10000);   
  Get_Toolbar_BtnRedisplayAllAndRemoveCheckmarks().Click();
  Delay(3000);
  Search_Client(client);
  Get_RelationshipsClientsAccountsGrid().FindChild("Text", client, 10).Click();
}

// Fonction qui permets d'accéder à la grille Relations Groupées sous details de la Relation
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupe()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 3], 10); 
}

// Fonction permets d'accéder à la premiere Relation de la grille Relation Groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupe().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);  
}
// Fonction permets d'accéder à la grille Relations Groupées sous details 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1Expandle()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 1], 10);   
}

// Fonction permets d'accéder à la première Relation de la grille Relations sous Relation Groupées 
function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1ExpandleRel01()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountRelationGroupeLine1Expandle().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);   
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelation()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccount().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["ExpandableFieldRecordPresenter", 4], 10);  
}

function Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelationDatarecord()
{
  return Get_RelationshipsClientsAccountsDetails_PnlHierarchyPanel_DgvAccountHistoRelation().FindChild(["ClrClassName", "WPFControlOrdinalNo"], ["DataRecordPresenter", 1], 10);
}